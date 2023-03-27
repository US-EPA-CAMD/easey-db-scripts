-- View: camdecmpswks.vw_ce_mp_monitor_location

DROP VIEW IF EXISTS camdecmpswks.vw_ce_mp_monitor_location;

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
