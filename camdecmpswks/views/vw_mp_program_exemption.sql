CREATE OR REPLACE VIEW camdecmpswks.vw_mp_program_exemption (mon_plan_id, mon_loc_id, unit_id, fac_id, prg_cd, up_id, upe_id, exempt_type_cd, ex_rec_date, begin_date, end_date) AS
SELECT
    monitor_plan.mon_plan_id, monitor_location.mon_loc_id, unit.unit_id, unit.fac_id, unit_program.prg_cd, unit_program.up_id, unit_program_exemption.upe_id, unit_program_exemption.exempt_type_cd, unit_program_exemption.ex_rec_date, unit_program_exemption.begin_date, unit_program_exemption.end_date
    FROM camdecmpswks.monitor_location
    INNER JOIN camdecmpswks.monitor_plan_location
        ON monitor_location.mon_loc_id = monitor_plan_location.mon_loc_id
    INNER JOIN camdecmpswks.monitor_plan
        ON monitor_plan_location.mon_plan_id = monitor_plan.mon_plan_id
    INNER JOIN camd.unit
        ON monitor_location.unit_id = unit.unit_id
    INNER JOIN camd.unit_program
        ON unit.unit_id = unit_program.unit_id
    INNER JOIN camd.unit_program_exemption
        ON unit_program.up_id = unit_program_exemption.up_id;