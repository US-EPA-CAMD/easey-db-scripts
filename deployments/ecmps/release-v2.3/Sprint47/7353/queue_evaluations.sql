/*
 * Selects monitoring plans by emissions reporting period, then queues the
 * requested workspace evaluation types for those plans for Quartz to process.
 *
 * Example: Set p_rpt_period_id to 123 and p_targets to ARRAY['QCE', 'TEE'] to
 * queue all QCE and TEE records associated with plans reporting in period 123.
 */
DO $$
DECLARE
    -- Input / config
    p_rpt_period_id camdecmps.emission_evaluation.rpt_period_id%TYPE := 123;
    p_user_email camdecmpsaux.evaluation_set.user_email%TYPE := 'CAMD_BP_3.1_CBS_Rearch_Mail_Test@easternresearchgroup.onmicrosoft.com';
    p_targets text[] := ARRAY['MP', 'QCE', 'TEE'];

    -- Working variables
    v_evaluation_set_id camdecmpsaux.evaluation_set.evaluation_set_id%TYPE;
    v_mon_plan_id camdecmps.emission_evaluation.mon_plan_id%TYPE;
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
        WHERE target NOT IN ('MP', 'QCE', 'TEE')
    ) THEN
        RAISE EXCEPTION 'Invalid evaluation target. Valid targets are MP, QCE, and TEE.';
    END IF;

    -- Validate the reporting period before using its emissions records to
    -- select the monitoring plans that will be processed.
    PERFORM 1
    FROM camdecmpsmd.reporting_period
    WHERE rpt_period_id = p_rpt_period_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Reporting period ID % does not exist.', p_rpt_period_id;
    END IF;

    -- The reporting period selects monitoring plans only. Requested QA targets
    -- include every record associated with those plans, regardless of period.
    FOR v_mon_plan_id IN
        SELECT DISTINCT ee.mon_plan_id
        FROM camdecmps.emission_evaluation ee
        WHERE ee.rpt_period_id = p_rpt_period_id
          AND (
              'MP' = ANY(p_targets)
              OR (
                  'QCE' = ANY(p_targets)
                  AND EXISTS (
                      SELECT 1
                      FROM camdecmpswks.qa_cert_event qce
                      JOIN camdecmpswks.monitor_plan_location mpl USING (mon_loc_id)
                      WHERE mpl.mon_plan_id = ee.mon_plan_id
                  )
              )
              OR (
                  'TEE' = ANY(p_targets)
                  AND EXISTS (
                      SELECT 1
                      FROM camdecmpswks.test_extension_exemption tee
                      JOIN camdecmpswks.monitor_plan_location mpl USING (mon_loc_id)
                      WHERE mpl.mon_plan_id = ee.mon_plan_id
                  )
              )
          )
        ORDER BY mon_plan_id
    LOOP
        v_evaluation_set_id := uuid_generate_v4();

        v_queue_mp := 'MP' = ANY(p_targets);

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

        -- Create one QA queue record for each selected QCE or TEE source
        -- record, using its identifier to tell Quartz which checks to run.
        WITH qa_targets AS (
            SELECT
                qce.qa_cert_event_id,
                NULL::varchar AS test_extension_exemption_id
            FROM camdecmpswks.qa_cert_event qce
            JOIN camdecmpswks.monitor_plan_location mpl USING (mon_loc_id)
            WHERE 'QCE' = ANY(p_targets)
              AND mpl.mon_plan_id = v_mon_plan_id

            UNION ALL

            SELECT
                NULL::varchar,
                tee.test_extension_exemption_id
            FROM camdecmpswks.test_extension_exemption tee
            JOIN camdecmpswks.monitor_plan_location mpl USING (mon_loc_id)
            WHERE 'TEE' = ANY(p_targets)
              AND mpl.mon_plan_id = v_mon_plan_id
        )
        INSERT INTO camdecmpsaux.evaluation_queue (
            evaluation_set_id,
            process_cd,
            qa_cert_event_id,
            test_extension_exemption_id,
            queued_time,
            status_cd
        )
        SELECT
            v_evaluation_set_id,
            'QA',
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
