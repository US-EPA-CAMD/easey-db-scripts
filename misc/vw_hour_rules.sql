-- View: camdecmps.vw_hour_rules

DROP VIEW IF EXISTS camdecmps.vw_hour_rules;

CREATE OR REPLACE VIEW camdecmps.vw_hour_rules
 AS
 SELECT DISTINCT ge.hour_id
   FROM camdecmps.vw_hourly_errors ge
     JOIN camdecmps.emission_evaluation evl ON evl.mon_plan_id::text = ge.mon_plan_id::text AND evl.rpt_period_id = ge.rpt_period_id
     JOIN camdecmps.hrly_op_data hod ON hod.hour_id::text = ge.hour_id::text
     JOIN camdecmpsaux.check_log log ON log.chk_session_id::text = evl.chk_session_id::text AND log.mon_loc_id::text = ge.mon_loc_id::text AND (log.op_begin_date < hod.begin_date OR log.op_begin_date = hod.begin_date AND log.op_begin_hour <= hod.begin_hour) AND (log.op_end_date > hod.begin_date OR log.op_end_date = hod.begin_date AND log.op_end_hour >= hod.begin_hour)
     JOIN camdecmpsmd.rule_check rc ON rc.rule_check_id = log.rule_check_id AND "substring"(COALESCE(rc.category_cd, ''::character varying)::text, 1, 2) = 'ST'::text;
