-- View: camdecmpswks.emission_view_nsps4t

DROP VIEW IF EXISTS camdecmpswks.emission_view_nsps4t;

CREATE OR REPLACE VIEW camdecmpswks.emission_view_nsps4t
 AS
 SELECT mpl.mon_plan_id,
    nsm.mon_loc_id,
    rp.rpt_period_id,
        CASE
            WHEN (12::numeric * ncp.end_year + ncp.end_month) = sel.include_all_month OR sel.include_all_month IS NULL THEN nsm.emission_standard_cd
            ELSE NULL::character varying
        END AS emission_standard,
        CASE
            WHEN (12::numeric * ncp.end_year + ncp.end_month) = sel.include_all_month OR sel.include_all_month IS NULL THEN (nsm.modus_value || ' '::text) || nsm.modus_uom_cd::text
            ELSE NULL::text
        END AS modus_value_and_uom,
        CASE
            WHEN (12::numeric * ncp.end_year + ncp.end_month) = sel.include_all_month OR sel.include_all_month IS NULL THEN nsm.electrical_load_cd
            ELSE NULL::character varying
        END AS electrical_load_type,
        CASE
            WHEN (12::numeric * ncp.end_year + ncp.end_month) = sel.include_all_month OR sel.include_all_month IS NULL THEN
            CASE
                WHEN nsm.no_period_ended_ind = 1::numeric AND nsm.no_period_ended_comment IS NOT NULL THEN 'NO'::text
                WHEN nsm.no_period_ended_ind = 1::numeric AND nsm.no_period_ended_comment IS NULL THEN 'No'::text
                ELSE 'Yes'::text
            END
            ELSE NULL::text
        END AS compliance_period_ended,
    (ncp.begin_month || '/'::text) || ncp.begin_year AS compliance_period_begin_month,
    (ncp.end_month || '/'::text) || ncp.end_year AS compliance_period_end_month,
    (ncp.avg_co2_emission_rate || ' '::text) || ncp.co2_emission_rate_uom_cd::text AS avg_co2_emission_rate_and_uom,
    ncp.pct_valid_op_hours,
        CASE
            WHEN ncp.co2_violation_ind = 1::numeric AND ncp.co2_violation_comment IS NOT NULL THEN 'YES'::text
            WHEN ncp.co2_violation_ind = 1::numeric AND ncp.co2_violation_comment IS NULL THEN 'Yes'::text
            WHEN ncp.co2_violation_comment IS NOT NULL THEN 'NO'::text
            ELSE 'No'::text
        END AS co2_violation,
        CASE
            WHEN (12::numeric * ncp.end_year + ncp.end_month) = sel.include_all_month OR sel.include_all_month IS NULL THEN nan.annual_energy_sold
            ELSE NULL::numeric
        END AS annual_energy_sold,
        CASE
            WHEN (12::numeric * ncp.end_year + ncp.end_month) = sel.include_all_month OR sel.include_all_month IS NULL THEN nan.annual_energy_sold_type_cd
            ELSE NULL::character varying
        END AS annual_energy_sold_type,
        CASE
            WHEN (12::numeric * ncp.end_year + ncp.end_month) = sel.include_all_month OR sel.include_all_month IS NULL THEN nan.annual_potential_output
            ELSE NULL::numeric
        END AS annual_potential_output
   FROM ( SELECT ans.nsps4t_sum_id,
            prd.period_abbreviation AS quarter,
            max(12::numeric * anp.end_year + anp.end_month) AS include_all_month
           FROM camdecmpswks.nsps4t_summary ans
             JOIN camdecmpsmd.reporting_period prd ON prd.rpt_period_id = ans.rpt_period_id
             LEFT JOIN camdecmpswks.nsps4t_compliance_period anp ON anp.nsps4t_sum_id::text = ans.nsps4t_sum_id::text
          GROUP BY ans.nsps4t_sum_id, ans.rpt_period_id, prd.period_abbreviation) sel
     JOIN camdecmpswks.nsps4t_summary nsm ON nsm.nsps4t_sum_id::text = sel.nsps4t_sum_id::text
     JOIN camdecmpswks.nsps4t_compliance_period ncp ON ncp.nsps4t_sum_id::text = sel.nsps4t_sum_id::text
     JOIN camdecmpswks.monitor_plan_location mpl ON mpl.mon_loc_id::text = nsm.mon_loc_id::text
     JOIN camdecmpsmd.reporting_period rp ON rp.rpt_period_id = nsm.rpt_period_id
     LEFT JOIN camdecmpswks.nsps4t_annual nan ON nan.nsps4t_sum_id::text = sel.nsps4t_sum_id::text;
