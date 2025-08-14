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