DO $$
DECLARE
    -- Input / config
    p_rpt_period_id camdecmps.emission_evaluation.rpt_period_id%TYPE := 123;
    p_user_email camdecmpsaux.evaluation_set.user_email%TYPE := 'CAMD_BP_3.1_CBS_Rearch_Mail_Test@easternresearchgroup.onmicrosoft.com';

    -- Working variables
    v_evaluation_set_id camdecmpsaux.evaluation_set.evaluation_set_id%TYPE;
    v_mon_plan_id camdecmps.emission_evaluation.mon_plan_id%TYPE;
BEGIN
    FOR v_mon_plan_id IN
        SELECT mon_plan_id
        FROM camdecmps.emission_evaluation
        WHERE rpt_period_id = p_rpt_period_id
    LOOP
        v_evaluation_set_id := uuid_generate_v4();

        -- Insert into evaluation_set with facility details
        WITH facility AS (
            SELECT f.oris_code, f.fac_id, f.facility_name
            FROM camd.plant f
            JOIN camdecmps.monitor_plan mp USING (fac_id)
            WHERE mp.mon_plan_id = v_mon_plan_id
        )
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
            facility.oris_code,
            facility.fac_id,
            facility.facility_name,
            camdecmpswks.get_mp_location_list(v_mon_plan_id)
        FROM facility;

        -- Insert into evaluation_queue
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

        -- Update monitor_plan
        UPDATE camdecmps.monitor_plan
        SET submission_availability_cd = 'REQUIRE'
        WHERE mon_plan_id = v_mon_plan_id;

        -- Update monitor_plan in workspace
        UPDATE camdecmpswks.monitor_plan
        SET submission_availability_cd = 'REQUIRE',
            updated_status_flg = 'N'
        WHERE mon_plan_id = v_mon_plan_id;

    END LOOP;
END;
$$;

