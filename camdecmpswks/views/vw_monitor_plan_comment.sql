-- View: camdecmpswks.vw_monitor_plan_comment

-- DROP VIEW camdecmpswks.vw_monitor_plan_comment;

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
