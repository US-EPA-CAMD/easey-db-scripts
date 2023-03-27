-- View: camdecmpswks.vw_rpt_monitoring_plan_unit_stack_config

DROP VIEW IF EXISTS camdecmpswks.vw_rpt_monitoring_plan_unit_stack_config;

CREATE OR REPLACE VIEW camdecmpswks.vw_rpt_monitoring_plan_unit_stack_config
 AS
 SELECT DISTINCT mpusc.unitid,
    mpusc.mon_plan_id,
    mpusc.begin_date,
    mpusc.end_date
   FROM camdecmpswks.vw_mp_unit_stack_configuration mpusc;
