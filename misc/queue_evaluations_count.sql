/*
 * Previews the evaluations that queue_evaluations.sql will queue without
 * changing any data. Keep the reporting period and targets in both queries
 * synchronized with queue_evaluations.sql before running them.
 */

-- Query 1: Count the evaluations that will be queued for each requested type.
WITH input AS (
    SELECT
        123::numeric AS rpt_period_id,
        ARRAY['MP', 'QAT', 'QCE', 'TEE']::text[] AS targets
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
reporting_period AS (
    SELECT
        rp.rpt_period_id,
        rp.begin_date,
        rp.end_date
    FROM camdecmpsmd.reporting_period rp
    JOIN parameters p USING (rpt_period_id)
),
latest_plan_by_location AS (
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
qa_candidates AS (
    SELECT
        'QAT'::text AS evaluation_type,
        lp.mon_plan_id,
        ts.test_sum_id AS record_id
    FROM camdecmpswks.test_summary ts
    JOIN latest_plan_by_location lp USING (mon_loc_id)
    CROSS JOIN parameters p
    CROSS JOIN reporting_period rp
    WHERE 'QAT' = ANY(p.targets)
      AND (
          ts.end_date BETWEEN rp.begin_date AND rp.end_date
          OR (
              ts.end_date IS NULL
              AND ts.rpt_period_id = p.rpt_period_id
          )
      )

    UNION ALL

    SELECT
        'QCE',
        lp.mon_plan_id,
        qce.qa_cert_event_id
    FROM camdecmpswks.qa_cert_event qce
    JOIN latest_plan_by_location lp USING (mon_loc_id)
    CROSS JOIN parameters p
    JOIN reporting_period rp
      ON qce.qa_cert_event_date BETWEEN rp.begin_date AND rp.end_date
    WHERE 'QCE' = ANY(p.targets)

    UNION ALL

    SELECT
        'TEE',
        lp.mon_plan_id,
        tee.test_extension_exemption_id
    FROM camdecmpswks.test_extension_exemption tee
    JOIN latest_plan_by_location lp USING (mon_loc_id)
    CROSS JOIN parameters p
    WHERE 'TEE' = ANY(p.targets)
      AND tee.rpt_period_id = p.rpt_period_id
),
mp_candidates AS (
    SELECT DISTINCT ee.mon_plan_id
    FROM camdecmps.emission_evaluation ee
    CROSS JOIN parameters p
    WHERE 'MP' = ANY(p.targets)
      AND ee.rpt_period_id = p.rpt_period_id
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
            WHEN 'QAT' THEN 2
            WHEN 'QCE' THEN 3
            WHEN 'TEE' THEN 4
        END AS type_order
    FROM parameters p
    CROSS JOIN unnest(p.targets) AS selected_targets(target)
    WHERE target IN ('MP', 'QAT', 'QCE', 'TEE')
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
        ARRAY['MP', 'QAT', 'QCE', 'TEE']::text[] AS targets
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
reporting_period AS (
    SELECT
        rp.rpt_period_id,
        rp.begin_date,
        rp.end_date
    FROM camdecmpsmd.reporting_period rp
    JOIN parameters p USING (rpt_period_id)
),
latest_plan_by_location AS (
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
qa_candidates AS (
    SELECT
        'QAT'::text AS evaluation_type,
        lp.mon_plan_id,
        ts.test_sum_id AS record_id
    FROM camdecmpswks.test_summary ts
    JOIN latest_plan_by_location lp USING (mon_loc_id)
    CROSS JOIN parameters p
    CROSS JOIN reporting_period rp
    WHERE 'QAT' = ANY(p.targets)
      AND (
          ts.end_date BETWEEN rp.begin_date AND rp.end_date
          OR (
              ts.end_date IS NULL
              AND ts.rpt_period_id = p.rpt_period_id
          )
      )

    UNION ALL

    SELECT
        'QCE',
        lp.mon_plan_id,
        qce.qa_cert_event_id
    FROM camdecmpswks.qa_cert_event qce
    JOIN latest_plan_by_location lp USING (mon_loc_id)
    CROSS JOIN parameters p
    JOIN reporting_period rp
      ON qce.qa_cert_event_date BETWEEN rp.begin_date AND rp.end_date
    WHERE 'QCE' = ANY(p.targets)

    UNION ALL

    SELECT
        'TEE',
        lp.mon_plan_id,
        tee.test_extension_exemption_id
    FROM camdecmpswks.test_extension_exemption tee
    JOIN latest_plan_by_location lp USING (mon_loc_id)
    CROSS JOIN parameters p
    WHERE 'TEE' = ANY(p.targets)
      AND tee.rpt_period_id = p.rpt_period_id
),
mp_candidates AS (
    SELECT DISTINCT ee.mon_plan_id
    FROM camdecmps.emission_evaluation ee
    CROSS JOIN parameters p
    WHERE 'MP' = ANY(p.targets)
      AND ee.rpt_period_id = p.rpt_period_id
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
            WHEN 'QAT' THEN 2
            WHEN 'QCE' THEN 3
            WHEN 'TEE' THEN 4
        END AS type_order
    FROM parameters p
    CROSS JOIN unnest(p.targets) AS selected_targets(target)
    WHERE target IN ('MP', 'QAT', 'QCE', 'TEE')
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
