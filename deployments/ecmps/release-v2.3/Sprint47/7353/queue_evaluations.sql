/*
 * Queues the selected workspace evaluation types for a reporting period, grouped
 * into one evaluation set per monitoring plan for Quartz to process.
 *
 * Example: Set p_rpt_period_id to 123 and p_targets to ARRAY['QAT', 'QCE'] to
 * queue all QAT and QCE records associated with reporting period 123.
 */
DO $$
DECLARE
    -- Input / config
    p_rpt_period_id camdecmps.emission_evaluation.rpt_period_id%TYPE := 123;
    p_user_email camdecmpsaux.evaluation_set.user_email%TYPE := 'CAMD_BP_3.1_CBS_Rearch_Mail_Test@easternresearchgroup.onmicrosoft.com';
    p_targets text[] := ARRAY['MP', 'QAT', 'QCE', 'TEE'];

    -- Working variables
    v_evaluation_set_id camdecmpsaux.evaluation_set.evaluation_set_id%TYPE;
    v_mon_plan_id camdecmps.emission_evaluation.mon_plan_id%TYPE;
    v_period_begin_date camdecmpsmd.reporting_period.begin_date%TYPE;
    v_period_end_date camdecmpsmd.reporting_period.end_date%TYPE;
    v_queue_mp boolean;
BEGIN
    -- Normalize the requested targets and reject invalid input instead of silently creating incomplete or empty evaluation sets.
    SELECT array_agg(DISTINCT upper(btrim(target)))
    INTO p_targets
    FROM unnest(p_targets) AS targets(target)
    WHERE nullif(btrim(target), '') IS NOT NULL;

    IF coalesce(cardinality(p_targets), 0) = 0 THEN
        RAISE EXCEPTION 'At least one evaluation target is required.';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM unnest(p_targets) AS targets(target)
        WHERE target NOT IN ('MP', 'QAT', 'QCE', 'TEE')
    ) THEN
        RAISE EXCEPTION 'Invalid evaluation target. Valid targets are MP, QAT, QCE, and TEE.';
    END IF;

    -- QCE records do not store a reporting-period ID, so use the period dates
    -- to identify certification events belonging to the requested quarter.
    SELECT begin_date, end_date
    INTO v_period_begin_date, v_period_end_date
    FROM camdecmpsmd.reporting_period
    WHERE rpt_period_id = p_rpt_period_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Reporting period ID % does not exist.', p_rpt_period_id;
    END IF;

    -- Resolve QA records through their monitoring locations to the latest
    -- monitoring plan, matching the grouping used by the Evaluate screen.
    FOR v_mon_plan_id IN
        WITH latest_plan_by_location AS (
            SELECT DISTINCT ON (mpl.mon_loc_id)
                mpl.mon_loc_id,
                mpl.mon_plan_id
            FROM camdecmpswks.monitor_plan_location mpl
            JOIN camdecmpswks.monitor_plan mp USING (mon_plan_id)
            ORDER BY
                mpl.mon_loc_id,
                mp.begin_rpt_period_id DESC,
                mpl.mon_plan_id
        ),
        target_mon_plans AS (
            SELECT ee.mon_plan_id
            FROM camdecmps.emission_evaluation ee
            WHERE 'MP' = ANY(p_targets)
              AND ee.rpt_period_id = p_rpt_period_id

            UNION ALL

            SELECT lp.mon_plan_id
            FROM camdecmpswks.test_summary ts
            JOIN latest_plan_by_location lp USING (mon_loc_id)
            WHERE 'QAT' = ANY(p_targets)
              AND (
                  ts.end_date BETWEEN v_period_begin_date AND v_period_end_date
                  OR ts.rpt_period_id = p_rpt_period_id
              )

            UNION ALL

            SELECT lp.mon_plan_id
            FROM camdecmpswks.qa_cert_event qce
            JOIN latest_plan_by_location lp USING (mon_loc_id)
            WHERE 'QCE' = ANY(p_targets)
              AND qce.qa_cert_event_date BETWEEN v_period_begin_date AND v_period_end_date

            UNION ALL

            SELECT lp.mon_plan_id
            FROM camdecmpswks.test_extension_exemption tee
            JOIN latest_plan_by_location lp USING (mon_loc_id)
            WHERE 'TEE' = ANY(p_targets)
              AND tee.rpt_period_id = p_rpt_period_id
        )
        -- Only create evaluation sets for plans that have requested work.
        SELECT DISTINCT mon_plan_id
        FROM target_mon_plans
        ORDER BY mon_plan_id
    LOOP
        v_evaluation_set_id := uuid_generate_v4();

        -- MP is independently selected by reporting period. A plan included
        -- only because it has QA work should not automatically receive MP work.
        SELECT EXISTS (
            SELECT 1
            FROM camdecmps.emission_evaluation ee
            WHERE 'MP' = ANY(p_targets)
              AND ee.mon_plan_id = v_mon_plan_id
              AND ee.rpt_period_id = p_rpt_period_id
        )
        INTO v_queue_mp;

        -- Store the shared facility and configuration context once for all
        -- evaluation queue records belonging to this monitoring plan.
        INSERT INTO camdecmpsaux.evaluation_set (
            evaluation_set_id,
            mon_plan_id,
            queued_time,
            user_id,
            user_email,
            oris_code,
            fac_id,
            fac_name,
            configuration
        )
        SELECT
            v_evaluation_set_id,
            v_mon_plan_id,
            CURRENT_TIMESTAMP,
            'system',
            p_user_email,
            f.oris_code,
            f.fac_id,
            f.facility_name,
            camdecmpswks.get_mp_location_list(v_mon_plan_id)
        FROM camd.plant f
        JOIN camdecmpswks.monitor_plan mp USING (fac_id)
        WHERE mp.mon_plan_id = v_mon_plan_id;

        -- Queue MP only when this plan is an MP candidate. Quartz releases this
        -- set's pending QA records after the MP evaluation completes.
        IF v_queue_mp THEN
            INSERT INTO camdecmpsaux.evaluation_queue (
                evaluation_set_id,
                process_cd,
                queued_time,
                status_cd
            )
            VALUES (
                v_evaluation_set_id,
                'MP',
                CURRENT_TIMESTAMP,
                'QUEUED'
            );

            UPDATE camdecmps.monitor_plan
            SET submission_availability_cd = 'REQUIRE'
            WHERE mon_plan_id = v_mon_plan_id;

            UPDATE camdecmpswks.monitor_plan
            SET submission_availability_cd = 'REQUIRE',
                updated_status_flg = 'N',
                eval_status_cd = 'INQ'
            WHERE mon_plan_id = v_mon_plan_id;
        END IF;

        -- Create one QA queue record for each selected QAT, QCE, or TEE source
        -- record, using its identifier to tell Quartz which checks to run.
        WITH latest_plan_by_location AS (
            SELECT DISTINCT ON (mpl.mon_loc_id)
                mpl.mon_loc_id,
                mpl.mon_plan_id
            FROM camdecmpswks.monitor_plan_location mpl
            JOIN camdecmpswks.monitor_plan mp USING (mon_plan_id)
            ORDER BY
                mpl.mon_loc_id,
                mp.begin_rpt_period_id DESC,
                mpl.mon_plan_id
        ),
        qa_targets AS (
            SELECT
                ts.test_sum_id,
                NULL::varchar AS qa_cert_event_id,
                NULL::varchar AS test_extension_exemption_id
            FROM camdecmpswks.test_summary ts
            JOIN latest_plan_by_location lp USING (mon_loc_id)
            WHERE 'QAT' = ANY(p_targets)
              AND lp.mon_plan_id = v_mon_plan_id
              AND (
                  ts.end_date BETWEEN v_period_begin_date AND v_period_end_date
                  OR ts.rpt_period_id = p_rpt_period_id
              )

            UNION ALL

            SELECT
                NULL::varchar,
                qce.qa_cert_event_id,
                NULL::varchar
            FROM camdecmpswks.qa_cert_event qce
            JOIN latest_plan_by_location lp USING (mon_loc_id)
            WHERE 'QCE' = ANY(p_targets)
              AND lp.mon_plan_id = v_mon_plan_id
              AND qce.qa_cert_event_date BETWEEN v_period_begin_date AND v_period_end_date

            UNION ALL

            SELECT
                NULL::varchar,
                NULL::varchar,
                tee.test_extension_exemption_id
            FROM camdecmpswks.test_extension_exemption tee
            JOIN latest_plan_by_location lp USING (mon_loc_id)
            WHERE 'TEE' = ANY(p_targets)
              AND lp.mon_plan_id = v_mon_plan_id
              AND tee.rpt_period_id = p_rpt_period_id
        )
        INSERT INTO camdecmpsaux.evaluation_queue (
            evaluation_set_id,
            process_cd,
            test_sum_id,
            qa_cert_event_id,
            test_extension_exemption_id,
            queued_time,
            status_cd
        )
        SELECT
            v_evaluation_set_id,
            'QA',
            test_sum_id,
            qa_cert_event_id,
            test_extension_exemption_id,
            CURRENT_TIMESTAMP,
            CASE
                WHEN v_queue_mp THEN 'PENDING'
                ELSE 'QUEUED'
            END
        FROM qa_targets;

        -- Keep the workspace status consistent with the queue so users see
        -- each selected QA record as in progress on the Evaluate screen.
        UPDATE camdecmpswks.test_summary ts
        SET eval_status_cd = 'INQ'
        FROM camdecmpsaux.evaluation_queue eq
        WHERE eq.evaluation_set_id = v_evaluation_set_id
          AND eq.test_sum_id = ts.test_sum_id;

        UPDATE camdecmpswks.qa_cert_event qce
        SET eval_status_cd = 'INQ'
        FROM camdecmpsaux.evaluation_queue eq
        WHERE eq.evaluation_set_id = v_evaluation_set_id
          AND eq.qa_cert_event_id = qce.qa_cert_event_id;

        UPDATE camdecmpswks.test_extension_exemption tee
        SET eval_status_cd = 'INQ'
        FROM camdecmpsaux.evaluation_queue eq
        WHERE eq.evaluation_set_id = v_evaluation_set_id
          AND eq.test_extension_exemption_id = tee.test_extension_exemption_id;
    END LOOP;
END;
$$;
