-- View: camdecmpswks.vw_mp_program_exemption

DROP VIEW IF EXISTS camdecmpswks.vw_mp_program_exemption;

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
