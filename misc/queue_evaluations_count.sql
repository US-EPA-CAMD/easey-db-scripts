/*
 * Previews the evaluations that queue_evaluations.sql will queue without
 * changing any data. The reporting period selects monitoring plans; requested
 * QA targets include all records associated with those plans.
 */

-- Query 1: Count the evaluations that will be queued for each requested type.
WITH input AS (
    SELECT
        123::numeric AS rpt_period_id,
        ARRAY['MP', 'QCE', 'TEE']::text[] AS targets
),
parameters AS (
    SELECT
        rpt_period_id,
        ARRAY(
            SELECT DISTINCT upper(btrim(target))
            FROM unnest(targets) AS requested_targets(target)
            WHERE nullif(btrim(target), '') IS NOT NULL
        ) AS targets
    FROM input
),
selected_mon_plans AS (
    SELECT DISTINCT ee.mon_plan_id
    FROM camdecmps.emission_evaluation ee
    JOIN parameters p USING (rpt_period_id)
),
qa_candidates AS (
    SELECT
        'QCE'::text AS evaluation_type,
        lp.mon_plan_id,
        qce.qa_cert_event_id
    FROM camdecmpswks.qa_cert_event qce
    JOIN camdecmpswks.monitor_plan_location lp USING (mon_loc_id)
    JOIN selected_mon_plans smp USING (mon_plan_id)
    CROSS JOIN parameters p
    WHERE 'QCE' = ANY(p.targets)

    UNION ALL

    SELECT
        'TEE',
        lp.mon_plan_id,
        tee.test_extension_exemption_id
    FROM camdecmpswks.test_extension_exemption tee
    JOIN camdecmpswks.monitor_plan_location lp USING (mon_loc_id)
    JOIN selected_mon_plans smp USING (mon_plan_id)
    CROSS JOIN parameters p
    WHERE 'TEE' = ANY(p.targets)
),
mp_candidates AS (
    SELECT smp.mon_plan_id
    FROM selected_mon_plans smp
    CROSS JOIN parameters p
    WHERE 'MP' = ANY(p.targets)
),
evaluation_candidates AS (
    SELECT
        'MP'::text AS evaluation_type,
        mp.mon_plan_id,
        mp.mon_plan_id AS record_id,
        'QUEUED'::text AS initial_status_cd
    FROM mp_candidates mp

    UNION ALL

    SELECT
        qa.evaluation_type,
        qa.mon_plan_id,
        qa.record_id,
        CASE
            WHEN mp.mon_plan_id IS NOT NULL THEN 'PENDING'
            ELSE 'QUEUED'
        END
    FROM qa_candidates qa
    LEFT JOIN mp_candidates mp USING (mon_plan_id)
),
selected_target_types AS (
    SELECT
        target AS evaluation_type,
        CASE target
            WHEN 'MP' THEN 'MP'
            ELSE 'QA'
        END AS process_cd,
        CASE target
            WHEN 'MP' THEN 1
            WHEN 'QCE' THEN 2
            WHEN 'TEE' THEN 3
        END AS type_order
    FROM parameters p
    CROSS JOIN unnest(p.targets) AS selected_targets(target)
    WHERE target IN ('MP', 'QCE', 'TEE')
),
evaluation_counts AS (
    SELECT
        st.evaluation_type,
        count(ec.record_id) AS evaluation_count,
        count(ec.record_id) FILTER (
            WHERE ec.initial_status_cd = 'QUEUED'
        ) AS queued_count,
        count(ec.record_id) FILTER (
            WHERE ec.initial_status_cd = 'PENDING'
        ) AS pending_count,
        st.process_cd,
        st.type_order
    FROM selected_target_types st
    LEFT JOIN evaluation_candidates ec USING (evaluation_type)
    GROUP BY
        st.evaluation_type,
        st.process_cd,
        st.type_order
)
SELECT
    evaluation_type,
    evaluation_count,
    queued_count,
    pending_count,
    process_cd,
    CASE
        WHEN pending_count > 0 AND queued_count > 0 THEN 'MIXED'
        WHEN pending_count > 0 THEN 'PENDING'
        ELSE 'QUEUED'
    END AS initial_status_cd
FROM evaluation_counts
ORDER BY type_order;


-- Query 2: List every evaluation record that will be queued.
WITH input AS (
    SELECT
        123::numeric AS rpt_period_id,
        ARRAY['MP', 'QCE', 'TEE']::text[] AS targets
),
parameters AS (
    SELECT
        rpt_period_id,
        ARRAY(
            SELECT DISTINCT upper(btrim(target))
            FROM unnest(targets) AS requested_targets(target)
            WHERE nullif(btrim(target), '') IS NOT NULL
        ) AS targets
    FROM input
),
selected_mon_plans AS (
    SELECT DISTINCT ee.mon_plan_id
    FROM camdecmps.emission_evaluation ee
    JOIN parameters p USING (rpt_period_id)
),
qa_candidates AS (
    SELECT
        'QCE'::text AS evaluation_type,
        lp.mon_plan_id,
        qce.qa_cert_event_id
    FROM camdecmpswks.qa_cert_event qce
    JOIN camdecmpswks.monitor_plan_location lp USING (mon_loc_id)
    JOIN selected_mon_plans smp USING (mon_plan_id)
    CROSS JOIN parameters p
    WHERE 'QCE' = ANY(p.targets)

    UNION ALL

    SELECT
        'TEE',
        lp.mon_plan_id,
        tee.test_extension_exemption_id
    FROM camdecmpswks.test_extension_exemption tee
    JOIN camdecmpswks.monitor_plan_location lp USING (mon_loc_id)
    JOIN selected_mon_plans smp USING (mon_plan_id)
    CROSS JOIN parameters p
    WHERE 'TEE' = ANY(p.targets)
),
mp_candidates AS (
    SELECT smp.mon_plan_id
    FROM selected_mon_plans smp
    CROSS JOIN parameters p
    WHERE 'MP' = ANY(p.targets)
),
evaluation_candidates AS (
    SELECT
        'MP'::text AS evaluation_type,
        mp.mon_plan_id,
        mp.mon_plan_id AS record_id,
        'QUEUED'::text AS initial_status_cd
    FROM mp_candidates mp

    UNION ALL

    SELECT
        qa.evaluation_type,
        qa.mon_plan_id,
        qa.record_id,
        CASE
            WHEN mp.mon_plan_id IS NOT NULL THEN 'PENDING'
            ELSE 'QUEUED'
        END
    FROM qa_candidates qa
    LEFT JOIN mp_candidates mp USING (mon_plan_id)
),
selected_target_types AS (
    SELECT
        target AS evaluation_type,
        CASE target
            WHEN 'MP' THEN 'MP'
            ELSE 'QA'
        END AS process_cd,
        CASE target
            WHEN 'MP' THEN 1
            WHEN 'QCE' THEN 2
            WHEN 'TEE' THEN 3
        END AS type_order
    FROM parameters p
    CROSS JOIN unnest(p.targets) AS selected_targets(target)
    WHERE target IN ('MP', 'QCE', 'TEE')
)
SELECT
    ec.evaluation_type,
    st.process_cd,
    ec.initial_status_cd,
    plant.oris_code,
    plant.facility_name,
    ec.mon_plan_id,
    ec.record_id
FROM evaluation_candidates ec
JOIN selected_target_types st USING (evaluation_type)
JOIN camdecmpswks.monitor_plan mp USING (mon_plan_id)
JOIN camd.plant plant USING (fac_id)
ORDER BY
    st.type_order,
    plant.oris_code,
    ec.mon_plan_id,
    ec.record_id;
