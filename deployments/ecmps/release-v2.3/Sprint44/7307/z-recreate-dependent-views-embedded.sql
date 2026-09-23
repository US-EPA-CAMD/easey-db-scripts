-- Run this file after all six alter-numeric-id-columns-to-bigint.sql scripts
-- have completed. It can be used instead of the manual z-recreate-dependent-views.sql steps.
-- This file recreates the dependent regular views and the units-expected function.
-- After this file completes, run the separately maintained camdsnap scripts
-- to recreate the affected materialized views and indexes.

BEGIN;

-- 001. Recreate camdaux.vw_annual_emissions_bulk_files_per_quarter_to_generate
-- Source: camdaux/views/vw_annual_emissions_bulk_files_per_quarter_to_generate.sql
-- View: camdaux.vw_annual_emissions_bulk_files_per_quarter_to_generate


CREATE OR REPLACE VIEW camdaux.vw_annual_emissions_bulk_files_per_quarter_to_generate
 AS
 SELECT rp.calendar_year AS year,
    rp.quarter,
    rp.begin_date::text AS qtr_begin_date,
    rp.end_date::text AS qtr_end_date
   FROM camdecmps.dm_emissions dme
     JOIN camdecmpsmd.reporting_period rp USING (rpt_period_id)
     LEFT JOIN camdecmps.dm_emissions_user dmeu ON dme.dm_emissions_id::text = dmeu.dm_emissions_id::text AND dmeu.dm_emissions_user_cd::text = 'S3QTRFILES'::text
  WHERE dmeu.dm_emissions_id IS NULL AND camdaux.can_generate_quarter(rp.quarter::integer, rp.calendar_year::integer)
  GROUP BY rp.calendar_year, rp.quarter, rp.begin_date, rp.end_date
  ORDER BY rp.calendar_year, rp.quarter;

-- 002. Recreate camdaux.vw_annual_emissions_bulk_files_per_state_to_generate
-- Source: camdaux/views/vw_annual_emissions_bulk_files_per_state_to_generate.sql
-- View: camdaux.vw_annual_emissions_bulk_files_per_state_to_generate


CREATE OR REPLACE VIEW camdaux.vw_annual_emissions_bulk_files_per_state_to_generate
 AS
 SELECT rp.calendar_year AS year,
    p.state AS state_cd
   FROM camdecmps.dm_emissions dme
     JOIN camdecmpsmd.reporting_period rp USING (rpt_period_id)
     JOIN camd.plant p USING (fac_id)
     LEFT JOIN camdecmps.dm_emissions_user dmeu ON dme.dm_emissions_id::text = dmeu.dm_emissions_id::text AND dmeu.dm_emissions_user_cd::text = 'S3STATEFILES'::text
  WHERE dmeu.dm_emissions_id IS NULL AND camdaux.can_generate_state(rp.calendar_year::integer)
  GROUP BY rp.calendar_year, p.state
  ORDER BY rp.calendar_year, p.state;

-- 003. Recreate camdaux.vw_annual_facility_bulk_files_to_generate
-- Source: camdaux/views/vw_annual_facility_bulk_files_to_generate.sql
-- View: camdaux.vw_annual_facility_bulk_files_to_generate


CREATE OR REPLACE VIEW camdaux.vw_annual_facility_bulk_files_to_generate
 AS
 SELECT DISTINCT uf.op_year AS year
   FROM camddmw.unit_fact uf
     LEFT JOIN camddmw.owner_display_fact odf ON uf.unit_id = odf.unit_id AND uf.op_year = odf.op_year
  WHERE uf.last_update_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval) OR odf.last_update_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval)
UNION
 SELECT DISTINCT date_part('year'::text, ug.begin_date) AS year
   FROM camd.unit_generator ug
     JOIN camd.generator g USING (gen_id)
  WHERE ug.add_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval) OR ug.update_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval) OR g.add_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval) OR g.update_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval)
UNION
 SELECT DISTINCT date_part('year'::text, ug.end_date) AS year
   FROM camd.unit_generator ug
     JOIN camd.generator g USING (gen_id)
  WHERE ug.end_date IS NOT NULL AND (ug.add_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval) OR ug.update_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval) OR g.add_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval) OR g.update_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval));

-- 004. Recreate camddmw.vw_facility_unit_attributes
-- Source: camddmw/views/2-vw_facility_unit_attributes.sql
-- View: camddmw.vw_facility_unit_attributes


CREATE OR REPLACE VIEW camddmw.vw_facility_unit_attributes
 AS
 SELECT uf.unit_id,
    uf.op_year,
    uf.prg_code_info,
    uf.state,
    uf.orispl_code,
    uf.unitid,
    uf.assoc_stacks,
    uf.epa_region,
    uf.nerc_region,
    uf.county,
    uf.county_code,
    uf.fips_code,
    uf.source_cat,
    uf.latitude,
    uf.longitude,
    uf.so2_phase,
    uf.nox_phase,
    uf.unit_type_info,
    uf.primary_fuel_info,
    uf.secondary_fuel_info,
    uf.so2_control_info,
    uf.nox_control_info,
    uf.part_control_info,
    uf.hg_control_info,
    uf.comr_op_date,
    uf.op_status_info,
    uf.capacity_input,
    odf.own_display,
    odf.opr_display,
    d.generator_id,
    uf.facility_name,
    d.arp_nameplate_capacity,
    d.other_nameplate_capacity,
    rep.primary_rep_info
   FROM camddmw.unit_fact uf
     LEFT JOIN camddmw.vw_rep_display_fact rep ON uf.unit_id = rep.unit_id AND uf.op_year = rep.op_year
     LEFT JOIN ( SELECT ug.unit_id,
            string_agg(g.genid::text, ', '::text) AS generator_id,
            string_agg(COALESCE(g.arp_nameplate_capacity::text, 'null'::text), ', '::text) AS arp_nameplate_capacity,
            string_agg(COALESCE(g.other_nameplate_capacity::text, 'null'::text), ', '::text) AS other_nameplate_capacity
           FROM camd.generator g
             JOIN camd.unit_generator ug ON g.gen_id = ug.gen_id
          GROUP BY ug.unit_id) d ON uf.unit_id = d.unit_id
     LEFT JOIN camddmw.owner_display_fact odf ON uf.unit_id = odf.unit_id AND uf.op_year = odf.op_year;

-- 005. Recreate camdecmps.emission_view_counts
-- Source: camdecmps/views/emission_view_counts.sql
-- View: camdecmps.emission_view_counts


CREATE OR REPLACE VIEW camdecmps.emission_view_counts
 AS
 SELECT vw.mon_plan_id,
    vw.mon_loc_id,
    COALESCE(u.unitid, sp.stack_name) AS unit_stack,
    vw.dataset_cd,
    rp.rpt_period_id,
    rp.calendar_year AS rpt_period_year,
    rp.quarter AS rpt_period_qtr,
    vw.count
   FROM camdecmps.emission_view_count vw
     JOIN camdecmps.monitor_location ml USING (mon_loc_id)
     JOIN camdecmpsmd.reporting_period rp USING (rpt_period_id)
     LEFT JOIN camdecmps.stack_pipe sp USING (stack_pipe_id)
     LEFT JOIN camd.unit u USING (unit_id);

-- 006. Recreate camdecmps.emission_view_dailybackstop
-- Source: camdecmps/views/emission_view_dailybackstop.sql
-- View: camdecmps.emission_view_dailybackstop


CREATE OR REPLACE VIEW camdecmps.emission_view_dailybackstop
AS
SELECT mpl.mon_plan_id,
	mpl.mon_loc_id,
	rp.rpt_period_id,
	rp.begin_date,
	rp.end_date,
	rp.begin_date AS datehour,
  u.unit_id,
	u.unitid as "unit_name",
	bkstop.op_date,
	bkstop.daily_noxm,
	bkstop.daily_hit,
	bkstop.daily_avg_noxr,
	bkstop.daily_noxm_exceed,
	bkstop.cumulative_os_noxm_exceed
FROM camdecmps.daily_backstop bkstop
JOIN camd.unit u USING (unit_id)
JOIN camdecmps.monitor_plan_location mpl USING (mon_loc_id)
JOIN camdecmpsmd.reporting_period rp USING (rpt_period_id);

-- 007. Recreate camdecmps.emission_view_ltff
-- Source: camdecmps/views/emission_view_ltff.sql
-- View: camdecmps.emission_view_ltff


CREATE OR REPLACE VIEW camdecmps.emission_view_ltff
 AS
 SELECT mpl.mon_plan_id,
    ltff.mon_loc_id,
    rp.rpt_period_id,
    rp.begin_date,
    rp.end_date,
    rp.begin_date AS datehour,
    ms.system_identifier AS fuel_flow_system_id,
    ms.sys_type_cd AS system_type,
    ms.fuel_cd AS fuel_type,
    ltff.fuel_flow_period_cd AS period_cd,
    ltff.long_term_fuel_flow_value AS fuel_flow,
    ltff.ltff_uom_cd AS fuel_flow_uom,
    ltff.gross_calorific_value,
    ltff.gcv_uom_cd AS gcv_uom,
    ltff.total_heat_input AS rpt_heat_input,
    ltff.calc_total_heat_input AS calc_heat_input
   FROM camdecmps.long_term_fuel_flow ltff
     JOIN camdecmps.monitor_plan_location mpl USING (mon_loc_id)
     JOIN camdecmpsmd.reporting_period rp USING (rpt_period_id)
     LEFT JOIN camdecmps.monitor_system ms USING (mon_sys_id);

-- 008. Recreate camdecmps.emission_view_nsps4t
-- Source: camdecmps/views/emission_view_nsps4t.sql
-- View: camdecmps.emission_view_nsps4t


CREATE OR REPLACE VIEW camdecmps.emission_view_nsps4t
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
           FROM camdecmps.nsps4t_summary ans
             JOIN camdecmpsmd.reporting_period prd ON prd.rpt_period_id = ans.rpt_period_id
             LEFT JOIN camdecmps.nsps4t_compliance_period anp ON anp.nsps4t_sum_id::text = ans.nsps4t_sum_id::text
          GROUP BY ans.nsps4t_sum_id, ans.rpt_period_id, prd.period_abbreviation) sel
     JOIN camdecmps.nsps4t_summary nsm ON nsm.nsps4t_sum_id::text = sel.nsps4t_sum_id::text
     JOIN camdecmps.nsps4t_compliance_period ncp ON ncp.nsps4t_sum_id::text = sel.nsps4t_sum_id::text
     JOIN camdecmps.monitor_plan_location mpl ON mpl.mon_loc_id::text = nsm.mon_loc_id::text
     JOIN camdecmpsmd.reporting_period rp ON rp.rpt_period_id = nsm.rpt_period_id
     LEFT JOIN camdecmps.nsps4t_annual nan ON nan.nsps4t_sum_id::text = sel.nsps4t_sum_id::text;

-- 009. Recreate camdecmps.emission_view_sumval
-- Source: camdecmps/views/emission_view_sumval.sql
CREATE OR REPLACE VIEW camdecmps.emission_view_sumval
AS
	SELECT DISTINCT mpl.mon_plan_id, rp.period_description, d.*
	FROM camdecmps.summary_value sv
	JOIN camdecmps.monitor_plan_location mpl USING(mon_loc_id)
	JOIN camdecmpsmd.reporting_period rp USING (rpt_period_id)
	JOIN camdecmps.get_summary_values(mpl.mon_loc_id, rp.rpt_period_id) d
		ON sv.mon_loc_id = d.mon_loc_id
		AND sv.rpt_period_id = d.rpt_period_id;

-- 010. Recreate camdecmps.vw_em_export_and_report
-- Source: camdecmps/views/vw_em_export_and_report.sql
-- View: camdecmps.vw_em_export_and_report

CREATE OR REPLACE VIEW camdecmps.vw_em_export_and_report AS
SELECT
    fac.oris_code,
    fac.facility_name,
    ems.mon_plan_id,
    (
        SELECT
            string_agg(coalesce(unt.unitid, stp.stack_name), ', '::text ORDER BY unt.unitid, stp.stack_name)
        FROM
            camdecmps.monitor_plan_location mpl
            JOIN camdecmps.monitor_location loc ON loc.mon_loc_id = mpl.mon_loc_id
            LEFT JOIN camd.unit unt ON unt.unit_id = loc.unit_id
            LEFT JOIN camdecmps.stack_pipe stp ON stp.stack_pipe_id = loc.stack_pipe_id
        WHERE
            mpl.mon_plan_id = ems.mon_plan_id
    ) AS configuration,
    (
        SELECT
            max(smv.userid)
        FROM
            camdecmps.monitor_plan_location mpl
            JOIN camdecmps.summary_value smv ON smv.mon_loc_id = mpl.mon_loc_id
                AND smv.rpt_period_id = ems.rpt_period_id
        WHERE
            mpl.mon_plan_id = ems.mon_plan_id
    ) AS userid,
    ems.last_updated AS update_date,
    (
        SELECT
            esa.sub_availability_cd
        FROM (
            SELECT
                sub.mon_plan_id,
                sub.rpt_period_id,
                max(sub.access_begin_date) AS last_access_begin_date
            FROM
                camdecmpsaux.em_submission_access sub
            WHERE
                sub.mon_plan_id = ems.mon_plan_id
                AND sub.rpt_period_id = ems.rpt_period_id
            GROUP BY
                sub.mon_plan_id,
                sub.rpt_period_id) lst1
            JOIN camdecmpsaux.EM_SUBMISSION_ACCESS esa ON esa.mon_plan_id = lst1.mon_plan_id
                AND esa.rpt_period_id = lst1.rpt_period_id
                AND esa.access_begin_date = lst1.last_access_begin_date
    ) AS window_status,
    prd.period_abbreviation
FROM
    camdecmps.emission_evaluation ems
    JOIN camdecmpsmd.reporting_period prd ON prd.rpt_period_id = ems.rpt_period_id
    JOIN camdecmps.monitor_plan pln ON pln.mon_plan_id = ems.mon_plan_id
    JOIN camd.plant fac ON fac.fac_id = pln.fac_id;

-- 011. Recreate camdecmps.vw_em_reporting_status
-- Source: camdecmps/views/vw_em_reporting_status.sql
create or replace
view camdecmps.vw_em_reporting_status
as
select
	up.unit_id,
	up.prg_cd,
	up.unit_monitor_cert_begin_date,
	up.emissions_recording_begin_date,
	ml.mon_loc_id,
	uos.end_date as retire_date,
	cc.affected_ind,
	rp.rpt_period_id,
	rp.calendar_year,
	rp.quarter,
	case
		when (up.emissions_recording_begin_date is not null
		and up.emissions_recording_begin_date <= rp.end_date)
		or (up.emissions_recording_begin_date is null
		and up.unit_monitor_cert_begin_date + 180 <= rp.end_date) then 'REQUIRE'
		when (up.emissions_recording_begin_date is null) then 'GRANTED'
		else null
	end as em_reporting_status,
	case
		when ml.mon_loc_id is null then 'Missing Monitor Location'
		when count(active_mp.mon_plan_id) = 0
		and cc.affected_ind = 0 then null
		when count(active_mp.mon_plan_id) = 0
		and cc.affected_ind = 1 then 'No Active Monitoring Plan'
		when count(distinct active_mp.mon_plan_id) > 1 then 'Multiple Monitoring Plans'
		when rp.quarter = 3 then max(active_mp.mon_plan_id)
		when max(active_mp.report_freq_cd) is null then 'Missing Reporting Frequency'
		when count(distinct active_mp.report_freq_cd) > 1 then 'Multiple Reporting Frequencies'
		when rp.quarter in (1, 4) then
			case
				when max(active_mp.report_freq_cd) = 'OS' then null
			else max(active_mp.mon_plan_id)
		end
		when rp.quarter in (2, 3) then
			case
				when max(active_mp.report_freq_cd) = 'OS'
			and uos.end_date is not null
			and extract(year from uos.end_date) = rp.calendar_year
			and extract(month from uos.end_date) = 4 then null
			else max(active_mp.mon_plan_id)
		end
	end as mon_plan_id,
	u.fac_id
from
	camd.unit u
cross join camdecmpsmd.reporting_period rp
join camd.unit_op_status uos on
	u.unit_id = uos.unit_id
	and uos.op_status_cd = 'OPR'
	and uos.begin_date <= rp.end_date
	and (uos.end_date is null or uos.end_date >= rp.begin_date)
join camd.unit_program up on
	u.unit_id = up.unit_id
	and up.unit_monitor_cert_begin_date <= rp.end_date
	and (up.end_date is null
		or up.end_date >= rp.begin_date)
join camdmd.class_code cc on
	up.class_cd = cc.class_cd
left join camd.unit_program otc on
	otc.unit_id = u.unit_id
	and otc.prg_cd = 'OTC'
join camd.program p on
	up.prg_id = p.prg_id
join camd.program_phase pp on
	up.prg_id = pp.prg_id
	and pp.phase_monitor_cert_deadline <= rp.end_date
	and case
			when pp.phase is not null then pp.phase
			when p.prg_cd in ('NBP', 'NHNOX') then 'NON-OTC'
			else 'NULL'
		end	=
		case
			when up.prg_cd = 'ARP' then up.class_cd
			when up.prg_cd in ('NBP', 'NHNOX') and otc.unit_id is not null then 'OTC'
			when up.prg_cd in ('NBP', 'NHNOX') and otc.unit_id is null then 'NON-OTC'
			else 'NULL'
		end
left join camdecmps.monitor_location ml on
	up.unit_id = ml.unit_id
left join (
	select
		mp.mon_plan_id,
		mpl.mon_loc_id,
		mp_brp.calendar_year as mp_begin_year,
		mp_brp.quarter as mp_begin_quarter,
		mp_erp.calendar_year as mp_end_year,
		mp_erp.quarter as mp_end_quarter,
		mprf.report_freq_cd,
		mprf_brp.calendar_year as mprf_begin_year,
		mprf_brp.quarter as mprf_begin_quarter,
		mprf_erp.calendar_year as mprf_end_year,
		mprf_erp.quarter as mprf_end_quarter
	from
		camdecmps.monitor_plan_location mpl
	join camdecmps.monitor_plan mp on
		mpl.mon_plan_id = mp.mon_plan_id
	join camdecmpsmd.reporting_period mp_brp on
		mp.begin_rpt_period_id = mp_brp.rpt_period_id
	left join camdecmpsmd.reporting_period mp_erp on
		mp.end_rpt_period_id = mp_erp.rpt_period_id
	left join camdecmps.monitor_plan_reporting_freq mprf
	on
		mp.mon_plan_id = mprf.mon_plan_id
	left join camdecmpsmd.reporting_period mprf_brp on
		mprf.begin_rpt_period_id = mprf_brp.rpt_period_id
	left join camdecmpsmd.reporting_period mprf_erp on
		mprf.end_rpt_period_id = mprf_erp.rpt_period_id) active_mp on
	ml.mon_loc_id = active_mp.mon_loc_id
	and (active_mp.mp_begin_year < rp.calendar_year
		or (active_mp.mp_begin_year = rp.calendar_year
			and active_mp.mp_begin_quarter <= rp.quarter))
	and (active_mp.mp_end_year is null
		or active_mp.mp_end_year > rp.calendar_year
		or (active_mp.mp_end_year = rp.calendar_year
			and active_mp.mp_end_quarter >= rp.quarter))
	and (active_mp.mprf_begin_year < rp.calendar_year
		or (active_mp.mprf_begin_year = rp.calendar_year
			and active_mp.mprf_begin_quarter <= rp.quarter))
	and (active_mp.mprf_end_year is null
		or active_mp.mprf_end_year > rp.calendar_year
		or (active_mp.mprf_end_year = rp.calendar_year
			and active_mp.mprf_end_quarter >= rp.quarter))
where
	not exists (
	select
		up2.up_id
	from
		camd.unit_exemption ue
	inner join camd.unit_program up2 on
		ue.unit_id = up2.unit_id
		and up2.up_id = up.up_id
	inner join camdmd.program_exemption pe on
		up2.prg_cd = pe.prg_cd
		and ue.exemption_type_cd = pe.exemption_type_cd
	where
		ue.begin_date <= rp.begin_date
		and (ue.end_date is null
			or ue.end_date >= rp.end_date)
		and ue.unit_id = up.unit_id
           )
group by
	up.unit_id,
	up.prg_cd,
	up.unit_monitor_cert_begin_date,
	up.emissions_recording_begin_date,
	ml.mon_loc_id,
	uos.end_date,
	cc.affected_ind,
	rp.rpt_period_id,
	rp.calendar_year,
	rp.quarter,
	case
		when (up.emissions_recording_begin_date is not null
			and up.emissions_recording_begin_date <= rp.end_date)
		or (up.emissions_recording_begin_date is null
			and up.unit_monitor_cert_begin_date + 180 <= rp.end_date) then 'REQUIRE'
		when (up.emissions_recording_begin_date is null) then 'GRANTED'
		else null
	end,
	u.fac_id;

-- 012. Recreate camdecmps.vw_emissions_submissions_expected
-- Source: camdecmps/views/1-vw_emissions_submissions_expected.sql
-- View: camdecmps.vw_emissions_submissions_expected


CREATE OR REPLACE VIEW camdecmps.vw_emissions_submissions_expected
 AS
 SELECT esa.rpt_period_id,
    count(esa.em_sub_access_id) AS total,
    rp.calendar_year,
    rp.quarter
   FROM camdecmpsaux.em_submission_access esa,
    camdecmpsmd.reporting_period rp
  WHERE esa.rpt_period_id = rp.rpt_period_id AND esa.em_sub_type_cd::text = 'INITIAL'::text AND COALESCE(esa.sub_availability_cd, 'NULL'::character varying)::text <> 'DELETE'::text
  GROUP BY esa.rpt_period_id, rp.calendar_year, rp.quarter
  ORDER BY esa.rpt_period_id, rp.calendar_year, rp.quarter;

-- 013. Recreate camdecmps.vw_emissions_submissions_gdm
-- Source: camdecmps/views/1-vw_emissions_submissions_gdm.sql
-- View: camdecmps.vw_emissions_submissions_gdm


CREATE OR REPLACE VIEW camdecmps.vw_emissions_submissions_gdm
 AS
 SELECT dme.rpt_period_id,
    count(dmu.dm_emissions_user_id) AS used_count
   FROM camdecmps.dm_emissions dme,
    camdecmps.dm_emissions_user dmu
  WHERE dme.dm_emissions_id::text = dmu.dm_emissions_id::text AND dmu.dm_emissions_user_cd::text = 'GDM'::text AND dmu.complete_date IS NOT NULL
  GROUP BY dme.rpt_period_id;

-- 014. Recreate camdecmps.vw_emissions_submissions_received
-- Source: camdecmps/views/1-vw_emissions_submissions_received.sql
-- View: camdecmps.vw_emissions_submissions_received


CREATE OR REPLACE VIEW camdecmps.vw_emissions_submissions_received
 AS
 SELECT em_submission_access.rpt_period_id,
    count(em_submission_access.em_sub_access_id) AS total
   FROM camdecmpsaux.em_submission_access
  WHERE em_submission_access.em_status_cd::text = 'RECVD'::text AND em_submission_access.em_sub_type_cd::text = 'INITIAL'::text AND em_submission_access.sub_availability_cd::text <> 'DELETE'::text
  GROUP BY em_submission_access.rpt_period_id
  ORDER BY em_submission_access.rpt_period_id;

-- 015. Recreate camdecmps.vw_emissions_submissions_progress
-- Source: camdecmps/views/2-vw_emissions_submissions_progress.sql
-- View: camdecmps.vw_emissions_submissions_progress


CREATE OR REPLACE VIEW camdecmps.vw_emissions_submissions_progress
 AS
 SELECT rp.begin_date,
    rp.end_date,
    expected.calendar_year,
    expected.quarter,
    COALESCE(100::numeric * (received.total::numeric / expected.total::numeric), 0::numeric) AS submitted_percentage,
    COALESCE(received.total, 0::bigint) AS submitted_count,
    expected.total - COALESCE(received.total, 0::bigint) AS remaining_count,
    expected.total AS total_expected_count,
    COALESCE(100::numeric * (gdm.used_count::numeric / expected.total::numeric), 0::numeric) AS gdm_used_percentage,
    COALESCE(gdm.used_count, 0::bigint) AS gdm_used_count,
    COALESCE(expected.total - gdm.used_count, 0::bigint) AS gdm_remaining_count
   FROM camdecmps.vw_emissions_submissions_received received
     JOIN camdecmpsmd.reporting_period rp USING (rpt_period_id)
     LEFT JOIN camdecmps.vw_emissions_submissions_expected expected ON expected.rpt_period_id = received.rpt_period_id
     LEFT JOIN camdecmps.vw_emissions_submissions_gdm gdm ON expected.rpt_period_id = gdm.rpt_period_id
  ORDER BY rp.begin_date;

-- 016. Recreate camdecmps.vw_monitor_plan
-- Source: camdecmps/views/vw_monitor_plan.sql
-- View: camdecmps.vw_monitor_plan


CREATE OR REPLACE VIEW camdecmps.vw_monitor_plan
AS SELECT pln.mon_plan_id,
    fac.fac_id,
    fac.oris_code,
    fac.state,
    fac.facility_name,
    ( SELECT string_agg(COALESCE(unt.unitid, stp.stack_name)::text, ', '::text ORDER BY stp.stack_name, unt.unitid)
           FROM camdecmps.monitor_plan_location mpl
             JOIN camdecmps.monitor_location loc ON loc.mon_loc_id::text = mpl.mon_loc_id::text
             LEFT JOIN camd.unit unt ON unt.unit_id = loc.unit_id
             LEFT JOIN camdecmps.stack_pipe stp ON stp.stack_pipe_id::text = loc.stack_pipe_id::text
          WHERE mpl.mon_plan_id::text = pln.mon_plan_id::text) AS locations,
    pln.begin_rpt_period_id,
	mp_brp.calendar_year as mp_begin_year,
	mp_brp.quarter as mp_begin_quarter,
    pln.end_rpt_period_id,
	mp_erp.calendar_year as mp_end_year,
	mp_erp.quarter as mp_end_quarter,
    fac.first_ecmps_rpt_period_id
   FROM camdecmps.monitor_plan pln
   JOIN camd.plant fac ON fac.fac_id = pln.fac_id
   join camdecmpsmd.reporting_period mp_brp on pln.begin_rpt_period_id = mp_brp.rpt_period_id
   left join camdecmpsmd.reporting_period mp_erp on pln.end_rpt_period_id = mp_erp.rpt_period_id;

-- 017. Recreate camdecmps.vw_inconsistent_mprf_dates
-- Source: camdecmps/views/vw_inconsistent_mprf_dates.sql
CREATE OR REPLACE VIEW camdecmps.vw_inconsistent_mprf_dates AS
SELECT
    VMP.ORIS_CODE,
    VMP.FACILITY_NAME,
    VMP.STATE,
    VMP.LOCATIONS,
    BRP.PERIOD_ABBREVIATION AS BEGIN_PERIOD,
    CASE
         WHEN RF.END_RPT_PERIOD_ID IS NOT NULL THEN ERP.PERIOD_ABBREVIATION
         ELSE ''
    END AS END_PERIOD,
    RF.REPORT_FREQ_CD AS LOCATIONS2,
    NULL AS BEGIN_PERIOD2,
    NULL AS END_PERIOD2
FROM
    (
      SELECT
          MON_PLAN_ID,
          ORIS_CODE,
          FACILITY_NAME,
          STATE,
          LOCATIONS
      FROM camdecmps.VW_MONITOR_PLAN
    ) VMP
JOIN
    (
      SELECT
          MON_PLAN_ID,
          MPRF.BEGIN_RPT_PERIOD_ID,
          MPRF.END_RPT_PERIOD_ID,
          MPRF.REPORT_FREQ_CD
      FROM camdecmps.MONITOR_PLAN_REPORTING_FREQ MPRF
      WHERE EXISTS (
          SELECT 1
          FROM camdecmps.MONITOR_PLAN_REPORTING_FREQ
          WHERE MON_PLAN_RF_ID <> MPRF.MON_PLAN_RF_ID
            AND MON_PLAN_ID = MPRF.MON_PLAN_ID
            AND (
                 BEGIN_RPT_PERIOD_ID BETWEEN MPRF.BEGIN_RPT_PERIOD_ID AND COALESCE(MPRF.END_RPT_PERIOD_ID, 999)
                 OR COALESCE(END_RPT_PERIOD_ID, 999) BETWEEN MPRF.BEGIN_RPT_PERIOD_ID AND COALESCE(MPRF.END_RPT_PERIOD_ID, 999)
                )
      )
    ) RF
      ON VMP.MON_PLAN_ID = RF.MON_PLAN_ID
JOIN camdecmpsmd.REPORTING_PERIOD BRP
      ON RF.BEGIN_RPT_PERIOD_ID = BRP.RPT_PERIOD_ID
LEFT JOIN camdecmpsmd.REPORTING_PERIOD ERP
      ON RF.END_RPT_PERIOD_ID = ERP.RPT_PERIOD_ID
ORDER BY
    VMP.ORIS_CODE,
    VMP.LOCATIONS,
    BRP.PERIOD_ABBREVIATION;

-- 018. Recreate camdecmpsmd.vw_reporting_period
-- Source: camdecmpsmd/views/vw_reporting_period.sql
-- View: camdecmpsmd.vw_reporting_period


CREATE OR REPLACE VIEW camdecmpsmd.vw_reporting_period
 AS
 SELECT reporting_period.rpt_period_id,
    reporting_period.calendar_year,
    reporting_period.quarter,
    reporting_period.period_description AS year_quarter,
    reporting_period.period_description,
    reporting_period.period_abbreviation AS year_quarter_short,
    reporting_period.period_abbreviation,
    reporting_period.begin_date AS quarter_begin_date,
    reporting_period.end_date AS quarter_end_date
   FROM camdecmpsmd.reporting_period;

-- 019. Recreate camdecmpswks.vw_monitor_plan_location
-- Source: camdecmpswks/views/vw_monitor_plan_location.sql
-- View: camdecmpswks.vw_monitor_plan_location


CREATE OR REPLACE VIEW camdecmpswks.vw_monitor_plan_location
 AS
 SELECT mpl.mon_loc_id,
    ml.stack_pipe_id,
    ml.unit_id,
    mp.mon_plan_id,
    mp.fac_id,
    sp.stack_name,
    u.unitid,
    u.non_load_based_ind,
    sp.active_date,
    sp.retire_date,
    mp.needs_eval_flg,
    cs.severity_cd,
        CASE
            WHEN mp.submission_availability_cd::text = 'REQUIRE'::text OR mp.updated_status_flg::text = 'Y'::text THEN 'Y'::text
            ELSE 'N'::text
        END AS must_submit,
    mp.begin_rpt_period_id,
    rpbegin.calendar_year AS begin_year,
    rpbegin.quarter AS begin_quarter,
    mp.end_rpt_period_id,
    rpend.calendar_year AS end_year,
    rpend.quarter AS end_quarter
   FROM camdecmpswks.monitor_plan_location mpl
     JOIN camdecmpswks.monitor_location ml ON mpl.mon_loc_id::text = ml.mon_loc_id::text
     JOIN camdecmpswks.monitor_plan mp ON mpl.mon_plan_id::text = mp.mon_plan_id::text
     LEFT JOIN camdecmpsmd.vw_reporting_period rpbegin ON mp.begin_rpt_period_id = rpbegin.rpt_period_id
     LEFT JOIN camdecmpsmd.vw_reporting_period rpend ON mp.end_rpt_period_id = rpend.rpt_period_id
     LEFT JOIN camd.unit u ON ml.unit_id = u.unit_id
     LEFT JOIN camdecmpswks.stack_pipe sp ON ml.stack_pipe_id::text = sp.stack_pipe_id::text
     LEFT JOIN camdecmpswks.check_session cs ON mp.chk_session_id::text = cs.chk_session_id::text;

-- 020. Recreate camdecmps.vw_locations_in_multiple_mps
-- Source: camdecmps/views/vw_locations_in_multiple_mps.sql
CREATE OR REPLACE VIEW camdecmps.vw_locations_in_multiple_mps AS
SELECT
    VMP.ORIS_CODE,
    VMP.FACILITY_NAME,
    VMP.STATE,
    VMP.LOCATIONS,
    BRP.PERIOD_ABBREVIATION AS BEGIN_PERIOD,
    CASE
         WHEN X.END_RPT_PERIOD_ID IS NOT NULL
         THEN ERP.PERIOD_ABBREVIATION
         ELSE ''
    END AS END_PERIOD,
    VMP2.LOCATIONS AS LOCATIONS2,
    BRP2.PERIOD_ABBREVIATION AS BEGIN_PERIOD2,
    CASE
         WHEN X.END_RPT_PERIOD_ID2 IS NOT NULL
         THEN ERP2.PERIOD_ABBREVIATION
         ELSE ''
    END AS END_PERIOD2
FROM (
    SELECT DISTINCT
           MP.MON_PLAN_ID,
           MP2.MON_PLAN_ID AS MON_PLAN_ID2,
           MP.BEGIN_RPT_PERIOD_ID,
           MP.END_RPT_PERIOD_ID,
           MP2.BEGIN_RPT_PERIOD_ID AS BEGIN_RPT_PERIOD_ID2,
           MP2.END_RPT_PERIOD_ID AS END_RPT_PERIOD_ID2
    FROM camdecmpswks.VW_MONITOR_PLAN_LOCATION MPL
    JOIN camdecmps.MONITOR_PLAN_LOCATION MPL2
         ON MPL.MON_LOC_ID = MPL2.MON_LOC_ID
    JOIN camdecmps.MONITOR_PLAN MP
         ON MP.MON_PLAN_ID = MPL.MON_PLAN_ID
    JOIN camdecmps.MONITOR_PLAN MP2
         ON MPL2.MON_PLAN_ID = MP2.MON_PLAN_ID
    WHERE MP.MON_PLAN_ID > MP2.MON_PLAN_ID
      AND (
           (MP.BEGIN_RPT_PERIOD_ID <= MP2.BEGIN_RPT_PERIOD_ID
              AND COALESCE(MP.END_RPT_PERIOD_ID, 999) >= MP2.BEGIN_RPT_PERIOD_ID)
           OR
           (MP.BEGIN_RPT_PERIOD_ID >= MP2.BEGIN_RPT_PERIOD_ID
              AND MP.BEGIN_RPT_PERIOD_ID <= COALESCE(MP2.END_RPT_PERIOD_ID, 999))
          )
) X
JOIN camdecmps.VW_MONITOR_PLAN VMP
    ON X.MON_PLAN_ID = VMP.MON_PLAN_ID
JOIN camdecmps.VW_MONITOR_PLAN VMP2
    ON X.MON_PLAN_ID2 = VMP2.MON_PLAN_ID
JOIN camdecmpsmd.REPORTING_PERIOD BRP
    ON X.BEGIN_RPT_PERIOD_ID = BRP.RPT_PERIOD_ID
LEFT JOIN camdecmpsmd.REPORTING_PERIOD ERP
    ON X.END_RPT_PERIOD_ID = ERP.RPT_PERIOD_ID
JOIN camdecmpsmd.REPORTING_PERIOD BRP2
    ON X.BEGIN_RPT_PERIOD_ID2 = BRP2.RPT_PERIOD_ID
LEFT JOIN camdecmpsmd.REPORTING_PERIOD ERP2
    ON X.END_RPT_PERIOD_ID2 = ERP2.RPT_PERIOD_ID
ORDER BY VMP.ORIS_CODE, VMP.LOCATIONS;

-- 021. Recreate camdecmps.vw_monitor_location
-- Source: camdecmps/views/vw_monitor_location.sql
-- camdecmps.vw_monitor_location source
CREATE OR REPLACE VIEW camdecmps.vw_monitor_location
AS SELECT  ml.mon_loc_id,
           p.oris_code,
           p.facility_name,
           COALESCE( sp.stack_name, u.unitid ) AS location_identifier,
           p.fac_id,
           p.state,
           p.county_cd,
           u.unit_id,
           sp.stack_pipe_id,
           u.non_load_based_ind,
           sp.active_date,
           sp.retire_date,
           u.unitid,
           sp.stack_name,
           u.comr_op_date,
           u.comm_op_date
   FROM   camdecmps.monitor_location ml
              LEFT JOIN camd.unit u
                        ON u.unit_id = ml.unit_id
              LEFT JOIN camdecmps.stack_pipe sp
                        ON sp.stack_pipe_id::text = ml.stack_pipe_id::text
        JOIN camd.plant p
   ON p.fac_id in ( u.fac_id, sp.fac_id );

-- 022. Recreate camdecmps.vw_mp_em_inconsistencies
-- Source: camdecmps/views/vw_mp_em_inconsistencies.sql
CREATE OR REPLACE VIEW camdecmps.vw_mp_em_inconsistencies AS
SELECT
    VMP.ORIS_CODE,
    VMP.FACILITY_NAME,
    VMP.STATE,
    VMP.LOCATIONS,
    BRP.PERIOD_ABBREVIATION AS BEGIN_PERIOD,
    CASE
         WHEN X.END_RPT_PERIOD_ID IS NOT NULL
         THEN ERP.PERIOD_ABBREVIATION
         ELSE ''
    END AS END_PERIOD,
    NULL AS LOCATIONS2,
    RP.PERIOD_ABBREVIATION AS BEGIN_PERIOD2,
    NULL AS END_PERIOD2
FROM (
    SELECT
         MP.MON_PLAN_ID,
         E.RPT_PERIOD_ID,
         MP.BEGIN_RPT_PERIOD_ID,
         MP.END_RPT_PERIOD_ID
    FROM camdecmps.EMISSION_EVALUATION E
    JOIN camdecmps.MONITOR_PLAN MP
         ON E.MON_PLAN_ID = MP.MON_PLAN_ID
    WHERE E.RPT_PERIOD_ID < MP.BEGIN_RPT_PERIOD_ID
       OR E.RPT_PERIOD_ID > COALESCE(MP.END_RPT_PERIOD_ID, 999)
) X
JOIN camdecmps.VW_MONITOR_PLAN VMP
    ON X.MON_PLAN_ID = VMP.MON_PLAN_ID
JOIN camdecmpsmd.REPORTING_PERIOD BRP
    ON X.BEGIN_RPT_PERIOD_ID = BRP.RPT_PERIOD_ID
LEFT JOIN camdecmpsmd.REPORTING_PERIOD ERP
    ON X.END_RPT_PERIOD_ID = ERP.RPT_PERIOD_ID
JOIN camdecmpsmd.REPORTING_PERIOD RP
    ON X.RPT_PERIOD_ID = RP.RPT_PERIOD_ID
ORDER BY VMP.ORIS_CODE, VMP.LOCATIONS;

-- 023. Recreate camdecmps.vw_mp_unit_stack_configuration
-- Source: camdecmps/views/vw_mp_unit_stack_configuration.sql
-- View: camdecmps.vw_mp_unit_stack_configuration

CREATE OR REPLACE VIEW camdecmps.vw_mp_unit_stack_configuration AS SELECT DISTINCT
    mp.mon_plan_id,
    ml.mon_loc_id,
    usc.config_id,
    usc.begin_date,
    usc.end_date,
    sp.stack_name,
    u.unitid,
    sp.stack_pipe_id,
    u.unit_id,
    u.non_load_based_ind,
    ml1.mon_loc_id AS stack_pipe_mon_loc_id,
    sp.fac_id
FROM
    camdecmps.stack_pipe sp
    JOIN (camdecmps.unit_stack_configuration usc
        JOIN (camd.unit u
            JOIN (camdecmps.monitor_plan_location mpl
                JOIN camdecmps.monitor_plan mp ON mpl.mon_plan_id::text = mp.mon_plan_id::text
                JOIN camdecmps.monitor_location ml ON mpl.mon_loc_id::text = ml.mon_loc_id::text) ON u.unit_id = ml.unit_id) ON usc.unit_id = u.unit_id) ON sp.stack_pipe_id::text = usc.stack_pipe_id::text
    JOIN camdecmps.monitor_location ml1 ON sp.stack_pipe_id::text = ml1.stack_pipe_id::text;

-- 024. Recreate camdecmps.vw_qa_cert_event_eval_and_submit
-- Source: camdecmps/views/vw_test_extension_exemption_eval_and_submit.sql
CREATE OR REPLACE VIEW camdecmps.vw_qa_cert_event_eval_and_submit
 AS
 SELECT p.oris_code,
    p.facility_name,
    mpl.mon_plan_id,
    COALESCE(u.unitid, sp.stack_name) AS location_info,
    qce.qa_cert_event_id,
    qce.qa_cert_event_cd,
    qce.mon_loc_id,
    COALESCE(ms.system_identifier, c.component_identifier) AS system_component_identifier,
        CASE
            WHEN qce.qa_cert_event_date IS NULL THEN NULL::text
            ELSE concat(qce.qa_cert_event_date, ' ', lpad(COALESCE(qce.qa_cert_event_hour, 0::numeric)::text, 2, '0'::text), ':00')
        END AS event_date,
        CASE
            WHEN qce.conditional_data_begin_date IS NULL THEN NULL::text
            ELSE concat(qce.conditional_data_begin_date, ' ', lpad(COALESCE(qce.conditional_data_begin_hour, 0::numeric)::text, 2, '0'::text), ':00')
        END AS condition_date,
        CASE
            WHEN qce.last_test_completed_date IS NULL THEN NULL::text
            ELSE concat(qce.last_test_completed_date, ' ', lpad(COALESCE(qce.last_test_completed_hour, 0::numeric)::text, 2, '0'::text), ':00')
        END AS last_completion,
    qce.required_test_cd,
    qce.userid,
    COALESCE(qce.update_date, qce.add_date) AS update_date
   FROM camd.plant p
     JOIN camdecmps.monitor_plan mp USING (fac_id)
     JOIN camdecmps.monitor_plan_location mpl USING (mon_plan_id)
     JOIN camdecmps.monitor_location ml USING (mon_loc_id)
     JOIN camdecmps.qa_cert_event qce USING (mon_loc_id)
     LEFT JOIN camdecmps.monitor_system ms USING (mon_sys_id)
     LEFT JOIN camdecmps.component c USING (component_id)
     LEFT JOIN camd.unit u USING (unit_id)
     LEFT JOIN camdecmps.stack_pipe sp USING (stack_pipe_id)
  ORDER BY p.oris_code, mp.mon_plan_id, u.unitid, sp.stack_name, qce.qa_cert_event_date, qce.qa_cert_event_hour;

-- 025. Recreate camdecmps.vw_qa_cert_event_maintenance
-- Source: camdecmps/views/vw_qa_cert_event_maintenance.sql
-- View: camdecmps.vw_qa_cert_event_maintenance


CREATE OR REPLACE VIEW camdecmps.vw_qa_cert_event_maintenance
AS SELECT qce.qa_cert_event_id AS cert_event_id,
    qce.mon_loc_id AS location_id,
    qce.resub_explanation,
    COALESCE(up.oris_code, spp.oris_code) AS oris_code,
    COALESCE(u.unitid, sp.stack_name) AS unit_stack,
    ms.system_identifier,
    c.component_identifier,
    cec.qa_cert_event_cd AS cert_event_cd,
    cec.qa_cert_event_cd_description AS cert_event_description,
    camdecmps.format_date_hour(qce.qa_cert_event_date, qce.qa_cert_event_hour, 0::numeric) AS event_date_time,
    rtc.required_test_cd,
    rtc.required_test_cd_description AS required_test_description,
    camdecmps.format_date_hour(qce.conditional_data_begin_date, qce.conditional_data_begin_hour, 0::numeric) AS conditional_date_time,
    camdecmps.format_date_hour(qce.last_test_completed_date, qce.last_test_completed_hour, 0::numeric) AS last_completed_date_time,
    sac.submission_availability_cd,
    sac.sub_avail_cd_description AS submission_availability_description,
    sc.severity_cd,
    sc.severity_cd_description AS severity_description
   FROM camdecmps.qa_cert_event qce
     JOIN camdecmps.monitor_location ml ON ml.mon_loc_id::text = qce.mon_loc_id::text
     JOIN camdecmpsmd.submission_availability_code sac USING (submission_availability_cd)
     JOIN camdecmpsmd.qa_cert_event_code cec USING (qa_cert_event_cd)
     JOIN camdecmpsmd.required_test_code rtc USING (required_test_cd)
     LEFT JOIN camdecmpsaux.check_session cs ON cs.chk_session_id::text = qce.chk_session_id::text
     LEFT JOIN camdecmpsmd.severity_code sc USING (severity_cd)
     LEFT JOIN camdecmps.monitor_system ms ON ms.mon_sys_id::text = qce.mon_sys_id::text
     LEFT JOIN camdecmps.component c ON c.component_id::text = qce.component_id::text
     LEFT JOIN camdecmps.stack_pipe sp USING (stack_pipe_id)
     LEFT JOIN camd.unit u USING (unit_id)
     LEFT JOIN camd.plant up ON up.fac_id = u.fac_id
     LEFT JOIN camd.plant spp ON spp.fac_id = sp.fac_id;

-- 026. Recreate camdecmps.vw_qa_test_extens_exempt_maintenance
-- Source: camdecmps/views/vw_qa_test_extens_exempt_maintenance.sql
-- View: camdecmps.vw_qa_test_extens_exempt_maintenance


CREATE OR REPLACE VIEW camdecmps.vw_qa_test_extens_exempt_maintenance
AS SELECT tee.test_extension_exemption_id,
    tee.mon_loc_id AS location_id,
    tee.resub_explanation,
    COALESCE(up.oris_code, spp.oris_code) AS oris_code,
    COALESCE(u.unitid, sp.stack_name) AS unit_stack,
    ms.system_identifier,
    c.component_identifier,
    fc.fuel_cd,
    fc.fuel_cd_description AS fuel_description,
    eec.extens_exempt_cd AS extension_exemption_cd,
    eec.extens_exemp_cd_description AS extension_exemption_description,
    rp.period_abbreviation AS year_quarter,
    tee.hours_used,
    tee.span_scale_cd,
    sac.submission_availability_cd,
    sac.sub_avail_cd_description AS submission_availability_description,
    sc.severity_cd,
    sc.severity_cd_description AS severity_description
   FROM camdecmps.test_extension_exemption tee
     JOIN camdecmps.monitor_location ml ON ml.mon_loc_id::text = tee.mon_loc_id::text
     JOIN camdecmpsmd.submission_availability_code sac USING (submission_availability_cd)
     JOIN camdecmpsmd.extension_exemption_code eec USING (extens_exempt_cd)
     LEFT JOIN camdecmpsmd.fuel_code fc USING (fuel_cd)
     LEFT JOIN camdecmpsmd.reporting_period rp ON rp.rpt_period_id = tee.rpt_period_id
     LEFT JOIN camdecmpsaux.check_session cs ON cs.chk_session_id::text = tee.chk_session_id::text
     LEFT JOIN camdecmpsmd.severity_code sc USING (severity_cd)
     LEFT JOIN camdecmps.monitor_system ms ON ms.mon_sys_id::text = tee.mon_sys_id::text
     LEFT JOIN camdecmps.component c ON c.component_id::text = tee.component_id::text
     LEFT JOIN camdecmps.stack_pipe sp USING (stack_pipe_id)
     LEFT JOIN camd.unit u USING (unit_id)
     LEFT JOIN camd.plant up ON up.fac_id = u.fac_id
     LEFT JOIN camd.plant spp ON spp.fac_id = sp.fac_id;

-- 027. Recreate camdecmps.vw_qa_test_summary_maintenance
-- Source: camdecmps/views/vw_qa_test_summary_maintenance.sql
-- View: camdecmps.vw_qa_test_summary_maintenance


CREATE OR REPLACE VIEW camdecmps.vw_qa_test_summary_maintenance
AS SELECT ts.test_sum_id,
    ts.mon_loc_id AS location_id,
    COALESCE(up.oris_code, spp.oris_code) AS oris_code,
    COALESCE(u.unitid, sp.stack_name) AS unit_stack,
    ms.system_identifier,
    c.component_identifier,
    ts.test_num AS test_number,
    ts.gp_ind AS grace_period_indicator,
    ts.test_type_cd,
    ts.test_reason_cd,
    ts.test_result_cd,
    rp.period_abbreviation AS year_quarter,
    ts.test_description,
    camdecmps.format_date_hour(ts.begin_date, ts.begin_hour, ts.begin_min) AS begin_date_time,
    camdecmps.format_date_hour(ts.end_date, ts.end_hour, ts.end_min) AS end_date_time,
    ts.test_comment,
    ts.span_scale_cd,
    ts.injection_protocol_cd,
    sd.resub_explanation,
    sac.submission_availability_cd,
    sac.sub_avail_cd_description AS submission_availability_description,
    sc.severity_cd,
    sc.severity_cd_description AS severity_description
   FROM camdecmps.test_summary ts
     JOIN camdecmps.qa_supp_data sd USING (test_sum_id)
     JOIN camdecmps.monitor_location ml ON ml.mon_loc_id::text = ts.mon_loc_id::text
     JOIN camdecmpsmd.submission_availability_code sac USING (submission_availability_cd)
     LEFT JOIN camdecmpsmd.reporting_period rp ON rp.rpt_period_id = ts.rpt_period_id
     LEFT JOIN camdecmpsaux.check_session cs ON cs.chk_session_id::text = ts.chk_session_id::text
     LEFT JOIN camdecmpsmd.severity_code sc USING (severity_cd)
     LEFT JOIN camdecmps.monitor_system ms ON ms.mon_sys_id::text = ts.mon_sys_id::text
     LEFT JOIN camdecmps.component c ON c.component_id::text = ts.component_id::text
     LEFT JOIN camdecmps.stack_pipe sp USING (stack_pipe_id)
     LEFT JOIN camd.unit u USING (unit_id)
     LEFT JOIN camd.plant up ON up.fac_id = u.fac_id
     LEFT JOIN camd.plant spp ON spp.fac_id = sp.fac_id;

-- 028. Recreate camdecmps.vw_test_extension_exemption_eval_and_submit
-- Source: camdecmps/views/vw_qa_cert_event_eval_and_submit.sql
CREATE OR REPLACE VIEW camdecmps.vw_test_extension_exemption_eval_and_submit
 AS
 SELECT p.oris_code,
    p.facility_name,
    mpl.mon_plan_id,
    COALESCE(u.unitid, sp.stack_name) AS location_info,
    tee.test_extension_exemption_id,
    tee.extens_exempt_cd,
    tee.mon_loc_id,
    COALESCE(ms.system_identifier, c.component_identifier) AS system_component_identifier,
    tee.rpt_period_id,
    tee.userid,
    COALESCE(tee.update_date, tee.add_date) AS update_date,
	tee.fuel_cd,
    tee.hours_used,
    tee.span_scale_cd,
    rp.period_abbreviation
   FROM camd.plant p
     JOIN camdecmps.monitor_plan mp USING (fac_id)
     JOIN camdecmps.monitor_plan_location mpl USING (mon_plan_id)
     JOIN camdecmps.monitor_location ml USING (mon_loc_id)
     JOIN camdecmps.test_extension_exemption tee USING (mon_loc_id)
     LEFT JOIN camdecmps.monitor_system ms USING (mon_sys_id)
     LEFT JOIN camdecmps.component c USING (component_id)
     LEFT JOIN camdecmpsmd.reporting_period rp ON rp.rpt_period_id = tee.rpt_period_id
     LEFT JOIN camd.unit u USING (unit_id)
     LEFT JOIN camdecmps.stack_pipe sp USING (stack_pipe_id)
  ORDER BY p.oris_code, mp.mon_plan_id, u.unitid, sp.stack_name, tee.rpt_period_id;

-- 029. Recreate camdecmps.vw_test_summary_eval_and_submit
-- Source: camdecmps/views/vw_test_summary_eval_and_submit.sql
-- View: camdecmpswks.vw_test_summary_eval_and_submit


CREATE OR REPLACE VIEW camdecmps.vw_test_summary_eval_and_submit
 AS
 SELECT p.oris_code,
    p.facility_name,
    mpl.mon_plan_id,
    COALESCE(u.unitid, sp.stack_name) AS location_info,
    ts.test_sum_id,
    ts.mon_loc_id,
    COALESCE(ms.system_identifier, c.component_identifier) AS system_component_identifier,
    ts.test_num,
    ts.gp_ind,
    ts.test_type_cd,
    ts.test_reason_cd,
    ts.test_result_cd,
    qsd.rpt_period_id,
        CASE
            WHEN ts.begin_date IS NULL THEN NULL::text
            ELSE concat(ts.begin_date, ' ', lpad(COALESCE(ts.begin_hour, 0::numeric)::text, 2, '0'::text), ':', lpad(COALESCE(ts.begin_min, 0::numeric)::text, 2, '0'::text))
        END AS begin_date,
        CASE
            WHEN ts.end_date IS NULL THEN NULL::text
            ELSE concat(ts.end_date, ' ', lpad(COALESCE(ts.end_hour, 0::numeric)::text, 2, '0'::text), ':', lpad(COALESCE(ts.end_min, 0::numeric)::text, 2, '0'::text))
        END AS end_date,
    ts.updated_status_flg,
    ts.userid,
    ts.add_date,
    COALESCE(ts.update_date, ts.add_date) AS update_date,
    rp.period_abbreviation
   FROM camd.plant p
     JOIN camdecmps.monitor_plan mp USING (fac_id)
     JOIN camdecmps.monitor_plan_location mpl USING (mon_plan_id)
     JOIN camdecmps.monitor_location ml USING (mon_loc_id)
     JOIN camdecmps.test_summary ts USING (mon_loc_id)
     LEFT JOIN camdecmps.qa_supp_data qsd USING (test_sum_id)
	 LEFT JOIN camdecmps.monitor_system ms ON ms.mon_sys_id::text = ts.mon_sys_id::text
     LEFT JOIN camdecmps.component c ON c.component_id::text = ts.component_id::text
     LEFT JOIN camdecmpsmd.reporting_period rp ON rp.rpt_period_id = ts.rpt_period_id
     LEFT JOIN camd.unit u USING (unit_id)
     LEFT JOIN camdecmps.stack_pipe sp USING (stack_pipe_id)
  ORDER BY p.oris_code, mp.mon_plan_id, u.unitid, sp.stack_name, ts.test_type_cd, qsd.rpt_period_id, ts.end_date, ts.end_hour, ts.end_min;

-- 030. Recreate camdecmps.vw_unit_program_exemption
-- Source: camdecmps/views/vw_unit_program_exemption.sql
-- View: camdecmps.vw_unit_program_exemption


CREATE OR REPLACE VIEW camdecmps.vw_unit_program_exemption
 AS
 SELECT ml.mon_loc_id,
    u.unit_id,
    u.fac_id,
    up.prg_cd,
    up.up_id,
    pe.exemption_type_cd AS exempt_type_cd,
    ue.ex_rec_date,
    ue.begin_date,
    ue.end_date
   FROM camd.unit_program up
     JOIN camd.unit u ON u.unit_id = up.unit_id
     JOIN camdecmps.monitor_location ml ON u.unit_id = ml.unit_id
     JOIN camdmd.program_exemption pe ON pe.prg_cd::text = up.prg_cd::text
     JOIN camd.unit_exemption ue ON ue.unit_id = up.unit_id AND ue.exemption_type_cd::text = pe.exemption_type_cd::text;

-- 031. Recreate camdecmpsaux.vw_combined_submissions
-- Source: camdecmpsaux/views/vw_combined_submissions.sql
CREATE OR REPLACE VIEW camdecmpsaux.vw_combined_submissions
 AS
 SELECT sq.submission_id,
    sq.process_cd,
    sq.severity_cd,
    ss.fac_id,
    ss.mon_plan_id,
    sq.rpt_period_id,
    ss.submission_set_id,
    sq.queued_time AS submitted_on,
    ss.user_id,
    CASE
        WHEN ss.status_cd = 'WIP' THEN ss.started_time
        WHEN ss.status_cd = 'COMPLETE' THEN ss.completed_time
        ELSE NULL
    END AS submission_end_stage_time,
	ss.status_cd
   FROM camdecmpsaux.submission_set ss
     JOIN camdecmpsaux.submission_queue sq USING (submission_set_id);

-- 032. Recreate camdecmpsaux.vw_em_submission_access
-- Source: camdecmpsaux/views/vw_em_submission_access.sql
CREATE OR REPLACE VIEW camdecmpsaux.vw_em_submission_access AS
SELECT
    em.em_sub_access_id,
    em.mon_plan_id,
    em.rpt_period_id,
    em.access_begin_date,
    em.access_end_date,
    stc.em_sub_type_cd,
    stc.em_sub_type_cd_description,
    em.userid,
    em.add_date,
    em.update_date,
    statc.em_status_cd,
    statc.em_status_cd_description,
    sac.submission_availability_cd AS sub_availability_cd,
    sac.sub_avail_cd_description AS sub_availability_cd_description,
    em.resub_explanation,
    pl.fac_id,
    pl.oris_code,
    pl.state,
    pl.facility_name,
    rp.calendar_year,
    rp.quarter,
    rp.period_abbreviation,
    rf.report_freq_cd,
    sq.submission_id,
    sq.queued_time AS submission_date,
    sc.severity_cd,
    sc.severity_cd_description,
    CASE
        WHEN em.sub_availability_cd = 'DELETE' THEN 'Cancelled'
        WHEN em.em_status_cd = 'PENDING' THEN 'Pending Approval'
        WHEN em.sub_availability_cd IS NULL AND em.access_end_date::date >= CURRENT_DATE THEN 'Not Yet Open'
        WHEN em.sub_availability_cd IN ('GRANTED', 'REQUIRE') THEN 'Open'
        ELSE 'Closed'
    END AS window_status,
    CASE
        WHEN sc.severity_cd = 'CRIT1' THEN 'Received with Critical 1 Errors'
        WHEN sq.submission_id IS NULL AND em.em_status_cd = 'RECVD' AND em.mon_plan_id IS NOT NULL THEN 'Received via ETS'
        WHEN sc.severity_cd = 'CRIT2' THEN 'Received with Critical 2 Errors'
        WHEN sc.severity_cd IS NOT NULL THEN 'Received'
        WHEN sq.submission_id IS NOT NULL THEN 'Data Not Loaded'
        ELSE 'No Submission'
    END AS submission_status,
    mp.locations,
    CASE
        WHEN em.access_begin_date = (
            SELECT MAX(esa_max.access_begin_date) AS access_begin_date
              FROM camdecmpsaux.em_submission_access esa_max
             WHERE esa_max.mon_plan_id = em.mon_plan_id
               AND esa_max.rpt_period_id = em.rpt_period_id
               AND (esa_max.sub_availability_cd <> 'DELETE' OR esa_max.sub_availability_cd IS null)
             GROUP BY esa_max.mon_plan_id, esa_max.rpt_period_id
             )
        THEN 'Yes'
        ELSE 'No'
    END AS last_window,
    CASE
        WHEN ee.mon_plan_id IS NULL THEN 'No'
        ELSE 'Yes'
    END AS accepted_submission_in_period,
    CASE
        WHEN ee.mon_plan_id IS NULL THEN 'No'
        WHEN sq.submission_id IS NULL AND em.em_status_cd = 'RECVD' AND ee.submission_id IS NULL THEN 'Yes'
        WHEN sq.submission_id IS NOT NULL AND ee.submission_id IS NOT NULL AND sq.submission_id = ee.submission_id THEN 'Yes'
        WHEN ee.submission_id IS NOT NULL THEN 'No'
        ELSE 'Unknown'
    END AS last_window_with_ok_submission,
    ss.user_id AS submitter_user_id
FROM camdecmpsaux.em_submission_access em
JOIN camdecmps.vw_monitor_plan mp USING(mon_plan_id)
JOIN camdecmps.monitor_plan_reporting_freq rf
    ON rf.mon_plan_id = em.mon_plan_id
    AND (
         (rf.begin_rpt_period_id <= em.rpt_period_id AND rf.end_rpt_period_id IS NULL)
         OR (rf.begin_rpt_period_id <= em.rpt_period_id AND rf.end_rpt_period_id >= em.rpt_period_id)
    )
JOIN camdecmpsmd.reporting_period rp USING (rpt_period_id)
JOIN camdecmpsmd.em_status_code statc USING (em_status_cd)
JOIN camdecmpsmd.em_sub_type_code stc USING (em_sub_type_cd)
LEFT JOIN camdecmpsmd.submission_availability_code sac
    ON em.sub_availability_cd = sac.submission_availability_cd
JOIN camd.plant pl USING(fac_id)
LEFT JOIN camdecmpsaux.submission_queue sq
    ON sq.submission_id = em.submission_id
LEFT JOIN camdecmpsaux.submission_set ss
    ON ss.submission_set_id = sq.submission_set_id
LEFT JOIN camdecmpsmd.severity_code sc
    ON sq.severity_cd = sc.severity_cd
LEFT JOIN camdecmps.emission_evaluation ee
    ON ee.mon_plan_id = em.mon_plan_id
   AND ee.rpt_period_id = em.rpt_period_id
GROUP BY
    em.em_sub_access_id,
    em.mon_plan_id,
    em.rpt_period_id,
    em.access_begin_date,
    em.access_end_date,
    stc.em_sub_type_cd,
    stc.em_sub_type_cd_description,
    em.userid,
    em.add_date,
    em.update_date,
    statc.em_status_cd,
    statc.em_status_cd_description,
    sac.submission_availability_cd,
    sac.sub_avail_cd_description,
    em.resub_explanation,
    pl.fac_id,
    pl.oris_code,
    pl.state,
    pl.facility_name,
    rp.calendar_year,
    rp.quarter,
    rp.period_abbreviation,
    rf.report_freq_cd,
    sq.submission_id,
    sq.queued_time,
    sc.severity_cd,
    sc.severity_cd_description,
    mp.locations,
    ee.mon_plan_id,
    ee.submission_id,
	ss.user_id
ORDER BY
    em.rpt_period_id DESC,
    em.access_begin_date DESC;

-- 033. Recreate camdecmpsaux.vw_evaluation_queue_position
-- Source: camdecmpsaux/views/vw_evaluation_queue_position.sql
CREATE OR REPLACE VIEW camdecmpsaux.vw_evaluation_queue_position AS
SELECT
        evs.evaluation_set_id,
        evq.evaluation_id,
        evs.mon_plan_id,
        evq.test_sum_id,
        evq.qa_cert_event_id,
        evq.test_extension_exemption_id,
        prd.period_abbreviation,
        evq.process_cd,
        evs.oris_code,
        ROW_NUMBER() OVER (ORDER BY evs.queued_time, evq.evaluation_id) as "queuePosition"
      FROM
        camdecmpsaux.evaluation_set evs
      JOIN camdecmpsaux.evaluation_queue evq
        ON evq.evaluation_set_id = evs.evaluation_set_id
        AND evq.status_cd IN ('QUEUED', 'CLAIMED')
      LEFT JOIN camdecmpswks.monitor_plan pln
        ON pln.mon_plan_id = evs.mon_plan_id
      LEFT JOIN camdecmpswks.test_summary tst
        ON tst.test_sum_id = evq.test_sum_id
      LEFT JOIN camdecmpswks.qa_cert_event qce
        ON qce.qa_cert_event_id = evq.qa_cert_event_id
      LEFT JOIN camdecmpswks.test_extension_exemption tee
        ON tee.test_extension_exemption_id = evq.test_extension_exemption_id
      LEFT JOIN camdecmpswks.emission_evaluation ems
        ON ems.mon_plan_id = evs.mon_plan_id
        AND ems.rpt_period_id = evq.rpt_period_id
      LEFT JOIN camdecmpsmd.reporting_period prd ON prd.rpt_period_id = ems.rpt_period_id;

-- 034. Recreate camdecmpsaux.vw_last_submission
-- Source: camdecmpsaux/views/vw_last_submission.sql
create or replace
view camdecmpsaux.vw_last_submission
as
select
	sq.submission_id,
	sq.completed_time,
	sq.status_cd,
	ss.mon_plan_id,
	sq.process_cd,
	sq.test_sum_id,
	sq.qa_cert_event_id,
	sq.test_extension_exemption_id,
	sq.rpt_period_id,
	sub_last.submission_id as last_submission_id
from
	camdecmpsaux.submission_set ss
join camdecmpsaux.submission_queue sq on
	ss.submission_set_id = sq.submission_set_id
left join (
	select
		sq_last.submission_id,
		ss_last.mon_plan_id,
		sq_last.process_cd,
		sq_last.test_sum_id,
		sq_last.qa_cert_event_id,
		sq_last.test_extension_exemption_id,
		sq_last.rpt_period_id,
		max(sq_last.completed_time) completed_time
	from
		camdecmpsaux.submission_set ss_last
	join camdecmpsaux.submission_queue sq_last on
			ss_last.submission_set_id = sq_last.submission_set_id
		and sq_last.status_cd = 'COMPLETE'
	group by
		sq_last.submission_id,
		ss_last.mon_plan_id,
		sq_last.process_cd,
		sq_last.test_sum_id,
		sq_last.qa_cert_event_id,
		sq_last.test_extension_exemption_id,
		sq_last.rpt_period_id) sub_last
on
	ss.mon_plan_id = sub_last.mon_plan_id
	and sq.process_cd = sub_last.process_cd
	and ((sq.process_cd = 'MP'
		and ss.mon_plan_id = sub_last.mon_plan_id)
	or (sq.process_cd = 'QA'
		and sq.test_sum_id = sub_last.test_sum_id)
	or (sq.process_cd = 'QA'
		and sq.qa_cert_event_id = sub_last.qa_cert_event_id)
	or (sq.process_cd = 'QA'
		and sq.test_extension_exemption_id = sub_last.test_extension_exemption_id)
	or (sq.process_cd = 'EM'
		and ss.mon_plan_id = sub_last.mon_plan_id
		and sq.rpt_period_id = sub_last.rpt_period_id))
	and sq.completed_time = sub_last.completed_time;

-- 035. Recreate camdecmpsaux.vw_submission_list
-- Source: camdecmpsaux/views/vw_submission_list.sql
CREATE OR REPLACE VIEW camdecmpsaux.vw_submission_list
 AS
select  fac.oris_code,
        fac.facility_name,
        fac.state,
        case ( sbq.process_cd )
            when 'QA' then
                case
                    when sbq.test_sum_id is not null then 'QAT'
                    when sbq.qa_cert_event_id is not null then 'QCE'
                    when sbq.test_extension_exemption_id is not null then 'TEE'
                    else sbq.process_cd
                end
            else null
        end as qa_data_type_cd,
        ts.test_type_cd as test_type_cd,
        pln.locations,
        prd.period_abbreviation as reporting_period,
        case
            when sbq.process_cd = 'MP' then
                null
            when sbq.process_cd = 'EM' then
                (
                    select  prd.period_abbreviation
                      from  camdecmpsmd.REPORTING_PERIOD prd
                     where  prd.rpt_period_id = sbq.rpt_period_id
                )
            when sbq.process_cd = 'QA' and sbq.test_sum_id is not null then
                (
                    select
                    	case
                    	when tst.test_type_cd is not null and tst.test_num is not null
                    	then tst.test_type_cd || ' - ' || tst.test_num
                    	end
                      from  camdecmps.TEST_SUMMARY tst
                     where  tst.test_sum_id = sbq.test_sum_id
                   UNION ALL
                     SELECT 'Data Unavailable'
					 WHERE NOT EXISTS (
					  SELECT 1 from  camdecmps.TEST_SUMMARY tst
                     where  tst.test_sum_id = sbq.test_sum_id
                     )
                )
            when sbq.process_cd = 'QA' and sbq.qa_cert_event_id is not null then
                (
                select
                	case
	                	when sys.sys_type_cd  is not null and sys.system_identifier is not null and cmp.component_type_cd  is not null and cmp.component_identifier is not null
	                	then qce.qa_cert_event_cd || ' (' || camdecmps.format_date_hour(qce.qa_cert_event_date, qce.qa_cert_event_hour, 0::numeric) || ') S: (' || sys.sys_type_cd || '/' || sys.system_identifier || ') C: (' || cmp.component_type_cd || '/' || cmp.component_identifier || ')'
                		when sys.sys_type_cd  is not null and sys.system_identifier is not null
                		then qce.qa_cert_event_cd || ' (' || camdecmps.format_date_hour(qce.qa_cert_event_date, qce.qa_cert_event_hour, 0::numeric) || ') S: (' || sys.sys_type_cd || '/' || sys.system_identifier || ')'
                		when cmp.component_type_cd  is not null and cmp.component_identifier is not null
                		then qce.qa_cert_event_cd || ' (' || camdecmps.format_date_hour(qce.qa_cert_event_date, qce.qa_cert_event_hour, 0::numeric) || ') C: (' || cmp.component_type_cd || '/' || cmp.component_identifier || ')'
                	end
                    from  camdecmps.QA_CERT_EVENT qce
                            left join camdecmps.MONITOR_SYSTEM sys using ( mon_sys_id )
                            left join camdecmps.COMPONENT cmp using ( component_id )
                     where  qce.qa_cert_event_id = sbq.qa_cert_event_id
                UNION ALL
                     SELECT 'Data Unavailable'
					 WHERE NOT EXISTS (
					  SELECT 1 from  camdecmps.QA_CERT_EVENT qce
                     where  qce.qa_cert_event_id = sbq.qa_cert_event_id
                     )
                )
            when sbq.process_cd = 'QA' and sbq.test_extension_exemption_id is not null then
                (
                 select
                	case
                    	when tee.extens_exempt_cd is not null and prd.period_abbreviation is not null and sys.sys_type_cd  is not null and sys.system_identifier is not null and cmp.component_type_cd  is not null and cmp.component_identifier is not null
	                	then tee.extens_exempt_cd || ' (' || prd.period_abbreviation || ') S: (' || sys.sys_type_cd || '/' || sys.system_identifier || ') C: (' || cmp.component_type_cd || '/' || cmp.component_identifier ||  ')'
	                	when tee.extens_exempt_cd is not null and prd.period_abbreviation is not null and sys.sys_type_cd  is not null and sys.system_identifier is not null
	                	then tee.extens_exempt_cd || ' (' || prd.period_abbreviation || ') S: (' || sys.sys_type_cd || '/' || sys.system_identifier || ')'
                        when tee.extens_exempt_cd is not null and prd.period_abbreviation is not null and cmp.component_type_cd  is not null and cmp.component_identifier is not null
	                	then tee.extens_exempt_cd || ' (' || prd.period_abbreviation || ') C: (' || cmp.component_type_cd || '/' || cmp.component_identifier ||  ')'
	                	else tee.extens_exempt_cd || ' (' || prd.period_abbreviation || ')'
                    end
                      from  camdecmps.TEST_EXTENSION_EXEMPTION tee
                            join camdecmpsmd.REPORTING_PERIOD prd using ( rpt_period_id )
                            left join camdecmps.MONITOR_SYSTEM sys using ( mon_sys_id )
                            left join camdecmps.COMPONENT cmp using ( component_id )
                     where  tee.test_extension_exemption_id = sbq.test_extension_exemption_id
                UNION ALL
                     SELECT 'Data Unavailable'
					 WHERE NOT EXISTS (
					  SELECT 1 from  camdecmps.TEST_EXTENSION_EXEMPTION tee
                     where  tee.test_extension_exemption_id = sbq.test_extension_exemption_id
                     )
                )
        end as identifying_information,
        (
           select  rfc.report_freq_cd_description
             from  camdecmps.MONITOR_PLAN_REPORTING_FREQ frq
                   join camdecmpsmd.report_freq_code rfc using ( report_freq_cd )
            where  frq.mon_plan_id = sbs.mon_plan_id
            order
               by  frq.end_rpt_period_id desc
            limit  1
       ) as reporting_frequency,
       sbq.process_cd,
       sbq.submission_id,
       sbq.queued_time,
       sev.severity_cd_description as severity_level,
       case
          when sbq.submission_id = ls.last_submission_id
          then 'Yes'
          else 'No'
       end most_recent,
       sbq.status_cd as submission_status,
       sbq.severity_cd,
       sbs.user_id as submitter,
       sbs.mon_plan_id,
       sbq.rpt_period_id
  from  camdecmpsaux.SUBMISSION_QUEUE sbq
        join camdecmpsaux.SUBMISSION_SET sbs using ( submission_set_id )
        join camd.PLANT fac using ( fac_id )
        join camdecmps.VW_MONITOR_PLAN pln using ( mon_plan_id )
        left join camdecmpsmd.REPORTING_PERIOD prd using( rpt_period_id )
        left join camdecmpsmd.SEVERITY_CODE sev using ( severity_cd )
        left join camdecmps.test_summary ts on ts.test_sum_id = sbq.test_sum_id
        join camdecmpsaux.vw_last_submission ls using (submission_id)
        where  sbq.process_cd IN ('EM', 'QA', 'MP')
 order
    by  oris_code,
        locations,
        submission_id desc;

-- 036. Recreate camdecmpsaux.vw_submission_queue_position
-- Source: camdecmpsaux/views/vw_submission_queue_position.sql
CREATE OR REPLACE VIEW camdecmpsaux.vw_submission_queue_position AS
SELECT
        ss.submission_set_id,
        sq.submission_id,
        ss.mon_plan_id,
        sq.test_sum_id,
        sq.qa_cert_event_id,
        sq.test_extension_exemption_id,
        prd.period_abbreviation,
        sq.process_cd,
        ss.oris_code,
        ROW_NUMBER() OVER (
          ORDER BY ss.queued_time, sq.submission_id
        ) as "queuePosition"
      FROM
        camdecmpsaux.submission_set ss
      JOIN camdecmpsaux.submission_queue sq
        ON sq.submission_set_id = ss.submission_set_id
        AND sq.status_cd = 'QUEUED'
      LEFT JOIN camdecmpswks.monitor_plan pln
        ON pln.mon_plan_id = ss.mon_plan_id
      LEFT JOIN camdecmpswks.test_summary tst
        ON tst.test_sum_id = sq.test_sum_id
      LEFT JOIN camdecmpswks.qa_cert_event qce
        ON qce.qa_cert_event_id = sq.qa_cert_event_id
      LEFT JOIN camdecmpswks.test_extension_exemption tee
        ON tee.test_extension_exemption_id = sq.test_extension_exemption_id
      LEFT JOIN camdecmpswks.emission_evaluation ems
        ON ems.mon_plan_id = ss.mon_plan_id
        AND ems.rpt_period_id = sq.rpt_period_id
      LEFT JOIN camdecmpsmd.reporting_period prd ON prd.rpt_period_id = ems.rpt_period_id;

-- 037. Recreate camdecmpsaux.vw_submission_window_job_close
-- Source: camdecmpsaux/views/vw_submission_window_job_close.sql
create or replace
view camdecmpsaux.vw_submission_window_job_close
as
select
	MP.FAC_ID,
	MP.ORIS_CODE,
	MP.FACILITY_NAME,
	ESA.MON_PLAN_ID,
	MP.LOCATIONS,
	ESA.RPT_PERIOD_ID,
	RP.CALENDAR_YEAR,
	RP.QUARTER,
	ESA.EM_SUB_ACCESS_ID,
	ESA.ACCESS_BEGIN_DATE,
	ESA.ACCESS_END_DATE,
	ESA.SUB_AVAILABILITY_CD,
	ESA.EM_STATUS_CD,
	ESA.EM_SUB_TYPE_CD,
	S.STATUS_CD as SUBMISSION_STATUS_CD,
	S.SEVERITY_CD,
	case
		when ESA.SUB_AVAILABILITY_CD = 'UPDATED' AND
			S.SEVERITY_CD = 'CRIT2' then 'T'
		else 'F'
	end as REOPEN_CRIT2,
	case
		when ESA.EM_SUB_TYPE_CD = 'INITIAL' AND
			(ESA.SUB_AVAILABILITY_CD <> 'UPDATED' OR
			 S.SEVERITY_CD = 'CRIT2') then 'T'
		else 'F'
	end as CHECK_FOR_REMINDER,
	case
        when S.SUBMISSION_ID IS NULL THEN 'T' --Also, extend the window if there are no submissions
		when S.STATUS_CD IN ('NOLOAD') OR
             S.SEVERITY_CD IN ('CRIT1','CRIT2')
        then 'T'
		else 'F'
	end as EXTEND_WINDOW
from
	CAMDECMPSAUX.EM_SUBMISSION_ACCESS ESA
join CAMDECMPS.VW_MONITOR_PLAN MP on
	ESA.MON_PLAN_ID = MP.MON_PLAN_ID
join CAMDECMPSMD.REPORTING_PERIOD RP on
	ESA.RPT_PERIOD_ID = RP.RPT_PERIOD_ID
left join CAMDECMPSAUX.SUBMISSION_QUEUE S on
    ESA.SUBMISSION_ID = S.SUBMISSION_ID
where
	(ESA.SUB_AVAILABILITY_CD in ('REQUIRE', 'GRANTED')
		or (ESA.SUB_AVAILABILITY_CD = 'UPDATED'
			and S.SEVERITY_CD = 'CRIT2'));

-- 038. Recreate camdecmpsaux.vw_submission_window_job_open
-- Source: camdecmpsaux/views/vw_submission_window_job_open.sql
create or replace
view camdecmpsaux.vw_submission_window_job_open
as
select
	mp.fac_id,
	mp.oris_code,
	mp.facility_name,
	MP.MON_PLAN_ID,
	mp.locations,
	ers.rpt_period_id,
	ers.calendar_year,
	ers.quarter,
	max(ers.em_reporting_status) as EM_SUB_STATUS,
	em.sub_availability_cd,
	em.em_status_cd,
	em.em_sub_access_id,
	case
		when sum(case when exists(select 1
									from CAMDECMPS.MONITOR_PLAN_LOCATION MPL
										join CAMDECMPS.MONITOR_LOCATION ML
											on MPL.MON_LOC_ID = ML.MON_LOC_ID
										join CAMDECMPS.OPERATING_SUPP_DATA O
											on MPL.MON_LOC_ID = O.MON_LOC_ID
									where mpl.mon_plan_id = mp.mon_plan_id) then 0 else 1 end) > 0 then 'T'
		else 'F'
	end as CREATE_PENDING
	from
		CAMDECMPS.VW_MONITOR_PLAN MP
	join CAMDECMPS.vw_em_reporting_status ers
	on
		mp.fac_id = ers.fac_id
		and mp.mon_plan_id = ers.mon_plan_id
		and ers.em_reporting_status is not null
	left join CAMDECMPSAUX.EM_SUBMISSION_ACCESS EM
	on
		ERS.MON_PLAN_ID = EM.MON_PLAN_ID
		and ERS.rpt_period_id = EM.rpt_period_id
		and EM.EM_SUB_TYPE_CD = 'INITIAL'
	group by
		mp.fac_id,
		mp.oris_code,
		mp.facility_name,
		MP.mon_plan_id,
		mp.locations,
		ers.rpt_period_id,
		ers.calendar_year,
		ers.quarter,
		em.em_sub_access_id;

-- 039. Recreate camdecmpsmd.vw_check_catalog_plugin
-- Source: camdecmpsmd/views/vw_check_catalog_plugin.sql
-- View: camdecmpsmd.vw_check_catalog_plugin


CREATE OR REPLACE VIEW camdecmpsmd.vw_check_catalog_plugin
 AS
 SELECT ccp.check_catalog_plugin_id,
    ccp.check_catalog_id,
    cc.check_type_cd,
    cc.check_number,
    cc.check_name,
    ccp.plugin_name,
    ccp.plugin_type_cd,
    ptc.plugin_type_cd_description,
    ccp.check_param_id,
    cpc.display_name AS check_param_id_display_name,
    cpc.check_param_id_name,
    ccp.field_name
   FROM camdecmpsmd.check_catalog_plugin ccp
     JOIN camdecmpsmd.check_catalog cc ON ccp.check_catalog_id::numeric = cc.check_catalog_id
     LEFT JOIN camdecmpsmd.check_parameter_code cpc ON ccp.check_param_id = cpc.check_param_id
     LEFT JOIN camdecmpsmd.plugin_type_code ptc ON ccp.plugin_type_cd::text = ptc.plugin_type_cd::text;

-- 040. Recreate camdecmpsmd.vw_check_catalog_result
-- Source: camdecmpsmd/views/vw_check_catalog_result.sql
-- View: camdecmpsmd.vw_check_catalog_result


CREATE OR REPLACE VIEW camdecmpsmd.vw_check_catalog_result
 AS
 SELECT ccr.check_catalog_result_id,
    cc.check_name,
    ccr.check_result,
    ccr.severity_cd,
    sc.severity_cd_description,
    cc.check_number,
    cc.check_type_cd,
    cc.check_catalog_id,
    rc.response_catalog_description,
    ccr.response_catalog_id
   FROM camdecmpsmd.check_catalog_result ccr
     LEFT JOIN camdecmpsmd.response_catalog rc ON ccr.response_catalog_id = rc.response_catalog_id::numeric
     LEFT JOIN camdecmpsmd.severity_code sc ON ccr.severity_cd::text = sc.severity_cd::text
     LEFT JOIN camdecmpsmd.check_catalog cc ON cc.check_catalog_id = ccr.check_catalog_id;

-- 041. Recreate camdecmpsmd.vw_emissions_api_check_catalog_results
-- Source: camdecmpsmd/views/vw_emission_api_check_catalog_results.sql
-- View: camdecmpsmd.vw_emissions_api_check_catalog_results


CREATE OR REPLACE VIEW camdecmpsmd.vw_emissions_api_check_catalog_results
 AS
 SELECT vw_check_catalog_result.check_type_cd AS "checkTypeCode",
    vw_check_catalog_result.check_number AS "checkNumber",
    vw_check_catalog_result.check_result AS "resultCode",
    vw_check_catalog_result.response_catalog_description AS "resultMessage"
   FROM camdecmpsmd.vw_check_catalog_result
     JOIN camdecmpsmd.check_catalog_process USING (check_catalog_id)
  WHERE check_catalog_process.process_cd::text = ANY (ARRAY['EMIMPRT'::character varying::text, 'LMEIMPT'::character varying::text, 'LMESCRN'::character varying::text])
  ORDER BY vw_check_catalog_result.check_type_cd, vw_check_catalog_result.check_number, vw_check_catalog_result.check_result;

-- 042. Recreate camdecmpsmd.vw_es_check_catalog_result
-- Source: camdecmpsmd/views/vw_es_check_catalog_result.sql
-- View: camdecmpsmd.vw_es_check_catalog_result


CREATE OR REPLACE VIEW camdecmpsmd.vw_es_check_catalog_result
 AS
 SELECT ccr.check_catalog_result_id,
    lst.check_type_cd,
    ctc.check_type_cd_description,
    lst.check_number,
    ccr.check_result,
    lst.es_match_loc_type_cd,
    lst.es_match_time_type_cd,
    lst.es_match_data_type_cd,
    dtc.es_match_data_type_label,
    dtc.es_match_data_type_url
   FROM ( SELECT ccr_1.check_catalog_id,
            chk.check_type_cd,
            chk.check_number,
                CASE
                    WHEN min(COALESCE(cat.es_match_loc_type_cd, 'NONE'::character varying)::text) = max(COALESCE(cat.es_match_loc_type_cd, 'NONE'::character varying)::text) THEN min(cat.es_match_loc_type_cd::text)
                    ELSE NULL::text
                END AS es_match_loc_type_cd,
                CASE
                    WHEN min(COALESCE(cat.es_match_data_type_cd, 'NONE'::character varying)::text) = max(COALESCE(cat.es_match_data_type_cd, 'NONE'::character varying)::text) THEN min(cat.es_match_data_type_cd::text)
                    ELSE NULL::text
                END AS es_match_data_type_cd,
                CASE
                    WHEN min(COALESCE(cat.es_match_time_type_cd, 'NONE'::character varying)::text) = max(COALESCE(cat.es_match_time_type_cd, 'NONE'::character varying)::text) THEN min(cat.es_match_time_type_cd::text)
                    ELSE NULL::text
                END AS es_match_time_type_cd
           FROM camdecmpsmd.category_code cat
             JOIN camdecmpsmd.rule_check rul ON rul.category_cd::text = cat.category_cd::text
             JOIN camdecmpsmd.check_catalog chk ON chk.check_catalog_id = rul.check_catalog_id
             JOIN camdecmpsmd.check_catalog_result ccr_1 ON ccr_1.check_catalog_id = chk.check_catalog_id
          WHERE cat.process_cd::text = ANY (ARRAY['HOURLY'::character varying::text, 'MP'::character varying::text, 'OTHERQA'::character varying::text, 'TEST'::character varying::text])
          GROUP BY ccr_1.check_catalog_id, chk.check_type_cd, chk.check_number) lst
     JOIN camdecmpsmd.check_type_code ctc ON ctc.check_type_cd::text = lst.check_type_cd::text
     JOIN camdecmpsmd.check_catalog_result ccr ON ccr.check_catalog_id = lst.check_catalog_id
     LEFT JOIN camdecmpsmd.es_match_data_type_code dtc ON dtc.es_match_data_type_cd::text = lst.es_match_data_type_cd
  WHERE ccr.es_allowed_ind = 1::numeric
  ORDER BY lst.check_type_cd, lst.check_number, ccr.check_result;

-- 043. Recreate camdecmpsmd.vw_es_parameter_code
-- Source: camdecmpsmd/views/vw_es_parameter_code.sql
-- View: camdecmpsmd.vw_es_parameter_code


CREATE OR REPLACE VIEW camdecmpsmd.vw_es_parameter_code
 AS
 SELECT chk.check_type_cd,
    chk.check_number,
    esp.parameter_cd,
    pc.parameter_cd_description
   FROM camdecmpsmd.check_catalog chk
     JOIN camdecmpsmd.rule_check rul ON rul.check_catalog_id = chk.check_catalog_id
     JOIN camdecmpsmd.category_code cat ON cat.category_cd::text = rul.category_cd::text
     JOIN camdecmpsmd.es_parameter_category xrf ON xrf.category_cd::text = cat.category_cd::text
     JOIN camdecmpsmd.es_parameter esp ON esp.es_parameter_group_cd::text = xrf.es_parameter_group_cd::text
     JOIN camdecmpsmd.parameter_code pc USING (parameter_cd)
  WHERE cat.process_cd::text = ANY (ARRAY['HOURLY'::character varying::text, 'MP'::character varying::text, 'OTHERQA'::character varying::text, 'TEST'::character varying::text]);

-- 044. Recreate camdecmpsmd.vw_monitor_plan_api_check_catalog_results
-- Source: camdecmpsmd/views/vw_monitor_plan_api_check_catalog_results.sql
-- View: camdecmpsmd.vw_monitor_plan_api_check_catalog_results


CREATE OR REPLACE VIEW camdecmpsmd.vw_monitor_plan_api_check_catalog_results
 AS
 SELECT vw_check_catalog_result.check_type_cd AS "checkTypeCode",
    vw_check_catalog_result.check_number AS "checkNumber",
    vw_check_catalog_result.check_result AS "resultCode",
    vw_check_catalog_result.response_catalog_description AS "resultMessage"
   FROM camdecmpsmd.vw_check_catalog_result
     JOIN camdecmpsmd.check_catalog_process USING (check_catalog_id)
  WHERE check_catalog_process.process_cd::text = ANY (ARRAY['MPIMPRT'::character varying::text, 'MPSCRN'::character varying::text])
  ORDER BY vw_check_catalog_result.check_type_cd, vw_check_catalog_result.check_number, vw_check_catalog_result.check_result;

-- 045. Recreate camdecmpsmd.vw_qa_certification_api_check_catalog_results
-- Source: camdecmpsmd/views/vw_qa_certification_api_check_catalog_results.sql
-- View: camdecmpsmd.vw_qa_certification_api_check_catalog_results


CREATE OR REPLACE VIEW camdecmpsmd.vw_qa_certification_api_check_catalog_results
 AS
 SELECT vw_check_catalog_result.check_type_cd AS "checkTypeCode",
    vw_check_catalog_result.check_number AS "checkNumber",
    vw_check_catalog_result.check_result AS "resultCode",
        CASE
            WHEN vw_check_catalog_result.response_catalog_description IS NULL THEN 'Error'::character varying
            ELSE vw_check_catalog_result.response_catalog_description
        END AS "resultMessage"
   FROM camdecmpsmd.vw_check_catalog_result
     JOIN camdecmpsmd.check_catalog_process USING (check_catalog_id)
  WHERE check_catalog_process.process_cd::text = ANY (ARRAY['QAIMPRT'::character varying::text, 'QASCRN'::character varying::text])
  ORDER BY vw_check_catalog_result.check_type_cd, vw_check_catalog_result.check_number, vw_check_catalog_result.check_result;

-- 046. Recreate camdecmpsmd.vw_rule_check
-- Source: camdecmpsmd/views/vw_rule_check.sql
-- View: camdecmpsmd.vw_rule_check


CREATE OR REPLACE VIEW camdecmpsmd.vw_rule_check
 AS
 SELECT rc.rule_check_id,
    rc.category_cd,
    cat_cd.category_cd_description,
    cc.check_name,
    cc.check_procedure,
    cc.check_type_cd,
    cc.check_number,
    ((((cc.check_name::text || ' ('::text) || cc.check_type_cd::text) || '-'::text) || cc.check_number::character varying(30)::text) || ')'::text AS rule_description,
    rc.check_catalog_id,
    cc.check_status_cd,
    chk_stat.check_status_cd_description,
    cc.code_status_cd,
    cod_stat.check_status_cd_description AS code_status_cd_description,
    cc.test_status_cd,
    tst_stat.check_status_cd_description AS test_status_cd_description,
    cc.run_check_flg
   FROM camdecmpsmd.rule_check rc
     JOIN camdecmpsmd.category_code cat_cd ON rc.category_cd::text = cat_cd.category_cd::text
     JOIN camdecmpsmd.check_catalog cc ON rc.check_catalog_id = cc.check_catalog_id
     LEFT JOIN camdecmpsmd.check_status_code chk_stat ON cc.check_status_cd::text = chk_stat.check_status_cd::text
     LEFT JOIN camdecmpsmd.check_status_code tst_stat ON cc.test_status_cd::text = tst_stat.check_status_cd::text
     LEFT JOIN camdecmpsmd.check_status_code cod_stat ON cc.code_status_cd::text = cod_stat.check_status_cd::text;

-- 047. Recreate camdecmpsmd.vw_rule_check_condition
-- Source: camdecmpsmd/views/vw_rule_check_condition.sql
-- View: camdecmpsmd.vw_rule_check_condition


CREATE OR REPLACE VIEW camdecmpsmd.vw_rule_check_condition
 AS
 SELECT rcc.rule_check_condition_id,
    rcc.rule_check_id,
    rc.category_cd,
    rcc.and_group_no,
    rcc.check_param_id,
    cpc.check_param_id_name,
    rcc.check_operator_cd,
    coc.check_operator_cd_name,
    rcc.check_condition,
    rcc.negation_ind,
    cpc.check_data_type_cd,
    rc.check_catalog_id,
    cpc.display_name,
    cpc.check_param_id_description,
    cpc.chk_param_type_cd,
    cat.process_cd,
    cc.check_name,
    cc.check_number,
    cc.check_type_cd,
    cc.run_check_flg
   FROM camdecmpsmd.rule_check_condition rcc
     JOIN camdecmpsmd.rule_check rc ON rcc.rule_check_id::numeric = rc.rule_check_id
     JOIN camdecmpsmd.check_parameter_code cpc ON rcc.check_param_id = cpc.check_param_id
     JOIN camdecmpsmd.check_operator_code coc ON rcc.check_operator_cd::text = coc.check_operator_cd::text
     JOIN camdecmpsmd.category_code cat ON rc.category_cd::text = cat.category_cd::text
     JOIN camdecmpsmd.check_catalog cc ON rc.check_catalog_id = cc.check_catalog_id
     LEFT JOIN camdecmpsmd.check_status_code csc ON cc.check_status_cd::text = csc.check_status_cd::text;

-- 048. Recreate camdecmpsmd.vw_rule_check_parameter
-- Source: camdecmpsmd/views/vw_rule_check_parameter.sql
-- View: camdecmpsmd.vw_rule_check_parameter


CREATE OR REPLACE VIEW camdecmpsmd.vw_rule_check_parameter
 AS
 SELECT ccp.check_catalog_param_id,
    ccp.check_catalog_id,
    rc.rule_check_id,
    ccp.check_param_id,
    ccp.check_param_usage_cd,
    cpuc.check_param_usage_cd_name,
    rc.category_cd,
    cpc.check_param_id_name,
    cpc.check_data_type_cd,
    cc.check_type_cd,
    cc.check_number,
    cat.process_cd,
    cc.run_check_flg
   FROM camdecmpsmd.check_catalog cc
     JOIN camdecmpsmd.check_catalog_parameter ccp ON cc.check_catalog_id = ccp.check_catalog_id::numeric
     JOIN camdecmpsmd.rule_check rc ON cc.check_catalog_id = rc.check_catalog_id
     JOIN camdecmpsmd.check_parameter_code cpc ON ccp.check_param_id = cpc.check_param_id
     JOIN camdecmpsmd.category_code cat ON rc.category_cd::text = cat.category_cd::text
     JOIN camdecmpsmd.check_parameter_usage_code cpuc ON ccp.check_param_usage_cd::text = cpuc.check_param_usage_cd::text
     LEFT JOIN camdecmpsmd.check_status_code csc ON cc.check_status_cd::text = csc.check_status_cd::text;

-- 049. Recreate camdecmpswks.emission_view_counts
-- Source: camdecmpswks/views/emission_view_counts.sql
-- View: camdecmpswks.emission_view_counts


CREATE OR REPLACE VIEW camdecmpswks.emission_view_counts
 AS
 SELECT vw.mon_plan_id,
    vw.mon_loc_id,
    COALESCE(u.unitid, sp.stack_name) AS unit_stack,
    vw.dataset_cd,
    rp.rpt_period_id,
    rp.calendar_year AS rpt_period_year,
    rp.quarter AS rpt_period_qtr,
    vw.count
   FROM camdecmpswks.emission_view_count vw
     JOIN camdecmpswks.monitor_location ml USING (mon_loc_id)
     JOIN camdecmpsmd.reporting_period rp USING (rpt_period_id)
     LEFT JOIN camdecmpswks.stack_pipe sp USING (stack_pipe_id)
     LEFT JOIN camd.unit u USING (unit_id);

-- 050. Recreate camdecmpswks.emission_view_dailybackstop
-- Source: camdecmpswks/views/emission_view_dailybackstop.sql
-- View: camdecmpswks.emission_view_dailybackstop


CREATE OR REPLACE VIEW camdecmpswks.emission_view_dailybackstop
AS
SELECT mpl.mon_plan_id,
	mpl.mon_loc_id,
	rp.rpt_period_id,
	rp.begin_date,
	rp.end_date,
	rp.begin_date AS datehour,
  u.unit_id,
	u.unitid as "unit_name",
	bkstop.op_date,
	bkstop.daily_noxm,
	bkstop.daily_hit,
	bkstop.daily_avg_noxr,
	bkstop.daily_noxm_exceed,
	bkstop.cumulative_os_noxm_exceed
FROM camdecmpswks.daily_backstop bkstop
JOIN camd.unit u USING (unit_id)
JOIN camdecmpswks.monitor_plan_location mpl USING (mon_loc_id)
JOIN camdecmpsmd.reporting_period rp USING (rpt_period_id);

-- 051. Recreate camdecmpswks.emission_view_ltff
-- Source: camdecmpswks/views/emission_view_ltff.sql
-- View: camdecmpswks.emission_view_ltff


CREATE OR REPLACE VIEW camdecmpswks.emission_view_ltff
 AS
 SELECT mpl.mon_plan_id,
    ltff.mon_loc_id,
    rp.rpt_period_id,
    rp.begin_date,
    rp.end_date,
    rp.begin_date AS datehour,
    ms.system_identifier AS fuel_flow_system_id,
    ms.sys_type_cd AS system_type,
    ms.fuel_cd AS fuel_type,
    ltff.fuel_flow_period_cd AS period_cd,
    ltff.long_term_fuel_flow_value AS fuel_flow,
    ltff.ltff_uom_cd AS fuel_flow_uom,
    ltff.gross_calorific_value,
    ltff.gcv_uom_cd AS gcv_uom,
    ltff.total_heat_input AS rpt_heat_input,
    ltff.calc_total_heat_input AS calc_heat_input
   FROM camdecmpswks.long_term_fuel_flow ltff
     JOIN camdecmpswks.monitor_plan_location mpl USING (mon_loc_id)
     JOIN camdecmpsmd.reporting_period rp USING (rpt_period_id)
     LEFT JOIN camdecmpswks.monitor_system ms USING (mon_sys_id);

-- 052. Recreate camdecmpswks.emission_view_nsps4t
-- Source: camdecmpswks/views/emission_view_nsps4t.sql
-- View: camdecmpswks.emission_view_nsps4t


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

-- 053. Recreate camdecmpswks.emission_view_sumval
-- Source: camdecmpswks/views/emission_view_sumval.sql
CREATE OR REPLACE VIEW camdecmpswks.emission_view_sumval
AS
	SELECT DISTINCT mpl.mon_plan_id, rp.period_description, d.*
	FROM camdecmpswks.summary_value sv
	JOIN camdecmpswks.monitor_plan_location mpl USING(mon_loc_id)
	JOIN camdecmpsmd.reporting_period rp USING (rpt_period_id)
	JOIN camdecmpswks.get_summary_values(mpl.mon_loc_id, rp.rpt_period_id) d
		ON sv.mon_loc_id = d.mon_loc_id
		AND sv.rpt_period_id = d.rpt_period_id;

-- 054. Recreate camdecmpswks.vw_monitor_location
-- Source: camdecmpswks/views/1-vw_monitor_location.sql
-- View: camdecmpswks.vw_monitor_location

CREATE OR REPLACE VIEW camdecmpswks.vw_monitor_location
AS SELECT  ml.mon_loc_id,
           p.oris_code,
           p.facility_name,
           COALESCE( sp.stack_name, u.unitid ) AS location_identifier,
           p.fac_id,
           p.state,
           p.county_cd,
           u.unit_id,
           sp.stack_pipe_id,
           u.non_load_based_ind,
           sp.active_date,
           sp.retire_date,
           u.unitid,
           sp.stack_name,
           u.comr_op_date,
           u.comm_op_date
   FROM   camdecmpswks.monitor_location ml
              LEFT JOIN camdecmpswks.unit u ON ml.unit_id = u.unit_id
              LEFT JOIN camdecmpswks.stack_pipe sp ON ml.stack_pipe_id::text = sp.stack_pipe_id::text
        JOIN camd.plant p
   ON p.fac_id in ( u.fac_id, sp.fac_id );

-- 055. Recreate camdecmpswks.vw_analyzer_range
-- Source: camdecmpswks/views/vw_analyzer_range.sql
-- View: camdecmpswks.vw_analyzer_range


CREATE OR REPLACE VIEW camdecmpswks.vw_analyzer_range
 AS
 SELECT ar.component_id,
    ar.analyzer_range_cd,
    ar.dual_range_ind,
    ar.analyzer_range_id,
    camdecmpswks.format_date_time(ar.begin_date, ar.begin_hour::integer::numeric, 0::numeric) AS begin_datehour,
    ar.begin_date,
    ar.begin_hour,
    camdecmpswks.format_date_time(ar.end_date, ar.end_hour::integer::numeric, 0::numeric) AS end_datehour,
    ar.end_date,
    ar.end_hour,
    c.component_type_cd,
    ml.mon_loc_id,
    c.serial_number,
    ml.oris_code,
    ml.location_identifier,
    c.manufacturer,
    c.acq_cd,
    c.basis_cd,
    c.model_version,
    c.component_identifier,
    ml.fac_id
   FROM camdecmpswks.analyzer_range ar
     JOIN camdecmpswks.component c ON ar.component_id::text = c.component_id::text
     JOIN camdecmpswks.vw_monitor_location ml ON c.mon_loc_id::text = ml.mon_loc_id::text;

-- 056. Recreate camdecmpswks.vw_location_program
-- Source: camdecmpswks/views/2-vw_location_program.sql
-- View: camdecmpswks.vw_location_program


CREATE OR REPLACE VIEW camdecmpswks.vw_location_program
 AS
 SELECT up.up_id,
    ml.oris_code,
    ml.location_identifier,
    ml.mon_loc_id,
    ml.fac_id,
    up.unit_id,
    u.unitid,
    up.prg_cd,
    up.class_cd AS class,
        CASE
            WHEN usc.begin_date IS NULL THEN up.unit_monitor_cert_begin_date
            WHEN up.unit_monitor_cert_begin_date IS NULL THEN usc.begin_date
            WHEN up.unit_monitor_cert_begin_date >= usc.begin_date THEN up.unit_monitor_cert_begin_date
            ELSE usc.begin_date
        END AS unit_monitor_cert_begin_date,
        CASE
            WHEN usc.begin_date IS NULL THEN up.emissions_recording_begin_date
            WHEN up.emissions_recording_begin_date IS NULL THEN usc.begin_date
            WHEN up.emissions_recording_begin_date >= usc.begin_date THEN up.emissions_recording_begin_date
            ELSE usc.begin_date
        END AS emissions_recording_begin_date,
    NULL::date AS unit_monitoring_begin_date,
        CASE
            WHEN usc.end_date IS NULL THEN up.end_date
            WHEN up.end_date IS NULL THEN usc.end_date
            WHEN up.end_date <= usc.end_date THEN up.end_date
            ELSE usc.end_date
        END AS end_date
   FROM camdecmpswks.vw_monitor_location ml
     JOIN camdecmpswks.unit_stack_configuration usc ON ml.stack_pipe_id::text = usc.stack_pipe_id::text
     JOIN camd.unit_program up ON usc.unit_id = up.unit_id AND (usc.end_date IS NULL OR up.unit_monitor_cert_begin_date <= usc.end_date) AND (up.end_date IS NULL OR up.end_date >= usc.begin_date)
     JOIN camd.unit u ON u.unit_id = usc.unit_id
UNION
 SELECT up.up_id,
    ml.oris_code,
    ml.location_identifier,
    ml.mon_loc_id,
    ml.fac_id,
    up.unit_id,
    u.unitid,
    up.prg_cd,
    up.class_cd AS class,
    up.unit_monitor_cert_begin_date,
    up.emissions_recording_begin_date,
        CASE
            WHEN up.emissions_recording_begin_date IS NOT NULL THEN up.emissions_recording_begin_date
            WHEN up.unit_monitor_cert_deadline IS NOT NULL THEN up.unit_monitor_cert_deadline
            WHEN up.unit_monitor_cert_begin_date IS NOT NULL THEN up.unit_monitor_cert_begin_date + 180
            ELSE NULL::date
        END AS unit_monitoring_begin_date,
    up.end_date
   FROM camdecmpswks.vw_monitor_location ml
     JOIN camd.unit_program up ON ml.unit_id = up.unit_id
     JOIN camd.unit u ON u.unit_id = ml.unit_id;

-- 057. Recreate camdecmpswks.vw_ce_mp_monitor_location
-- Source: camdecmpswks/views/vw_ce_mp_monitor_location.sql
-- View: camdecmpswks.vw_ce_mp_monitor_location


CREATE OR REPLACE VIEW camdecmpswks.vw_ce_mp_monitor_location
 AS
 SELECT mpl.monitor_plan_location_id,
    mpl.mon_plan_id,
    mpl.mon_loc_id,
    fac.fac_id,
    fac.oris_code,
    COALESCE(unt.unitid, stp.stack_name) AS location_name,
    loc.stack_pipe_id,
    loc.unit_id,
    unt.non_load_based_ind,
    stp.active_date AS stack_pipe_active_date,
    stp.retire_date AS stack_pipe_retire_date,
    min(COALESCE(vlp.emissions_recording_begin_date, vlp.unit_monitor_cert_begin_date)) AS earliest_report_date
   FROM camdecmpswks.monitor_plan_location mpl
     JOIN camdecmpswks.monitor_location loc ON loc.mon_loc_id::text = mpl.mon_loc_id::text
     LEFT JOIN camd.unit unt ON unt.unit_id = loc.unit_id
     LEFT JOIN camdecmpswks.stack_pipe stp ON stp.stack_pipe_id::text = loc.stack_pipe_id::text
     JOIN camd.plant fac ON fac.fac_id = unt.fac_id OR fac.fac_id = stp.fac_id
     LEFT JOIN camdecmpswks.vw_location_program vlp ON vlp.mon_loc_id::text = loc.mon_loc_id::text
  GROUP BY mpl.monitor_plan_location_id, mpl.mon_plan_id, mpl.mon_loc_id, fac.fac_id, fac.oris_code, (COALESCE(unt.unitid, stp.stack_name)), loc.stack_pipe_id, loc.unit_id, unt.non_load_based_ind, stp.active_date, stp.retire_date;

-- 058. Recreate camdecmpswks.vw_component
-- Source: camdecmpswks/views/vw_component.sql
-- View: camdecmpswks.vw_component


CREATE OR REPLACE VIEW camdecmpswks.vw_component
 AS
 SELECT c.component_id,
    c.mon_loc_id,
    ml.oris_code,
    ml.location_identifier,
    c.component_identifier,
    c.model_version,
    c.serial_number,
    c.manufacturer,
    c.component_type_cd,
    c.acq_cd,
    c.basis_cd,
    ml.fac_id,
    c.hg_converter_ind
   FROM camdecmpswks.component c
     JOIN camdecmpswks.vw_monitor_location ml ON c.mon_loc_id::text = ml.mon_loc_id::text;

-- 059. Recreate camdecmpswks.vw_em_evaluate
-- Source: camdecmpswks/views/vw_em_evaluate.sql
-- View: camdecmpswks.vw_em_evaluate

CREATE OR REPLACE VIEW camdecmpswks.vw_em_evaluate AS
SELECT
    fac.oris_code,
    fac.facility_name,
    ems.mon_plan_id,
    (
        SELECT
            string_agg(coalesce(unt.unitid, stp.stack_name), ', '::text ORDER BY unt.unitid, stp.stack_name)
        FROM
            camdecmpswks.monitor_plan_location mpl
            JOIN camdecmpswks.monitor_location loc ON loc.mon_loc_id = mpl.mon_loc_id
            LEFT JOIN camd.unit unt ON unt.unit_id = loc.unit_id
            LEFT JOIN camdecmpswks.stack_pipe stp ON stp.stack_pipe_id = loc.stack_pipe_id
        WHERE
            mpl.mon_plan_id = ems.mon_plan_id
    ) AS configuration,
    esc.eval_status_cd,
    esc.eval_status_cd_description,
    sac.submission_availability_cd,
    sac.sub_avail_cd_description AS submission_availability_cd_description,
    (
        SELECT
            max(smv.userid)
        FROM
            camdecmpswks.MONITOR_PLAN_LOCATION mpl
            JOIN camdecmpswks.SUMMARY_VALUE smv ON smv.mon_loc_id = mpl.mon_loc_id
                AND smv.rpt_period_id = ems.rpt_period_id
        WHERE
            mpl.mon_plan_id = ems.mon_plan_id
    ) AS userid,
    ems.last_updated AS update_date,
    esa.sub_availability_cd AS window_status,
    esa.access_end_date AS window_expired_date,
    prd.period_abbreviation,
    sc.severity_cd,
    sc.severity_cd_description
FROM
    camdecmpswks.EMISSION_EVALUATION ems
    JOIN camdecmpsmd.REPORTING_PERIOD prd ON prd.rpt_period_id = ems.rpt_period_id
    JOIN camdecmpswks.MONITOR_PLAN pln ON pln.mon_plan_id = ems.mon_plan_id
    JOIN camd.PLANT fac ON fac.fac_id = pln.fac_id
    JOIN camdecmpsmd.EVAL_STATUS_CODE esc ON esc.eval_status_cd = ems.eval_status_cd
    LEFT JOIN camdecmpsaux.EM_SUBMISSION_ACCESS esa ON esa.mon_plan_id = ems.mon_plan_id
        AND esa.rpt_period_id = ems.rpt_period_id
        AND esa.access_begin_date = (
            SELECT
                CASE WHEN MAX(
                    CASE WHEN sub.sub_availability_cd NOT IN ('DELETE', 'NOTSUB') THEN
                        sub.access_begin_date
                    END
                ) IS NOT NULL
                -- If there's a non-'DELETE' record, pick its latest access_begin_date
                THEN
                    MAX(
                        CASE WHEN sub.sub_availability_cd NOT IN ('DELETE', 'NOTSUB') THEN
                            sub.access_begin_date
                        END
                    )
                    -- Otherwise, pick the latest record (even if it is 'DELETE')
                ELSE
                    MAX(sub.access_begin_date)
                END
            FROM
                camdecmpsaux.EM_SUBMISSION_ACCESS sub
            WHERE
                sub.mon_plan_id = ems.mon_plan_id
                AND sub.rpt_period_id = ems.rpt_period_id
        )
    LEFT JOIN camdecmpsmd.SUBMISSION_AVAILABILITY_CODE sac ON sac.submission_availability_cd = esa.sub_availability_cd
    LEFT JOIN camdecmpswks.check_session cs ON cs.chk_session_id = ems.chk_session_id
    LEFT JOIN camdecmpsmd.severity_code sc on sc.severity_cd = cs.severity_cd;

-- 060. Recreate camdecmpswks.vw_em_export_and_report
-- Source: camdecmpswks/views/vw_em_export_and_report.sql
-- View: camdecmpswks.vw_em_export_and_report

CREATE OR REPLACE VIEW camdecmpswks.vw_em_export_and_report AS
SELECT
    fac.oris_code,
    fac.facility_name,
    ems.mon_plan_id,
    (
        SELECT
            string_agg(coalesce(unt.unitid, stp.stack_name), ', '::text ORDER BY unt.unitid, stp.stack_name)
        FROM
            camdecmpswks.monitor_plan_location mpl
            JOIN camdecmpswks.monitor_location loc ON loc.mon_loc_id = mpl.mon_loc_id
            LEFT JOIN camd.unit unt ON unt.unit_id = loc.unit_id
            LEFT JOIN camdecmpswks.stack_pipe stp ON stp.stack_pipe_id = loc.stack_pipe_id
        WHERE
            mpl.mon_plan_id = ems.mon_plan_id
    ) AS configuration,
    esc.eval_status_cd,
    esc.eval_status_cd_description,
    sac.submission_availability_cd,
    sac.sub_avail_cd_description AS submission_availability_cd_description,
    (
        SELECT
            max(smv.userid)
        FROM
            camdecmpswks.MONITOR_PLAN_LOCATION mpl
            JOIN camdecmpswks.SUMMARY_VALUE smv ON smv.mon_loc_id = mpl.mon_loc_id
                AND smv.rpt_period_id = ems.rpt_period_id
        WHERE
            mpl.mon_plan_id = ems.mon_plan_id
    ) AS userid,
    ems.last_updated AS update_date,
    esa.sub_availability_cd AS window_status,
    esa.access_end_date AS window_expired_date,
    prd.period_abbreviation,
    sc.severity_cd,
    sc.severity_cd_description
FROM
    camdecmpswks.EMISSION_EVALUATION ems
    JOIN camdecmpsmd.REPORTING_PERIOD prd ON prd.rpt_period_id = ems.rpt_period_id
    JOIN camdecmpswks.MONITOR_PLAN pln ON pln.mon_plan_id = ems.mon_plan_id
    JOIN camd.PLANT fac ON fac.fac_id = pln.fac_id
    JOIN camdecmpsmd.EVAL_STATUS_CODE esc ON esc.eval_status_cd = ems.eval_status_cd
    LEFT JOIN camdecmpsaux.EM_SUBMISSION_ACCESS esa ON esa.mon_plan_id = ems.mon_plan_id
        AND esa.rpt_period_id = ems.rpt_period_id
        AND esa.access_begin_date = (
            SELECT
                CASE WHEN MAX(
                    CASE WHEN sub.sub_availability_cd NOT IN ('DELETE', 'NOTSUB') THEN
                        sub.access_begin_date
                    END
                ) IS NOT NULL
                -- If there's a non-'DELETE' record, pick its latest access_begin_date
                THEN
                    MAX(
                        CASE WHEN sub.sub_availability_cd NOT IN ('DELETE', 'NOTSUB') THEN
                            sub.access_begin_date
                        END
                    )
                    -- Otherwise, pick the latest record (even if it is 'DELETE')
                ELSE
                    MAX(sub.access_begin_date)
                END
            FROM
                camdecmpsaux.EM_SUBMISSION_ACCESS sub
            WHERE
                sub.mon_plan_id = ems.mon_plan_id
                AND sub.rpt_period_id = ems.rpt_period_id
        )
    LEFT JOIN camdecmpsmd.SUBMISSION_AVAILABILITY_CODE sac ON sac.submission_availability_cd = esa.sub_availability_cd
    LEFT JOIN camdecmpswks.check_session cs ON cs.chk_session_id = ems.chk_session_id
    LEFT JOIN camdecmpsmd.severity_code sc on sc.severity_cd = cs.severity_cd;

-- 061. Recreate camdecmpswks.vw_em_submit
-- Source: camdecmpswks/views/vw_em_submit.sql
-- View: camdecmpswks.vw_em_submit

CREATE OR REPLACE VIEW camdecmpswks.vw_em_submit AS
SELECT
    fac.oris_code,
    fac.facility_name,
    ems.mon_plan_id,
    (
        SELECT
            string_agg(coalesce(unt.unitid, stp.stack_name), ', '::text ORDER BY unt.unitid, stp.stack_name)
        FROM
            camdecmpswks.monitor_plan_location mpl
            JOIN camdecmpswks.monitor_location loc ON loc.mon_loc_id = mpl.mon_loc_id
            LEFT JOIN camd.unit unt ON unt.unit_id = loc.unit_id
            LEFT JOIN camdecmpswks.stack_pipe stp ON stp.stack_pipe_id = loc.stack_pipe_id
        WHERE
            mpl.mon_plan_id = ems.mon_plan_id
    ) AS configuration,
    esc.eval_status_cd,
    esc.eval_status_cd_description,
    sac.submission_availability_cd,
    sac.sub_avail_cd_description AS submission_availability_cd_description,
    (
        SELECT
            max(smv.userid)
        FROM
            camdecmpswks.MONITOR_PLAN_LOCATION mpl
            JOIN camdecmpswks.SUMMARY_VALUE smv ON smv.mon_loc_id = mpl.mon_loc_id
                AND smv.rpt_period_id = ems.rpt_period_id
        WHERE
            mpl.mon_plan_id = ems.mon_plan_id
    ) AS userid,
    ems.last_updated AS update_date,
    esa.sub_availability_cd AS window_status,
    esa.access_end_date AS window_expired_date,
    prd.period_abbreviation,
    sc.severity_cd,
    sc.severity_cd_description
FROM
    camdecmpswks.EMISSION_EVALUATION ems
    JOIN camdecmpsmd.REPORTING_PERIOD prd ON prd.rpt_period_id = ems.rpt_period_id
    JOIN camdecmpswks.MONITOR_PLAN pln ON pln.mon_plan_id = ems.mon_plan_id
    JOIN camd.PLANT fac ON fac.fac_id = pln.fac_id
    JOIN camdecmpsmd.EVAL_STATUS_CODE esc ON esc.eval_status_cd = ems.eval_status_cd
    JOIN camdecmpsaux.EM_SUBMISSION_ACCESS esa ON esa.mon_plan_id = ems.mon_plan_id
        AND esa.rpt_period_id = ems.rpt_period_id
        AND esa.access_begin_date <= CURRENT_DATE
        AND esa.access_end_date >= CURRENT_DATE
        AND esa.sub_availability_cd IN ('GRANTED', 'REQUIRE', 'CRITERR')
        AND esa.access_begin_date = (
            SELECT
                CASE WHEN MAX(
                    CASE WHEN sub.sub_availability_cd NOT IN ('DELETE', 'NOTSUB') THEN
                        sub.access_begin_date
                    END
                ) IS NOT NULL
                -- If there's a non-'DELETE' record, pick its latest access_begin_date
                THEN
                    MAX(
                        CASE WHEN sub.sub_availability_cd NOT IN ('DELETE', 'NOTSUB') THEN
                            sub.access_begin_date
                        END
                    )
                    -- Otherwise, pick the latest record (even if it is 'DELETE')
                ELSE
                    MAX(sub.access_begin_date)
                END
            FROM
                camdecmpsaux.EM_SUBMISSION_ACCESS sub
            WHERE
                sub.mon_plan_id = ems.mon_plan_id
                AND sub.rpt_period_id = ems.rpt_period_id
        )
    JOIN camdecmpsmd.SUBMISSION_AVAILABILITY_CODE sac ON sac.submission_availability_cd = esa.sub_availability_cd
    JOIN camdecmpswks.check_session cs ON cs.chk_session_id = ems.chk_session_id
    JOIN camdecmpsmd.severity_code sc on sc.severity_cd = cs.severity_cd;

-- 062. Recreate camdecmpswks.vw_evem_dhv_total_and_april_load
-- Source: camdecmpswks/views/vw_evem_dhv_total_and_april_load.sql
-- View: camdecmpswks.vw_evem_dhv_total_and_april_load


CREATE OR REPLACE VIEW camdecmpswks.vw_evem_dhv_total_and_april_load
 AS
 SELECT pln.mon_plan_id,
    pln.fac_id,
    mpl.mon_loc_id,
    fac.oris_code,
        CASE
            WHEN unt.unit_id IS NOT NULL THEN unt.unitid
            WHEN stp.stack_pipe_id IS NOT NULL THEN stp.stack_name
            ELSE NULL::character varying
        END AS location_name,
    hod.rpt_period_id,
    dhv.parameter_cd,
    dhv.modc_cd,
    sum(
        CASE
            WHEN hod.hr_load >= 0::numeric AND hod.op_time > 0::numeric AND hod.op_time <= 1::numeric AND dhv.hour_id IS NOT NULL AND dhv.modc_cd IS NULL THEN hod.op_time * hod.hr_load
            ELSE NULL::numeric
        END) AS total,
    sum(
        CASE
            WHEN hod.hr_load >= 0::numeric AND hod.op_time > 0::numeric AND hod.op_time <= 1::numeric AND dhv.hour_id IS NOT NULL AND dhv.modc_cd IS NULL AND date_part('month'::text, hod.begin_date::timestamp without time zone) = 4::double precision THEN hod.op_time * hod.hr_load
            ELSE NULL::numeric
        END) AS april,
    sum(
        CASE
            WHEN hod.op_time > 0::numeric AND hod.op_time <= 1::numeric AND dhv.hour_id IS NOT NULL AND dhv.modc_cd IS NULL THEN hod.op_time
            ELSE NULL::numeric
        END) AS total_optime,
    sum(
        CASE
            WHEN hod.op_time > 0::numeric AND hod.op_time <= 1::numeric AND dhv.hour_id IS NOT NULL AND dhv.modc_cd IS NULL AND date_part('month'::text, hod.begin_date::timestamp without time zone) = 4::double precision THEN hod.op_time
            ELSE NULL::numeric
        END) AS april_optime,
    max(
        CASE
            WHEN hod.hr_load >= 0::numeric AND hod.op_time > 0::numeric AND hod.op_time <= 1::numeric THEN
            CASE
                WHEN dhv.hour_id IS NULL AND (hod.hr_load > 0::numeric OR hod.op_time > 0::numeric) THEN 1
                ELSE 0
            END
            ELSE 1
        END) AS problem_occurred
   FROM camdecmpswks.monitor_plan pln
     LEFT JOIN camd.plant fac ON fac.fac_id = pln.fac_id
     JOIN camdecmpswks.monitor_plan_location mpl ON mpl.mon_plan_id::text = pln.mon_plan_id::text
     JOIN camdecmpswks.monitor_location loc ON loc.mon_loc_id::text = mpl.mon_loc_id::text
     LEFT JOIN camd.unit unt ON unt.unit_id = loc.unit_id
     LEFT JOIN camdecmpswks.stack_pipe stp ON stp.stack_pipe_id::text = loc.stack_pipe_id::text
     JOIN camdecmpswks.hrly_op_data hod ON hod.mon_loc_id::text = loc.mon_loc_id::text
     LEFT JOIN camdecmpswks.derived_hrly_value dhv ON dhv.hour_id::text = hod.hour_id::text AND dhv.parameter_cd::text = 'HIT'::text
  WHERE hod.op_time <> 0::numeric OR hod.hr_load IS NOT NULL
  GROUP BY pln.mon_plan_id, pln.fac_id, mpl.mon_loc_id, fac.oris_code, unt.unit_id, unt.unitid, stp.stack_pipe_id, stp.stack_name, hod.rpt_period_id, dhv.parameter_cd, dhv.modc_cd;

-- 063. Recreate camdecmpswks.vw_evem_emissions
-- Source: camdecmpswks/views/vw_evem_emissions.sql
-- View: camdecmpswks.vw_evem_emissions


CREATE OR REPLACE VIEW camdecmpswks.vw_evem_emissions
 AS
 SELECT ee.mon_plan_id,
    ee.rpt_period_id,
    rp.calendar_year,
    rp.quarter,
        CASE
            WHEN ee.updated_status_flg IS NULL THEN 'Y'::character varying
            ELSE ee.updated_status_flg
        END AS updated_status_flg,
        CASE
            WHEN ee.needs_eval_flg IS NULL THEN 'Y'::character varying
            ELSE ee.needs_eval_flg
        END AS needs_eval_flg,
    cs.severity_cd,
        CASE
            WHEN esa.sub_availability_cd::text = ANY (ARRAY['GRANTED'::character varying::text, 'REQUIRE'::character varying::text]) THEN 'Y'::text
            ELSE 'N'::text
        END AS can_submit,
    esa.sub_availability_cd AS submission_availability_cd
   FROM camdecmpswks.emission_evaluation ee
     JOIN camdecmpsmd.reporting_period rp ON ee.rpt_period_id = rp.rpt_period_id
     LEFT JOIN camdecmpswks.check_session cs ON ee.chk_session_id::text = cs.chk_session_id::text
     LEFT JOIN ( SELECT DISTINCT ON (esa_1.mon_plan_id, esa_1.rpt_period_id) *
           FROM camdecmpsaux.em_submission_access esa_1
          ORDER BY esa_1.mon_plan_id, esa_1.rpt_period_id, esa_1.access_begin_date DESC) esa ON ee.mon_plan_id::text = esa.mon_plan_id::text AND ee.rpt_period_id = esa.rpt_period_id
UNION ALL
 SELECT esa.mon_plan_id,
    esa.rpt_period_id,
    rp.calendar_year,
    rp.quarter,
    'NODATA'::text AS updated_status_flg,
    NULL::character varying AS needs_eval_flg,
    NULL::character varying AS severity_cd,
        CASE
            WHEN esa.sub_availability_cd::text = ANY (ARRAY['GRANTED'::character varying::text, 'REQUIRE'::character varying::text]) THEN 'Y'::text
            ELSE 'N'::text
        END AS can_submit,
    esa.sub_availability_cd AS submission_availability_cd
   FROM
   	 (
	   SELECT DISTINCT ON (esa_1.mon_plan_id, esa_1.rpt_period_id) *
       FROM camdecmpsaux.em_submission_access esa_1
       WHERE esa_1.sub_availability_cd != 'DELETE'
       ORDER BY esa_1.mon_plan_id, esa_1.rpt_period_id, esa_1.access_begin_date DESC
	 ) esa
     JOIN camdecmpsmd.reporting_period rp ON esa.rpt_period_id = rp.rpt_period_id
     LEFT JOIN camdecmpswks.emission_evaluation ee ON esa.mon_plan_id::text = ee.mon_plan_id::text AND esa.rpt_period_id = ee.rpt_period_id
  WHERE ee.mon_plan_id IS NULL;

-- 064. Recreate camdecmpswks.vw_monitor_location_merged
-- Source: camdecmpswks/views/1-vw_monitor_location_merged.sql
-- View: camdecmpswks.vw_monitor_location_merged


CREATE OR REPLACE VIEW camdecmpswks.vw_monitor_location_merged
 AS
 SELECT ml.mon_loc_id,
    COALESCE(u.unitid, sp.stack_name) AS location_name
   FROM camdecmpswks.monitor_location ml
     LEFT JOIN camd.unit u ON ml.unit_id = u.unit_id
     LEFT JOIN camdecmpswks.stack_pipe sp ON sp.stack_pipe_id::text = ml.stack_pipe_id::text;

-- 065. Recreate camdecmpswks.vw_mp_monitor_location
-- Source: camdecmpswks/views/2-vw_mp_monitor_location.sql
-- View: camdecmpswks.vw_mp_monitor_location


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_location
 AS
 SELECT mpl.monitor_plan_location_id,
    mp.mon_plan_id,
    ml.mon_loc_id,
    mp.fac_id,
    p.oris_code,
    vwm.location_name,
    sp.stack_pipe_id,
    u.unit_id,
    u.non_load_based_ind,
    sp.active_date AS stack_pipe_active_date,
    sp.retire_date AS stack_pipe_retire_date
   FROM camdecmpswks.monitor_plan mp
     FULL JOIN camd.plant p ON mp.fac_id = p.fac_id
     FULL JOIN (camdecmpswks.monitor_location ml
     JOIN camdecmpswks.monitor_plan_location mpl ON ml.mon_loc_id::text = mpl.mon_loc_id::text
     LEFT JOIN camdecmpswks.vw_monitor_location_merged vwm ON mpl.mon_loc_id::text = vwm.mon_loc_id::text) ON mp.mon_plan_id::text = mpl.mon_plan_id::text
     LEFT JOIN camd.unit u ON ml.unit_id = u.unit_id
     LEFT JOIN camdecmpswks.stack_pipe sp ON ml.stack_pipe_id::text = sp.stack_pipe_id::text;

-- 066. Recreate camdecmpswks.vw_evem_long_term_fuel_flow
-- Source: camdecmpswks/views/vw_evem_long_term_fuel_flow.sql
-- View: camdecmpswks.vw_evem_long_term_fuel_flow


CREATE OR REPLACE VIEW camdecmpswks.vw_evem_long_term_fuel_flow
 AS
 SELECT ltff.ltff_id,
    ltff.mon_loc_id,
    ms.mon_sys_id,
    ms.system_identifier,
    ms.sys_type_cd,
    ltff.fuel_flow_period_cd,
    ml.mon_plan_id,
    ltff.long_term_fuel_flow_value,
    ltff.ltff_uom_cd,
    ltff.gross_calorific_value,
    ltff.gcv_uom_cd,
    ltff.total_heat_input,
    ltff.calc_total_heat_input,
    ms.fuel_cd,
    ms.sys_designation_cd,
    rp.calendar_year,
    rp.quarter,
    rp.rpt_period_id
   FROM camdecmpswks.long_term_fuel_flow ltff
     JOIN camdecmpsmd.reporting_period rp ON ltff.rpt_period_id = rp.rpt_period_id
     JOIN camdecmpswks.vw_mp_monitor_location ml ON ml.mon_loc_id::text = ltff.mon_loc_id::text
     LEFT JOIN camdecmpswks.monitor_system ms ON ltff.mon_sys_id::text = ms.mon_sys_id::text;

-- 067. Recreate camdecmpswks.vw_evem_summary_value
-- Source: camdecmpswks/views/vw_evem_summary_value.sql
-- View: camdecmpswks.vw_evem_summary_value


CREATE OR REPLACE VIEW camdecmpswks.vw_evem_summary_value
 AS
 SELECT sv.sum_value_id,
    ml.mon_plan_id,
    sv.rpt_period_id,
    sv.mon_loc_id,
    sv.parameter_cd,
    sv.current_rpt_period_total,
    sv.calc_current_rpt_period_total,
    sv.os_total,
    sv.calc_os_total,
    sv.year_total,
    sv.calc_year_total
   FROM camdecmpswks.summary_value sv
     JOIN camdecmpswks.vw_mp_monitor_location ml ON sv.mon_loc_id::text = ml.mon_loc_id::text;

-- 068. Recreate camdecmpswks.vw_location_attribute
-- Source: camdecmpswks/views/vw_location_attribute.sql
-- View: camdecmpswks.vw_location_attribute


CREATE OR REPLACE VIEW camdecmpswks.vw_location_attribute
 AS
 SELECT ml.stack_pipe_id,
    ml.unit_id,
    mla.grd_elevation,
    mla.duct_ind,
    mla.bypass_ind,
    mla.cross_area_flow,
    mla.cross_area_exit,
    mla.begin_date,
    mla.end_date,
    mla.stack_height,
    mla.shape_cd,
    mla.material_cd,
    ml.fac_id,
    ml.oris_code,
    ml.non_load_based_ind,
    mla.mon_loc_attrib_id,
    mla.mon_loc_id,
        CASE
            WHEN ml.stack_pipe_id IS NULL THEN NULL::character varying
            ELSE ml.location_identifier
        END AS stack_name,
        CASE
            WHEN ml.unit_id IS NULL THEN NULL::character varying
            ELSE ml.location_identifier
        END AS unitid
   FROM camdecmpswks.monitor_location_attribute mla
     JOIN camdecmpswks.vw_monitor_location ml ON mla.mon_loc_id::text = ml.mon_loc_id::text;

-- 069. Recreate camdecmpswks.vw_location_capacity
-- Source: camdecmpswks/views/vw_location_capacity.sql
-- View: camdecmpswks.vw_location_capacity


CREATE OR REPLACE VIEW camdecmpswks.vw_location_capacity
 AS
 SELECT uc.unit_cap_id,
    ml.oris_code,
    ml.location_identifier,
    uc.unit_id,
    ml.mon_loc_id,
    ml.fac_id,
    u.unitid,
    u.comm_op_date,
    u.comr_op_date,
    uc.max_hi_capacity,
        CASE
            WHEN usc.begin_date IS NULL THEN uc.begin_date
            WHEN uc.begin_date IS NULL THEN usc.begin_date
            WHEN uc.begin_date >= usc.begin_date THEN uc.begin_date
            ELSE usc.begin_date
        END AS begin_date,
        CASE
            WHEN usc.end_date IS NULL THEN uc.end_date
            WHEN uc.end_date IS NULL THEN usc.end_date
            WHEN uc.end_date <= usc.end_date THEN uc.end_date
            ELSE usc.end_date
        END AS end_date
   FROM camdecmpswks.vw_monitor_location ml
     JOIN camdecmpswks.unit_stack_configuration usc ON ml.stack_pipe_id::text = usc.stack_pipe_id::text
     JOIN camdecmpswks.unit_capacity uc ON usc.unit_id = uc.unit_id AND (uc.begin_date IS NULL OR usc.end_date IS NULL OR uc.begin_date <= usc.end_date) AND (uc.end_date IS NULL OR uc.end_date >= usc.begin_date)
     JOIN camd.unit u ON u.unit_id = usc.unit_id
UNION
 SELECT uc.unit_cap_id,
    ml.oris_code,
    ml.location_identifier,
    uc.unit_id,
    ml.mon_loc_id,
    ml.fac_id,
    u.unitid,
    u.comm_op_date,
    u.comr_op_date,
    uc.max_hi_capacity,
    uc.begin_date,
    uc.end_date
   FROM camdecmpswks.vw_monitor_location ml
     JOIN camdecmpswks.unit_capacity uc ON ml.unit_id = uc.unit_id
     JOIN camd.unit u ON u.unit_id = ml.unit_id;

-- 070. Recreate camdecmpswks.vw_location_control
-- Source: camdecmpswks/views/vw_location_control.sql
-- View: camdecmpswks.vw_location_control


CREATE OR REPLACE VIEW camdecmpswks.vw_location_control
 AS
 SELECT uc.ctl_id,
    ml.oris_code,
    ml.location_identifier,
    ml.mon_loc_id,
    ml.fac_id,
    uc.unit_id,
    u.unitid,
    u.comm_op_date,
    u.comr_op_date,
    uc.ce_param,
    uc.control_cd,
    cc.control_description AS control_cd_description,
    uc.orig_cd AS orig_ind,
    uc.seas_cd AS seas_ind,
    uc.opt_date,
        CASE
            WHEN usc.begin_date IS NULL THEN uc.install_date
            WHEN uc.install_date IS NULL THEN usc.begin_date
            WHEN uc.install_date >= usc.begin_date THEN uc.install_date
            ELSE usc.begin_date
        END AS install_date,
        CASE
            WHEN usc.end_date IS NULL THEN uc.retire_date
            WHEN uc.retire_date IS NULL THEN usc.end_date
            WHEN uc.retire_date <= usc.end_date THEN uc.retire_date
            ELSE usc.end_date
        END AS retire_date
   FROM camdecmpswks.vw_monitor_location ml
     JOIN camdecmpswks.unit_stack_configuration usc ON ml.stack_pipe_id::text = usc.stack_pipe_id::text
     JOIN camdecmpswks.unit_control uc ON usc.unit_id = uc.unit_id AND (uc.install_date IS NULL OR usc.end_date IS NULL OR uc.install_date <= usc.end_date) AND (uc.retire_date IS NULL OR uc.retire_date >= usc.begin_date)
     JOIN camd.unit u ON u.unit_id = usc.unit_id
     LEFT JOIN camdecmpsmd.control_code cc ON cc.control_cd::text = uc.control_cd::text AND lower(cc.control_equip_param_cd::text) = lower(uc.ce_param::text)
UNION
 SELECT uc.ctl_id,
    ml.oris_code,
    ml.location_identifier,
    ml.mon_loc_id,
    ml.fac_id,
    uc.unit_id,
    u.unitid,
    u.comm_op_date,
    u.comr_op_date,
    uc.ce_param,
    uc.control_cd,
    cc.control_description AS control_cd_description,
    uc.orig_cd AS orig_ind,
    uc.seas_cd AS seas_ind,
    uc.opt_date,
    uc.install_date,
    uc.retire_date
   FROM camdecmpswks.vw_monitor_location ml
     JOIN camdecmpswks.unit_control uc ON ml.unit_id = uc.unit_id
     JOIN camd.unit u ON u.unit_id = ml.unit_id
     LEFT JOIN camdecmpsmd.control_code cc ON cc.control_cd::text = uc.control_cd::text AND lower(cc.control_equip_param_cd::text) = lower(uc.ce_param::text);

-- 071. Recreate camdecmpswks.vw_location_fuel
-- Source: camdecmpswks/views/vw_location_fuel.sql
-- View: camdecmpswks.vw_location_fuel


CREATE OR REPLACE VIEW camdecmpswks.vw_location_fuel
 AS
 SELECT uf.uf_id,
    ml.oris_code,
    ml.location_identifier,
    ml.mon_loc_id,
    ml.fac_id,
    u.unit_id,
    u.unitid,
    u.comm_op_date,
    u.comr_op_date,
    uf.fuel_type AS fuel_cd,
    uf.dem_gcv,
    uf.dem_so2,
    uf.indicator_cd,
    uf.ozone_seas_ind,
    fc.fuel_group_cd,
        CASE
            WHEN usc.begin_date IS NULL THEN uf.begin_date
            WHEN uf.begin_date IS NULL THEN usc.begin_date
            WHEN uf.begin_date >= usc.begin_date THEN uf.begin_date
            ELSE usc.begin_date
        END AS begin_date,
        CASE
            WHEN usc.end_date IS NULL THEN uf.end_date
            WHEN uf.end_date IS NULL THEN usc.end_date
            WHEN uf.end_date <= usc.end_date THEN uf.end_date
            ELSE usc.end_date
        END AS end_date
   FROM camdecmpswks.vw_monitor_location ml
     JOIN camdecmpswks.unit_stack_configuration usc ON ml.stack_pipe_id::text = usc.stack_pipe_id::text
     JOIN camdecmpswks.unit_fuel uf ON usc.unit_id = uf.unit_id AND (usc.end_date IS NULL OR uf.begin_date <= usc.end_date) AND (uf.end_date IS NULL OR uf.end_date >= usc.begin_date)
     JOIN camd.unit u ON u.unit_id = usc.unit_id
     JOIN camdecmpsmd.fuel_code fc ON fc.fuel_cd::text = uf.fuel_type::text
UNION
 SELECT uf.uf_id,
    ml.oris_code,
    ml.location_identifier,
    ml.mon_loc_id,
    ml.fac_id,
    u.unit_id,
    u.unitid,
    u.comm_op_date,
    u.comr_op_date,
    uf.fuel_type AS fuel_cd,
    uf.dem_gcv,
    uf.dem_so2,
    uf.indicator_cd,
    uf.ozone_seas_ind,
    fc.fuel_group_cd,
    uf.begin_date,
    uf.end_date
   FROM camdecmpswks.vw_monitor_location ml
     JOIN camdecmpswks.unit_fuel uf ON ml.unit_id = uf.unit_id
     JOIN camd.unit u ON u.unit_id = ml.unit_id
     JOIN camdecmpsmd.fuel_code fc ON fc.fuel_cd::text = uf.fuel_type::text;

-- 072. Recreate camdecmpswks.vw_location_operating_status
-- Source: camdecmpswks/views/vw_location_operating_status.sql
-- View: camdecmpswks.vw_location_operating_status


CREATE OR REPLACE VIEW camdecmpswks.vw_location_operating_status
 AS
 SELECT up.unit_op_status_id AS uos_id,
    ml.oris_code,
    ml.location_identifier,
    ml.mon_loc_id,
    ml.fac_id,
    up.unit_id,
    u.unitid,
    up.op_status_cd,
        CASE
            WHEN usc.begin_date IS NULL THEN up.begin_date
            WHEN up.begin_date IS NULL THEN usc.begin_date
            WHEN up.begin_date >= usc.begin_date THEN up.begin_date
            ELSE usc.begin_date
        END AS begin_date,
        CASE
            WHEN usc.end_date IS NULL THEN up.end_date
            WHEN up.end_date IS NULL THEN usc.end_date
            WHEN up.end_date <= usc.end_date THEN up.end_date
            ELSE usc.end_date
        END AS end_date
   FROM camdecmpswks.vw_monitor_location ml
     JOIN camdecmpswks.unit_stack_configuration usc ON ml.stack_pipe_id::text = usc.stack_pipe_id::text
     JOIN camd.unit_op_status up ON usc.unit_id = up.unit_id
     JOIN camd.unit u ON u.unit_id = usc.unit_id
  WHERE (usc.end_date IS NULL OR up.begin_date <= usc.end_date) AND (up.end_date IS NULL OR up.end_date >= usc.begin_date)
UNION
 SELECT up.unit_op_status_id AS uos_id,
    ml.oris_code,
    ml.location_identifier,
    ml.mon_loc_id,
    ml.fac_id,
    up.unit_id,
    u.unitid,
    up.op_status_cd,
    up.begin_date,
    up.end_date
   FROM camdecmpswks.vw_monitor_location ml
     JOIN camd.unit_op_status up ON ml.unit_id = up.unit_id
     JOIN camd.unit u ON u.unit_id = ml.unit_id;

-- 073. Recreate camdecmpswks.vw_location_reporting_frequency
-- Source: camdecmpswks/views/vw_location_reporting_frequency.sql
-- View: camdecmpswks.vw_location_reporting_frequency


CREATE OR REPLACE VIEW camdecmpswks.vw_location_reporting_frequency
 AS
 SELECT rf.mon_plan_rf_id,
    ml.oris_code,
    ml.location_identifier,
    ml.mon_loc_id,
    ml.fac_id,
    mp.mon_plan_id,
    rf.report_freq_cd,
    rf.begin_rpt_period_id,
    brp.year_quarter AS begin_quarter,
    rf.end_rpt_period_id,
    erp.year_quarter AS end_quarter,
    brp.quarter_begin_date AS begin_date,
    erp.quarter_end_date AS end_date
   FROM camdecmpswks.monitor_plan_reporting_freq rf
     JOIN camdecmpswks.monitor_plan mp ON rf.mon_plan_id::text = mp.mon_plan_id::text
     JOIN camdecmpswks.monitor_plan_location mpl ON mp.mon_plan_id::text = mpl.mon_plan_id::text
     JOIN camdecmpswks.vw_monitor_location ml ON mpl.mon_loc_id::text = ml.mon_loc_id::text
     JOIN camdecmpsmd.vw_reporting_period brp ON rf.begin_rpt_period_id = brp.rpt_period_id
     LEFT JOIN camdecmpsmd.vw_reporting_period erp ON rf.end_rpt_period_id = erp.rpt_period_id;

-- 074. Recreate camdecmpswks.vw_location_unit_type
-- Source: camdecmpswks/views/vw_location_unit_type.sql
-- View: camdecmpswks.vw_location_unit_type


CREATE OR REPLACE VIEW camdecmpswks.vw_location_unit_type
 AS
 SELECT uc.unit_boiler_type_id,
    ml.oris_code,
    ml.location_identifier,
    uc.unit_id,
    ml.mon_loc_id,
    ml.fac_id,
    u.unitid,
    uc.unit_type_cd,
        CASE
            WHEN usc.begin_date IS NULL THEN uc.begin_date
            WHEN uc.begin_date IS NULL THEN usc.begin_date
            WHEN uc.begin_date >= usc.begin_date THEN uc.begin_date
            ELSE usc.begin_date
        END AS begin_date,
        CASE
            WHEN usc.end_date IS NULL THEN uc.end_date
            WHEN uc.end_date IS NULL THEN usc.end_date
            WHEN uc.end_date <= usc.end_date THEN uc.end_date
            ELSE usc.end_date
        END AS end_date
   FROM camdecmpswks.vw_monitor_location ml
     JOIN camdecmpswks.unit_stack_configuration usc ON ml.stack_pipe_id::text = usc.stack_pipe_id::text
     JOIN camd.unit_boiler_type uc ON usc.unit_id = uc.unit_id AND (uc.begin_date IS NULL OR usc.end_date IS NULL OR uc.begin_date <= usc.end_date) AND (uc.end_date IS NULL OR uc.end_date >= usc.begin_date)
     JOIN camd.unit u ON u.unit_id = usc.unit_id
UNION
 SELECT uc.unit_boiler_type_id,
    ml.oris_code,
    ml.location_identifier,
    uc.unit_id,
    ml.mon_loc_id,
    ml.fac_id,
    u.unitid,
    uc.unit_type_cd,
    uc.begin_date,
    uc.end_date
   FROM camdecmpswks.vw_monitor_location ml
     JOIN camd.unit_boiler_type uc ON ml.unit_id = uc.unit_id
     JOIN camd.unit u ON u.unit_id = ml.unit_id;

-- 075. Recreate camdecmpswks.vw_monitor_default
-- Source: camdecmpswks/views/vw_monitor_default.sql
-- View: camdecmpswks.vw_monitor_default


CREATE OR REPLACE VIEW camdecmpswks.vw_monitor_default
 AS
 SELECT md.mondef_id,
    md.mon_loc_id,
    ml.oris_code,
    ml.location_identifier,
    ml.fac_id,
    md.parameter_cd,
    md.begin_date + ((md.begin_hour || ' HOUR'::text)::interval) AS begin_datehour,
    md.begin_date,
    md.begin_hour,
    md.end_date + ((md.end_hour || ' HOUR'::text)::interval) AS end_datehour,
    md.end_date,
    md.end_hour,
    md.operating_condition_cd,
    md.default_value,
    md.default_uom_cd,
    md.default_purpose_cd,
    md.default_source_cd,
    md.fuel_cd,
    md.group_id
   FROM camdecmpswks.monitor_default md
     JOIN camdecmpswks.vw_monitor_location ml ON md.mon_loc_id::text = ml.mon_loc_id::text;

-- 076. Recreate camdecmpswks.vw_monitor_formula
-- Source: camdecmpswks/views/vw_monitor_formula.sql
-- View: camdecmpswks.vw_monitor_formula


CREATE OR REPLACE VIEW camdecmpswks.vw_monitor_formula
 AS
 SELECT mf.mon_form_id,
    mf.mon_loc_id,
    ml.oris_code,
    ml.location_identifier,
    ml.fac_id,
    mf.parameter_cd,
    mf.equation_cd,
    mf.formula_identifier,
    mf.begin_date,
    mf.begin_hour,
    mf.end_date,
    mf.end_hour,
    mf.formula_equation,
    ec.equation_cd_description,
    ec.moisture_ind,
    mf.begin_date + ((mf.begin_hour || ' HOUR'::text)::interval) AS begin_datehour,
    mf.end_date + ((mf.end_hour || ' HOUR'::text)::interval) AS end_datehour
   FROM camdecmpswks.monitor_formula mf
     JOIN camdecmpswks.vw_monitor_location ml ON mf.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpsmd.equation_code ec ON mf.equation_cd::text = ec.equation_cd::text;

-- 077. Recreate camdecmpswks.vw_monitor_load
-- Source: camdecmpswks/views/vw_monitor_load.sql
-- View: camdecmpswks.vw_monitor_load


CREATE OR REPLACE VIEW camdecmpswks.vw_monitor_load
 AS
 SELECT loc.fac_id,
    loc.oris_code,
    loc.location_identifier,
    ml.load_id,
    ml.mon_loc_id,
    ml.load_analysis_date,
    ml.begin_date,
    ml.begin_hour,
    ml.end_date,
    ml.end_hour,
    ml.max_load_value,
    ml.second_normal_ind,
    ml.up_op_boundary,
    ml.low_op_boundary,
    ml.normal_level_cd,
    ml.second_level_cd,
    ml.max_load_uom_cd,
    ml.begin_date + ((ml.begin_hour || ' HOUR'::text)::interval) AS begin_datehour,
    ml.end_date + ((ml.end_hour || ' HOUR'::text)::interval) AS end_datehour
   FROM camdecmpswks.monitor_load ml
     JOIN camdecmpswks.vw_monitor_location loc ON ml.mon_loc_id::text = loc.mon_loc_id::text;

-- 078. Recreate camdecmpswks.vw_monitor_method
-- Source: camdecmpswks/views/vw_monitor_method.sql
-- View: camdecmpswks.vw_monitor_method


CREATE OR REPLACE VIEW camdecmpswks.vw_monitor_method
 AS
 SELECT mm.mon_method_id,
    ml.mon_loc_id,
    mm.parameter_cd,
    mm.sub_data_cd,
    mm.bypass_approach_cd,
    mm.method_cd,
    mm.begin_date,
    mm.begin_hour,
    mm.end_date,
    mm.end_hour,
    ml.stack_pipe_id,
    ml.unit_id,
        CASE
            WHEN ml.stack_pipe_id IS NULL THEN NULL::character varying
            ELSE ml.location_identifier
        END AS stack_name,
        CASE
            WHEN ml.unit_id IS NULL THEN NULL::character varying
            ELSE ml.location_identifier
        END AS unitid,
    mm.begin_date + ((mm.begin_hour || ' HOUR'::text)::interval) AS begin_datehour,
    mm.end_date + ((mm.end_hour || ' HOUR'::text)::interval) AS end_datehour
   FROM camdecmpswks.monitor_method mm
     JOIN camdecmpswks.vw_monitor_location ml ON mm.mon_loc_id::text = ml.mon_loc_id::text;

-- 079. Recreate camdecmpswks.vw_monitor_plan_comment
-- Source: camdecmpswks/views/vw_monitor_plan_comment.sql
-- View: camdecmpswks.vw_monitor_plan_comment


CREATE OR REPLACE VIEW camdecmpswks.vw_monitor_plan_comment
 AS
 SELECT mpc.mon_plan_comment_id,
    mpc.mon_plan_id,
    mpc.mon_plan_comment,
    mpc.begin_date,
    mpc.end_date,
    p.oris_code,
    p.facility_name,
    p.state,
    mp.fac_id,
    mp.submission_availability_cd
   FROM camdecmpswks.monitor_plan_comment mpc
     JOIN camdecmpswks.monitor_plan mp ON mpc.mon_plan_id::text = mp.mon_plan_id::text
     JOIN camd.plant p ON mp.fac_id = p.fac_id;

-- 080. Recreate camdecmpswks.vw_monitor_qualification
-- Source: camdecmpswks/views/vw_monitor_qualification.sql
-- View: camdecmpswks.vw_monitor_qualification


CREATE OR REPLACE VIEW camdecmpswks.vw_monitor_qualification
 AS
 SELECT mq.mon_qual_id,
    ml.mon_loc_id,
    mq.qual_type_cd,
    mq.begin_date,
    mq.end_date,
    ml.location_identifier AS location_id,
    ml.oris_code,
    ml.fac_id
   FROM camdecmpswks.monitor_qualification mq
     JOIN camdecmpswks.vw_monitor_location ml ON mq.mon_loc_id::text = ml.mon_loc_id::text;

-- 081. Recreate camdecmpswks.vw_monitor_qualification_lme
-- Source: camdecmpswks/views/vw_monitor_qualification_lme.sql
-- View: camdecmpswks.vw_monitor_qualification_lme


CREATE OR REPLACE VIEW camdecmpswks.vw_monitor_qualification_lme
 AS
 SELECT ml.mon_loc_id,
    ml.location_identifier AS location_id,
    ml.oris_code,
    ml.fac_id,
    lme.mon_lme_id,
    lme.mon_qual_id,
    lme.qual_data_year,
    lme.so2_tons,
    lme.nox_tons,
    lme.op_hours,
    mq.qual_type_cd
   FROM camdecmpswks.monitor_qualification mq
     JOIN camdecmpswks.vw_monitor_location ml ON mq.mon_loc_id::text = ml.mon_loc_id::text
     JOIN camdecmpswks.monitor_qualification_lme lme ON mq.mon_qual_id::text = lme.mon_qual_id::text;

-- 082. Recreate camdecmpswks.vw_monitor_qualification_pct
-- Source: camdecmpswks/views/vw_monitor_qualification_pct.sql
-- View: camdecmpswks.vw_monitor_qualification_pct


CREATE OR REPLACE VIEW camdecmpswks.vw_monitor_qualification_pct
 AS
 SELECT ml.mon_loc_id,
    ml.location_identifier AS location_id,
    ml.oris_code,
    ml.fac_id,
    pct.mon_pct_id,
    mq.qual_type_cd,
    mq.begin_date,
    mq.end_date,
    pct.mon_qual_id,
    pct.qual_year,
    pct.yr1_qual_data_type_cd,
    pct.yr1_qual_data_year,
    pct.yr1_pct_value,
    pct.yr2_qual_data_type_cd,
    pct.yr2_qual_data_year,
    pct.yr2_pct_value,
    pct.yr3_qual_data_type_cd,
    pct.yr3_qual_data_year,
    pct.yr3_pct_value,
    pct.avg_pct_value
   FROM camdecmpswks.monitor_qualification mq
     JOIN camdecmpswks.vw_monitor_location ml ON mq.mon_loc_id::text = ml.mon_loc_id::text
     JOIN camdecmpswks.monitor_qualification_pct pct ON mq.mon_qual_id::text = pct.mon_qual_id::text;

-- 083. Recreate camdecmpswks.vw_monitor_span
-- Source: camdecmpswks/views/vw_monitor_span.sql
-- View: camdecmpswks.vw_monitor_span


CREATE OR REPLACE VIEW camdecmpswks.vw_monitor_span
 AS
 SELECT ms.span_id,
    ms.mon_loc_id,
    ml.oris_code,
    ml.location_identifier,
    ms.mpc_value,
    ms.mec_value,
    ms.mpf_value,
    ms.max_low_range,
    ms.span_value,
    ms.full_scale_range,
    ms.begin_date,
    ms.begin_hour,
    ms.end_date,
    ms.end_hour,
    ms.default_high_range,
    ms.flow_span_value,
    ms.flow_full_scale_range,
    ms.component_type_cd,
    ms.span_scale_cd,
    ms.span_method_cd,
    ms.span_uom_cd,
    ml.fac_id
   FROM camdecmpswks.monitor_span ms
     JOIN camdecmpswks.vw_monitor_location ml ON ms.mon_loc_id::text = ml.mon_loc_id::text;

-- 084. Recreate camdecmpswks.vw_monitor_system
-- Source: camdecmpswks/views/vw_monitor_system.sql
-- View: camdecmpswks.vw_monitor_system


CREATE OR REPLACE VIEW camdecmpswks.vw_monitor_system
 AS
 SELECT ml.mon_loc_id,
    ms.mon_sys_id,
    ml.oris_code,
    ml.location_identifier,
    ml.fac_id,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.begin_date,
    ms.begin_hour,
    ms.end_date,
    ms.end_hour,
    ms.sys_designation_cd,
    ms.fuel_cd,
    ms.begin_date + ((ms.begin_hour || ' HOUR'::text)::interval) AS begin_datehour,
    ms.end_date + ((ms.end_hour || ' HOUR'::text)::interval) AS end_datehour
   FROM camdecmpswks.monitor_system ms
     JOIN camdecmpswks.vw_monitor_location ml ON ms.mon_loc_id::text = ml.mon_loc_id::text;

-- 085. Recreate camdecmpswks.vw_monitor_system_component
-- Source: camdecmpswks/views/vw_monitor_system_component.sql
-- View: camdecmpswks.vw_monitor_system_component


CREATE OR REPLACE VIEW camdecmpswks.vw_monitor_system_component
 AS
 SELECT msc.mon_sys_comp_id,
    ml.mon_loc_id,
    ml.oris_code,
    ml.location_identifier,
    ml.fac_id,
    msc.mon_sys_id,
    msc.component_id,
    msc.begin_date,
    msc.begin_hour,
    msc.end_date,
    msc.end_hour,
    c.component_type_cd,
    c.acq_cd,
    c.basis_cd,
    ms.begin_date AS system_begin_date,
    ms.begin_hour AS system_begin_hour,
    ms.end_date AS system_end_date,
    ms.end_hour AS system_end_hour,
    ms.system_identifier,
    c.component_identifier,
    msc.begin_date + ((msc.begin_hour || ' HOUR'::text)::interval) AS begin_datehour,
    msc.end_date + ((msc.end_hour || ' HOUR'::text)::interval) AS end_datehour
   FROM camdecmpswks.monitor_system_component msc
     JOIN camdecmpswks.component c ON msc.component_id::text = c.component_id::text
     JOIN camdecmpswks.monitor_system ms ON msc.mon_sys_id::text = ms.mon_sys_id::text
     JOIN camdecmpswks.vw_monitor_location ml ON ms.mon_loc_id::text = ml.mon_loc_id::text;

-- 086. Recreate camdecmpswks.vw_mp_analyzer_range
-- Source: camdecmpswks/views/vw_mp_analyzer_range.sql
-- View: camdecmpswks.vw_mp_analyzer_range


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_analyzer_range
 AS
 SELECT c.component_id,
    ar.analyzer_range_cd,
    ar.dual_range_ind,
    ar.analyzer_range_id,
    camdecmpswks.format_date_time(ar.begin_date, ar.begin_hour::integer::numeric, 0::numeric) AS begin_datehour,
    ar.begin_date,
    ar.begin_hour,
    camdecmpswks.format_date_time(ar.end_date, ar.end_hour::integer::numeric, 0::numeric) AS end_datehour,
    ar.end_date,
    ar.end_hour,
    c.component_type_cd,
    ml.mon_loc_id,
    mp.mon_plan_id,
    c.serial_number,
    c.manufacturer,
    c.acq_cd,
    c.basis_cd,
    c.model_version,
    c.component_identifier,
    mp.fac_id
   FROM camdecmpswks.analyzer_range ar
     JOIN camdecmpswks.component c ON ar.component_id::text = c.component_id::text
     JOIN camdecmpswks.monitor_location ml ON c.mon_loc_id::text = ml.mon_loc_id::text
     JOIN camdecmpswks.monitor_plan_location mpl ON ml.mon_loc_id::text = mpl.mon_loc_id::text
     JOIN camdecmpswks.monitor_plan mp ON mpl.mon_plan_id::text = mp.mon_plan_id::text;

-- 087. Recreate camdecmpswks.vw_mp_component
-- Source: camdecmpswks/views/vw_mp_component.sql
-- View: camdecmpswks.vw_mp_component


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_component
 AS
 SELECT c.component_id,
    vwml.mon_plan_id,
    vwml.mon_loc_id,
    c.component_identifier,
    c.model_version,
    c.serial_number,
    c.manufacturer,
    c.component_type_cd,
    c.acq_cd,
    c.basis_cd,
    vwml.fac_id,
    vwml.location_name
   FROM camdecmpswks.component c
     JOIN camdecmpswks.vw_mp_monitor_location vwml ON c.mon_loc_id::text = vwml.mon_loc_id::text;

-- 088. Recreate camdecmpswks.vw_mp_daily_emission
-- Source: camdecmpswks/views/vw_mp_daily_emission.sql
-- View: camdecmpswks.vw_mp_daily_emission


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_daily_emission
 AS
 SELECT vwml.mon_plan_id,
    de.daily_emission_id,
    vwml.mon_loc_id,
    rp.rpt_period_id,
    vwml.oris_code,
    vwml.location_name,
    rp.calendar_year,
    rp.quarter,
    de.begin_date,
    de.parameter_cd,
    de.total_daily_emission,
    de.total_carbon_burned,
    de.adjusted_daily_emission,
    de.unadjusted_daily_emission,
    de.sorbent_mass_emission
   FROM camdecmpswks.daily_emission de
     JOIN camdecmpswks.vw_mp_monitor_location vwml ON vwml.mon_loc_id::text = de.mon_loc_id::text
     JOIN camdecmpsmd.reporting_period rp ON rp.rpt_period_id = de.rpt_period_id;

-- 089. Recreate camdecmpswks.vw_mp_daily_fuel
-- Source: camdecmpswks/views/vw_mp_daily_fuel.sql
-- View: camdecmpswks.vw_mp_daily_fuel


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_daily_fuel
 AS
 SELECT vwml.mon_plan_id,
    de.daily_emission_id,
    vwml.mon_loc_id,
    rp.rpt_period_id,
    vwml.oris_code,
    vwml.location_name,
    rp.calendar_year,
    rp.quarter,
    de.begin_date,
    de.parameter_cd,
    de.total_daily_emission,
    de.adjusted_daily_emission,
    de.unadjusted_daily_emission,
    de.sorbent_mass_emission,
    df.daily_fuel_id,
    df.fuel_cd,
    df.daily_fuel_feed,
    df.carbon_content_used,
    df.fuel_carbon_burned
   FROM camdecmpswks.daily_fuel df
     JOIN camdecmpswks.daily_emission de ON df.daily_emission_id::text = de.daily_emission_id::text
     JOIN camdecmpswks.vw_mp_monitor_location vwml ON vwml.mon_loc_id::text = de.mon_loc_id::text
     JOIN camdecmpsmd.reporting_period rp ON rp.rpt_period_id = de.rpt_period_id;

-- 090. Recreate camdecmpswks.vw_mp_hrly_op_data
-- Source: camdecmpswks/views/3-vw_mp_hrly_op_data.sql
-- View: camdecmpswks.vw_mp_hrly_op_data


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_hrly_op_data
 AS
 SELECT hod.hour_id,
    vwml.mon_plan_id,
    vwml.mon_loc_id,
    vwml.location_name,
    rp.rpt_period_id,
    rp.calendar_year,
    rp.quarter,
    fc.fuel_cd,
    fc.fuel_group_cd,
    fc.unit_fuel_cd,
    hod.load_uom_cd,
    hod.op_time,
    hod.begin_date,
    hod.begin_hour,
    camdecmpswks.format_date_time(hod.begin_date, hod.begin_hour::integer::numeric, 0::numeric) AS begin_datehour,
    hod.hr_load,
    hod.load_range,
    hod.common_stack_load_range,
    hod.fc_factor,
    hod.fd_factor,
    hod.fw_factor,
    hod.multi_fuel_flg,
    hod.fuel_cd_list,
    hod.operating_condition_cd,
    vwml.stack_pipe_id,
    vwml.unit_id,
    hod.mhhi_indicator,
    hod.mats_load AS mats_hour_load,
    hod.mats_startup_shutdown_flg
   FROM camdecmpsmd.reporting_period rp
     JOIN camdecmpswks.hrly_op_data hod ON rp.rpt_period_id = hod.rpt_period_id
     JOIN camdecmpswks.vw_mp_monitor_location vwml ON hod.mon_loc_id::text = vwml.mon_loc_id::text
     LEFT JOIN camdecmpsmd.fuel_code fc ON hod.fuel_cd::text = fc.fuel_cd::text;

-- 091. Recreate camdecmpswks.vw_mp_derived_hrly_value
-- Source: camdecmpswks/views/vw_mp_derived_hrly_value.sql
-- View: camdecmpswks.vw_mp_derived_hrly_value


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_derived_hrly_value
 AS
 SELECT derived_hrly_value.derv_id,
    vw_mp_hrly_op_data.mon_plan_id,
    vw_mp_hrly_op_data.mon_loc_id,
    vw_mp_hrly_op_data.hour_id,
    vw_mp_hrly_op_data.rpt_period_id,
    vw_mp_hrly_op_data.calendar_year,
    vw_mp_hrly_op_data.quarter,
    vw_mp_hrly_op_data.begin_date,
    vw_mp_hrly_op_data.begin_hour,
    derived_hrly_value.parameter_cd,
    derived_hrly_value.unadjusted_hrly_value,
    derived_hrly_value.adjusted_hrly_value,
    derived_hrly_value.modc_cd,
    derived_hrly_value.mon_sys_id,
    derived_hrly_value.mon_form_id,
    derived_hrly_value.pct_available,
    derived_hrly_value.diluent_cap_ind,
    derived_hrly_value.operating_condition_cd,
    derived_hrly_value.segment_num,
    derived_hrly_value.fuel_cd,
    monitor_system.system_identifier,
    monitor_system.sys_type_cd,
    monitor_system.sys_designation_cd,
    monitor_formula.formula_identifier,
    monitor_formula.parameter_cd AS formula_parameter_cd,
    monitor_formula.equation_cd
   FROM camdecmpswks.derived_hrly_value
     JOIN camdecmpswks.vw_mp_hrly_op_data ON derived_hrly_value.hour_id::text = vw_mp_hrly_op_data.hour_id::text
     LEFT JOIN camdecmpswks.monitor_system ON derived_hrly_value.mon_sys_id::text = monitor_system.mon_sys_id::text
     LEFT JOIN camdecmpswks.monitor_formula ON derived_hrly_value.mon_form_id::text = monitor_formula.mon_form_id::text;

-- 092. Recreate camdecmpswks.vw_mp_derived_hrly_value_co2
-- Source: camdecmpswks/views/vw_mp_derived_hrly_value_co2.sql
-- View: camdecmpswks.vw_mp_derived_hrly_value_co2


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_derived_hrly_value_co2
 AS
 SELECT vw_mp_derived_hrly_value.derv_id,
    vw_mp_derived_hrly_value.mon_plan_id,
    vw_mp_derived_hrly_value.mon_loc_id,
    vw_mp_derived_hrly_value.hour_id,
    vw_mp_derived_hrly_value.rpt_period_id,
    vw_mp_derived_hrly_value.calendar_year,
    vw_mp_derived_hrly_value.quarter,
    vw_mp_derived_hrly_value.begin_date,
    vw_mp_derived_hrly_value.begin_hour,
    vw_mp_derived_hrly_value.parameter_cd,
    vw_mp_derived_hrly_value.unadjusted_hrly_value,
    vw_mp_derived_hrly_value.adjusted_hrly_value,
    vw_mp_derived_hrly_value.modc_cd,
    vw_mp_derived_hrly_value.mon_sys_id,
    vw_mp_derived_hrly_value.mon_form_id,
    vw_mp_derived_hrly_value.pct_available,
    vw_mp_derived_hrly_value.diluent_cap_ind,
    vw_mp_derived_hrly_value.operating_condition_cd,
    vw_mp_derived_hrly_value.segment_num,
    vw_mp_derived_hrly_value.fuel_cd,
    vw_mp_derived_hrly_value.system_identifier,
    vw_mp_derived_hrly_value.sys_type_cd,
    vw_mp_derived_hrly_value.sys_designation_cd,
    vw_mp_derived_hrly_value.formula_identifier,
    vw_mp_derived_hrly_value.formula_parameter_cd,
    vw_mp_derived_hrly_value.equation_cd
   FROM camdecmpswks.vw_mp_derived_hrly_value
  WHERE vw_mp_derived_hrly_value.parameter_cd::text = ANY (ARRAY['CO2'::character varying::text, 'CO2M'::character varying::text]);

-- 093. Recreate camdecmpswks.vw_mp_derived_hrly_value_co2c
-- Source: camdecmpswks/views/vw_mp_derived_hrly_value_co2c.sql
-- View: camdecmpswks.vw_mp_derived_hrly_value_co2c


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_derived_hrly_value_co2c
 AS
 SELECT vw_mp_derived_hrly_value.derv_id,
    vw_mp_derived_hrly_value.mon_plan_id,
    vw_mp_derived_hrly_value.mon_loc_id,
    vw_mp_derived_hrly_value.hour_id,
    vw_mp_derived_hrly_value.rpt_period_id,
    vw_mp_derived_hrly_value.calendar_year,
    vw_mp_derived_hrly_value.quarter,
    vw_mp_derived_hrly_value.begin_date,
    vw_mp_derived_hrly_value.begin_hour,
    vw_mp_derived_hrly_value.parameter_cd,
    vw_mp_derived_hrly_value.unadjusted_hrly_value,
    vw_mp_derived_hrly_value.adjusted_hrly_value,
    vw_mp_derived_hrly_value.modc_cd,
    vw_mp_derived_hrly_value.mon_sys_id,
    vw_mp_derived_hrly_value.mon_form_id,
    vw_mp_derived_hrly_value.pct_available,
    vw_mp_derived_hrly_value.diluent_cap_ind,
    vw_mp_derived_hrly_value.operating_condition_cd,
    vw_mp_derived_hrly_value.segment_num,
    vw_mp_derived_hrly_value.fuel_cd,
    vw_mp_derived_hrly_value.system_identifier,
    vw_mp_derived_hrly_value.sys_type_cd,
    vw_mp_derived_hrly_value.sys_designation_cd,
    vw_mp_derived_hrly_value.formula_identifier,
    vw_mp_derived_hrly_value.formula_parameter_cd,
    vw_mp_derived_hrly_value.equation_cd
   FROM camdecmpswks.vw_mp_derived_hrly_value
  WHERE vw_mp_derived_hrly_value.parameter_cd::text = 'CO2C'::text;

-- 094. Recreate camdecmpswks.vw_mp_derived_hrly_value_h2o
-- Source: camdecmpswks/views/vw_mp_derived_hrly_value_h2o.sql
-- View: camdecmpswks.vw_mp_derived_hrly_value_h2o


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_derived_hrly_value_h2o
 AS
 SELECT vw_mp_derived_hrly_value.derv_id,
    vw_mp_derived_hrly_value.mon_plan_id,
    vw_mp_derived_hrly_value.mon_loc_id,
    vw_mp_derived_hrly_value.hour_id,
    vw_mp_derived_hrly_value.rpt_period_id,
    vw_mp_derived_hrly_value.calendar_year,
    vw_mp_derived_hrly_value.quarter,
    vw_mp_derived_hrly_value.begin_date,
    vw_mp_derived_hrly_value.begin_hour,
    vw_mp_derived_hrly_value.parameter_cd,
    vw_mp_derived_hrly_value.unadjusted_hrly_value,
    vw_mp_derived_hrly_value.adjusted_hrly_value,
    vw_mp_derived_hrly_value.modc_cd,
    vw_mp_derived_hrly_value.mon_sys_id,
    vw_mp_derived_hrly_value.mon_form_id,
    vw_mp_derived_hrly_value.pct_available,
    vw_mp_derived_hrly_value.diluent_cap_ind,
    vw_mp_derived_hrly_value.operating_condition_cd,
    vw_mp_derived_hrly_value.segment_num,
    vw_mp_derived_hrly_value.fuel_cd,
    vw_mp_derived_hrly_value.system_identifier,
    vw_mp_derived_hrly_value.sys_type_cd,
    vw_mp_derived_hrly_value.sys_designation_cd,
    vw_mp_derived_hrly_value.formula_identifier,
    vw_mp_derived_hrly_value.formula_parameter_cd,
    vw_mp_derived_hrly_value.equation_cd
   FROM camdecmpswks.vw_mp_derived_hrly_value
  WHERE vw_mp_derived_hrly_value.parameter_cd::text = 'H2O'::text;

-- 095. Recreate camdecmpswks.vw_mp_derived_hrly_value_hi
-- Source: camdecmpswks/views/vw_mp_derived_hrly_value_hi.sql
-- View: camdecmpswks.vw_mp_derived_hrly_value_hi


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_derived_hrly_value_hi
 AS
 SELECT vw_mp_derived_hrly_value.derv_id,
    vw_mp_derived_hrly_value.mon_plan_id,
    vw_mp_derived_hrly_value.mon_loc_id,
    vw_mp_derived_hrly_value.hour_id,
    vw_mp_derived_hrly_value.rpt_period_id,
    vw_mp_derived_hrly_value.calendar_year,
    vw_mp_derived_hrly_value.quarter,
    vw_mp_derived_hrly_value.begin_date,
    vw_mp_derived_hrly_value.begin_hour,
    vw_mp_derived_hrly_value.parameter_cd,
    vw_mp_derived_hrly_value.unadjusted_hrly_value,
    vw_mp_derived_hrly_value.adjusted_hrly_value,
    vw_mp_derived_hrly_value.modc_cd,
    vw_mp_derived_hrly_value.mon_sys_id,
    vw_mp_derived_hrly_value.mon_form_id,
    vw_mp_derived_hrly_value.pct_available,
    vw_mp_derived_hrly_value.diluent_cap_ind,
    vw_mp_derived_hrly_value.operating_condition_cd,
    vw_mp_derived_hrly_value.segment_num,
    vw_mp_derived_hrly_value.fuel_cd,
    vw_mp_derived_hrly_value.system_identifier,
    vw_mp_derived_hrly_value.sys_type_cd,
    vw_mp_derived_hrly_value.sys_designation_cd,
    vw_mp_derived_hrly_value.formula_identifier,
    vw_mp_derived_hrly_value.formula_parameter_cd,
    vw_mp_derived_hrly_value.equation_cd
   FROM camdecmpswks.vw_mp_derived_hrly_value
  WHERE lower(vw_mp_derived_hrly_value.parameter_cd::text) ~~ lower('HI%'::text);

-- 096. Recreate camdecmpswks.vw_mp_derived_hrly_value_lme
-- Source: camdecmpswks/views/vw_mp_derived_hrly_value_lme.sql
-- View: camdecmpswks.vw_mp_derived_hrly_value_lme


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_derived_hrly_value_lme
 AS
 SELECT vw_mp_derived_hrly_value.derv_id,
    vw_mp_derived_hrly_value.mon_plan_id,
    vw_mp_derived_hrly_value.mon_loc_id,
    vw_mp_derived_hrly_value.hour_id,
    vw_mp_derived_hrly_value.rpt_period_id,
    vw_mp_derived_hrly_value.calendar_year,
    vw_mp_derived_hrly_value.quarter,
    vw_mp_derived_hrly_value.begin_date,
    vw_mp_derived_hrly_value.begin_hour,
    vw_mp_derived_hrly_value.parameter_cd,
    vw_mp_derived_hrly_value.unadjusted_hrly_value,
    vw_mp_derived_hrly_value.adjusted_hrly_value,
    vw_mp_derived_hrly_value.modc_cd,
    vw_mp_derived_hrly_value.mon_sys_id,
    vw_mp_derived_hrly_value.mon_form_id,
    vw_mp_derived_hrly_value.pct_available,
    vw_mp_derived_hrly_value.diluent_cap_ind,
    vw_mp_derived_hrly_value.operating_condition_cd,
    vw_mp_derived_hrly_value.segment_num,
    vw_mp_derived_hrly_value.fuel_cd,
    vw_mp_derived_hrly_value.system_identifier,
    vw_mp_derived_hrly_value.sys_type_cd,
    vw_mp_derived_hrly_value.sys_designation_cd,
    vw_mp_derived_hrly_value.formula_identifier,
    vw_mp_derived_hrly_value.formula_parameter_cd,
    vw_mp_derived_hrly_value.equation_cd
   FROM camdecmpswks.vw_mp_derived_hrly_value
  WHERE vw_mp_derived_hrly_value.parameter_cd::text = ANY (ARRAY['SO2M'::character varying::text, 'CO2M'::character varying::text, 'NOXM'::character varying::text, 'HIT'::character varying::text]);

-- 097. Recreate camdecmpswks.vw_mp_derived_hrly_value_nox
-- Source: camdecmpswks/views/vw_mp_derived_hrly_value_nox.sql
-- View: camdecmpswks.vw_mp_derived_hrly_value_nox


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_derived_hrly_value_nox
 AS
 SELECT vw_mp_derived_hrly_value.derv_id,
    vw_mp_derived_hrly_value.mon_plan_id,
    vw_mp_derived_hrly_value.mon_loc_id,
    vw_mp_derived_hrly_value.hour_id,
    vw_mp_derived_hrly_value.rpt_period_id,
    vw_mp_derived_hrly_value.calendar_year,
    vw_mp_derived_hrly_value.quarter,
    vw_mp_derived_hrly_value.begin_date,
    vw_mp_derived_hrly_value.begin_hour,
    vw_mp_derived_hrly_value.parameter_cd,
    vw_mp_derived_hrly_value.unadjusted_hrly_value,
    vw_mp_derived_hrly_value.adjusted_hrly_value,
    vw_mp_derived_hrly_value.modc_cd,
    vw_mp_derived_hrly_value.mon_sys_id,
    vw_mp_derived_hrly_value.mon_form_id,
    vw_mp_derived_hrly_value.pct_available,
    vw_mp_derived_hrly_value.diluent_cap_ind,
    vw_mp_derived_hrly_value.operating_condition_cd,
    vw_mp_derived_hrly_value.segment_num,
    vw_mp_derived_hrly_value.fuel_cd,
    vw_mp_derived_hrly_value.system_identifier,
    vw_mp_derived_hrly_value.sys_type_cd,
    vw_mp_derived_hrly_value.sys_designation_cd,
    vw_mp_derived_hrly_value.formula_identifier,
    vw_mp_derived_hrly_value.formula_parameter_cd,
    vw_mp_derived_hrly_value.equation_cd
   FROM camdecmpswks.vw_mp_derived_hrly_value
  WHERE vw_mp_derived_hrly_value.parameter_cd::text = ANY (ARRAY['NOX'::character varying::text, 'NOXM'::character varying::text]);

-- 098. Recreate camdecmpswks.vw_mp_derived_hrly_value_noxr
-- Source: camdecmpswks/views/vw_mp_derived_hrly_value_noxr.sql
-- View: camdecmpswks.vw_mp_derived_hrly_value_noxr


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_derived_hrly_value_noxr
 AS
 SELECT vw_mp_derived_hrly_value.derv_id,
    vw_mp_derived_hrly_value.mon_plan_id,
    vw_mp_derived_hrly_value.mon_loc_id,
    vw_mp_derived_hrly_value.hour_id,
    vw_mp_derived_hrly_value.rpt_period_id,
    vw_mp_derived_hrly_value.calendar_year,
    vw_mp_derived_hrly_value.quarter,
    vw_mp_derived_hrly_value.begin_date,
    vw_mp_derived_hrly_value.begin_hour,
    vw_mp_derived_hrly_value.parameter_cd,
    vw_mp_derived_hrly_value.unadjusted_hrly_value,
    vw_mp_derived_hrly_value.adjusted_hrly_value,
    vw_mp_derived_hrly_value.modc_cd,
    vw_mp_derived_hrly_value.mon_sys_id,
    vw_mp_derived_hrly_value.mon_form_id,
    vw_mp_derived_hrly_value.pct_available,
    vw_mp_derived_hrly_value.diluent_cap_ind,
    vw_mp_derived_hrly_value.operating_condition_cd,
    vw_mp_derived_hrly_value.segment_num,
    vw_mp_derived_hrly_value.fuel_cd,
    vw_mp_derived_hrly_value.system_identifier,
    vw_mp_derived_hrly_value.sys_type_cd,
    vw_mp_derived_hrly_value.sys_designation_cd,
    vw_mp_derived_hrly_value.formula_identifier,
    vw_mp_derived_hrly_value.formula_parameter_cd,
    vw_mp_derived_hrly_value.equation_cd
   FROM camdecmpswks.vw_mp_derived_hrly_value
  WHERE vw_mp_derived_hrly_value.parameter_cd::text = 'NOXR'::text;

-- 099. Recreate camdecmpswks.vw_mp_derived_hrly_value_so2
-- Source: camdecmpswks/views/vw_mp_derived_hrly_value_so2.sql
-- View: camdecmpswks.vw_mp_derived_hrly_value_so2


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_derived_hrly_value_so2
 AS
 SELECT vw_mp_derived_hrly_value.derv_id,
    vw_mp_derived_hrly_value.mon_plan_id,
    vw_mp_derived_hrly_value.mon_loc_id,
    vw_mp_derived_hrly_value.hour_id,
    vw_mp_derived_hrly_value.rpt_period_id,
    vw_mp_derived_hrly_value.calendar_year,
    vw_mp_derived_hrly_value.quarter,
    vw_mp_derived_hrly_value.begin_date,
    vw_mp_derived_hrly_value.begin_hour,
    vw_mp_derived_hrly_value.parameter_cd,
    vw_mp_derived_hrly_value.unadjusted_hrly_value,
    vw_mp_derived_hrly_value.adjusted_hrly_value,
    vw_mp_derived_hrly_value.modc_cd,
    vw_mp_derived_hrly_value.mon_sys_id,
    vw_mp_derived_hrly_value.mon_form_id,
    vw_mp_derived_hrly_value.pct_available,
    vw_mp_derived_hrly_value.diluent_cap_ind,
    vw_mp_derived_hrly_value.operating_condition_cd,
    vw_mp_derived_hrly_value.segment_num,
    vw_mp_derived_hrly_value.fuel_cd,
    vw_mp_derived_hrly_value.system_identifier,
    vw_mp_derived_hrly_value.sys_type_cd,
    vw_mp_derived_hrly_value.sys_designation_cd,
    vw_mp_derived_hrly_value.formula_identifier,
    vw_mp_derived_hrly_value.formula_parameter_cd,
    vw_mp_derived_hrly_value.equation_cd
   FROM camdecmpswks.vw_mp_derived_hrly_value
  WHERE vw_mp_derived_hrly_value.parameter_cd::text = ANY (ARRAY['SO2'::character varying::text, 'SO2M'::character varying::text]);

-- 100. Recreate camdecmpswks.vw_mp_derived_hrly_value_so2r
-- Source: camdecmpswks/views/vw_mp_derived_hrly_value_so2r.sql
-- View: camdecmpswks.vw_mp_derived_hrly_value_so2r


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_derived_hrly_value_so2r
 AS
 SELECT vw_mp_derived_hrly_value.derv_id,
    vw_mp_derived_hrly_value.mon_plan_id,
    vw_mp_derived_hrly_value.mon_loc_id,
    vw_mp_derived_hrly_value.hour_id,
    vw_mp_derived_hrly_value.rpt_period_id,
    vw_mp_derived_hrly_value.calendar_year,
    vw_mp_derived_hrly_value.quarter,
    vw_mp_derived_hrly_value.begin_date,
    vw_mp_derived_hrly_value.begin_hour,
    vw_mp_derived_hrly_value.parameter_cd,
    vw_mp_derived_hrly_value.unadjusted_hrly_value,
    vw_mp_derived_hrly_value.adjusted_hrly_value,
    vw_mp_derived_hrly_value.modc_cd,
    vw_mp_derived_hrly_value.mon_sys_id,
    vw_mp_derived_hrly_value.mon_form_id,
    vw_mp_derived_hrly_value.pct_available,
    vw_mp_derived_hrly_value.diluent_cap_ind,
    vw_mp_derived_hrly_value.operating_condition_cd,
    vw_mp_derived_hrly_value.segment_num,
    vw_mp_derived_hrly_value.fuel_cd,
    vw_mp_derived_hrly_value.system_identifier,
    vw_mp_derived_hrly_value.sys_type_cd,
    vw_mp_derived_hrly_value.sys_designation_cd,
    vw_mp_derived_hrly_value.formula_identifier,
    vw_mp_derived_hrly_value.formula_parameter_cd,
    vw_mp_derived_hrly_value.equation_cd
   FROM camdecmpswks.vw_mp_derived_hrly_value
  WHERE vw_mp_derived_hrly_value.parameter_cd::text = 'SO2R'::text;

-- 101. Recreate camdecmpswks.vw_mp_evaluation_results
-- Source: camdecmpswks/views/vw_mp_evaluation_results.sql
-- View: camdecmpswks.vw_mp_evaluation_results


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_evaluation_results
 AS
 SELECT cs.mon_plan_id AS monitorplanid,
        CASE
            WHEN ml.stack_pipe_id IS NOT NULL THEN sp.stack_name
            WHEN ml.unit_id IS NOT NULL THEN u.unitid
            WHEN cl.mon_loc_id IS NULL THEN 'All Locations'::character varying
            ELSE 'Undetermined'::character varying
        END AS unitstackinformation,
    cl.severity_cd AS severitycode,
    ccd.category_cd_description AS categorycodedescription,
    (((cc.check_type_cd::text || '-'::text) || cc.check_number) || '-'::text) || ccr.check_result::text AS checkcode,
    cl.result_message AS resultmessage
   FROM camdecmpswks.check_log cl
     JOIN camdecmpswks.check_session cs ON cl.chk_session_id::text = cs.chk_session_id::text
     LEFT JOIN camdecmpswks.monitor_location ml ON cl.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.stack_pipe sp ON ml.stack_pipe_id::text = sp.stack_pipe_id::text
     LEFT JOIN camd.unit u ON ml.unit_id = u.unit_id
     JOIN camdecmpsmd.check_catalog_result ccr ON cl.check_catalog_result_id = ccr.check_catalog_result_id
     JOIN camdecmpsmd.check_catalog cc ON ccr.check_catalog_id = cc.check_catalog_id
     JOIN camdecmpsmd.rule_check rc ON cc.check_catalog_id = rc.check_catalog_id
     JOIN camdecmpsmd.category_code ccd ON rc.category_cd::text = ccd.category_cd::text AND ccd.process_cd::text = 'MP'::text;

-- 102. Recreate camdecmpswks.vw_mp_hrly_fuel_flow
-- Source: camdecmpswks/views/vw_mp_hrly_fuel_flow.sql
-- View: camdecmpswks.vw_mp_hrly_fuel_flow


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_hrly_fuel_flow
 AS
 SELECT hff.hrly_fuel_flow_id,
    hff.hour_id,
    vwhod.mon_plan_id,
    vwhod.mon_loc_id,
    vwhod.rpt_period_id,
    vwhod.calendar_year,
    vwhod.quarter,
    vwhod.begin_date,
    vwhod.begin_hour,
    ms.mon_sys_id,
    fc.fuel_cd,
    fc.fuel_group_cd,
    fc.unit_fuel_cd,
    hff.fuel_usage_time,
    hff.volumetric_flow_rate,
    hff.calc_volumetric_flow_rate,
    hff.volumetric_uom_cd,
    hff.sod_volumetric_cd,
    hff.mass_flow_rate,
    hff.calc_mass_flow_rate,
    hff.sod_mass_cd,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.sys_designation_cd,
    ms.begin_date AS system_begin_date
   FROM camdecmpswks.vw_mp_hrly_op_data vwhod
     JOIN camdecmpswks.hrly_fuel_flow hff ON vwhod.hour_id::text = hff.hour_id::text
     LEFT JOIN camdecmpsmd.fuel_code fc ON hff.fuel_cd::text = fc.fuel_cd::text
     LEFT JOIN camdecmpswks.monitor_system ms ON hff.mon_sys_id::text = ms.mon_sys_id::text;

-- 103. Recreate camdecmpswks.vw_mp_hrly_param_fuel_flow
-- Source: camdecmpswks/views/vw_mp_hrly_param_fuel_flow.sql
-- View: camdecmpswks.vw_mp_hrly_param_fuel_flow


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_hrly_param_fuel_flow
 AS
 SELECT hpff.hrly_param_ff_id,
    hff.hrly_fuel_flow_id,
    vwhod.hour_id,
    vwhod.mon_plan_id,
    vwhod.mon_loc_id,
    vwhod.rpt_period_id,
    vwhod.calendar_year,
    vwhod.quarter,
    vwhod.begin_date,
    vwhod.begin_hour,
    ms.mon_sys_id,
    hpff.mon_form_id,
    hpff.parameter_cd,
    hpff.param_val_fuel,
    hpff.calc_param_val_fuel,
    hpff.sample_type_cd,
    hpff.operating_condition_cd,
    hpff.segment_num,
    hpff.parameter_uom_cd,
    fc.fuel_cd,
    fc.fuel_group_cd,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.sys_designation_cd,
    mf.formula_identifier,
    mf.parameter_cd AS formula_parameter_cd,
    mf.equation_cd
   FROM camdecmpswks.vw_mp_hrly_op_data vwhod
     JOIN camdecmpswks.hrly_fuel_flow hff ON vwhod.hour_id::text = hff.hour_id::text
     JOIN camdecmpswks.hrly_param_fuel_flow hpff ON hff.hrly_fuel_flow_id::text = hpff.hrly_fuel_flow_id::text
     LEFT JOIN camdecmpsmd.fuel_code fc ON hff.fuel_cd::text = fc.fuel_cd::text
     LEFT JOIN camdecmpswks.monitor_system ms ON hpff.mon_sys_id::text = ms.mon_sys_id::text
     LEFT JOIN camdecmpswks.monitor_formula mf ON hpff.mon_form_id::text = mf.mon_form_id::text;

-- 104. Recreate camdecmpswks.vw_mp_location
-- Source: camdecmpswks/views/vw_mp_location.sql
-- View: camdecmpswks.vw_mp_location


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_location
 AS
 SELECT mpl.mon_loc_id,
    ml.stack_pipe_id,
    ml.unit_id,
    mp.mon_plan_id,
    mp.fac_id,
    sp.stack_name,
    u.unitid,
    u.non_load_based_ind,
    sp.active_date,
    sp.retire_date,
        CASE
            WHEN u.unit_id IS NOT NULL THEN u.unitid
            WHEN sp.stack_pipe_id IS NOT NULL THEN sp.stack_name
            ELSE NULL::character varying
        END AS location_identifier,
    COALESCE(u.comr_op_date::timestamp without time zone, dsp.comr_op_date) AS comr_op_date,
        CASE
            WHEN ml.unit_id IS NOT NULL THEN 'UN'::text
            ELSE substr(sp.stack_name::text, 1, 2)
        END AS location_type
   FROM camdecmpswks.monitor_plan_location mpl
     JOIN camdecmpswks.monitor_location ml ON mpl.mon_loc_id::text = ml.mon_loc_id::text
     JOIN camdecmpswks.monitor_plan mp ON mpl.mon_plan_id::text = mp.mon_plan_id::text
     LEFT JOIN camd.unit u ON ml.unit_id = u.unit_id
     LEFT JOIN camdecmpswks.stack_pipe sp ON ml.stack_pipe_id::text = sp.stack_pipe_id::text
     LEFT JOIN ( SELECT usc.stack_pipe_id,
            min(COALESCE(unit.comr_op_date::timestamp without time zone, '9999-12-31 00:00:00'::timestamp without time zone)) AS comr_op_date
           FROM camd.unit unit
             JOIN camdecmpswks.unit_stack_configuration usc ON unit.unit_id = usc.unit_id
          GROUP BY usc.stack_pipe_id) dsp ON ml.stack_pipe_id::text = dsp.stack_pipe_id::text;

-- 105. Recreate camdecmpswks.vw_mp_location_attribute
-- Source: camdecmpswks/views/vw_mp_location_attribute.sql
-- View: camdecmpswks.vw_mp_location_attribute


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_location_attribute
 AS
 SELECT sp.stack_pipe_id,
    ml.unit_id,
    mla.grd_elevation,
    mla.duct_ind,
    mla.bypass_ind,
    mla.cross_area_flow,
    mla.cross_area_exit,
    mla.begin_date,
    mla.end_date,
    mla.stack_height,
    mla.shape_cd,
    mla.material_cd,
    mp.mon_plan_id,
    mp.fac_id,
    sp.stack_name,
    u.unitid,
    u.non_load_based_ind,
    mla.mon_loc_attrib_id,
    ml.mon_loc_id
   FROM camdecmpswks.monitor_plan_location mpl
     JOIN camdecmpswks.monitor_location ml ON mpl.mon_loc_id::text = ml.mon_loc_id::text
     JOIN camdecmpswks.monitor_location_attribute mla ON ml.mon_loc_id::text = mla.mon_loc_id::text
     JOIN camdecmpswks.monitor_plan mp ON mpl.mon_plan_id::text = mp.mon_plan_id::text
     LEFT JOIN camd.unit u ON ml.unit_id = u.unit_id
     LEFT JOIN camdecmpswks.stack_pipe sp ON ml.stack_pipe_id::text = sp.stack_pipe_id::text;

-- 106. Recreate camdecmpswks.vw_mp_location_capacity
-- Source: camdecmpswks/views/vw_mp_location_capacity.sql
-- View: camdecmpswks.vw_mp_location_capacity


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_location_capacity
 AS
 SELECT mpl.mon_plan_id,
    loc.mon_loc_id,
    cap.unit_id,
    loc.stack_pipe_id,
    cap.max_hi_capacity,
        CASE
            WHEN usc.begin_date IS NULL THEN cap.begin_date
            WHEN cap.begin_date IS NULL THEN usc.begin_date
            WHEN cap.begin_date >= usc.begin_date THEN cap.begin_date
            ELSE usc.begin_date
        END AS begin_date,
        CASE
            WHEN usc.end_date IS NULL THEN cap.end_date
            WHEN cap.end_date IS NULL THEN usc.end_date
            WHEN cap.end_date <= usc.end_date THEN cap.end_date
            ELSE usc.end_date
        END AS end_date
   FROM camdecmpswks.monitor_plan_location mpl
     JOIN camdecmpswks.monitor_location loc ON loc.mon_loc_id::text = mpl.mon_loc_id::text
     JOIN camdecmpswks.unit_stack_configuration usc ON usc.stack_pipe_id::text = loc.stack_pipe_id::text
     JOIN camdecmpswks.unit_capacity cap ON cap.unit_id = usc.unit_id
UNION
 SELECT mpl.mon_plan_id,
    loc.mon_loc_id,
    cap.unit_id,
    NULL::character varying AS stack_pipe_id,
    cap.max_hi_capacity,
    cap.begin_date,
    cap.end_date
   FROM camdecmpswks.monitor_plan_location mpl
     JOIN camdecmpswks.monitor_location loc ON loc.mon_loc_id::text = mpl.mon_loc_id::text
     JOIN camdecmpswks.unit_capacity cap ON cap.unit_id = loc.unit_id;

-- 107. Recreate camdecmpswks.vw_mp_location_fuel
-- Source: camdecmpswks/views/vw_mp_location_fuel.sql
-- View: camdecmpswks.vw_mp_location_fuel


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_location_fuel
 AS
 SELECT mpl.mon_plan_id,
    mpl.mon_loc_id,
    uf.uf_id,
    u.unitid AS location_name,
    u.unitid AS unit_name,
    uf.dem_gcv,
    uf.dem_so2,
    uf.begin_date,
    uf.end_date,
    uf.indicator_cd,
    uf.ozone_seas_ind,
    uf.fuel_type AS fuel_cd,
    fc.fuel_group_cd,
    uf.unit_id
   FROM camdecmpswks.monitor_plan_location mpl
     JOIN camdecmpswks.monitor_location ml ON mpl.mon_loc_id::text = ml.mon_loc_id::text
     JOIN camdecmpswks.unit_fuel uf ON ml.unit_id = uf.unit_id
     JOIN camd.unit u ON ml.unit_id = u.unit_id
     JOIN camdecmpsmd.fuel_code fc ON uf.fuel_type::text = fc.fuel_cd::text
UNION
 SELECT mpl.mon_plan_id,
    mpl.mon_loc_id,
    uf.uf_id,
    stack_pipe.stack_name AS location_name,
    u.unitid AS unit_name,
    uf.dem_gcv,
    uf.dem_so2,
    uf.begin_date,
    uf.end_date,
    uf.indicator_cd,
    uf.ozone_seas_ind,
    uf.fuel_type AS fuel_cd,
    fc.fuel_group_cd,
    uf.unit_id
   FROM camdecmpswks.monitor_plan_location mpl
     JOIN camdecmpswks.monitor_location ml ON mpl.mon_loc_id::text = ml.mon_loc_id::text
     JOIN camdecmpswks.unit_stack_configuration usc ON ml.stack_pipe_id::text = usc.stack_pipe_id::text
     JOIN camd.unit u ON u.unit_id = usc.unit_id
     JOIN camdecmpswks.unit_fuel uf ON usc.unit_id = uf.unit_id
     JOIN camdecmpswks.stack_pipe ON usc.stack_pipe_id::text = stack_pipe.stack_pipe_id::text
     JOIN camdecmpsmd.fuel_code fc ON uf.fuel_type::text = fc.fuel_cd::text;

-- 108. Recreate camdecmpswks.vw_mp_location_program
-- Source: camdecmpswks/views/vw_mp_location_program.sql
-- View: camdecmpswks.vw_mp_location_program


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_location_program
 AS
 SELECT up.up_id,
    ml.mon_plan_id,
    ml.mon_loc_id,
    ml.oris_code,
    ml.location_name,
    usc.unit_id,
    ml.stack_pipe_id,
    up.prg_cd,
    up.class_cd AS class,
        CASE
            WHEN usc.begin_date IS NULL THEN up.unit_monitor_cert_begin_date
            WHEN up.unit_monitor_cert_begin_date IS NULL THEN usc.begin_date
            WHEN up.unit_monitor_cert_begin_date >= usc.begin_date THEN up.unit_monitor_cert_begin_date
            ELSE usc.begin_date
        END AS unit_monitor_cert_begin_date,
        CASE
            WHEN usc.begin_date IS NULL THEN up.emissions_recording_begin_date
            WHEN up.emissions_recording_begin_date IS NULL THEN usc.begin_date
            WHEN up.emissions_recording_begin_date >= usc.begin_date THEN up.emissions_recording_begin_date
            ELSE usc.begin_date
        END AS emissions_recording_begin_date,
    up.trueup_begin_year,
    up.unit_monitor_cert_deadline,
    up.non_egu_ind AS non_egu_flg,
    up.app_status_cd AS app_status,
    up.optin_ind,
    up.def_ind,
    up.def_end_date,
        CASE
            WHEN usc.end_date IS NULL THEN up.end_date
            WHEN up.end_date IS NULL THEN usc.end_date
            WHEN up.end_date <= usc.end_date THEN up.end_date
            ELSE usc.end_date
        END AS end_date,
    ml.fac_id
   FROM camdecmpswks.vw_mp_monitor_location ml
     JOIN camdecmpswks.unit_stack_configuration usc ON ml.stack_pipe_id::text = usc.stack_pipe_id::text
     JOIN camd.unit_program up ON usc.unit_id = up.unit_id
     JOIN camd.unit u ON u.unit_id = usc.unit_id
UNION
 SELECT up.up_id,
    ml.mon_plan_id,
    ml.mon_loc_id,
    ml.oris_code,
    ml.location_name,
    ml.unit_id,
    NULL::character varying AS stack_pipe_id,
    up.prg_cd,
    up.class_cd AS class,
    up.unit_monitor_cert_begin_date,
    up.emissions_recording_begin_date,
    up.trueup_begin_year,
    up.unit_monitor_cert_deadline,
    up.non_egu_ind AS non_egu_flg,
    up.app_status_cd AS app_status,
    up.optin_ind,
    up.def_ind,
    up.def_end_date,
    up.end_date,
    ml.fac_id
   FROM camdecmpswks.vw_mp_monitor_location ml
     JOIN camd.unit_program up ON ml.unit_id = up.unit_id
     JOIN camd.unit u ON u.unit_id = ml.unit_id;

-- 109. Recreate camdecmpswks.vw_mp_location_unit_type
-- Source: camdecmpswks/views/vw_mp_location_unit_type.sql
-- View: camdecmpswks.vw_mp_location_unit_type


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_location_unit_type
 AS
 SELECT mpl.mon_plan_id,
    mpl.mon_loc_id,
    uc.unit_boiler_type_id,
    uc.unit_id,
    u.unitid,
    uc.unit_type_cd,
    uc.begin_date,
    uc.end_date
   FROM camdecmpswks.monitor_plan_location mpl
     JOIN camdecmpswks.monitor_location ml ON mpl.mon_loc_id::text = ml.mon_loc_id::text
     JOIN camdecmpswks.unit_stack_configuration usc ON ml.stack_pipe_id::text = usc.stack_pipe_id::text
     JOIN camd.unit_boiler_type uc ON usc.unit_id = uc.unit_id
     JOIN camd.unit u ON u.unit_id = usc.unit_id
UNION
 SELECT mpl.mon_plan_id,
    mpl.mon_loc_id,
    uc.unit_boiler_type_id,
    uc.unit_id,
    u.unitid,
    uc.unit_type_cd,
    uc.begin_date,
    uc.end_date
   FROM camdecmpswks.monitor_plan_location mpl
     JOIN camdecmpswks.monitor_location ml ON mpl.mon_loc_id::text = ml.mon_loc_id::text
     JOIN camd.unit_boiler_type uc ON ml.unit_id = uc.unit_id
     JOIN camd.unit u ON u.unit_id = ml.unit_id;

-- 110. Recreate camdecmpswks.vw_mp_locations_and_unit_stack_configurations
-- Source: camdecmpswks/views/vw_mp_locations_and_unit_stack_configurations.sql
-- View: camdecmpswks.vw_mp_locations_and_unit_stack_configurations


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_locations_and_unit_stack_configurations
AS
SELECT
    mp.mon_plan_id,
    p.oris_code,
    mp.fac_id,
    p.facility_name,
    p.frs_id,
    mp.config_type_cd,
    mp.last_updated,
    mp.updated_status_flg,
    mp.needs_eval_flg,
    mp.chk_session_id,
    mp.userid,
    mp.add_date,
    mp.update_date,
    mp.submission_id,
    mp.submission_availability_cd,
    mp.pending_status_cd,
    mp.begin_rpt_period_id,
    rpb.period_abbreviation AS begin_period_abbreviation,
    mp.end_rpt_period_id,
    rpe.period_abbreviation AS end_period_abbreviation,
    mp.last_evaluated_date,
    mp.eval_status_cd,
    esc.eval_status_cd_description,
    sac.sub_avail_cd_description,
    sc.severity_cd_description,
    sc.severity_cd,
    (
        SELECT string_agg(COALESCE(unt.unitid, stp.stack_name), ', ' ORDER BY unt.unitid, stp.stack_name)
        FROM camdecmpswks.monitor_plan_location mpl
            JOIN camdecmpswks.monitor_location loc USING (mon_loc_id)
            LEFT JOIN camdecmpswks.unit unt USING (unit_id)
            LEFT JOIN camdecmpswks.stack_pipe stp USING (stack_pipe_id)
        WHERE mpl.mon_plan_id = mp.mon_plan_id
    ) AS locations
FROM camdecmpswks.monitor_plan mp
    INNER JOIN camd.plant p ON mp.fac_id = p.fac_id
    INNER JOIN camdecmpsmd.reporting_period rpb ON mp.begin_rpt_period_id = rpb.rpt_period_id
    LEFT JOIN camdecmpsmd.reporting_period rpe ON mp.end_rpt_period_id = rpe.rpt_period_id
    INNER JOIN camdecmpsmd.eval_status_code esc ON mp.eval_status_cd = esc.eval_status_cd
    LEFT JOIN camdecmpsmd.submission_availability_code sac ON mp.submission_availability_cd = sac.submission_availability_cd
    LEFT JOIN camdecmpswks.check_session cs ON cs.chk_session_id = mp.chk_session_id
    LEFT JOIN camdecmpsmd.severity_code sc ON sc.severity_cd = cs.severity_cd;

-- 111. Recreate camdecmpswks.vw_mp_monitor_default
-- Source: camdecmpswks/views/vw_mp_monitor_default.sql
-- View: camdecmpswks.vw_mp_monitor_default


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_default
 AS
 SELECT md.mondef_id,
    ml.mon_plan_id,
    md.mon_loc_id,
    md.parameter_cd,
    md.begin_date,
    md.begin_hour,
    md.end_date,
    md.end_hour,
    md.operating_condition_cd,
    md.default_value,
    md.default_uom_cd,
    md.default_purpose_cd,
    md.default_source_cd,
    md.fuel_cd,
    md.group_id
   FROM camdecmpswks.monitor_default md
     JOIN camdecmpswks.vw_mp_monitor_location ml ON md.mon_loc_id::text = ml.mon_loc_id::text;

-- 112. Recreate camdecmpswks.vw_mp_monitor_default_co2n_nfs
-- Source: camdecmpswks/views/vw_mp_monitor_default_co2n_nfs.sql
-- View: camdecmpswks.vw_mp_monitor_default_co2n_nfs


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_default_co2n_nfs
 AS
 SELECT vw_mp_monitor_default.mondef_id,
    vw_mp_monitor_default.mon_plan_id,
    vw_mp_monitor_default.mon_loc_id,
    vw_mp_monitor_default.parameter_cd,
    vw_mp_monitor_default.begin_date,
    vw_mp_monitor_default.begin_hour,
    vw_mp_monitor_default.end_date,
    vw_mp_monitor_default.end_hour,
    vw_mp_monitor_default.operating_condition_cd,
    vw_mp_monitor_default.default_value,
    vw_mp_monitor_default.default_uom_cd,
    vw_mp_monitor_default.default_purpose_cd,
    vw_mp_monitor_default.default_source_cd,
    vw_mp_monitor_default.fuel_cd,
    vw_mp_monitor_default.group_id
   FROM camdecmpswks.vw_mp_monitor_default
  WHERE vw_mp_monitor_default.parameter_cd::text = 'CO2N'::text AND vw_mp_monitor_default.fuel_cd::text = 'NFS'::text;

-- 113. Recreate camdecmpswks.vw_mp_monitor_default_co2x
-- Source: camdecmpswks/views/vw_mp_monitor_default_co2x.sql
-- View: camdecmpswks.vw_mp_monitor_default_co2x


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_default_co2x
 AS
 SELECT vw_mp_monitor_default.mondef_id,
    vw_mp_monitor_default.mon_plan_id,
    vw_mp_monitor_default.mon_loc_id,
    vw_mp_monitor_default.parameter_cd,
    vw_mp_monitor_default.begin_date,
    vw_mp_monitor_default.begin_hour,
    vw_mp_monitor_default.end_date,
    vw_mp_monitor_default.end_hour,
    vw_mp_monitor_default.operating_condition_cd,
    vw_mp_monitor_default.default_value,
    vw_mp_monitor_default.default_uom_cd,
    vw_mp_monitor_default.default_purpose_cd,
    vw_mp_monitor_default.default_source_cd,
    vw_mp_monitor_default.fuel_cd,
    vw_mp_monitor_default.group_id
   FROM camdecmpswks.vw_mp_monitor_default
  WHERE vw_mp_monitor_default.parameter_cd::text = 'CO2X'::text;

-- 114. Recreate camdecmpswks.vw_mp_monitor_default_h2o
-- Source: camdecmpswks/views/vw_mp_monitor_default_h2o.sql
-- View: camdecmpswks.vw_mp_monitor_default_h2o


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_default_h2o
 AS
 SELECT vw_mp_monitor_default.mondef_id,
    vw_mp_monitor_default.mon_plan_id,
    vw_mp_monitor_default.mon_loc_id,
    vw_mp_monitor_default.parameter_cd,
    vw_mp_monitor_default.begin_date,
    vw_mp_monitor_default.begin_hour,
    vw_mp_monitor_default.end_date,
    vw_mp_monitor_default.end_hour,
    vw_mp_monitor_default.operating_condition_cd,
    vw_mp_monitor_default.default_value,
    vw_mp_monitor_default.default_uom_cd,
    vw_mp_monitor_default.default_purpose_cd,
    vw_mp_monitor_default.default_source_cd,
    vw_mp_monitor_default.fuel_cd,
    vw_mp_monitor_default.group_id
   FROM camdecmpswks.vw_mp_monitor_default
  WHERE vw_mp_monitor_default.parameter_cd::text = 'H2O'::text;

-- 115. Recreate camdecmpswks.vw_mp_monitor_default_mngf
-- Source: camdecmpswks/views/vw_mp_monitor_default_mngf.sql
-- View: camdecmpswks.vw_mp_monitor_default_mngf


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_default_mngf
 AS
 SELECT vw_mp_monitor_default.mondef_id,
    vw_mp_monitor_default.mon_plan_id,
    vw_mp_monitor_default.mon_loc_id,
    vw_mp_monitor_default.parameter_cd,
    vw_mp_monitor_default.begin_date,
    vw_mp_monitor_default.begin_hour,
    vw_mp_monitor_default.end_date,
    vw_mp_monitor_default.end_hour,
    vw_mp_monitor_default.operating_condition_cd,
    vw_mp_monitor_default.default_value,
    vw_mp_monitor_default.default_uom_cd,
    vw_mp_monitor_default.default_purpose_cd,
    vw_mp_monitor_default.default_source_cd,
    vw_mp_monitor_default.fuel_cd,
    vw_mp_monitor_default.group_id
   FROM camdecmpswks.vw_mp_monitor_default
  WHERE vw_mp_monitor_default.parameter_cd::text = 'MNGF'::text;

-- 116. Recreate camdecmpswks.vw_mp_monitor_default_mnof
-- Source: camdecmpswks/views/vw_mp_monitor_default_mnof.sql
-- View: camdecmpswks.vw_mp_monitor_default_mnof


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_default_mnof
 AS
 SELECT vw_mp_monitor_default.mondef_id,
    vw_mp_monitor_default.mon_plan_id,
    vw_mp_monitor_default.mon_loc_id,
    vw_mp_monitor_default.parameter_cd,
    vw_mp_monitor_default.begin_date,
    vw_mp_monitor_default.begin_hour,
    vw_mp_monitor_default.end_date,
    vw_mp_monitor_default.end_hour,
    vw_mp_monitor_default.operating_condition_cd,
    vw_mp_monitor_default.default_value,
    vw_mp_monitor_default.default_uom_cd,
    vw_mp_monitor_default.default_purpose_cd,
    vw_mp_monitor_default.default_source_cd,
    vw_mp_monitor_default.fuel_cd,
    vw_mp_monitor_default.group_id
   FROM camdecmpswks.vw_mp_monitor_default
  WHERE vw_mp_monitor_default.parameter_cd::text = 'MNOF'::text;

-- 117. Recreate camdecmpswks.vw_mp_monitor_default_mxff
-- Source: camdecmpswks/views/vw_mp_monitor_default_mxff.sql
-- View: camdecmpswks.vw_mp_monitor_default_mxff


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_default_mxff
 AS
 SELECT vw_mp_monitor_default.mondef_id,
    vw_mp_monitor_default.mon_plan_id,
    vw_mp_monitor_default.mon_loc_id,
    vw_mp_monitor_default.parameter_cd,
    vw_mp_monitor_default.begin_date,
    vw_mp_monitor_default.begin_hour,
    vw_mp_monitor_default.end_date,
    vw_mp_monitor_default.end_hour,
    vw_mp_monitor_default.operating_condition_cd,
    vw_mp_monitor_default.default_value,
    vw_mp_monitor_default.default_uom_cd,
    vw_mp_monitor_default.default_purpose_cd,
    vw_mp_monitor_default.default_source_cd,
    vw_mp_monitor_default.fuel_cd,
    vw_mp_monitor_default.group_id
   FROM camdecmpswks.vw_mp_monitor_default
  WHERE vw_mp_monitor_default.parameter_cd::text = 'MXFF'::text;

-- 118. Recreate camdecmpswks.vw_mp_monitor_default_norx
-- Source: camdecmpswks/views/vw_mp_monitor_default_norx.sql
-- View: camdecmpswks.vw_mp_monitor_default_norx


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_default_norx
 AS
 SELECT vw_mp_monitor_default.mondef_id,
    vw_mp_monitor_default.mon_plan_id,
    vw_mp_monitor_default.mon_loc_id,
    vw_mp_monitor_default.parameter_cd,
    vw_mp_monitor_default.begin_date,
    vw_mp_monitor_default.begin_hour,
    vw_mp_monitor_default.end_date,
    vw_mp_monitor_default.end_hour,
    vw_mp_monitor_default.operating_condition_cd,
    vw_mp_monitor_default.default_value,
    vw_mp_monitor_default.default_uom_cd,
    vw_mp_monitor_default.default_purpose_cd,
    vw_mp_monitor_default.default_source_cd,
    vw_mp_monitor_default.fuel_cd,
    vw_mp_monitor_default.group_id
   FROM camdecmpswks.vw_mp_monitor_default
  WHERE vw_mp_monitor_default.parameter_cd::text = 'NORX'::text;

-- 119. Recreate camdecmpswks.vw_mp_monitor_default_o2x
-- Source: camdecmpswks/views/vw_mp_monitor_default_o2x.sql
-- View: camdecmpswks.vw_mp_monitor_default_o2x


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_default_o2x
 AS
 SELECT vw_mp_monitor_default.mondef_id,
    vw_mp_monitor_default.mon_plan_id,
    vw_mp_monitor_default.mon_loc_id,
    vw_mp_monitor_default.parameter_cd,
    vw_mp_monitor_default.begin_date,
    vw_mp_monitor_default.begin_hour,
    vw_mp_monitor_default.end_date,
    vw_mp_monitor_default.end_hour,
    vw_mp_monitor_default.operating_condition_cd,
    vw_mp_monitor_default.default_value,
    vw_mp_monitor_default.default_uom_cd,
    vw_mp_monitor_default.default_purpose_cd,
    vw_mp_monitor_default.default_source_cd,
    vw_mp_monitor_default.fuel_cd,
    vw_mp_monitor_default.group_id
   FROM camdecmpswks.vw_mp_monitor_default
  WHERE vw_mp_monitor_default.parameter_cd::text = 'O2X'::text;

-- 120. Recreate camdecmpswks.vw_mp_monitor_default_so2c
-- Source: camdecmpswks/views/vw_mp_monitor_default_so2c.sql
-- View: camdecmpswks.vw_mp_monitor_default_so2c


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_default_so2c
 AS
 SELECT vw_mp_monitor_default.mondef_id,
    vw_mp_monitor_default.mon_plan_id,
    vw_mp_monitor_default.mon_loc_id,
    vw_mp_monitor_default.parameter_cd,
    vw_mp_monitor_default.begin_date,
    vw_mp_monitor_default.begin_hour,
    vw_mp_monitor_default.end_date,
    vw_mp_monitor_default.end_hour,
    vw_mp_monitor_default.operating_condition_cd,
    vw_mp_monitor_default.default_value,
    vw_mp_monitor_default.default_uom_cd,
    vw_mp_monitor_default.default_purpose_cd,
    vw_mp_monitor_default.default_source_cd,
    vw_mp_monitor_default.fuel_cd,
    vw_mp_monitor_default.group_id
   FROM camdecmpswks.vw_mp_monitor_default
  WHERE vw_mp_monitor_default.parameter_cd::text = 'SO2C'::text;

-- 121. Recreate camdecmpswks.vw_mp_monitor_default_so2r_f23
-- Source: camdecmpswks/views/vw_mp_monitor_default_so2r_f23.sql
-- View: camdecmpswks.vw_mp_monitor_default_so2r_f23


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_default_so2r_f23
 AS
 SELECT vw_mp_monitor_default.mondef_id,
    vw_mp_monitor_default.mon_plan_id,
    vw_mp_monitor_default.mon_loc_id,
    vw_mp_monitor_default.parameter_cd,
    vw_mp_monitor_default.begin_date,
    vw_mp_monitor_default.begin_hour,
    vw_mp_monitor_default.end_date,
    vw_mp_monitor_default.end_hour,
    vw_mp_monitor_default.operating_condition_cd,
    vw_mp_monitor_default.default_value,
    vw_mp_monitor_default.default_uom_cd,
    vw_mp_monitor_default.default_purpose_cd,
    vw_mp_monitor_default.default_source_cd,
    vw_mp_monitor_default.fuel_cd,
    vw_mp_monitor_default.group_id
   FROM camdecmpswks.vw_mp_monitor_default
  WHERE vw_mp_monitor_default.parameter_cd::text = 'SO2R'::text AND vw_mp_monitor_default.default_purpose_cd::text = 'F23'::text;

-- 122. Recreate camdecmpswks.vw_mp_monitor_default_so2x
-- Source: camdecmpswks/views/vw_mp_monitor_default_so2x.sql
-- View: camdecmpswks.vw_mp_monitor_default_so2x


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_default_so2x
 AS
 SELECT vw_mp_monitor_default.mondef_id,
    vw_mp_monitor_default.mon_plan_id,
    vw_mp_monitor_default.mon_loc_id,
    vw_mp_monitor_default.parameter_cd,
    vw_mp_monitor_default.begin_date,
    vw_mp_monitor_default.begin_hour,
    vw_mp_monitor_default.end_date,
    vw_mp_monitor_default.end_hour,
    vw_mp_monitor_default.operating_condition_cd,
    vw_mp_monitor_default.default_value,
    vw_mp_monitor_default.default_uom_cd,
    vw_mp_monitor_default.default_purpose_cd,
    vw_mp_monitor_default.default_source_cd,
    vw_mp_monitor_default.fuel_cd,
    vw_mp_monitor_default.group_id
   FROM camdecmpswks.vw_mp_monitor_default
  WHERE vw_mp_monitor_default.parameter_cd::text = 'SO2X'::text;

-- 123. Recreate camdecmpswks.vw_mp_monitor_formula
-- Source: camdecmpswks/views/vw_mp_monitor_formula.sql
-- View: camdecmpswks.vw_mp_monitor_formula


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_formula
 AS
 SELECT mf.mon_form_id,
    vwml.mon_plan_id,
    vwml.mon_loc_id,
    mf.parameter_cd,
    ec.equation_cd,
    mf.formula_identifier,
    mf.begin_date,
    mf.begin_hour,
    mf.end_date,
    mf.end_hour,
    mf.formula_equation,
    vwml.fac_id,
    vwml.location_name,
    ec.equation_cd_description,
    ec.moisture_ind
   FROM camdecmpswks.monitor_formula mf
     JOIN camdecmpswks.vw_mp_monitor_location vwml ON mf.mon_loc_id::text = vwml.mon_loc_id::text
     LEFT JOIN camdecmpsmd.equation_code ec ON mf.equation_cd::text = ec.equation_cd::text;

-- 124. Recreate camdecmpswks.vw_mp_monitor_formula_so2
-- Source: camdecmpswks/views/vw_mp_monitor_formula_so2.sql
-- View: camdecmpswks.vw_mp_monitor_formula_so2


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_formula_so2
 AS
 SELECT mf.mon_form_id,
    vwml.mon_plan_id,
    vwml.mon_loc_id,
    mf.parameter_cd,
    mf.equation_cd,
    mf.formula_identifier,
    mf.begin_date,
    mf.begin_hour,
    mf.end_date,
    mf.end_hour,
    mf.formula_equation
   FROM camdecmpswks.monitor_formula mf
     JOIN camdecmpswks.vw_mp_monitor_location vwml ON mf.mon_loc_id::text = vwml.mon_loc_id::text
  WHERE mf.parameter_cd::text = 'SO2'::text;

-- 125. Recreate camdecmpswks.vw_mp_monitor_hrly_value
-- Source: camdecmpswks/views/vw_mp_monitor_hrly_value.sql
-- View: camdecmpswks.vw_mp_monitor_hrly_value


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_hrly_value
 AS
 SELECT monitor_hrly_value.monitor_hrly_val_id,
    vw_mp_hrly_op_data.mon_plan_id,
    vw_mp_hrly_op_data.mon_loc_id,
    vw_mp_hrly_op_data.hour_id,
    vw_mp_hrly_op_data.rpt_period_id,
    vw_mp_hrly_op_data.calendar_year,
    vw_mp_hrly_op_data.quarter,
    monitor_hrly_value.mon_sys_id,
    monitor_hrly_value.component_id,
    monitor_hrly_value.parameter_cd,
    monitor_hrly_value.modc_cd,
    monitor_hrly_value.adjusted_hrly_value,
    monitor_hrly_value.unadjusted_hrly_value,
    monitor_hrly_value.pct_available,
    monitor_hrly_value.moisture_basis,
    vw_mp_hrly_op_data.begin_date,
    vw_mp_hrly_op_data.begin_hour,
    monitor_system.system_identifier,
    monitor_system.sys_type_cd,
    monitor_system.sys_designation_cd,
    component.component_type_cd,
    component.component_identifier,
    component.serial_number,
    component.acq_cd
   FROM camdecmpswks.monitor_hrly_value
     JOIN camdecmpswks.vw_mp_hrly_op_data ON monitor_hrly_value.hour_id::text = vw_mp_hrly_op_data.hour_id::text
     LEFT JOIN camdecmpswks.component ON monitor_hrly_value.component_id::text = component.component_id::text
     LEFT JOIN camdecmpswks.monitor_system ON monitor_hrly_value.mon_sys_id::text = monitor_system.mon_sys_id::text
  WHERE COALESCE(monitor_hrly_value.modc_cd, ''::character varying)::text <> ALL (ARRAY['47'::character varying::text, '48'::character varying::text]);

-- 126. Recreate camdecmpswks.vw_mp_monitor_hrly_value_co2c
-- Source: camdecmpswks/views/vw_mp_monitor_hrly_value_co2c.sql
-- View: camdecmpswks.vw_mp_monitor_hrly_value_co2c


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_hrly_value_co2c
 AS
 SELECT vw_mp_monitor_hrly_value.monitor_hrly_val_id,
    vw_mp_monitor_hrly_value.mon_plan_id,
    vw_mp_monitor_hrly_value.mon_loc_id,
    vw_mp_monitor_hrly_value.hour_id,
    vw_mp_monitor_hrly_value.rpt_period_id,
    vw_mp_monitor_hrly_value.calendar_year,
    vw_mp_monitor_hrly_value.quarter,
    vw_mp_monitor_hrly_value.mon_sys_id,
    vw_mp_monitor_hrly_value.component_id,
    vw_mp_monitor_hrly_value.parameter_cd,
    vw_mp_monitor_hrly_value.modc_cd,
    vw_mp_monitor_hrly_value.adjusted_hrly_value,
    vw_mp_monitor_hrly_value.unadjusted_hrly_value,
    vw_mp_monitor_hrly_value.pct_available,
    vw_mp_monitor_hrly_value.moisture_basis,
    vw_mp_monitor_hrly_value.begin_date,
    vw_mp_monitor_hrly_value.begin_hour,
    vw_mp_monitor_hrly_value.system_identifier,
    vw_mp_monitor_hrly_value.sys_type_cd,
    vw_mp_monitor_hrly_value.sys_designation_cd,
    vw_mp_monitor_hrly_value.component_type_cd,
    vw_mp_monitor_hrly_value.component_identifier,
    vw_mp_monitor_hrly_value.serial_number,
    vw_mp_monitor_hrly_value.acq_cd
   FROM camdecmpswks.vw_mp_monitor_hrly_value
  WHERE vw_mp_monitor_hrly_value.parameter_cd::text = 'CO2C'::text;

-- 127. Recreate camdecmpswks.vw_mp_monitor_hrly_value_flow
-- Source: camdecmpswks/views/vw_mp_monitor_hrly_value_flow.sql
-- View: camdecmpswks.vw_mp_monitor_hrly_value_flow


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_hrly_value_flow
 AS
 SELECT vw_mp_monitor_hrly_value.monitor_hrly_val_id,
    vw_mp_monitor_hrly_value.mon_plan_id,
    vw_mp_monitor_hrly_value.mon_loc_id,
    vw_mp_monitor_hrly_value.hour_id,
    vw_mp_monitor_hrly_value.rpt_period_id,
    vw_mp_monitor_hrly_value.calendar_year,
    vw_mp_monitor_hrly_value.quarter,
    vw_mp_monitor_hrly_value.mon_sys_id,
    vw_mp_monitor_hrly_value.component_id,
    vw_mp_monitor_hrly_value.parameter_cd,
    vw_mp_monitor_hrly_value.modc_cd,
    vw_mp_monitor_hrly_value.adjusted_hrly_value,
    vw_mp_monitor_hrly_value.unadjusted_hrly_value,
    vw_mp_monitor_hrly_value.pct_available,
    vw_mp_monitor_hrly_value.moisture_basis,
    vw_mp_monitor_hrly_value.begin_date,
    vw_mp_monitor_hrly_value.begin_hour,
    vw_mp_monitor_hrly_value.system_identifier,
    vw_mp_monitor_hrly_value.sys_type_cd,
    vw_mp_monitor_hrly_value.sys_designation_cd,
    vw_mp_monitor_hrly_value.component_type_cd,
    vw_mp_monitor_hrly_value.component_identifier,
    vw_mp_monitor_hrly_value.serial_number,
    vw_mp_monitor_hrly_value.acq_cd
   FROM camdecmpswks.vw_mp_monitor_hrly_value
  WHERE vw_mp_monitor_hrly_value.parameter_cd::text = 'FLOW'::text;

-- 128. Recreate camdecmpswks.vw_mp_monitor_hrly_value_h2o
-- Source: camdecmpswks/views/vw_mp_monitor_hrly_value_h2o.sql
-- View: camdecmpswks.vw_mp_monitor_hrly_value_h2o


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_hrly_value_h2o
 AS
 SELECT vw_mp_monitor_hrly_value.monitor_hrly_val_id,
    vw_mp_monitor_hrly_value.mon_plan_id,
    vw_mp_monitor_hrly_value.mon_loc_id,
    vw_mp_monitor_hrly_value.hour_id,
    vw_mp_monitor_hrly_value.rpt_period_id,
    vw_mp_monitor_hrly_value.calendar_year,
    vw_mp_monitor_hrly_value.quarter,
    vw_mp_monitor_hrly_value.mon_sys_id,
    vw_mp_monitor_hrly_value.component_id,
    vw_mp_monitor_hrly_value.parameter_cd,
    vw_mp_monitor_hrly_value.modc_cd,
    vw_mp_monitor_hrly_value.adjusted_hrly_value,
    vw_mp_monitor_hrly_value.unadjusted_hrly_value,
    vw_mp_monitor_hrly_value.pct_available,
    vw_mp_monitor_hrly_value.moisture_basis,
    vw_mp_monitor_hrly_value.begin_date,
    vw_mp_monitor_hrly_value.begin_hour,
    vw_mp_monitor_hrly_value.system_identifier,
    vw_mp_monitor_hrly_value.sys_type_cd,
    vw_mp_monitor_hrly_value.sys_designation_cd,
    vw_mp_monitor_hrly_value.component_type_cd,
    vw_mp_monitor_hrly_value.component_identifier,
    vw_mp_monitor_hrly_value.serial_number,
    vw_mp_monitor_hrly_value.acq_cd
   FROM camdecmpswks.vw_mp_monitor_hrly_value
  WHERE vw_mp_monitor_hrly_value.parameter_cd::text = 'H2O'::text;

-- 129. Recreate camdecmpswks.vw_mp_monitor_hrly_value_noxc
-- Source: camdecmpswks/views/vw_mp_monitor_hrly_value_noxc.sql
-- View: camdecmpswks.vw_mp_monitor_hrly_value_noxc


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_hrly_value_noxc
 AS
 SELECT vw_mp_monitor_hrly_value.monitor_hrly_val_id,
    vw_mp_monitor_hrly_value.mon_plan_id,
    vw_mp_monitor_hrly_value.mon_loc_id,
    vw_mp_monitor_hrly_value.hour_id,
    vw_mp_monitor_hrly_value.rpt_period_id,
    vw_mp_monitor_hrly_value.calendar_year,
    vw_mp_monitor_hrly_value.quarter,
    vw_mp_monitor_hrly_value.mon_sys_id,
    vw_mp_monitor_hrly_value.component_id,
    vw_mp_monitor_hrly_value.parameter_cd,
    vw_mp_monitor_hrly_value.modc_cd,
    vw_mp_monitor_hrly_value.adjusted_hrly_value,
    vw_mp_monitor_hrly_value.unadjusted_hrly_value,
    vw_mp_monitor_hrly_value.pct_available,
    vw_mp_monitor_hrly_value.moisture_basis,
    vw_mp_monitor_hrly_value.begin_date,
    vw_mp_monitor_hrly_value.begin_hour,
    vw_mp_monitor_hrly_value.system_identifier,
    vw_mp_monitor_hrly_value.sys_type_cd,
    vw_mp_monitor_hrly_value.sys_designation_cd,
    vw_mp_monitor_hrly_value.component_type_cd,
    vw_mp_monitor_hrly_value.component_identifier,
    vw_mp_monitor_hrly_value.serial_number,
    vw_mp_monitor_hrly_value.acq_cd
   FROM camdecmpswks.vw_mp_monitor_hrly_value
  WHERE vw_mp_monitor_hrly_value.parameter_cd::text = 'NOXC'::text;

-- 130. Recreate camdecmpswks.vw_mp_monitor_hrly_value_o2_dry
-- Source: camdecmpswks/views/vw_mp_monitor_hrly_value_o2_dry.sql
-- View: camdecmpswks.vw_mp_monitor_hrly_value_o2_dry


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_hrly_value_o2_dry
 AS
 SELECT vw_mp_monitor_hrly_value.monitor_hrly_val_id,
    vw_mp_monitor_hrly_value.mon_plan_id,
    vw_mp_monitor_hrly_value.mon_loc_id,
    vw_mp_monitor_hrly_value.hour_id,
    vw_mp_monitor_hrly_value.rpt_period_id,
    vw_mp_monitor_hrly_value.calendar_year,
    vw_mp_monitor_hrly_value.quarter,
    vw_mp_monitor_hrly_value.mon_sys_id,
    vw_mp_monitor_hrly_value.component_id,
    vw_mp_monitor_hrly_value.parameter_cd,
    vw_mp_monitor_hrly_value.modc_cd,
    vw_mp_monitor_hrly_value.adjusted_hrly_value,
    vw_mp_monitor_hrly_value.unadjusted_hrly_value,
    vw_mp_monitor_hrly_value.pct_available,
    vw_mp_monitor_hrly_value.moisture_basis,
    vw_mp_monitor_hrly_value.begin_date,
    vw_mp_monitor_hrly_value.begin_hour,
    vw_mp_monitor_hrly_value.system_identifier,
    vw_mp_monitor_hrly_value.sys_type_cd,
    vw_mp_monitor_hrly_value.sys_designation_cd,
    vw_mp_monitor_hrly_value.component_type_cd,
    vw_mp_monitor_hrly_value.component_identifier,
    vw_mp_monitor_hrly_value.serial_number,
    vw_mp_monitor_hrly_value.acq_cd
   FROM camdecmpswks.vw_mp_monitor_hrly_value
  WHERE vw_mp_monitor_hrly_value.parameter_cd::text = 'O2C'::text AND lower(vw_mp_monitor_hrly_value.moisture_basis::text) = lower('D'::text);

-- 131. Recreate camdecmpswks.vw_mp_monitor_hrly_value_o2_null
-- Source: camdecmpswks/views/vw_mp_monitor_hrly_value_o2_null.sql
-- View: camdecmpswks.vw_mp_monitor_hrly_value_o2_null


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_hrly_value_o2_null
 AS
 SELECT vw_mp_monitor_hrly_value.monitor_hrly_val_id,
    vw_mp_monitor_hrly_value.mon_plan_id,
    vw_mp_monitor_hrly_value.mon_loc_id,
    vw_mp_monitor_hrly_value.hour_id,
    vw_mp_monitor_hrly_value.rpt_period_id,
    vw_mp_monitor_hrly_value.calendar_year,
    vw_mp_monitor_hrly_value.quarter,
    vw_mp_monitor_hrly_value.mon_sys_id,
    vw_mp_monitor_hrly_value.component_id,
    vw_mp_monitor_hrly_value.parameter_cd,
    vw_mp_monitor_hrly_value.modc_cd,
    vw_mp_monitor_hrly_value.adjusted_hrly_value,
    vw_mp_monitor_hrly_value.unadjusted_hrly_value,
    vw_mp_monitor_hrly_value.pct_available,
    vw_mp_monitor_hrly_value.moisture_basis,
    vw_mp_monitor_hrly_value.begin_date,
    vw_mp_monitor_hrly_value.begin_hour,
    vw_mp_monitor_hrly_value.system_identifier,
    vw_mp_monitor_hrly_value.sys_type_cd,
    vw_mp_monitor_hrly_value.sys_designation_cd,
    vw_mp_monitor_hrly_value.component_type_cd,
    vw_mp_monitor_hrly_value.component_identifier,
    vw_mp_monitor_hrly_value.serial_number,
    vw_mp_monitor_hrly_value.acq_cd
   FROM camdecmpswks.vw_mp_monitor_hrly_value
  WHERE vw_mp_monitor_hrly_value.parameter_cd::text = 'O2C'::text AND (lower(vw_mp_monitor_hrly_value.moisture_basis::text) = lower(''::text) OR vw_mp_monitor_hrly_value.moisture_basis IS NULL);

-- 132. Recreate camdecmpswks.vw_mp_monitor_hrly_value_o2_wet
-- Source: camdecmpswks/views/vw_mp_monitor_hrly_value_o2_wet.sql
-- View: camdecmpswks.vw_mp_monitor_hrly_value_o2_wet


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_hrly_value_o2_wet
 AS
 SELECT vw_mp_monitor_hrly_value.monitor_hrly_val_id,
    vw_mp_monitor_hrly_value.mon_plan_id,
    vw_mp_monitor_hrly_value.mon_loc_id,
    vw_mp_monitor_hrly_value.hour_id,
    vw_mp_monitor_hrly_value.rpt_period_id,
    vw_mp_monitor_hrly_value.calendar_year,
    vw_mp_monitor_hrly_value.quarter,
    vw_mp_monitor_hrly_value.mon_sys_id,
    vw_mp_monitor_hrly_value.component_id,
    vw_mp_monitor_hrly_value.parameter_cd,
    vw_mp_monitor_hrly_value.modc_cd,
    vw_mp_monitor_hrly_value.adjusted_hrly_value,
    vw_mp_monitor_hrly_value.unadjusted_hrly_value,
    vw_mp_monitor_hrly_value.pct_available,
    vw_mp_monitor_hrly_value.moisture_basis,
    vw_mp_monitor_hrly_value.begin_date,
    vw_mp_monitor_hrly_value.begin_hour,
    vw_mp_monitor_hrly_value.system_identifier,
    vw_mp_monitor_hrly_value.sys_type_cd,
    vw_mp_monitor_hrly_value.sys_designation_cd,
    vw_mp_monitor_hrly_value.component_type_cd,
    vw_mp_monitor_hrly_value.component_identifier,
    vw_mp_monitor_hrly_value.serial_number,
    vw_mp_monitor_hrly_value.acq_cd
   FROM camdecmpswks.vw_mp_monitor_hrly_value
  WHERE vw_mp_monitor_hrly_value.parameter_cd::text = 'O2C'::text AND lower(vw_mp_monitor_hrly_value.moisture_basis::text) = lower('W'::text);

-- 133. Recreate camdecmpswks.vw_mp_monitor_load
-- Source: camdecmpswks/views/vw_mp_monitor_load.sql
-- View: camdecmpswks.vw_mp_monitor_load


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_load
 AS
 SELECT loc.mon_plan_id,
    loc.fac_id,
    loc.oris_code,
    loc.location_name,
    ml.load_id,
    ml.mon_loc_id,
    ml.load_analysis_date,
    ml.begin_date,
    ml.begin_hour,
    ml.end_date,
    ml.end_hour,
    ml.max_load_value,
    ml.second_normal_ind,
    ml.up_op_boundary,
    ml.low_op_boundary,
    ml.normal_level_cd,
    ml.second_level_cd,
    ml.max_load_uom_cd
   FROM camdecmpswks.monitor_load ml
     JOIN camdecmpswks.vw_mp_monitor_location loc ON ml.mon_loc_id::text = loc.mon_loc_id::text;

-- 134. Recreate camdecmpswks.vw_mp_monitor_method
-- Source: camdecmpswks/views/vw_mp_monitor_method.sql
-- View: camdecmpswks.vw_mp_monitor_method


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_method
 AS
 SELECT mm.mon_method_id,
    mp.mon_plan_id,
    ml.mon_loc_id,
    mm.parameter_cd,
    mm.sub_data_cd,
    mm.bypass_approach_cd,
    mm.method_cd,
    mm.begin_date + ((mm.begin_hour || ' HOUR'::text)::interval) AS begin_datehour,
    mm.begin_date,
    mm.begin_hour,
    mm.end_date + ((mm.end_hour || ' HOUR'::text)::interval) AS end_datehour,
    mm.end_date,
    mm.end_hour,
    sp.stack_pipe_id,
    sp.stack_name,
    u.unit_id,
    u.unitid
   FROM camdecmpswks.monitor_location ml
     JOIN camdecmpswks.monitor_method mm ON ml.mon_loc_id::text = mm.mon_loc_id::text
     JOIN camdecmpswks.monitor_plan_location mpl ON ml.mon_loc_id::text = mpl.mon_loc_id::text
     JOIN camdecmpswks.monitor_plan mp ON mpl.mon_plan_id::text = mp.mon_plan_id::text
     LEFT JOIN camd.unit u ON ml.unit_id = u.unit_id
     LEFT JOIN camdecmpswks.stack_pipe sp ON ml.stack_pipe_id::text = sp.stack_pipe_id::text;

-- 135. Recreate camdecmpswks.vw_mp_monitor_method_missing_data_fsp
-- Source: camdecmpswks/views/vw_mp_monitor_method_missing_data_fsp.sql
-- View: camdecmpswks.vw_mp_monitor_method_missing_data_fsp


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_method_missing_data_fsp
 AS
 SELECT vw_mp_monitor_method.mon_method_id,
    vw_mp_monitor_method.mon_plan_id,
    vw_mp_monitor_method.mon_loc_id,
    vw_mp_monitor_method.parameter_cd,
    vw_mp_monitor_method.sub_data_cd,
    vw_mp_monitor_method.bypass_approach_cd,
    vw_mp_monitor_method.method_cd,
    vw_mp_monitor_method.begin_datehour,
    vw_mp_monitor_method.begin_date,
    vw_mp_monitor_method.begin_hour,
    vw_mp_monitor_method.end_datehour,
    vw_mp_monitor_method.end_date,
    vw_mp_monitor_method.end_hour,
    vw_mp_monitor_method.stack_pipe_id,
    vw_mp_monitor_method.stack_name,
    vw_mp_monitor_method.unit_id,
    vw_mp_monitor_method.unitid
   FROM camdecmpswks.vw_mp_monitor_method
  WHERE vw_mp_monitor_method.sub_data_cd::text = ANY (ARRAY['FSP75'::character varying::text, 'FSP75C'::character varying::text]);

-- 136. Recreate camdecmpswks.vw_mp_monitor_plan
-- Source: camdecmpswks/views/vw_mp_monitor_plan.sql
-- View: camdecmpswks.vw_mp_monitor_plan


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_plan
 AS
 SELECT mp.mon_plan_id,
    f.oris_code,
    f.facility_name,
    f.state,
    mp.fac_id,
    mp.config_type_cd,
    mp.begin_rpt_period_id,
    mp.end_rpt_period_id,
    dmps.mon_plan_status_cd AS status,
    dmps.mon_plan_status_cd_description AS display_status,
    mp.last_updated,
    mp.updated_status_flg,
    mp.needs_eval_flg,
    mp.chk_session_id,
    mp.last_evaluated_date,
    mp.submission_id,
    mp.submission_availability_cd,
    f.first_ecmps_rpt_period_id,
    cs.severity_cd,
        CASE
            WHEN mp.submission_availability_cd::text = 'REQUIRE'::text OR mp.updated_status_flg::text = 'Y'::text THEN 'Y'::text
            ELSE 'N'::text
        END AS must_submit
   FROM camdecmpswks.monitor_plan mp
     JOIN camd.plant f ON mp.fac_id = f.fac_id
     LEFT JOIN camdecmpswks.derived_monitor_plan_status() dmps(mon_plan_id, begin_date, end_date, mon_plan_status_cd, mon_plan_status_cd_description) ON mp.mon_plan_id::text = dmps.mon_plan_id
     LEFT JOIN camdecmpsmd.vw_reporting_period rpbegin ON mp.begin_rpt_period_id = rpbegin.rpt_period_id
     LEFT JOIN camdecmpsmd.vw_reporting_period rpend ON mp.end_rpt_period_id = rpend.rpt_period_id
     LEFT JOIN camdecmpswks.check_session cs ON mp.chk_session_id::text = cs.chk_session_id::text;

-- 137. Recreate camdecmpswks.vw_mp_monitor_qualification
-- Source: camdecmpswks/views/vw_mp_monitor_qualification.sql
-- View: camdecmpswks.vw_mp_monitor_qualification


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_qualification
 AS
 SELECT monitor_qualification.mon_qual_id,
    monitor_plan.mon_plan_id,
    monitor_location.mon_loc_id,
    monitor_qualification.qual_type_cd,
    monitor_qualification.begin_date,
    monitor_qualification.end_date,
    COALESCE(stack_pipe.stack_name, unit.unitid) AS location_id,
    COALESCE(stack_pipe.fac_id, unit.fac_id) AS fac_id
   FROM camdecmpswks.monitor_location
     JOIN camdecmpswks.monitor_qualification ON monitor_location.mon_loc_id::text = monitor_qualification.mon_loc_id::text
     JOIN camdecmpswks.monitor_plan_location ON monitor_location.mon_loc_id::text = monitor_plan_location.mon_loc_id::text
     JOIN camdecmpswks.monitor_plan ON monitor_plan_location.mon_plan_id::text = monitor_plan.mon_plan_id::text
     LEFT JOIN camd.unit ON monitor_location.unit_id = unit.unit_id
     LEFT JOIN camdecmpswks.stack_pipe ON monitor_location.stack_pipe_id::text = stack_pipe.stack_pipe_id::text;

-- 138. Recreate camdecmpswks.vw_mp_monitor_span
-- Source: camdecmpswks/views/vw_mp_monitor_span.sql
-- View: camdecmpswks.vw_mp_monitor_span


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_span
 AS
 SELECT ml.mon_plan_id,
    ms.span_id,
    ms.mon_loc_id,
    ms.mpc_value,
    ms.mec_value,
    ms.mpf_value,
    ms.max_low_range,
    ms.span_value,
    ms.full_scale_range,
    ms.begin_date,
    ms.begin_hour,
    ms.end_date,
    ms.end_hour,
    ms.default_high_range,
    ms.flow_span_value,
    ms.flow_full_scale_range,
    ms.component_type_cd,
    ms.span_scale_cd,
    ms.span_method_cd,
    ms.span_uom_cd,
    ml.fac_id
   FROM camdecmpswks.monitor_span ms
     JOIN camdecmpswks.vw_mp_monitor_location ml ON ms.mon_loc_id::text = ml.mon_loc_id::text;

-- 139. Recreate camdecmpswks.vw_mp_monitor_span_co2
-- Source: camdecmpswks/views/vw_mp_monitor_span_co2.sql
-- View: camdecmpswks.vw_mp_monitor_span_co2


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_span_co2
 AS
 SELECT ml.mon_plan_id,
    ms.span_id,
    ms.mon_loc_id,
    ms.mpc_value,
    ms.mec_value,
    ms.mpf_value,
    ms.max_low_range,
    ms.span_value,
    ms.full_scale_range,
    ms.begin_date,
    ms.begin_hour,
    ms.end_date,
    ms.end_hour,
    ms.default_high_range,
    ms.flow_span_value,
    ms.flow_full_scale_range,
    ms.component_type_cd,
    ms.span_scale_cd,
    ms.span_method_cd,
    ms.span_uom_cd
   FROM camdecmpswks.monitor_span ms
     JOIN camdecmpswks.vw_mp_monitor_location ml ON ms.mon_loc_id::text = ml.mon_loc_id::text
  WHERE ms.component_type_cd::text = 'CO2'::text;

-- 140. Recreate camdecmpswks.vw_mp_monitor_span_flow
-- Source: camdecmpswks/views/vw_mp_monitor_span_flow.sql
-- View: camdecmpswks.vw_mp_monitor_span_flow


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_span_flow
 AS
 SELECT ml.mon_plan_id,
    ms.span_id,
    ms.mon_loc_id,
    ms.mpc_value,
    ms.mec_value,
    ms.mpf_value,
    ms.max_low_range,
    ms.span_value,
    ms.full_scale_range,
    ms.begin_date,
    ms.begin_hour,
    ms.end_date,
    ms.end_hour,
    ms.default_high_range,
    ms.flow_span_value,
    ms.flow_full_scale_range,
    ms.component_type_cd,
    ms.span_scale_cd,
    ms.span_method_cd,
    ms.span_uom_cd
   FROM camdecmpswks.monitor_span ms
     JOIN camdecmpswks.vw_mp_monitor_location ml ON ms.mon_loc_id::text = ml.mon_loc_id::text
  WHERE ms.component_type_cd::text = 'FLOW'::text;

-- 141. Recreate camdecmpswks.vw_mp_monitor_span_nox
-- Source: camdecmpswks/views/vw_mp_monitor_span_nox.sql
-- View: camdecmpswks.vw_mp_monitor_span_nox


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_span_nox
 AS
 SELECT ml.mon_plan_id,
    ms.span_id,
    ms.mon_loc_id,
    ms.mpc_value,
    ms.mec_value,
    ms.mpf_value,
    ms.max_low_range,
    ms.span_value,
    ms.full_scale_range,
    ms.begin_date,
    ms.begin_hour,
    ms.end_date,
    ms.end_hour,
    ms.default_high_range,
    ms.flow_span_value,
    ms.flow_full_scale_range,
    ms.component_type_cd,
    ms.span_scale_cd,
    ms.span_method_cd,
    ms.span_uom_cd
   FROM camdecmpswks.monitor_span ms
     JOIN camdecmpswks.vw_mp_monitor_location ml ON ms.mon_loc_id::text = ml.mon_loc_id::text
  WHERE ms.component_type_cd::text = 'NOX'::text;

-- 142. Recreate camdecmpswks.vw_mp_monitor_span_so2
-- Source: camdecmpswks/views/vw_mp_monitor_span_so2.sql
-- View: camdecmpswks.vw_mp_monitor_span_so2


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_span_so2
 AS
 SELECT ml.mon_plan_id,
    ms.span_id,
    ms.mon_loc_id,
    ms.mpc_value,
    ms.mec_value,
    ms.mpf_value,
    ms.max_low_range,
    ms.span_value,
    ms.full_scale_range,
    ms.begin_date,
    ms.begin_hour,
    ms.end_date,
    ms.end_hour,
    ms.default_high_range,
    ms.flow_span_value,
    ms.flow_full_scale_range,
    ms.component_type_cd,
    ms.span_scale_cd,
    ms.span_method_cd,
    ms.span_uom_cd
   FROM camdecmpswks.monitor_span ms
     JOIN camdecmpswks.vw_mp_monitor_location ml ON ms.mon_loc_id::text = ml.mon_loc_id::text
  WHERE ms.component_type_cd::text = 'SO2'::text;

-- 143. Recreate camdecmpswks.vw_mp_op_supp_data
-- Source: camdecmpswks/views/vw_mp_op_supp_data.sql
-- View: camdecmpswks.vw_mp_op_supp_data


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_op_supp_data
AS
	SELECT
		sd.op_supp_data_id,
    	sd.mon_loc_id,
		ml.mon_plan_id,
		sd.fuel_cd,
		sd.op_type_cd,
		sd.rpt_period_id,
		sd.op_value,
		rp.calendar_year,
		rp.quarter,
		sd.op_type_cd AS parameter_cd,
		rp.begin_date AS quarter_begin_date,
		rp.end_date AS quarter_end_date,
		4::numeric * rp.calendar_year + rp.quarter AS quarter_ord
	FROM camdecmpswks.operating_supp_data sd
	LEFT JOIN camdecmpswks.vw_mp_location ml ON sd.mon_loc_id::text = ml.mon_loc_id::text
	LEFT JOIN camdecmpsmd.reporting_period rp ON sd.rpt_period_id = rp.rpt_period_id;

-- 144. Recreate camdecmpswks.vw_mp_operating_status
-- Source: camdecmpswks/views/vw_mp_operating_status.sql
-- View: camdecmpswks.vw_mp_operating_status


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_operating_status
 AS
 SELECT monitor_location.mon_loc_id,
    unit.unit_id,
    unit.unitid,
    unit_op_status.op_status_cd,
    unit_op_status.begin_date,
    monitor_plan.mon_plan_id,
    unit_op_status.end_date,
    unit_op_status.unit_op_status_id AS uos_id
   FROM camdecmpswks.monitor_plan_location
     JOIN camdecmpswks.monitor_location ON monitor_plan_location.mon_loc_id::text = monitor_location.mon_loc_id::text
     JOIN camdecmpswks.monitor_plan ON monitor_plan_location.mon_plan_id::text = monitor_plan.mon_plan_id::text
     JOIN (camd.unit_op_status
     JOIN camd.unit ON unit_op_status.unit_id = unit.unit_id) ON monitor_location.unit_id = unit.unit_id;

-- 145. Recreate camdecmpswks.vw_unit_program_exemption
-- Source: camdecmpswks/views/1-vw_unit_program_exemption.sql
-- View: camdecmpswks.vw_unit_program_exemption


CREATE OR REPLACE VIEW camdecmpswks.vw_unit_program_exemption
 AS
 SELECT ml.mon_loc_id,
    u.unit_id,
    u.fac_id,
    up.prg_cd,
    up.up_id,
    NULL::text AS upe_id,
    pe.exemption_type_cd AS exempt_type_cd,
    ue.ex_rec_date,
    ue.begin_date,
    ue.end_date
   FROM camd.unit_program up
     JOIN camd.unit u ON u.unit_id = up.unit_id
     JOIN camdecmpswks.monitor_location ml ON u.unit_id = ml.unit_id
     JOIN camdmd.program_exemption pe ON pe.prg_cd::text = up.prg_cd::text
     JOIN camd.unit_exemption ue ON ue.unit_id = up.unit_id AND ue.exemption_type_cd::text = pe.exemption_type_cd::text;

-- 146. Recreate camdecmpswks.vw_mp_program_exemption
-- Source: camdecmpswks/views/vw_mp_program_exemption.sql
-- View: camdecmpswks.vw_mp_program_exemption


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_program_exemption
 AS
 SELECT monitor_plan.mon_plan_id,
    monitor_location.mon_loc_id,
    unit.unit_id,
    unit.fac_id,
    unit_program.prg_cd,
    unit_program.up_id,
    vw_unit_program_exemption.upe_id,
    vw_unit_program_exemption.exempt_type_cd,
    vw_unit_program_exemption.ex_rec_date,
    vw_unit_program_exemption.begin_date,
    vw_unit_program_exemption.end_date
   FROM camdecmpswks.monitor_location
     JOIN camdecmpswks.monitor_plan_location ON monitor_location.mon_loc_id::text = monitor_plan_location.mon_loc_id::text
     JOIN camdecmpswks.monitor_plan ON monitor_plan_location.mon_plan_id::text = monitor_plan.mon_plan_id::text
     JOIN camd.unit ON monitor_location.unit_id = unit.unit_id
     JOIN camd.unit_program ON unit.unit_id = unit_program.unit_id
     JOIN camdecmpswks.vw_unit_program_exemption ON unit_program.up_id = vw_unit_program_exemption.up_id;

-- 147. Recreate camdecmpswks.vw_mp_qa_supp_attribute
-- Source: camdecmpswks/views/vw_mp_qa_supp_attribute.sql
-- View: camdecmpswks.vw_mp_qa_supp_attribute


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_qa_supp_attribute
 AS
 SELECT qsa.qa_supp_attribute_id,
    ml.mon_plan_id,
    qsd.mon_loc_id,
    qsa.qa_supp_data_id,
    qsa.attribute_name,
    qsa.attribute_value
   FROM camdecmpswks.qa_supp_attribute qsa
     LEFT JOIN camdecmpswks.qa_supp_data qsd ON qsa.qa_supp_data_id::text = qsd.qa_supp_data_id::text
     LEFT JOIN camdecmpswks.vw_mp_location ml ON qsd.mon_loc_id::text = ml.mon_loc_id::text;

-- 148. Recreate camdecmpswks.vw_mp_unit_capacity
-- Source: camdecmpswks/views/vw_mp_unit_capacity.sql
-- View: camdecmpswks.vw_mp_unit_capacity


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_unit_capacity
 AS
 SELECT mpl.mon_plan_id,
    uc.unit_id,
    uc.unit_cap_id,
    uc.begin_date,
    uc.end_date,
    uc.max_hi_capacity,
    ml.mon_loc_id
   FROM camdecmpswks.unit_capacity uc
     JOIN camd.unit u ON u.unit_id = uc.unit_id
     JOIN camdecmpswks.monitor_location ml ON ml.unit_id = u.unit_id
     JOIN camdecmpswks.monitor_plan_location mpl ON ml.mon_loc_id::text = mpl.mon_loc_id::text;

-- 149. Recreate camdecmpswks.vw_mp_unit_program
-- Source: camdecmpswks/views/vw_mp_unit_program.sql
-- View: camdecmpswks.vw_mp_unit_program


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_unit_program
 AS
 SELECT up.up_id,
    mp.mon_plan_id,
    ml.mon_loc_id,
    u.unit_id,
    u.unitid,
    up.prg_cd,
    up.class_cd AS class,
    up.unit_monitor_cert_begin_date,
    up.emissions_recording_begin_date,
    up.end_date,
        CASE
            WHEN up.unit_monitor_cert_begin_date IS NULL THEN NULL::text
            ELSE date_part('year'::text, up.unit_monitor_cert_begin_date)::character varying(4)::text ||
            CASE
                WHEN date_part('month'::text, up.unit_monitor_cert_begin_date) = ANY (ARRAY[1::double precision, 2::double precision, 3::double precision]) THEN 1
                WHEN date_part('month'::text, up.unit_monitor_cert_begin_date) = ANY (ARRAY[4::double precision, 5::double precision, 6::double precision]) THEN 2
                WHEN date_part('month'::text, up.unit_monitor_cert_begin_date) = ANY (ARRAY[7::double precision, 8::double precision, 9::double precision]) THEN 3
                ELSE 4
            END
        END AS unit_monitor_cert_begin_quarter,
        CASE
            WHEN up.end_date IS NULL THEN NULL::text
            ELSE date_part('year'::text, up.end_date)::character varying(4)::text ||
            CASE
                WHEN date_part('month'::text, up.end_date) = ANY (ARRAY[1::double precision, 2::double precision, 3::double precision]) THEN 1
                WHEN date_part('month'::text, up.end_date) = ANY (ARRAY[4::double precision, 5::double precision, 6::double precision]) THEN 2
                WHEN date_part('month'::text, up.end_date) = ANY (ARRAY[7::double precision, 8::double precision, 9::double precision]) THEN 3
                ELSE 4
            END
        END AS end_quarter,
    up.prg_id
   FROM camdecmpswks.monitor_plan_location mpl
     JOIN camdecmpswks.monitor_location ml ON mpl.mon_loc_id::text = ml.mon_loc_id::text
     JOIN camdecmpswks.monitor_plan mp ON mpl.mon_plan_id::text = mp.mon_plan_id::text
     JOIN (camd.unit_program up
     JOIN camd.unit u ON up.unit_id = u.unit_id) ON ml.unit_id = u.unit_id;

-- 150. Recreate camdecmpswks.vw_mp_unit_stack_configuration
-- Source: camdecmpswks/views/vw_mp_unit_stack_configuration.sql
-- View: camdecmpswks.vw_mp_unit_stack_configuration


CREATE OR REPLACE VIEW camdecmpswks.vw_mp_unit_stack_configuration
 AS
 SELECT DISTINCT mp.mon_plan_id,
    ml.mon_loc_id,
    usc.config_id,
    usc.begin_date,
    usc.end_date,
    sp.stack_name,
    u.unitid,
    sp.stack_pipe_id,
    u.unit_id,
    u.non_load_based_ind,
    ml1.mon_loc_id AS stack_pipe_mon_loc_id,
    sp.fac_id
   FROM camdecmpswks.stack_pipe sp
     JOIN (camdecmpswks.unit_stack_configuration usc
     JOIN (camd.unit u
     JOIN (camdecmpswks.monitor_plan_location mpl
     JOIN camdecmpswks.monitor_plan mp ON mpl.mon_plan_id::text = mp.mon_plan_id::text
     JOIN camdecmpswks.monitor_location ml ON mpl.mon_loc_id::text = ml.mon_loc_id::text) ON u.unit_id = ml.unit_id) ON usc.unit_id = u.unit_id) ON sp.stack_pipe_id::text = usc.stack_pipe_id::text
     JOIN camdecmpswks.monitor_location ml1 ON sp.stack_pipe_id::text = ml1.stack_pipe_id::text;

-- 151. Recreate camdecmpswks.vw_program_parameter
-- Source: camdecmpswks/views/vw_program_parameter.sql
-- View: camdecmpswks.vw_program_parameter


CREATE OR REPLACE VIEW camdecmpswks.vw_program_parameter
 AS
 SELECT pp.prg_param_id,
    pp.prg_id,
    pp.parameter_cd,
    pp.required_ind,
    pc.os_ind,
    pp.begin_rpt_period_id,
    pp.end_rpt_period_id,
    pp.userid,
    pp.add_date,
    pp.update_date
   FROM camdecmpsaux.program_parameter pp
     JOIN camd.program p ON p.prg_id = pp.prg_id
     JOIN camdmd.program_code pc ON pc.prg_cd::text = p.prg_cd::text;

-- 152. Recreate camdecmpswks.vw_qa_test_summary_appe
-- Source: camdecmpswks/views/2-vw_qa_test_summary_appe.sql
-- View: camdecmpswks.vw_qa_test_summary_appe


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_summary_appe
 AS
 SELECT ts.test_sum_id,
    ts.mon_loc_id,
    ts.mon_sys_id,
    ts.test_num,
    ts.test_reason_cd,
    ts.begin_date,
    ts.begin_hour,
    ts.begin_min,
    ts.end_date,
    ts.end_hour,
    ts.end_min,
    ts.test_comment,
    ts.last_updated,
    ts.updated_status_flg,
    ts.needs_eval_flg,
    ts.chk_session_id,
    ts.userid,
    ts.add_date,
    ts.update_date,
    ml.fac_id,
    COALESCE(ml.stack_name, ml.unitid) AS location_identifier,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.sys_designation_cd,
    ms.fuel_cd
   FROM camdecmpswks.test_summary ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.monitor_system ms ON ts.mon_sys_id::text = ms.mon_sys_id::text
  WHERE ts.test_type_cd::text = 'APPE'::text;

-- 153. Recreate camdecmpswks.vw_qa_ae_correlation_test_sum
-- Source: camdecmpswks/views/3-vw_qa_ae_correlation_test_sum.sql
-- View: camdecmpswks.vw_qa_ae_correlation_test_sum


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_ae_correlation_test_sum
 AS
 SELECT ts.test_sum_id,
    ts.test_num,
    ts.test_reason_cd,
    ts.begin_date,
    ts.begin_hour,
    ts.begin_min,
    ts.end_date,
    ts.end_hour,
    ts.end_min,
    ts.sys_type_cd,
    ts.system_identifier,
    ts.fuel_cd,
    ts.mon_sys_id,
    ts.mon_loc_id,
    ts.fac_id,
    ts.location_identifier,
    ac.ae_corr_test_sum_id,
    ac.op_level_num,
    ac.mean_ref_value,
    ac.avg_hrly_hi_rate,
    ac.f_factor,
    ac.userid,
    ac.add_date,
    ac.update_date
   FROM camdecmpswks.ae_correlation_test_sum ac
     JOIN camdecmpswks.vw_qa_test_summary_appe ts ON ac.test_sum_id::text = ts.test_sum_id::text;

-- 154. Recreate camdecmpswks.vw_qa_ae_correlation_test_run
-- Source: camdecmpswks/views/vw_qa_ae_correlation_test_run.sql
-- View: camdecmpswks.vw_qa_ae_correlation_test_run


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_ae_correlation_test_run
 AS
 SELECT ts.test_sum_id,
    ts.test_num,
    ts.test_reason_cd,
    ts.begin_date AS test_begin_date,
    ts.begin_hour AS test_begin_hour,
    ts.begin_min AS test_begin_min,
    ts.end_date AS test_end_date,
    ts.end_hour AS test_end_hour,
    ts.end_min AS test_end_min,
    ts.sys_type_cd,
    ts.system_identifier,
    ts.mon_sys_id,
    ts.fuel_cd,
    ts.mon_loc_id,
    ts.fac_id,
    ts.location_identifier,
    ts.ae_corr_test_sum_id,
    ts.op_level_num,
    ar.ae_corr_test_run_id,
    ar.run_num,
    ar.begin_date,
    ar.begin_hour,
    ar.begin_min,
    ar.end_date,
    ar.end_hour,
    ar.end_min,
    ar.response_time,
    ar.ref_value,
    ar.hourly_hi_rate,
    ar.total_hi,
    ar.userid,
    ar.add_date,
    ar.update_date
   FROM camdecmpswks.ae_correlation_test_run ar
     JOIN camdecmpswks.vw_qa_ae_correlation_test_sum ts ON ar.ae_corr_test_sum_id::text = ts.ae_corr_test_sum_id::text;

-- 155. Recreate camdecmpswks.vw_qa_ae_hi_gas
-- Source: camdecmpswks/views/vw_qa_ae_hi_gas.sql
-- View: camdecmpswks.vw_qa_ae_hi_gas


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_ae_hi_gas
 AS
 SELECT ts.test_sum_id,
    ts.test_num,
    ts.test_reason_cd,
    ts.begin_date AS test_begin_date,
    ts.begin_hour AS test_begin_hour,
    ts.begin_min AS test_begin_min,
    ts.end_date AS test_end_date,
    ts.end_hour AS test_end_hour,
    ts.end_min AS test_end_min,
    ts.sys_type_cd AS noxe_sys_type_cd,
    ts.system_identifier AS noxe_system_identifier,
    ts.mon_sys_id AS noxe_mon_sys_id,
    ts.fuel_cd AS noxe_fuel_cd,
    ts.mon_loc_id,
    ts.fac_id,
    ts.location_identifier,
    ts.ae_corr_test_sum_id,
    ts.op_level_num,
    ts.ae_corr_test_run_id,
    ag.ae_hi_gas_id,
    ts.run_num,
    ts.begin_date,
    ts.begin_hour,
    ts.begin_min,
    ts.end_date,
    ts.end_hour,
    ts.end_min,
    ms.sys_type_cd,
    ms.system_identifier,
    ms.mon_sys_id,
    ag.gas_volume,
    ag.gas_gcv,
    ag.gas_hi,
    ag.userid,
    ag.add_date,
    ag.update_date
   FROM camdecmpswks.ae_hi_gas ag
     JOIN camdecmpswks.vw_qa_ae_correlation_test_run ts ON ag.ae_corr_test_run_id::text = ts.ae_corr_test_run_id::text
     JOIN camdecmpswks.monitor_system ms ON ag.mon_sys_id::text = ms.mon_sys_id::text;

-- 156. Recreate camdecmpswks.vw_qa_ae_hi_oil
-- Source: camdecmpswks/views/vw_qa_ae_hi_oil.sql
-- View: camdecmpswks.vw_qa_ae_hi_oil


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_ae_hi_oil
 AS
 SELECT ts.test_sum_id,
    ts.test_num,
    ts.test_reason_cd,
    ts.begin_date AS test_begin_date,
    ts.begin_hour AS test_begin_hour,
    ts.begin_min AS test_begin_min,
    ts.end_date AS test_end_date,
    ts.end_hour AS test_end_hour,
    ts.end_min AS test_end_min,
    ts.sys_type_cd AS noxe_sys_type_cd,
    ts.system_identifier AS noxe_system_identifier,
    ts.mon_sys_id AS noxe_mon_sys_id,
    ts.fuel_cd AS noxe_fuel_cd,
    ts.mon_loc_id,
    ts.fac_id,
    ts.location_identifier,
    ts.ae_corr_test_sum_id,
    ts.op_level_num,
    ts.ae_corr_test_run_id,
    ao.ae_hi_oil_id,
    ts.run_num,
    ts.begin_date,
    ts.begin_hour,
    ts.begin_min,
    ts.end_date,
    ts.end_hour,
    ts.end_min,
    ms.sys_type_cd,
    ms.system_identifier,
    ms.mon_sys_id,
    ao.oil_mass,
    ao.oil_density,
    ao.oil_density_uom_cd,
    ao.oil_volume,
    ao.oil_volume_uom_cd,
    ao.oil_gcv,
    ao.oil_gcv_uom_cd,
    ao.oil_hi,
    ao.userid,
    ao.add_date,
    ao.update_date
   FROM camdecmpswks.ae_hi_oil ao
     JOIN camdecmpswks.vw_qa_ae_correlation_test_run ts ON ao.ae_corr_test_run_id::text = ts.ae_corr_test_run_id::text
     JOIN camdecmpswks.monitor_system ms ON ao.mon_sys_id::text = ms.mon_sys_id::text;

-- 157. Recreate camdecmpswks.vw_qa_test_summary_7day
-- Source: camdecmpswks/views/2-vw_qa_test_summary_7day.sql
-- View: camdecmpswks.vw_qa_test_summary_7day


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_summary_7day
 AS
 SELECT ts.test_sum_id,
    ts.mon_loc_id,
    ts.component_id,
    ts.test_num,
    ts.test_reason_cd,
    ts.test_result_cd,
    ts.begin_date,
    ts.begin_hour,
    ts.begin_min,
    ts.end_date,
    ts.end_hour,
    ts.end_min,
    ts.span_scale_cd,
    ts.test_comment,
    ts.injection_protocol_cd,
    ts.last_updated,
    ts.updated_status_flg,
    ts.needs_eval_flg,
    ts.chk_session_id,
    ts.userid,
    ts.add_date,
    ts.update_date,
    ml.fac_id,
    COALESCE(ml.stack_name, ml.unitid) AS location_identifier,
    c.component_type_cd,
    c.component_identifier,
    c.acq_cd
   FROM camdecmpswks.test_summary ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.component c ON ts.component_id::text = c.component_id::text
  WHERE ts.test_type_cd::text = '7DAY'::text;

-- 158. Recreate camdecmpswks.vw_qa_calibration_injection
-- Source: camdecmpswks/views/vw_qa_calibration_injection.sql
-- View: camdecmpswks.vw_qa_calibration_injection


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_calibration_injection
 AS
 SELECT ci.cal_inj_id,
    ci.online_offline_ind,
    ci.zero_injection_date,
    ci.zero_injection_hour,
    ci.zero_injection_min,
    ci.zero_measured_value,
    ci.zero_ref_value,
    ci.zero_cal_error,
    ci.zero_aps_ind,
    ci.userid,
    ci.add_date,
    ci.update_date,
    ts.test_num,
    ts.test_reason_cd,
    ts.test_result_cd,
    ts.begin_date,
    ts.begin_hour,
    ts.begin_min,
    ts.end_date,
    ts.end_hour,
    ts.end_min,
    ts.span_scale_cd,
    ts.component_type_cd,
    ts.component_identifier,
    ci.upscale_injection_date,
    ci.upscale_injection_hour,
    ci.upscale_injection_min,
    ci.upscale_measured_value,
    ci.upscale_ref_value,
    ci.upscale_gas_level_cd,
    ci.upscale_cal_error,
    ci.upscale_aps_ind,
    ts.test_sum_id,
    ts.component_id,
    ts.mon_loc_id,
    ts.acq_cd
   FROM camdecmpswks.calibration_injection ci
     JOIN camdecmpswks.vw_qa_test_summary_7day ts ON ci.test_sum_id::text = ts.test_sum_id::text;

-- 159. Recreate camdecmpswks.vw_qa_cert_event
-- Source: camdecmpswks/views/vw_qa_cert_event.sql
-- View: camdecmpswks.vw_qa_cert_event


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_cert_event
 AS
 SELECT ts.qa_cert_event_id,
    ts.mon_loc_id,
    ts.mon_sys_id,
    ts.component_id,
    ts.qa_cert_event_cd,
    ts.required_test_cd,
    ts.qa_cert_event_date,
    ts.qa_cert_event_hour,
    ts.qa_cert_event_date + ((ts.qa_cert_event_hour || ' HOUR'::text)::interval) AS qa_cert_event_datehour,
    ts.conditional_data_begin_date,
    ts.conditional_data_begin_hour,
    ts.conditional_data_begin_date + ((ts.conditional_data_begin_hour || ' HOUR'::text)::interval) AS conditional_data_begin_datehour,
    ts.last_test_completed_date,
    ts.last_test_completed_hour,
    ts.last_test_completed_date + ((ts.last_test_completed_hour || ' HOUR'::text)::interval) AS last_test_completed_datehour,
    ts.last_updated,
    ts.updated_status_flg,
    ts.needs_eval_flg,
    ts.chk_session_id,
    ts.userid,
    ts.add_date,
    ts.update_date,
    ml.fac_id,
    COALESCE(ml.stack_name, ml.unitid) AS location_identifier,
    c.component_type_cd,
    c.component_identifier,
    c.acq_cd,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.sys_designation_cd,
    ms.begin_date AS sys_begin_date,
        CASE
            WHEN line.value2 IS NOT NULL THEN 'Y'::text
            ELSE 'N'::text
        END AS linearity_required,
        CASE
            WHEN rata.value2 IS NOT NULL THEN 'Y'::text
            ELSE 'N'::text
        END AS rata_required,
        CASE
            WHEN rata2.value2 IS NOT NULL THEN 'Y'::text
            ELSE 'N'::text
        END AS rata2_required,
        CASE
            WHEN rata3.value2 IS NOT NULL THEN 'Y'::text
            ELSE 'N'::text
        END AS rata3_required,
        CASE
            WHEN ffacc.value2 IS NOT NULL THEN 'Y'::text
            ELSE 'N'::text
        END AS ffacc_required,
        CASE
            WHEN pei.value2 IS NOT NULL THEN 'Y'::text
            ELSE 'N'::text
        END AS pei_required,
        CASE
            WHEN le.value1 IS NOT NULL THEN 'Y'::text
            ELSE 'N'::text
        END AS linearity_cert_event,
        CASE
            WHEN re.value1 IS NOT NULL THEN 'Y'::text
            ELSE 'N'::text
        END AS rata_cert_event,
        CASE
            WHEN ooc.value2 IS NOT NULL THEN 'Y'::text
            ELSE 'N'::text
        END AS ooc_required,
        CASE
            WHEN leak.value2 IS NOT NULL THEN 'Y'::text
            ELSE 'N'::text
        END AS leak_required,
    NULL::integer AS max_op_days_prior_qtr,
    NULL::integer AS min_op_days_prior_qtr,
    NULL::integer AS max_op_hours_prior_qtr,
    NULL::integer AS min_op_hours_prior_qtr,
    cs.severity_cd,
        CASE
            WHEN ts.submission_availability_cd::text = 'REQUIRE'::text OR ts.updated_status_flg::text = 'Y'::text THEN 'Y'::text
            ELSE 'N'::text
        END AS must_submit,
        CASE
            WHEN eds.qa_cert_event_id IS NULL THEN 0
            ELSE 1
        END AS qa_cert_event_date_supp_data_exists_ind,
    eds.count AS qa_cert_event_op_day_count,
        CASE
            WHEN chs.qa_cert_event_id IS NULL THEN 0
            ELSE 1
        END AS conditional_begin_hour_supp_data_exists_ind,
    chs.count AS conditional_begin_op_hour_count,
        CASE
            WHEN ses.qa_cert_event_id IS NULL THEN 0
            ELSE 1
        END AS qa_cert_event_date_system_supp_data_exists_ind,
    ses.count AS qa_cert_event_system_op_day_count,
        CASE
            WHEN scs.qa_cert_event_id IS NULL THEN 0
            ELSE 1
        END AS conditional_begin_hour_system_supp_data_exists_ind,
    scs.count AS conditional_begin_system_op_hour_count
   FROM camdecmpswks.qa_cert_event ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.monitor_system ms ON ts.mon_sys_id::text = ms.mon_sys_id::text
     LEFT JOIN camdecmpswks.component c ON ts.component_id::text = c.component_id::text
     LEFT JOIN ( SELECT ccv.value1,
            ccv.value2
           FROM camdecmpsmd.cross_check_catalog_value ccv
             JOIN camdecmpsmd.cross_check_catalog cc ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
          WHERE cc.cross_chk_catalog_name::text = 'Test Type to Required Test Code'::text AND lower(ccv.value1) = lower('LINE'::text)) line ON ts.required_test_cd::text = line.value2::character varying::text
     LEFT JOIN ( SELECT ccv.value1,
            ccv.value2
           FROM camdecmpsmd.cross_check_catalog_value ccv
             JOIN camdecmpsmd.cross_check_catalog cc ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
          WHERE cc.cross_chk_catalog_name::text = 'Test Type to Required Test Code'::text AND lower(ccv.value1) ~~ lower('%RATA%'::text)) rata ON ts.required_test_cd::text = rata.value2::character varying::text
     LEFT JOIN ( SELECT ccv.value1,
            ccv.value2
           FROM camdecmpsmd.cross_check_catalog_value ccv
             JOIN camdecmpsmd.cross_check_catalog cc ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
          WHERE cc.cross_chk_catalog_name::text = 'Test Type to Required Test Code'::text AND lower(ccv.value1) = lower('RATA2'::text)) rata2 ON ts.required_test_cd::text = rata2.value2::character varying::text
     LEFT JOIN ( SELECT ccv.value1,
            ccv.value2
           FROM camdecmpsmd.cross_check_catalog_value ccv
             JOIN camdecmpsmd.cross_check_catalog cc ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
          WHERE cc.cross_chk_catalog_name::text = 'Test Type to Required Test Code'::text AND lower(ccv.value1) = lower('RATA3'::text)) rata3 ON ts.required_test_cd::text = rata3.value2::character varying::text
     LEFT JOIN ( SELECT ccv.value1,
            ccv.value2
           FROM camdecmpsmd.cross_check_catalog_value ccv
             JOIN camdecmpsmd.cross_check_catalog cc ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
          WHERE cc.cross_chk_catalog_name::text = 'Test Type to Required Test Code'::text AND lower(ccv.value1) ~~ lower('FFACC%'::text)) ffacc ON ts.required_test_cd::text = ffacc.value2::character varying::text
     LEFT JOIN ( SELECT ccv.value1,
            ccv.value2
           FROM camdecmpsmd.cross_check_catalog_value ccv
             JOIN camdecmpsmd.cross_check_catalog cc ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
          WHERE cc.cross_chk_catalog_name::text = 'Test Type to Required Test Code'::text AND lower(ccv.value1) = lower('PEI'::text)) pei ON ts.required_test_cd::text = pei.value2::character varying::text
     LEFT JOIN ( SELECT ccv.value1,
            ccv.value2
           FROM camdecmpsmd.cross_check_catalog_value ccv
             JOIN camdecmpsmd.cross_check_catalog cc ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
          WHERE cc.cross_chk_catalog_name::text = 'Certification Event Code to Test Type'::text AND (ccv.value2 IS NULL OR lower(ccv.value2) = lower('LINE'::text))) le ON ts.qa_cert_event_cd::text = le.value1::character varying::text
     LEFT JOIN ( SELECT ccv.value1,
            ccv.value2
           FROM camdecmpsmd.cross_check_catalog_value ccv
             JOIN camdecmpsmd.cross_check_catalog cc ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
          WHERE cc.cross_chk_catalog_name::text = 'Certification Event Code to Test Type'::text AND (ccv.value2 IS NULL OR lower(ccv.value2) = lower('RATA'::text))) re ON ts.qa_cert_event_cd::text = re.value1::character varying::text
     LEFT JOIN ( SELECT ccv.value1,
            ccv.value2
           FROM camdecmpsmd.cross_check_catalog_value ccv
             JOIN camdecmpsmd.cross_check_catalog cc ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
          WHERE cc.cross_chk_catalog_name::text = 'Test Type to Required Test Code'::text AND lower(ccv.value1) = lower('ONOFF'::text)) ooc ON ts.required_test_cd::text = ooc.value2::character varying::text
     LEFT JOIN ( SELECT ccv.value1,
            ccv.value2
           FROM camdecmpsmd.cross_check_catalog_value ccv
             JOIN camdecmpsmd.cross_check_catalog cc ON ccv.cross_chk_catalog_id = cc.cross_chk_catalog_id
          WHERE cc.cross_chk_catalog_name::text = 'Test Type to Required Test Code'::text AND lower(ccv.value1) = lower('LEAK'::text)) leak ON ts.required_test_cd::text = leak.value2::character varying::text
     LEFT JOIN camdecmpswks.check_session cs ON ts.chk_session_id::text = cs.chk_session_id::text
     LEFT JOIN camdecmpswks.qa_cert_event_supp_data eds ON eds.qa_cert_event_id::text = ts.qa_cert_event_id::text AND eds.qa_cert_event_supp_date_cd::text = 'QCEDATE'::text AND eds.qa_cert_event_supp_data_cd::text = 'OP'::text
     LEFT JOIN camdecmpswks.qa_cert_event_supp_data chs ON chs.qa_cert_event_id::text = ts.qa_cert_event_id::text AND chs.qa_cert_event_supp_date_cd::text = 'CDBHOUR'::text AND chs.qa_cert_event_supp_data_cd::text = 'OP'::text
     LEFT JOIN camdecmpswks.qa_cert_event_supp_data ses ON ses.qa_cert_event_id::text = ts.qa_cert_event_id::text AND ses.qa_cert_event_supp_date_cd::text = 'QCEDATE'::text AND ses.qa_cert_event_supp_data_cd::text = 'SYSOP'::text
     LEFT JOIN camdecmpswks.qa_cert_event_supp_data scs ON scs.qa_cert_event_id::text = ts.qa_cert_event_id::text AND scs.qa_cert_event_supp_date_cd::text = 'CDBHOUR'::text AND scs.qa_cert_event_supp_data_cd::text = 'SYSOP'::text;

-- 160. Recreate camdecmpswks.vw_qa_cert_event_eval_and_submit
-- Source: camdecmpswks/views/vw_qa_cert_event_eval_and_submit.sql
-- View: camdecmpswks.vw_qa_cert_event_eval_and_submit


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_cert_event_eval_and_submit
 AS
 SELECT p.oris_code,
    p.facility_name,
    mp.mon_plan_id,
    COALESCE(u.unitid, sp.stack_name) AS location_info,
    qce.qa_cert_event_id,
    qce.qa_cert_event_cd,
    qce.mon_loc_id,
    COALESCE(ms.system_identifier, c.component_identifier) AS system_component_identifier,
        CASE
            WHEN qce.qa_cert_event_date IS NULL THEN NULL::text
            ELSE concat(qce.qa_cert_event_date, ' ', lpad(COALESCE(qce.qa_cert_event_hour, 0::numeric)::text, 2, '0'::text), ':00')
        END AS event_date,
        CASE
            WHEN qce.conditional_data_begin_date IS NULL THEN NULL::text
            ELSE concat(qce.conditional_data_begin_date, ' ', lpad(COALESCE(qce.conditional_data_begin_hour, 0::numeric)::text, 2, '0'::text), ':00')
        END AS condition_date,
        CASE
            WHEN qce.last_test_completed_date IS NULL THEN NULL::text
            ELSE concat(qce.last_test_completed_date, ' ', lpad(COALESCE(qce.last_test_completed_hour, 0::numeric)::text, 2, '0'::text), ':00')
        END AS last_completion,
    qce.required_test_cd,
    qce.userid,
    COALESCE(qce.update_date, qce.add_date) AS update_date,
    qce.eval_status_cd,
    esc.eval_status_cd_description,
    qce.submission_availability_cd,
    sac.sub_avail_cd_description as submission_availability_cd_description
   FROM camd.plant p
     JOIN camdecmpswks.monitor_plan mp USING (fac_id)
     JOIN (select distinct mpl.mon_loc_id,
				first_value(mp.mon_plan_id)
			    over (
			    	partition by mpl.mon_loc_id
			        order by mp.begin_rpt_period_id desc
			    ) latest_mon_plan_id
			from camdecmpswks.monitor_plan_location mpl
			inner join camdecmpswks.monitor_plan mp on mpl.mon_plan_id = mp.mon_plan_id) mpl ON mpl.latest_mon_plan_id = mp.mon_plan_Id
     JOIN camdecmpswks.monitor_location ml USING (mon_loc_id)
     JOIN camdecmpswks.qa_cert_event qce USING (mon_loc_id)
     JOIN camdecmpsmd.eval_status_code esc
	 	ON esc.eval_status_cd = qce.eval_status_cd
	 JOIN camdecmpsmd.submission_availability_code sac
	 	ON sac.submission_availability_cd = qce.submission_availability_cd
     LEFT JOIN camdecmpswks.monitor_system ms USING (mon_sys_id)
     LEFT JOIN camdecmpswks.component c USING (component_id)
     LEFT JOIN camd.unit u USING (unit_id)
     LEFT JOIN camdecmpswks.stack_pipe sp USING (stack_pipe_id);

-- 161. Recreate camdecmpswks.vw_qa_test_summary_cycle
-- Source: camdecmpswks/views/2-vw_qa_test_summary_cycle.sql
-- View: camdecmpswks.vw_qa_test_summary_cycle


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_summary_cycle
 AS
 SELECT ts.test_sum_id,
    ts.mon_loc_id,
    ts.component_id,
    ts.test_num,
    ts.test_reason_cd,
    ts.test_result_cd,
    ts.begin_date,
    ts.begin_hour,
    ts.begin_min,
    ts.end_date,
    ts.end_hour,
    ts.end_min,
    ts.span_scale_cd,
    ts.test_comment,
    ts.injection_protocol_cd,
    ts.last_updated,
    ts.updated_status_flg,
    ts.needs_eval_flg,
    ts.chk_session_id,
    ts.userid,
    ts.add_date,
    ts.update_date,
    ml.fac_id,
    COALESCE(ml.stack_name, ml.unitid) AS location_identifier,
    c.component_type_cd,
    c.component_identifier,
    c.acq_cd,
    cs.cycle_time_sum_id,
    cs.total_time
   FROM camdecmpswks.test_summary ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.component c ON ts.component_id::text = c.component_id::text
     LEFT JOIN camdecmpswks.cycle_time_summary cs ON ts.test_sum_id::text = cs.test_sum_id::text
  WHERE ts.test_type_cd::text = 'CYCLE'::text;

-- 162. Recreate camdecmpswks.vw_qa_cycle_time_injection
-- Source: camdecmpswks/views/vw_qa_cycle_time_injection.sql
-- View: camdecmpswks.vw_qa_cycle_time_injection


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_cycle_time_injection
 AS
 SELECT ci.cycle_time_inj_id,
    ci.begin_date,
    ci.begin_hour,
    ci.begin_min,
    ci.cal_gas_value,
    ci.begin_monitor_value,
    ci.end_monitor_value,
    ci.injection_cycle_time,
    ci.userid,
    ci.add_date,
    ci.update_date,
    ts.test_num,
    ts.test_reason_cd,
    ts.test_result_cd,
    ts.begin_date AS test_begin_date,
    ts.begin_hour AS test_begin_hour,
    ts.begin_min AS test_begin_min,
    ts.end_date AS test_end_date,
    ts.end_hour AS test_end_hour,
    ts.end_min AS test_end_min,
    ts.total_time,
    ts.span_scale_cd,
    ts.component_type_cd,
    ts.component_identifier,
    ci.end_date,
    ci.end_hour,
    ci.end_min,
    ci.gas_level_cd,
    ts.cycle_time_sum_id,
    ts.test_sum_id,
    ts.component_id,
    ts.mon_loc_id
   FROM camdecmpswks.cycle_time_injection ci
     JOIN camdecmpswks.vw_qa_test_summary_cycle ts ON ci.cycle_time_sum_id::text = ts.cycle_time_sum_id::text;

-- 163. Recreate camdecmpswks.vw_qa_test_summary_rata
-- Source: camdecmpswks/views/2-vw_qa_test_summary_rata.sql
-- View: camdecmpswks.vw_qa_test_summary_rata


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_summary_rata
 AS
 SELECT ts.test_sum_id,
    ts.mon_loc_id,
    ts.mon_sys_id,
    ts.test_num,
    ts.gp_ind,
    ts.test_reason_cd,
    ts.test_result_cd,
    ts.begin_date,
    ts.begin_hour,
    ts.begin_min,
    ts.end_date,
    ts.end_hour,
    ts.end_min,
    ts.test_comment,
    ts.last_updated,
    ts.updated_status_flg,
    ts.needs_eval_flg,
    ts.chk_session_id,
    ts.userid,
    ts.add_date,
    ts.update_date,
    r.rata_id,
    r.relative_accuracy,
    r.overall_bias_adj_factor,
    r.num_load_level,
    r.rata_frequency_cd,
    ml.fac_id,
    COALESCE(ml.stack_name, ml.unitid) AS location_identifier,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.sys_designation_cd,
    ms.begin_date AS system_begin_date,
    ms.begin_hour AS system_begin_hour
   FROM camdecmpswks.test_summary ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.monitor_system ms ON ts.mon_sys_id::text = ms.mon_sys_id::text
     LEFT JOIN camdecmpswks.rata r ON ts.test_sum_id::text = r.test_sum_id::text
  WHERE ts.test_type_cd::text = 'RATA'::text;

-- 164. Recreate camdecmpswks.vw_qa_rata_summary
-- Source: camdecmpswks/views/3-vw_qa_rata_summary.sql
-- View: camdecmpswks.vw_qa_rata_summary


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_rata_summary
 AS
 SELECT ts.test_num,
    ts.gp_ind,
    ts.test_reason_cd,
    ts.test_result_cd,
    ts.begin_date,
    ts.begin_hour,
    ts.begin_min,
    ts.end_date,
    ts.end_hour,
    ts.end_min,
    ts.sys_type_cd,
    ts.system_identifier,
    ts.mon_sys_id,
    rs.op_level_cd,
    rs.avg_gross_unit_load,
    rs.relative_accuracy,
    rs.bias_adj_factor,
    rs.mean_cem_value,
    rs.mean_diff,
    rs.mean_rata_ref_value,
    rs.aps_ind,
    rs.aps_cd,
    rs.stnd_dev_diff,
    rs.confidence_coef,
    rs.ref_method_cd,
    rs.co2_o2_ref_method_cd,
    rs.t_value,
    rs.stack_diameter,
    rs.stack_area,
    rs.calc_waf,
    rs.default_waf,
    rs.num_traverse_point,
    rs.rata_sum_id,
    ts.test_sum_id,
    ts.rata_id,
    ts.mon_loc_id,
    ts.fac_id,
    ts.location_identifier,
    ts.needs_eval_flg,
    rs.userid,
    rs.add_date,
    rs.update_date
   FROM camdecmpswks.rata_summary rs
     JOIN camdecmpswks.vw_qa_test_summary_rata ts ON rs.rata_id::text = ts.rata_id::text;

-- 165. Recreate camdecmpswks.vw_qa_rata_run
-- Source: camdecmpswks/views/4-vw_qa_rata_run.sql
-- View: camdecmpswks.vw_qa_rata_run


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_rata_run
 AS
 SELECT rr.rata_run_id,
    rr.rata_sum_id,
    rs.op_level_cd,
    rr.run_num,
    rr.begin_date,
    rr.begin_hour,
    rr.begin_min,
    rr.end_date,
    rr.end_hour,
    rr.end_min,
    rr.cem_value,
    rr.gross_unit_load,
    rr.run_status_cd,
    rr.rata_ref_value,
    rr.calc_rata_ref_value,
    rr.userid,
    rr.add_date,
    rr.update_date,
    rs.test_num,
    rs.gp_ind,
    rs.ref_method_cd,
    rs.test_reason_cd,
    rs.test_result_cd,
    rs.begin_date AS rata_begin_date,
    rs.begin_hour AS rata_begin_hour,
    rs.begin_min AS rata_begin_min,
    rs.end_date AS rata_end_date,
    rs.end_hour AS rata_end_hour,
    rs.end_min AS rata_end_min,
    rs.sys_type_cd,
    rs.system_identifier,
    rs.rata_id,
    rs.test_sum_id,
    rs.mon_sys_id,
    rs.mon_loc_id,
    rs.stack_diameter,
    rs.stack_area,
    rs.calc_waf AS level_calc_waf,
    rs.default_waf,
    rs.fac_id,
    rs.location_identifier,
    frr.flow_rata_run_id,
    frr.num_traverse_point,
    frr.barometric_pressure,
    frr.static_stack_pressure,
    frr.percent_co2,
    frr.percent_o2,
    frr.percent_moisture,
    frr.dry_molecular_weight,
    frr.wet_molecular_weight,
    frr.avg_vel_wo_wall,
    frr.avg_vel_w_wall,
    frr.calc_waf,
    frr.avg_stack_flow_rate
   FROM camdecmpswks.rata_run rr
     JOIN camdecmpswks.vw_qa_rata_summary rs ON rr.rata_sum_id::text = rs.rata_sum_id::text
     LEFT JOIN camdecmpswks.flow_rata_run frr ON rr.rata_run_id::text = frr.rata_run_id::text;

-- 166. Recreate camdecmpswks.vw_qa_flow_rata_run
-- Source: camdecmpswks/views/vw_qa_flow_rata_run.sql
-- View: camdecmpswks.vw_qa_flow_rata_run


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_flow_rata_run
 AS
 SELECT rf.flow_rata_run_id,
    rf.num_traverse_point,
    rf.barometric_pressure,
    rf.static_stack_pressure,
    rf.percent_co2,
    rf.percent_o2,
    rf.percent_moisture,
    rf.dry_molecular_weight,
    rf.wet_molecular_weight,
    rf.avg_vel_wo_wall,
    rf.avg_vel_w_wall,
    rf.calc_waf,
    rf.avg_stack_flow_rate,
    rr.rata_run_id,
    rr.rata_sum_id,
    rr.op_level_cd,
    rr.run_num,
    rr.begin_date,
    rr.begin_hour,
    rr.begin_min,
    rr.end_date,
    rr.end_hour,
    rr.end_min,
    rr.run_status_cd,
    rr.level_calc_waf,
    rr.default_waf,
    rr.cem_value,
    rr.rata_ref_value,
    rf.userid,
    rf.add_date,
    rr.update_date,
    rr.test_num,
    rr.ref_method_cd,
    rr.sys_type_cd,
    rr.system_identifier,
    rr.stack_diameter,
    rr.rata_id,
    rr.test_sum_id,
    rr.mon_sys_id,
    rr.mon_loc_id
   FROM camdecmpswks.flow_rata_run rf
     JOIN camdecmpswks.vw_qa_rata_run rr ON rf.rata_run_id::text = rr.rata_run_id::text;

-- 167. Recreate camdecmpswks.vw_qa_rata_traverse
-- Source: camdecmpswks/views/vw_qa_rata_traverse.sql
-- View: camdecmpswks.vw_qa_rata_traverse


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_rata_traverse
 AS
 SELECT rr.rata_run_id,
    rr.rata_sum_id,
    rr.op_level_cd,
    rr.run_num,
    rr.sys_type_cd,
    rr.system_identifier,
    rr.begin_date AS run_begin_date,
    rr.begin_hour AS run_begin_hour,
    rr.end_date AS run_end_date,
    rr.end_hour AS run_end_hour,
    rr.rata_id,
    rr.test_sum_id,
    rr.mon_sys_id,
    rr.mon_loc_id,
    rr.fac_id,
    rr.location_identifier,
    rr.ref_method_cd,
    rr.flow_rata_run_id,
    rt.rata_traverse_id,
    rt.probeid,
    rr.default_waf,
    rt.probe_type_cd,
    rt.pressure_meas_cd,
    rt.method_traverse_point_id,
    rt.vel_cal_coef,
    rt.last_probe_date,
    rt.avg_vel_diff_pressure,
    rt.avg_sq_vel_diff_pressure,
    rt.t_stack_temp,
    rt.pitch_angle,
    rt.yaw_angle,
    rt.point_used_ind,
    rt.num_wall_effects_points,
    rt.calc_vel,
    rt.rep_vel,
    rt.add_date,
    rt.update_date,
    rt.userid
   FROM camdecmpswks.rata_traverse rt
     JOIN camdecmpswks.vw_qa_rata_run rr ON rt.flow_rata_run_id::text = rr.flow_rata_run_id::text;

-- 168. Recreate camdecmpswks.vw_qa_supp_attribute
-- Source: camdecmpswks/views/vw_qa_supp_attribute.sql
-- View: camdecmpswks.vw_qa_supp_attribute


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_supp_attribute
 AS
 SELECT at.qa_supp_attribute_id,
    qa.qa_supp_data_id,
    qa.test_sum_id,
    qa.mon_loc_id,
    qa.mon_sys_id,
    qa.component_id,
    at.attribute_name,
    at.attribute_value,
    qa.test_num,
    qa.gp_ind,
    qa.test_type_cd,
    qa.test_reason_cd,
    qa.test_result_cd,
    qa.rpt_period_id,
    rp.calendar_year,
    rp.quarter,
    qa.op_level_cd,
    qa.span_scale,
    qa.begin_date,
    qa.begin_hour,
    qa.begin_min,
    qa.end_date,
    qa.end_hour,
    qa.end_min,
    qa.reinstallation_date,
    qa.reinstallation_hour,
    qa.test_expire_date,
    qa.test_expire_hour,
    at.userid,
    at.add_date,
    at.update_date,
    ml.fac_id,
    COALESCE(ml.stack_name, ml.unitid) AS location_identifier,
    c.component_type_cd,
    c.component_identifier,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.sys_designation_cd,
        CASE
            WHEN qa.submission_availability_cd IS NULL OR (qa.submission_availability_cd::text = ANY (ARRAY['GRANTED'::character varying::text, 'REQUIRE'::character varying::text])) THEN 'Y'::text
            ELSE 'N'::text
        END AS can_submit,
    qa.fuel_cd,
    fc.fuel_group_cd,
    fc.unit_fuel_cd,
    fc.fuel_cd_description,
    qa.operating_condition_cd,
    occ.op_condition_cd_description
   FROM camdecmpswks.qa_supp_attribute at
     JOIN camdecmpswks.qa_supp_data qa ON at.qa_supp_data_id::text = qa.qa_supp_data_id::text
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON qa.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.monitor_system ms ON qa.mon_sys_id::text = ms.mon_sys_id::text
     LEFT JOIN camdecmpswks.component c ON qa.component_id::text = c.component_id::text
     LEFT JOIN camdecmpsmd.reporting_period rp ON qa.rpt_period_id = rp.rpt_period_id
     LEFT JOIN camdecmpsmd.fuel_code fc ON fc.fuel_cd::text = qa.fuel_cd::text
     LEFT JOIN camdecmpsmd.operating_condition_code occ ON qa.operating_condition_cd::text = occ.operating_condition_cd::text;

-- 169. Recreate camdecmpswks.vw_qa_supp_data
-- Source: camdecmpswks/views/2-vw_qa_supp_data.sql
-- View: camdecmpswks.vw_qa_supp_data


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_supp_data
 AS
 SELECT qa.qa_supp_data_id,
    qa.test_sum_id,
    qa.mon_loc_id,
    qa.mon_sys_id,
    qa.component_id,
    qa.test_num,
    qa.gp_ind,
    qa.test_type_cd,
    qa.test_reason_cd,
    qa.test_result_cd,
    qa.rpt_period_id,
        CASE
            WHEN qa.end_date IS NULL THEN rp.calendar_year::double precision
            ELSE date_part('year'::text, qa.end_date::timestamp without time zone)
        END AS calendar_year,
        CASE
            WHEN qa.end_date IS NULL THEN rp.quarter::double precision
            ELSE floor((date_part('month'::text, qa.end_date::timestamp without time zone) + 2::double precision) / 3::double precision)
        END AS quarter,
    qa.op_level_cd,
    qa.span_scale,
    qa.begin_date,
    qa.begin_hour,
    qa.begin_min,
    qa.end_date,
    qa.end_hour,
    qa.end_min,
    qa.reinstallation_date,
    qa.reinstallation_hour,
    qa.reinstallation_date AS reinstall_date,
    qa.reinstallation_hour AS reinstall_hour,
    qa.test_expire_date,
    qa.test_expire_hour,
    qa.userid,
    qa.add_date,
    qa.update_date,
    ml.fac_id,
    ml.location_identifier,
    c.component_type_cd,
    c.component_identifier,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.sys_designation_cd,
        CASE
            WHEN qa.submission_availability_cd IS NULL OR (qa.submission_availability_cd::text = ANY (ARRAY['GRANTED'::character varying::text, 'REQUIRE'::character varying::text])) THEN 'Y'::text
            ELSE 'N'::text
        END AS can_submit,
        CASE
            WHEN qa.submission_availability_cd IS NULL OR qa.submission_availability_cd::text = 'REQUIRE'::text THEN 'Y'::text
            ELSE 'N'::text
        END AS must_submit,
    qa.fuel_cd,
    fc.fuel_group_cd,
    fc.unit_fuel_cd,
    fc.fuel_cd_description,
    qa.operating_condition_cd,
    occ.op_condition_cd_description,
    qa.submission_availability_cd,
    NULL::text AS pending_status_cd,
    ml.oris_code,
    ml.facility_name,
    qa.submission_id
   FROM camdecmpswks.qa_supp_data qa
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON qa.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.monitor_system ms ON qa.mon_sys_id::text = ms.mon_sys_id::text
     LEFT JOIN camdecmpswks.component c ON qa.component_id::text = c.component_id::text
     LEFT JOIN camdecmpsmd.reporting_period rp ON qa.rpt_period_id = rp.rpt_period_id
     LEFT JOIN camdecmpsmd.fuel_code fc ON fc.fuel_cd::text = qa.fuel_cd::text
     LEFT JOIN camdecmpsmd.operating_condition_code occ ON qa.operating_condition_cd::text = occ.operating_condition_cd::text;

-- 170. Recreate camdecmpswks.vw_qa_test_summary
-- Source: camdecmpswks/views/2-vw_qa_test_summary.sql
-- View: camdecmpswks.vw_qa_test_summary


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_summary
 AS
 SELECT ts.test_sum_id,
    ts.mon_loc_id,
    ts.mon_sys_id,
    ts.component_id,
    ts.test_num,
    ts.gp_ind,
    ts.test_type_cd,
    ts.test_reason_cd,
    ts.test_result_cd,
    ts.calc_test_result_cd,
    rp.calendar_year,
    rp.quarter,
    ts.test_description,
    ts.rpt_period_id,
    ts.begin_date,
    ts.begin_hour,
    ts.begin_min,
    ts.end_date,
    ts.end_hour,
    ts.end_min,
    ts.span_scale_cd,
    ts.test_comment,
    ts.injection_protocol_cd,
    ts.last_updated,
    ts.updated_status_flg,
    ts.needs_eval_flg,
    ts.chk_session_id,
    ts.userid,
    ts.add_date,
    ts.update_date,
    ml.fac_id,
    COALESCE(ml.stack_name, ml.unitid) AS location_identifier,
    c.component_type_cd,
    c.component_identifier,
    c.acq_cd,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.sys_designation_cd,
    ff.reinstall_date,
    ff.reinstall_hour,
    udt.fuel_cd,
    fc.fuel_group_cd,
    fc.unit_fuel_cd,
    fc.fuel_cd_description,
    udt.operating_condition_cd,
    occ.op_condition_cd_description,
    COALESCE(flc.op_level_cd, flr.op_level_cd) AS op_level_cd
   FROM camdecmpswks.test_summary ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.monitor_system ms ON ts.mon_sys_id::text = ms.mon_sys_id::text
     LEFT JOIN camdecmpswks.component c ON ts.component_id::text = c.component_id::text
     LEFT JOIN camdecmpsmd.reporting_period rp ON ts.rpt_period_id = rp.rpt_period_id
     LEFT JOIN camdecmpswks.fuel_flowmeter_accuracy ff ON ts.test_sum_id::text = ff.test_sum_id::text
     LEFT JOIN camdecmpswks.unit_default_test udt ON ts.test_sum_id::text = udt.test_sum_id::text
     LEFT JOIN camdecmpsmd.fuel_code fc ON udt.fuel_cd::text = fc.fuel_cd::text
     LEFT JOIN camdecmpsmd.operating_condition_code occ ON udt.operating_condition_cd::text = occ.operating_condition_cd::text
     LEFT JOIN camdecmpswks.flow_to_load_check flc ON ts.test_sum_id::text = flc.test_sum_id::text
     LEFT JOIN camdecmpswks.flow_to_load_reference flr ON ts.test_sum_id::text = flr.test_sum_id::text;

-- 171. Recreate camdecmpswks.vw_qa_supp_data_hourly_status
-- Source: camdecmpswks/views/vw_qa_supp_data_hourly_status.sql
-- View: camdecmpswks.vw_qa_supp_data_hourly_status


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_supp_data_hourly_status
 AS
 SELECT qas.qa_supp_data_id,
    ts.test_sum_id,
    qas.mon_loc_id,
    qas.mon_sys_id,
    qas.component_id,
    qas.test_num,
    qas.gp_ind,
    qas.test_type_cd,
    qas.test_reason_cd,
    qas.test_result_cd,
    ts.calc_test_result_cd,
    qas.rpt_period_id,
    qas.calendar_year,
    qas.quarter,
    qas.op_level_cd,
    qas.span_scale AS span_scale_cd,
    qas.begin_date,
    qas.begin_hour,
    qas.begin_min,
    camdecmpswks.format_date_time(qas.begin_date, qas.begin_hour::integer::numeric, 0::numeric) AS begin_datehour,
    COALESCE(qas.end_date, rp.quarter_end_date) AS end_date,
    qas.end_hour,
    qas.end_min,
    camdecmpswks.format_date_time(COALESCE(qas.end_date, rp.quarter_end_date), qas.end_hour, 0::numeric) AS end_datehour,
    camdecmpswks.format_date_time(COALESCE(qas.end_date, rp.quarter_end_date), qas.end_hour, qas.end_min) AS end_datetime,
    qas.reinstallation_date,
    qas.reinstallation_hour,
    qas.reinstall_date,
    qas.reinstall_hour,
    qas.fac_id,
    qas.location_identifier,
    qas.component_type_cd,
    qas.component_identifier,
    qas.system_identifier,
    qas.sys_type_cd,
    qas.sys_designation_cd,
    qas.can_submit,
    qas.fuel_cd,
    qas.fuel_group_cd,
    qas.unit_fuel_cd,
    qas.fuel_cd_description,
    qas.operating_condition_cd,
    qas.op_condition_cd_description,
    NULL::timestamp without time zone AS test_exp_date,
    NULL::timestamp without time zone AS test_exp_date_with_ext,
    ts.needs_eval_flg,
    'N'::text AS qa_needs_eval_flg,
    'QASUPP'::text AS qa_supp_or_test_summary,
    qsa_freq.attribute_value AS rata_frequency_cd,
    qsa_baf.attribute_value AS overall_bias_adj_factor,
    qsa_level.attribute_value AS op_level_cd_list,
    qsa_claim.attribute_value AS test_claim_cd,
    cs.severity_cd,
    qas.must_submit,
    COALESCE(ts.updated_status_flg, 'N'::character varying) AS updated_status_flg,
    0 AS ignore_grace_for_extensions
   FROM camdecmpswks.vw_qa_supp_data qas
     LEFT JOIN camdecmpswks.test_summary ts ON qas.test_sum_id::text = ts.test_sum_id::text
     LEFT JOIN ( SELECT qa_supp_attribute.qa_supp_attribute_id,
            qa_supp_attribute.qa_supp_data_id,
            qa_supp_attribute.attribute_name,
            qa_supp_attribute.attribute_value,
            qa_supp_attribute.userid,
            qa_supp_attribute.add_date,
            qa_supp_attribute.update_date
           FROM camdecmpswks.qa_supp_attribute
          WHERE lower(qa_supp_attribute.attribute_name::text) = lower('RATA_FREQUENCY_CD'::text)) qsa_freq ON qas.qa_supp_data_id::text = qsa_freq.qa_supp_data_id::text
     LEFT JOIN ( SELECT qa_supp_attribute.qa_supp_attribute_id,
            qa_supp_attribute.qa_supp_data_id,
            qa_supp_attribute.attribute_name,
            qa_supp_attribute.attribute_value,
            qa_supp_attribute.userid,
            qa_supp_attribute.add_date,
            qa_supp_attribute.update_date
           FROM camdecmpswks.qa_supp_attribute
          WHERE lower(qa_supp_attribute.attribute_name::text) = lower('OVERALL_BIAS_ADJ_FACTOR'::text)) qsa_baf ON qas.qa_supp_data_id::text = qsa_baf.qa_supp_data_id::text
     LEFT JOIN ( SELECT qa_supp_attribute.qa_supp_attribute_id,
            qa_supp_attribute.qa_supp_data_id,
            qa_supp_attribute.attribute_name,
            qa_supp_attribute.attribute_value,
            qa_supp_attribute.userid,
            qa_supp_attribute.add_date,
            qa_supp_attribute.update_date
           FROM camdecmpswks.qa_supp_attribute
          WHERE lower(qa_supp_attribute.attribute_name::text) = lower('OP_LEVEL_CD_LIST'::text)) qsa_level ON qas.qa_supp_data_id::text = qsa_level.qa_supp_data_id::text
     LEFT JOIN ( SELECT qa_supp_attribute.qa_supp_attribute_id,
            qa_supp_attribute.qa_supp_data_id,
            qa_supp_attribute.attribute_name,
            qa_supp_attribute.attribute_value,
            qa_supp_attribute.userid,
            qa_supp_attribute.add_date,
            qa_supp_attribute.update_date
           FROM camdecmpswks.qa_supp_attribute
          WHERE lower(qa_supp_attribute.attribute_name::text) = lower('TEST_CLAIM_CD'::text)) qsa_claim ON qas.qa_supp_data_id::text = qsa_claim.qa_supp_data_id::text
     LEFT JOIN camdecmpswks.check_session cs ON ts.chk_session_id::text = cs.chk_session_id::text
     LEFT JOIN camdecmpsmd.vw_reporting_period rp ON qas.rpt_period_id = rp.rpt_period_id
  WHERE ts.test_sum_id IS NULL OR lower(qas.can_submit) = lower('N'::text) OR ts.needs_eval_flg::text = 'N'::text
UNION
 SELECT NULL::character varying AS qa_supp_data_id,
    ts.test_sum_id,
    ts.mon_loc_id,
    ts.mon_sys_id,
    ts.component_id,
    ts.test_num,
    ts.gp_ind,
    ts.test_type_cd,
    ts.test_reason_cd,
    ts.test_result_cd,
    ts.calc_test_result_cd,
    ts.rpt_period_id,
    ts.calendar_year,
    ts.quarter,
    ts.op_level_cd,
    ts.span_scale_cd,
    ts.begin_date,
    ts.begin_hour,
    ts.begin_min,
    camdecmpswks.format_date_time(ts.begin_date, ts.begin_hour::integer::numeric, 0::numeric) AS begin_datehour,
    COALESCE(ts.end_date, rp.quarter_end_date) AS end_date,
    ts.end_hour,
    ts.end_min,
    camdecmpswks.format_date_time(COALESCE(ts.end_date, rp.quarter_end_date), ts.end_hour, 0::numeric) AS end_datehour,
    camdecmpswks.format_date_time(COALESCE(qas.end_date, rp.quarter_end_date), ts.end_hour, ts.end_min) AS end_datetime,
    ts.reinstall_date AS reinstallation_date,
    ts.reinstall_hour AS reinstallation_hour,
    ts.reinstall_date,
    ts.reinstall_hour,
    ts.fac_id,
    ts.location_identifier,
    ts.component_type_cd,
    ts.component_identifier,
    ts.system_identifier,
    ts.sys_type_cd,
    ts.sys_designation_cd,
    'Y'::text AS can_submit,
    ts.fuel_cd,
    ts.fuel_group_cd,
    ts.unit_fuel_cd,
    ts.fuel_cd_description,
    ts.operating_condition_cd,
    ts.op_condition_cd_description,
    NULL::timestamp without time zone AS test_exp_date,
    NULL::timestamp without time zone AS test_exp_date_with_ext,
    ts.needs_eval_flg,
    'Y'::text AS qa_needs_eval_flg,
    'TESTSUM'::text AS qa_supp_or_test_summary,
    NULL::character varying AS rata_frequency_cd,
    NULL::character varying AS overall_bias_adj_factor,
    qsa_level.attribute_value AS op_level_cd_list,
    NULL::character varying AS test_claim_cd,
    cs.severity_cd,
    COALESCE(qas.must_submit, 'Y'::text) AS must_submit,
    ts.updated_status_flg,
    0 AS ignore_grace_for_extensions
   FROM camdecmpswks.vw_qa_test_summary ts
     LEFT JOIN camdecmpswks.vw_qa_supp_data qas ON ts.test_sum_id::text = qas.test_sum_id::text
     LEFT JOIN ( SELECT qa_supp_attribute.qa_supp_attribute_id,
            qa_supp_attribute.qa_supp_data_id,
            qa_supp_attribute.attribute_name,
            qa_supp_attribute.attribute_value,
            qa_supp_attribute.userid,
            qa_supp_attribute.add_date,
            qa_supp_attribute.update_date
           FROM camdecmpswks.qa_supp_attribute
          WHERE lower(qa_supp_attribute.attribute_name::text) = lower('OP_LEVEL_CD_LIST'::text)) qsa_level ON qas.qa_supp_data_id::text = qsa_level.qa_supp_data_id::text
     LEFT JOIN camdecmpswks.check_session cs ON ts.chk_session_id::text = cs.chk_session_id::text
     LEFT JOIN camdecmpsmd.vw_reporting_period rp ON ts.rpt_period_id = rp.rpt_period_id
  WHERE qas.test_sum_id IS NULL OR lower(qas.can_submit) = lower('Y'::text) AND ts.needs_eval_flg::text = 'Y'::text;

-- 172. Recreate camdecmpswks.vw_qa_test_claim
-- Source: camdecmpswks/views/vw_qa_test_claim.sql
-- View: camdecmpswks.vw_qa_test_claim


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_claim
 AS
 SELECT ts.test_num,
    ts.gp_ind,
    ts.test_reason_cd,
    ts.test_result_cd,
    ts.begin_date,
    ts.begin_hour,
    ts.begin_min,
    ts.end_date,
    ts.end_hour,
    ts.end_min,
    ts.sys_type_cd,
    ts.system_identifier,
    ts.mon_sys_id,
    ts.mon_loc_id,
    r.num_load_level,
    tq.test_claim_cd,
    tq.begin_date AS claim_begin_date,
    tq.end_date AS claim_end_date,
    tq.hi_load_pct,
    tq.mid_load_pct,
    tq.low_load_pct,
    tq.test_qualification_id,
    tq.test_sum_id,
    tq.userid,
    tq.add_date,
    tq.update_date
   FROM camdecmpswks.test_qualification tq
     JOIN camdecmpswks.vw_qa_test_summary ts ON tq.test_sum_id::text = ts.test_sum_id::text
     LEFT JOIN camdecmpswks.rata r ON ts.test_sum_id::text = r.test_sum_id::text;

-- 173. Recreate camdecmpswks.vw_qa_test_extension_exemption
-- Source: camdecmpswks/views/vw_qa_test_extension_exemption.sql
-- View: camdecmpswks.vw_qa_test_extension_exemption


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_extension_exemption
 AS
 SELECT ts.test_extension_exemption_id,
    ts.mon_loc_id,
    ts.mon_sys_id,
    ts.component_id,
    ts.span_scale_cd,
    ts.extens_exempt_cd,
    ts.fuel_cd,
    ts.hours_used,
    rp.calendar_year,
    rp.quarter,
    ts.rpt_period_id,
    ts.last_updated,
    ts.updated_status_flg,
    ts.needs_eval_flg,
    ts.chk_session_id,
    ts.userid,
    ts.add_date,
    ts.update_date,
    ml.fac_id,
    COALESCE(ml.stack_name, ml.unitid) AS location_identifier,
    c.component_type_cd,
    c.component_identifier,
    c.acq_cd,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.sys_designation_cd,
    cs.severity_cd,
        CASE
            WHEN ts.submission_availability_cd::text = 'REQUIRE'::text OR ts.updated_status_flg::text = 'Y'::text THEN 'Y'::text
            ELSE 'N'::text
        END AS must_submit,
    rp.begin_date AS period_begin_date,
    rp.end_date AS period_end_date
   FROM camdecmpswks.test_extension_exemption ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.monitor_system ms ON ts.mon_sys_id::text = ms.mon_sys_id::text
     LEFT JOIN camdecmpswks.component c ON ts.component_id::text = c.component_id::text
     LEFT JOIN camdecmpsmd.reporting_period rp ON ts.rpt_period_id = rp.rpt_period_id
     LEFT JOIN camdecmpswks.check_session cs ON ts.chk_session_id::text = cs.chk_session_id::text;

-- 174. Recreate camdecmpswks.vw_qa_test_summary_f2lchk
-- Source: camdecmpswks/views/vw_qa_test_summary_f2lchk.sql
-- View: camdecmpswks.vw_qa_test_summary_f2lchk


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_summary_f2lchk
 AS
 SELECT ts.test_sum_id,
    ts.mon_loc_id,
    ts.mon_sys_id,
    ts.test_num,
    ts.gp_ind,
    ts.test_reason_cd,
    ts.test_result_cd,
    rp.calendar_year,
    rp.quarter,
    ts.rpt_period_id,
    ts.test_comment,
    ts.last_updated,
    ts.updated_status_flg,
    ts.needs_eval_flg,
    ts.chk_session_id,
    ts.userid,
    ts.add_date,
    ts.update_date,
    ml.fac_id,
    COALESCE(ml.stack_name, ml.unitid) AS location_identifier,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.sys_designation_cd,
    fc.flow_load_check_id,
    fc.test_basis_cd,
    fc.avg_abs_pct_diff,
    fc.num_hrs,
    fc.nhe_fuel,
    fc.nhe_ramping,
    fc.nhe_bypass,
    fc.nhe_pre_rata,
    fc.nhe_test,
    fc.nhe_main_bypass,
    fc.bias_adjusted_ind,
    fc.op_level_cd
   FROM camdecmpswks.test_summary ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.monitor_system ms ON ts.mon_sys_id::text = ms.mon_sys_id::text
     LEFT JOIN camdecmpswks.flow_to_load_check fc ON ts.test_sum_id::text = fc.test_sum_id::text
     LEFT JOIN camdecmpsmd.reporting_period rp ON ts.rpt_period_id = rp.rpt_period_id
  WHERE ts.test_type_cd::text = 'F2LCHK'::text;

-- 175. Recreate camdecmpswks.vw_qa_test_summary_f2lref
-- Source: camdecmpswks/views/vw_qa_test_summary_f2lref.sql
-- View: camdecmpswks.vw_qa_test_summary_f2lref


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_summary_f2lref
 AS
 SELECT ts.test_sum_id,
    ts.mon_loc_id,
    ts.mon_sys_id,
    ts.test_num,
    ts.begin_date,
    ts.begin_hour,
    ts.begin_min,
    ts.end_date,
    ts.end_hour,
    ts.end_min,
    ts.test_comment,
    ts.last_updated,
    ts.updated_status_flg,
    ts.needs_eval_flg,
    ts.chk_session_id,
    ts.userid,
    ts.add_date,
    ts.update_date,
    ml.fac_id,
    COALESCE(ml.stack_name, ml.unitid) AS location_identifier,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.sys_designation_cd,
    fr.op_level_cd,
    fr.flow_load_ref_id,
    fr.avg_ref_method_flow,
    fr.rata_test_num,
    fr.avg_gross_unit_load,
    fr.ref_flow_load_ratio,
    fr.ref_ghr,
    fr.avg_hrly_hi_rate,
    fr.calc_sep_ref_ind
   FROM camdecmpswks.test_summary ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.monitor_system ms ON ts.mon_sys_id::text = ms.mon_sys_id::text
     LEFT JOIN camdecmpswks.flow_to_load_reference fr ON ts.test_sum_id::text = fr.test_sum_id::text
  WHERE ts.test_type_cd::text = 'F2LREF'::text;

-- 176. Recreate camdecmpswks.vw_qa_test_summary_ff2lbas
-- Source: camdecmpswks/views/vw_qa_test_summary_ff2lbas.sql
-- View: camdecmpswks.vw_qa_test_summary_ff2lbas


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_summary_ff2lbas
 AS
 SELECT ts.test_sum_id,
    ts.mon_loc_id,
    ts.mon_sys_id,
    ts.test_num,
    ts.begin_date,
    ts.begin_hour,
    ts.end_date,
    ts.end_hour,
    ts.test_comment,
    ts.last_updated,
    ts.updated_status_flg,
    ts.needs_eval_flg,
    ts.chk_session_id,
    ts.userid,
    ts.add_date,
    ts.update_date,
    ml.fac_id,
    COALESCE(ml.stack_name, ml.unitid) AS location_identifier,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.sys_designation_cd,
    ff.fuel_flow_baseline_id,
    ff.accuracy_test_number,
    ff.pei_test_number,
    ff.avg_fuel_flow_rate,
    ff.avg_load,
    ff.baseline_fuel_flow_load_ratio,
    ff.fuel_flow_load_uom_cd,
    ff.avg_hrly_hi_rate,
    ff.baseline_ghr,
    ff.ghr_uom_cd,
    ff.nhe_cofiring,
    ff.nhe_ramping,
    ff.nhe_low_range
   FROM camdecmpswks.test_summary ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.monitor_system ms ON ts.mon_sys_id::text = ms.mon_sys_id::text
     LEFT JOIN camdecmpswks.fuel_flow_to_load_baseline ff ON ts.test_sum_id::text = ff.test_sum_id::text
  WHERE ts.test_type_cd::text = 'FF2LBAS'::text;

-- 177. Recreate camdecmpswks.vw_qa_test_summary_ff2ltst
-- Source: camdecmpswks/views/vw_qa_test_summary_ff2ltst.sql
-- View: camdecmpswks.vw_qa_test_summary_ff2ltst


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_summary_ff2ltst
 AS
 SELECT ts.test_sum_id,
    ts.mon_loc_id,
    ts.mon_sys_id,
    ts.test_num,
    ts.test_reason_cd,
    ts.test_result_cd,
    rp.calendar_year,
    rp.quarter,
    ts.rpt_period_id,
    ts.test_comment,
    ts.last_updated,
    ts.updated_status_flg,
    ts.needs_eval_flg,
    ts.chk_session_id,
    ts.userid,
    ts.add_date,
    ts.update_date,
    ml.fac_id,
    COALESCE(ml.stack_name, ml.unitid) AS location_identifier,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.sys_designation_cd,
    ff.fuel_flow_load_id,
    ff.test_basis_cd,
    ff.avg_diff,
    ff.num_hrs,
    ff.nhe_cofiring,
    ff.nhe_ramping,
    ff.nhe_low_range
   FROM camdecmpswks.test_summary ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.monitor_system ms ON ts.mon_sys_id::text = ms.mon_sys_id::text
     LEFT JOIN camdecmpswks.fuel_flow_to_load_check ff ON ts.test_sum_id::text = ff.test_sum_id::text
     LEFT JOIN camdecmpsmd.reporting_period rp ON ts.rpt_period_id = rp.rpt_period_id
  WHERE ts.test_type_cd::text = 'FF2LTST'::text;

-- 178. Recreate camdecmpswks.vw_qa_test_summary_ffacc
-- Source: camdecmpswks/views/vw_qa_test_summary_ffacc.sql
-- View: camdecmpswks.vw_qa_test_summary_ffacc


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_summary_ffacc
 AS
 SELECT ts.test_sum_id,
    ff.fuel_flow_acc_id,
    ts.mon_loc_id,
    ts.component_id,
    ts.test_num,
    ts.test_result_cd,
    ts.test_reason_cd,
    ts.end_date,
    ts.end_hour,
    ts.end_min,
    ts.test_comment,
    ts.last_updated,
    ts.updated_status_flg,
    ts.needs_eval_flg,
    ts.chk_session_id,
    ts.userid,
    ts.add_date,
    ts.update_date,
    ml.fac_id,
    COALESCE(ml.stack_name, ml.unitid) AS location_identifier,
    c.component_identifier,
    c.component_type_cd,
    c.acq_cd,
    ff.reinstall_date,
    ff.reinstall_hour,
    ff.acc_test_method_cd,
    ff.low_fuel_accuracy,
    ff.mid_fuel_accuracy,
    ff.high_fuel_accuracy
   FROM camdecmpswks.test_summary ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.component c ON ts.component_id::text = c.component_id::text
     LEFT JOIN camdecmpswks.fuel_flowmeter_accuracy ff ON ts.test_sum_id::text = ff.test_sum_id::text
  WHERE ts.test_type_cd::text = 'FFACC'::text;

-- 179. Recreate camdecmpswks.vw_qa_test_summary_ffacctt
-- Source: camdecmpswks/views/vw_qa_test_summary_ffacctt.sql
-- View: camdecmpswks.vw_qa_test_summary_ffacctt


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_summary_ffacctt
 AS
 SELECT ts.test_sum_id,
    ff.trans_ac_id,
    ts.mon_loc_id,
    ts.component_id,
    ts.test_num,
    ts.test_result_cd,
    ts.test_reason_cd,
    ts.end_date,
    ts.end_hour,
    ts.end_min,
    ts.test_comment,
    ts.last_updated,
    ts.updated_status_flg,
    ts.needs_eval_flg,
    ts.chk_session_id,
    ts.userid,
    ts.add_date,
    ts.update_date,
    ml.fac_id,
    COALESCE(ml.stack_name, ml.unitid) AS location_identifier,
    c.component_identifier,
    c.component_type_cd,
    c.acq_cd,
    ff.low_level_accuracy,
    ff.low_level_accuracy_spec_cd,
    ff.mid_level_accuracy,
    ff.mid_level_accuracy_spec_cd,
    ff.high_level_accuracy,
    ff.high_level_accuracy_spec_cd
   FROM camdecmpswks.test_summary ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.component c ON ts.component_id::text = c.component_id::text
     LEFT JOIN camdecmpswks.trans_accuracy ff ON ts.test_sum_id::text = ff.test_sum_id::text
  WHERE ts.test_type_cd::text = 'FFACCTT'::text;

-- 180. Recreate camdecmpswks.vw_qa_test_summary_line
-- Source: camdecmpswks/views/vw_qa_test_summary_line.sql
-- View: camdecmpswks.vw_qa_test_summary_line


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_summary_line
 AS
 SELECT ts.test_sum_id,
    ts.mon_loc_id,
    ts.test_type_cd,
    ts.component_id,
    ts.test_num,
    ts.gp_ind,
    ts.test_reason_cd,
    ts.test_result_cd,
    ts.begin_date,
    ts.begin_hour,
    ts.begin_min,
    ts.end_date,
    ts.end_hour,
    ts.end_min,
    ts.span_scale_cd,
    ts.test_comment,
    ts.last_updated,
    ts.updated_status_flg,
    ts.needs_eval_flg,
    ts.chk_session_id,
    ts.userid,
    ts.add_date,
    ts.update_date,
    ml.fac_id,
    COALESCE(ml.stack_name, ml.unitid) AS location_identifier,
    c.component_type_cd,
    c.component_identifier,
    c.acq_cd,
    c.hg_converter_ind,
    ts.begin_date + ((ts.begin_hour || ' HOUR'::text)::interval) AS begin_datehour,
    ts.end_date + ((ts.end_hour || ' HOUR'::text)::interval) AS end_datehour
   FROM camdecmpswks.test_summary ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.component c ON ts.component_id::text = c.component_id::text
  WHERE ts.test_type_cd::text = ANY (ARRAY['LINE'::character varying::text, 'HGLINE'::character varying::text, 'HGSI3'::character varying::text]);

-- 181. Recreate camdecmpswks.vw_qa_test_summary_onoff
-- Source: camdecmpswks/views/vw_qa_test_summary_onoff.sql
-- View: camdecmpswks.vw_qa_test_summary_onoff


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_summary_onoff
 AS
 SELECT ts.test_sum_id,
    ts.mon_loc_id,
    ts.component_id,
    ts.test_num,
    ts.test_reason_cd,
    ts.test_result_cd,
    ts.begin_date,
    ts.begin_hour,
    ts.begin_min,
    ts.end_date,
    ts.end_hour,
    ts.end_min,
    ts.span_scale_cd,
    ts.test_comment,
    ml.fac_id,
    COALESCE(ml.stack_name, ml.unitid) AS location_identifier,
    c.component_type_cd,
    c.component_identifier,
    c.acq_cd,
    o.online_zero_injection_date,
    o.online_zero_injection_hour,
    o.on_off_cal_id,
    o.online_zero_measured_value,
    o.online_zero_ref_value,
    o.online_zero_cal_error,
    o.online_zero_aps_ind,
    o.offline_zero_injection_date,
    o.offline_zero_injection_hour,
    o.offline_zero_measured_value,
    o.offline_zero_ref_value,
    o.offline_zero_cal_error,
    o.offline_zero_aps_ind,
    o.upscale_gas_level_cd,
    o.online_upscale_injection_date,
    o.online_upscale_injection_hour,
    o.online_upscale_measured_value,
    o.online_upscale_ref_value,
    o.online_upscale_cal_error,
    o.online_upscale_aps_ind,
    o.offline_upscale_injection_date,
    o.offline_upscale_injection_hour,
    o.offline_upscale_measured_value,
    o.offline_upscale_ref_value,
    o.offline_upscale_cal_error,
    o.offline_upscale_aps_ind,
    ts.last_updated,
    ts.updated_status_flg,
    ts.needs_eval_flg,
    ts.chk_session_id,
    ts.userid,
    ts.add_date,
    ts.update_date
   FROM camdecmpswks.test_summary ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.component c ON ts.component_id::text = c.component_id::text
     LEFT JOIN camdecmpswks.on_off_cal o ON ts.test_sum_id::text = o.test_sum_id::text
  WHERE ts.test_type_cd::text = 'ONOFF'::text;

-- 182. Recreate camdecmpswks.vw_qa_test_summary_unitdef
-- Source: camdecmpswks/views/vw_qa_test_summary_unitdef.sql
-- View: camdecmpswks.vw_qa_test_summary_unitdef


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_test_summary_unitdef
 AS
 SELECT ts.test_sum_id,
    ts.mon_loc_id,
    ts.test_num,
    ts.test_reason_cd,
    ts.begin_date,
    ts.begin_hour,
    ts.begin_min,
    ts.end_date,
    ts.end_hour,
    ts.end_min,
    ts.test_comment,
    ts.last_updated,
    ts.updated_status_flg,
    ts.needs_eval_flg,
    ts.chk_session_id,
    ts.userid,
    ts.add_date,
    ts.update_date,
    ml.fac_id,
    COALESCE(ml.stack_name, ml.unitid) AS location_identifier,
    ud.unit_default_test_sum_id,
    ud.fuel_cd,
    ud.operating_condition_cd,
    ud.nox_default_rate,
    ud.group_id,
    ud.num_units_in_group,
    ud.num_tests_for_group
   FROM camdecmpswks.test_summary ts
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.unit_default_test ud ON ts.test_sum_id::text = ud.test_sum_id::text
  WHERE ts.test_type_cd::text = 'UNITDEF'::text;

-- 183. Recreate camdecmpswks.vw_qa_unit_default_test_run
-- Source: camdecmpswks/views/vw_qa_unit_default_test_run.sql
-- View: camdecmpswks.vw_qa_unit_default_test_run


CREATE OR REPLACE VIEW camdecmpswks.vw_qa_unit_default_test_run
 AS
 SELECT ts.test_sum_id,
    ts.test_num,
    ts.test_reason_cd,
    ts.begin_date AS test_begin_date,
    ts.begin_hour AS test_begin_hour,
    ts.begin_min AS test_begin_min,
    ts.end_date AS test_end_date,
    ts.end_hour AS test_end_hour,
    ts.end_min AS test_end_min,
    ts.fuel_cd,
    ts.operating_condition_cd,
    ts.nox_default_rate,
    ts.mon_loc_id,
    ts.fac_id,
    ts.location_identifier,
    ts.unit_default_test_sum_id,
    ur.op_level_num,
    ur.unit_default_test_run_id,
    ur.run_num,
    ur.begin_date,
    ur.begin_hour,
    ur.begin_min,
    ur.end_date,
    ur.end_hour,
    ur.end_min,
    ur.response_time,
    ur.ref_value,
    ur.run_used_ind,
    ur.userid,
    ur.add_date,
    ur.update_date
   FROM camdecmpswks.unit_default_test_run ur
     JOIN camdecmpswks.vw_qa_test_summary_unitdef ts ON ur.unit_default_test_sum_id::text = ts.unit_default_test_sum_id::text;

-- 184. Recreate camdecmpswks.vw_rect_duct_waf
-- Source: camdecmpswks/views/vw_rect_duct_waf.sql
-- View: camdecmpswks.vw_rect_duct_waf


CREATE OR REPLACE VIEW camdecmpswks.vw_rect_duct_waf
 AS
 SELECT rw.rect_duct_waf_data_id,
    rw.mon_loc_id,
    ml.oris_code,
    ml.location_identifier,
    ml.fac_id,
    rw.waf_determined_date,
    rw.waf_effective_hour,
    rw.waf_effective_date,
    rw.end_date,
    rw.end_hour,
    rw.waf_method_cd,
    rw.waf_value,
    rw.num_test_runs,
    rw.num_test_ports,
    rw.num_traverse_points_waf,
    rw.num_traverse_points_ref,
    rw.duct_width,
    rw.duct_depth
   FROM camdecmpswks.rect_duct_waf rw
     JOIN camdecmpswks.vw_monitor_location ml ON rw.mon_loc_id::text = ml.mon_loc_id::text;

-- 185. Recreate camdecmpswks.vw_rpt_monitoring_plan_unit_stack_config
-- Source: camdecmpswks/views/vw_rpt_monitoring_plan_unit_stack_config.sql
-- View: camdecmpswks.vw_rpt_monitoring_plan_unit_stack_config


CREATE OR REPLACE VIEW camdecmpswks.vw_rpt_monitoring_plan_unit_stack_config
 AS
 SELECT DISTINCT mpusc.unitid,
    mpusc.mon_plan_id,
    mpusc.begin_date,
    mpusc.end_date
   FROM camdecmpswks.vw_mp_unit_stack_configuration mpusc;

-- 186. Recreate camdecmpswks.vw_stack_pipe
-- Source: camdecmpswks/views/vw_stack_pipe.sql
-- View: camdecmpswks.vw_stack_pipe


CREATE OR REPLACE VIEW camdecmpswks.vw_stack_pipe
 AS
 SELECT sp.stack_pipe_id,
    ml.mon_loc_id,
    sp.fac_id,
    sp.stack_name,
    sp.active_date,
    sp.retire_date
   FROM camdecmpswks.stack_pipe sp
     JOIN camdecmpswks.vw_monitor_location ml ON sp.stack_pipe_id::text = ml.stack_pipe_id::text;

-- 187. Recreate camdecmpswks.vw_system_analyzer_range
-- Source: camdecmpswks/views/vw_system_analyzer_range.sql
-- View: camdecmpswks.vw_system_analyzer_range


CREATE OR REPLACE VIEW camdecmpswks.vw_system_analyzer_range
 AS
 SELECT ar.component_id,
    ar.analyzer_range_cd,
    ar.dual_range_ind,
    ar.analyzer_range_id,
    msc.component_type_cd,
    ml.mon_loc_id,
    ml.oris_code,
    ml.location_identifier,
    msc.acq_cd,
    msc.basis_cd,
    msc.component_identifier,
    ml.fac_id,
    msc.mon_sys_id,
    msc.system_identifier,
        CASE
            WHEN msc.begin_date IS NULL THEN ar.begin_date
            WHEN ar.begin_date IS NULL THEN msc.begin_date
            WHEN msc.begin_date < ar.begin_date THEN ar.begin_date
            ELSE msc.begin_date
        END AS begin_date,
        CASE
            WHEN msc.begin_date IS NULL THEN ar.begin_hour
            WHEN ar.begin_date IS NULL THEN msc.begin_hour
            WHEN msc.begin_date < ar.begin_date THEN ar.begin_hour
            WHEN msc.begin_date = ar.begin_date AND msc.begin_hour < ar.begin_hour THEN ar.begin_hour
            ELSE msc.begin_hour
        END AS begin_hour,
        CASE
            WHEN msc.end_date IS NULL THEN ar.end_date
            WHEN ar.end_date IS NULL THEN msc.end_date
            WHEN msc.end_date > ar.end_date THEN ar.end_date
            ELSE msc.end_date
        END AS end_date,
        CASE
            WHEN msc.end_date IS NULL THEN ar.end_hour
            WHEN ar.end_date IS NULL THEN msc.end_hour
            WHEN msc.end_date > ar.end_date THEN ar.end_hour
            WHEN msc.end_date = ar.end_date AND msc.end_hour > ar.end_hour THEN ar.end_hour
            ELSE msc.end_hour
        END AS end_hour
   FROM camdecmpswks.analyzer_range ar
     JOIN camdecmpswks.vw_monitor_system_component msc ON ar.component_id::text = msc.component_id::text
     JOIN camdecmpswks.vw_monitor_location ml ON msc.mon_loc_id::text = ml.mon_loc_id::text;

-- 188. Recreate camdecmpswks.vw_system_fuel_flow
-- Source: camdecmpswks/views/vw_system_fuel_flow.sql
-- View: camdecmpswks.vw_system_fuel_flow


CREATE OR REPLACE VIEW camdecmpswks.vw_system_fuel_flow
 AS
 SELECT sff.sys_fuel_id,
    ms.fac_id,
    ms.mon_loc_id,
    sff.mon_sys_id,
    sff.max_rate,
    sff.begin_date,
    sff.begin_hour,
    sff.end_date,
    sff.end_hour,
    sff.sys_fuel_uom_cd,
    sff.max_rate_source_cd,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.fuel_cd
   FROM camdecmpswks.vw_monitor_system ms
     JOIN camdecmpswks.system_fuel_flow sff ON ms.mon_sys_id::text = sff.mon_sys_id::text;

-- 189. Recreate camdecmpswks.vw_test_extension_exemption_eval_and_submit
-- Source: camdecmpswks/views/vw_test_extension_exemption_eval_and_submit.sql
-- View: camdecmpswks.vw_test_extension_exemption_eval_and_submit


CREATE OR REPLACE VIEW camdecmpswks.vw_test_extension_exemption_eval_and_submit
 AS
 SELECT p.oris_code,
    p.facility_name,
    mp.mon_plan_id,
    COALESCE(u.unitid, sp.stack_name) AS location_info,
    tee.test_extension_exemption_id,
    tee.extens_exempt_cd,
    tee.mon_loc_id,
    COALESCE(ms.system_identifier, c.component_identifier) AS system_component_identifier,
    tee.rpt_period_id,
    tee.userid,
    COALESCE(tee.update_date, tee.add_date) AS update_date,
    tee.eval_status_cd,
    esc.eval_status_cd_description,
    tee.submission_availability_cd,
    sac.sub_avail_cd_description as submission_availability_cd_description,
	tee.fuel_cd,
    tee.hours_used,
    tee.span_scale_cd,
    rp.period_abbreviation
   FROM camd.plant p
     JOIN camdecmpswks.monitor_plan mp USING (fac_id)
     JOIN (select distinct mpl.mon_loc_id,
				first_value(mp.mon_plan_id)
			    over (
			    	partition by mpl.mon_loc_id
			        order by mp.begin_rpt_period_id desc
			    ) latest_mon_plan_id
			from camdecmpswks.monitor_plan_location mpl
			inner join camdecmpswks.monitor_plan mp on mpl.mon_plan_id = mp.mon_plan_id) mpl ON mpl.latest_mon_plan_id = mp.mon_plan_Id
     JOIN camdecmpswks.monitor_location ml USING (mon_loc_id)
     JOIN camdecmpswks.test_extension_exemption tee USING (mon_loc_id)
     JOIN camdecmpsmd.eval_status_code esc
	 	ON esc.eval_status_cd = tee.eval_status_cd
	 JOIN camdecmpsmd.submission_availability_code sac
	 	ON sac.submission_availability_cd = tee.submission_availability_cd
     LEFT JOIN camdecmpswks.monitor_system ms USING (mon_sys_id)
     LEFT JOIN camdecmpswks.component c USING (component_id)
     LEFT JOIN camdecmpsmd.reporting_period rp ON rp.rpt_period_id = tee.rpt_period_id
     LEFT JOIN camd.unit u USING (unit_id)
     LEFT JOIN camdecmpswks.stack_pipe sp USING (stack_pipe_id);

-- 190. Recreate camdecmpswks.vw_test_summary_eval_and_submit
-- Source: camdecmpswks/views/vw_test_summary_eval_and_submit.sql
-- View: camdecmpswks.vw_test_summary_eval_and_submit


CREATE OR REPLACE VIEW camdecmpswks.vw_test_summary_eval_and_submit
 AS
 SELECT p.oris_code,
    p.facility_name,
    mp.mon_plan_id,
    COALESCE(u.unitid, sp.stack_name) AS location_info,
    ts.test_sum_id,
    ts.mon_loc_id,
    COALESCE(ms.system_identifier, c.component_identifier) AS system_component_identifier,
    ts.test_num,
    ts.gp_ind,
    ts.test_type_cd,
    ts.test_reason_cd,
    ts.test_result_cd,
    qsd.rpt_period_id,
        CASE
            WHEN ts.begin_date IS NULL THEN NULL::text
            ELSE concat(ts.begin_date, ' ', lpad(COALESCE(ts.begin_hour, 0::numeric)::text, 2, '0'::text), ':', lpad(COALESCE(ts.begin_min, 0::numeric)::text, 2, '0'::text))
        END AS begin_date,
        CASE
            WHEN ts.end_date IS NULL THEN NULL::text
            ELSE concat(ts.end_date, ' ', lpad(COALESCE(ts.end_hour, 0::numeric)::text, 2, '0'::text), ':', lpad(COALESCE(ts.end_min, 0::numeric)::text, 2, '0'::text))
        END AS end_date,
    ts.updated_status_flg,
    ts.userid,
    ts.add_date,
    COALESCE(ts.update_date, ts.add_date) AS update_date,
    ts.eval_status_cd,
    esc.eval_status_cd_description,
    qsd.submission_availability_cd,
    sac.sub_avail_cd_description as submission_availability_cd_description,
    rp.period_abbreviation
   FROM camd.plant p
     JOIN camdecmpswks.monitor_plan mp USING (fac_id)
     JOIN (select distinct mpl.mon_loc_id,
				first_value(mp.mon_plan_id)
			    over (
			    	partition by mpl.mon_loc_id
			        order by mp.begin_rpt_period_id desc
			    ) latest_mon_plan_id
			from camdecmpswks.monitor_plan_location mpl
			inner join camdecmpswks.monitor_plan mp on mpl.mon_plan_id = mp.mon_plan_id) mpl ON mpl.latest_mon_plan_id = mp.mon_plan_Id
     JOIN camdecmpswks.monitor_location ml USING (mon_loc_id)
     JOIN camdecmpswks.test_summary ts USING (mon_loc_id)
     JOIN camdecmpsmd.eval_status_code esc
	 	ON esc.eval_status_cd = ts.eval_status_cd
     LEFT JOIN camdecmpswks.qa_supp_data qsd USING (test_sum_id)
	 LEFT JOIN camdecmpsmd.submission_availability_code sac
	 	ON sac.submission_availability_cd = qsd.submission_availability_cd
	 LEFT JOIN camdecmpswks.monitor_system ms ON ms.mon_sys_id::text = ts.mon_sys_id::text
     LEFT JOIN camdecmpswks.component c ON c.component_id::text = ts.component_id::text
     LEFT JOIN camdecmpsmd.reporting_period rp ON rp.rpt_period_id = ts.rpt_period_id
     LEFT JOIN camd.unit u USING (unit_id)
     LEFT JOIN camdecmpswks.stack_pipe sp USING (stack_pipe_id);

-- 191. Recreate camdecmpswks.vw_unit_stack_configuration
-- Source: camdecmpswks/views/2-vw_unit_stack_configuration.sql
-- View: camdecmpswks.vw_unit_stack_configuration


CREATE OR REPLACE VIEW camdecmpswks.vw_unit_stack_configuration
 AS
 SELECT DISTINCT mlu.mon_loc_id,
    usc.config_id,
    usc.begin_date,
    usc.end_date,
    mls.location_identifier AS stack_name,
    mlu.location_identifier AS unitid,
    mls.stack_pipe_id,
    mlu.unit_id,
    mlu.non_load_based_ind,
    mls.mon_loc_id AS stack_pipe_mon_loc_id,
    mlu.fac_id
   FROM camdecmpswks.unit_stack_configuration usc
     JOIN camdecmpswks.vw_monitor_location mlu ON usc.unit_id = mlu.unit_id
     JOIN camdecmpswks.vw_monitor_location mls ON usc.stack_pipe_id::text = mls.stack_pipe_id::text;

-- 192. Recreate camdecmpswks.vw_unit_monitor_system
-- Source: camdecmpswks/views/vw_unit_monitor_system.sql
-- View: camdecmpswks.vw_unit_monitor_system


CREATE OR REPLACE VIEW camdecmpswks.vw_unit_monitor_system
 AS
 SELECT ml.mon_loc_id,
    ms.mon_sys_id,
    ml.oris_code,
    ml.location_identifier,
    ml.fac_id,
    usc.stack_name,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.sys_designation_cd,
    ms.fuel_cd,
        CASE
            WHEN usc.begin_date IS NULL THEN ms.begin_date
            WHEN ms.begin_date IS NULL THEN usc.begin_date
            WHEN ms.begin_date >= usc.begin_date THEN ms.begin_date
            ELSE usc.begin_date
        END AS begin_date,
        CASE
            WHEN usc.begin_date IS NULL THEN ms.begin_hour
            WHEN ms.begin_date IS NULL THEN NULL::numeric
            WHEN ms.begin_date >= usc.begin_date THEN ms.begin_hour
            ELSE NULL::numeric
        END AS begin_hour,
        CASE
            WHEN usc.end_date IS NULL THEN ms.end_date
            WHEN ms.end_date IS NULL THEN usc.end_date
            WHEN ms.end_date <= usc.end_date THEN ms.end_date
            ELSE usc.end_date
        END AS end_date,
        CASE
            WHEN usc.end_date IS NULL THEN ms.end_hour
            WHEN ms.end_date IS NULL THEN NULL::numeric
            WHEN ms.end_date <= usc.end_date THEN ms.end_hour
            ELSE NULL::numeric
        END AS end_hour
   FROM camdecmpswks.vw_monitor_location ml
     JOIN camdecmpswks.vw_unit_stack_configuration usc ON ml.unit_id = usc.unit_id
     JOIN camdecmpswks.monitor_system ms ON usc.stack_pipe_mon_loc_id::text = ms.mon_loc_id::text AND (usc.end_date IS NULL OR ms.begin_date <= usc.end_date) AND (ms.end_date IS NULL OR ms.end_date >= usc.begin_date)
UNION
 SELECT ml.mon_loc_id,
    ms.mon_sys_id,
    ml.oris_code,
    ml.location_identifier,
    ml.fac_id,
    NULL::character varying AS stack_name,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.sys_designation_cd,
    ms.fuel_cd,
    ms.begin_date,
    ms.begin_hour,
    ms.end_date,
    ms.end_hour
   FROM camdecmpswks.vw_monitor_location ml
     JOIN camdecmpswks.monitor_system ms ON ml.mon_loc_id::text = ms.mon_loc_id::text;

-- 193. Recreate camdecmpswks.vw_unit_op_status
-- Source: camdecmpswks/views/vw_unit_op_status.sql
-- View: camdecmpswks.vw_unit_op_status


CREATE OR REPLACE VIEW camdecmpswks.vw_unit_op_status
 AS
 SELECT ml.mon_loc_id,
    u.unit_id,
    u.unitid,
    uos.op_status_cd,
    uos.begin_date,
    uos.end_date,
    uos.unit_op_status_id,
    ml.oris_code,
    ml.location_identifier,
    ml.fac_id
   FROM camdecmpswks.vw_monitor_location ml
     JOIN (camd.unit_op_status uos
     JOIN camd.unit u ON uos.unit_id = u.unit_id) ON ml.unit_id = u.unit_id;

-- 194. Recreate camdecmpswks.vw_unit_reporting_period
-- Source: camdecmpswks/views/vw_unit_reporting_period.sql
-- View: camdecmpswks.vw_unit_reporting_period


CREATE OR REPLACE VIEW camdecmpswks.vw_unit_reporting_period
 AS
 SELECT u.fac_id,
    u.unit_id,
    u.unitid,
    date_part('year'::text, up.begin_date) AS begin_year,
        CASE
            WHEN date_part('month'::text, up.begin_date) <= 3::double precision THEN 1
            WHEN date_part('month'::text, up.begin_date) <= 6::double precision THEN 2
            WHEN date_part('month'::text, up.begin_date) <= 9::double precision THEN 3
            ELSE 4
        END AS begin_quarter,
        CASE
            WHEN ret2.retire_date IS NULL THEN NULL::double precision
            ELSE date_part('year'::text, ret2.retire_date)
        END AS end_year,
        CASE
            WHEN ret2.retire_date IS NULL THEN NULL::integer
            WHEN date_part('month'::text, ret2.retire_date) <= 3::double precision THEN 1
            WHEN date_part('month'::text, ret2.retire_date) <= 6::double precision THEN 2
            WHEN date_part('month'::text, ret2.retire_date) <= 9::double precision THEN 3
            ELSE 4
        END AS end_quarter
   FROM camd.unit u
     JOIN ( SELECT vw_monitor_method.unit_id,
            min(vw_monitor_method.begin_date) AS begin_date
           FROM camdecmpswks.vw_monitor_method
          GROUP BY vw_monitor_method.unit_id) up ON u.unit_id = up.unit_id
     LEFT JOIN ( SELECT ret.unit_id,
            max(ret.retire_date) AS retire_date
           FROM ( SELECT unit_op_status.unit_id,
                    unit_op_status.begin_date - 1 AS retire_date
                   FROM camd.unit_op_status
                  WHERE unit_op_status.op_status_cd::text = 'RET'::text AND unit_op_status.end_date IS NULL) ret
          GROUP BY ret.unit_id) ret2 ON u.unit_id = ret2.unit_id
  WHERE ret2.retire_date IS NULL OR ret2.retire_date >= up.begin_date;

-- 195. Recreate camdecmpswks.vw_used_identifier
-- Source: camdecmpswks/views/vw_used_identifier.sql
-- View: camdecmpswks.vw_used_identifier


CREATE OR REPLACE VIEW camdecmpswks.vw_used_identifier
 AS
 SELECT ui.mon_loc_id,
    ui.table_cd,
    ui.identifier,
    ui.type_or_parameter_cd,
    ui.formula_or_basis_cd,
    ml.oris_code,
    ml.location_identifier,
    ml.fac_id
   FROM camdecmps.used_identifier ui
     JOIN camdecmpswks.vw_monitor_location ml ON ui.mon_loc_id::text = ml.mon_loc_id::text;

-- Recreate this function after its dependent regular views.
DROP FUNCTION IF EXISTS camdecmpsaux.get_units_expected_to_submit_report_data(numeric, character varying, character varying, character varying, numeric, numeric, character varying);
DROP FUNCTION IF EXISTS camdecmpsaux.get_units_expected_to_submit_report_data(bigint, character varying, character varying, character varying, numeric, numeric, character varying);

create or replace
function camdecmpsaux.get_units_expected_to_submit_report_data(
    V_FAC_ID bigint,
    V_FACILITY_NAME character varying,
    V_STATE character varying,
    V_PRG_CODE character varying,
    V_YEAR numeric,
    V_QUARTER numeric,
    V_WINDOW_STATUS character varying
)
returns table (
    ORIS_CODE numeric,
	FAC_ID bigint,
    FACILITY_NAME character varying,
    STATE character varying,
    UNITID character varying,
    LOCATIONS text,
    EM_SUB_TYPE_CD_DESCRIPTION character varying,
    ACCESS_BEGIN_DATE date,
    ACCESS_END_DATE date,
    WINDOW_STATUS text,
    SUBMISSION_STATUS text,
    SUBMISSION_ID bigint,
    SUBMISSION_DATE timestamp,
    SEVERITY_CD_DESCRIPTION character varying
)
as $BODY$
declare
    v_rpt_period_id bigint;

begin

if V_YEAR is null then
        raise exception 'Required input parameter [V_YEAR] (year) was not provided.';
end if;

if V_QUARTER is null then
        raise exception 'Required input parameter [V_QUARTER] (quarter) was not provided.';
end if;

select
	RPT_PERIOD_ID
      into
	v_rpt_period_id
from
	camdecmpsmd.reporting_period
where
	calendar_year = V_YEAR
	and quarter = V_QUARTER;

return QUERY
    select
	F.ORIS_CODE,
	F.FAC_ID,
	F.FACILITY_NAME,
	F.STATE,
	U.UNITID,
	coalesce(vmp.locations, mp.mon_plan_id) as locations,
	ESA_SUB.EM_SUB_TYPE_CD_DESCRIPTION,
	ESA_SUB.ACCESS_BEGIN_DATE::date as ACCESS_BEGIN_DATE,
	ESA_SUB.ACCESS_END_DATE::date as ACCESS_END_DATE,
	coalesce(ESA_SUB.WINDOW_STATUS, 'No Window') as WINDOW_STATUS,
	ESA_SUB.SUBMISSION_STATUS,
	ESA_SUB.SUBMISSION_ID,
	ESA_SUB.SUBMISSION_DATE,
	ESA_SUB.SEVERITY_CD_DESCRIPTION
from
	camd.UNIT U
join camd.plant F
        on
	U.FAC_ID = F.FAC_ID
	and
	F.FAC_ID = coalesce(V_FAC_ID, U.FAC_ID)
	and F.FACILITY_NAME = coalesce(V_FACILITY_NAME, F.FACILITY_NAME)
	and F.STATE = coalesce(V_STATE, F.STATE)
join (
	select
		U.UNIT_ID,
		max(ers.mon_plan_id) as mon_plan_id
	from
		camd.UNIT U
	join camdecmps.vw_em_reporting_status ers
         on
		u.unit_id = ers.unit_id
		and ers.rpt_period_id = v_rpt_period_id
		and ers.prg_cd = coalesce(V_PRG_CODE, ers.prg_cd)
	group by
		U.UNIT_ID
        ) mp
        on
	u.unit_id = mp.unit_id
left join camdecmps.vw_monitor_plan vmp on
	mp.mon_plan_id = vmp.mon_plan_id
left join
        (
	select
		ESA.MON_PLAN_ID,
		ESA.EM_SUB_TYPE_CD_DESCRIPTION,
		ESA.ACCESS_BEGIN_DATE,
		ESA.ACCESS_END_DATE,
		ESA.WINDOW_STATUS,
		ESA.SUBMISSION_STATUS,
		ESA.SUBMISSION_ID,
		ESA.SUBMISSION_DATE,
		ESA.SEVERITY_CD_DESCRIPTION
	from
		camdecmpsaux.VW_EM_SUBMISSION_ACCESS ESA
	where
		ESA.RPT_PERIOD_ID = v_rpt_period_id
		and (ESA.LAST_WINDOW = 'Yes'
			or (ESA.EM_SUB_TYPE_CD = 'INITIAL'
				and ESA.SUB_AVAILABILITY_CD = 'DELETE'))
        ) ESA_SUB
        on
	mp.MON_PLAN_ID = ESA_SUB.MON_PLAN_ID
WHERE coalesce(ESA_SUB.WINDOW_STATUS, 'No Window') = coalesce(V_WINDOW_STATUS, coalesce(ESA_SUB.WINDOW_STATUS, 'No Window'))
order by
	F.ORIS_CODE,
	U.UNITID,
	vmp.locations;
end;

$BODY$ language plpgsql;

COMMIT;
