-- View: camdecmpswks.vw_mp_related_location

DROP VIEW IF EXISTS camdecmpswks.vw_mp_related_location;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_related_location
 AS
 SELECT monitor_plan_location.mon_plan_id,
    monitor_plan_location.mon_loc_id
   FROM camdecmpswks.monitor_plan_location
UNION
 SELECT related.related_mon_plan_id AS mon_plan_id,
    ml.mon_loc_id
   FROM camdecmpswks.monitor_plan_location ml
     JOIN ( SELECT DISTINCT a.mon_plan_id,
            b.mon_plan_id AS related_mon_plan_id
           FROM ( SELECT monitor_plan_location.mon_plan_id,
                    monitor_plan_location.mon_loc_id
                   FROM camdecmpswks.monitor_plan_location) a
             JOIN ( SELECT monitor_plan_location.mon_plan_id,
                    monitor_plan_location.mon_loc_id
                   FROM camdecmpswks.monitor_plan_location) b ON a.mon_loc_id::text = b.mon_loc_id::text AND a.mon_plan_id::text <> b.mon_plan_id::text) related ON ml.mon_plan_id::text = related.mon_plan_id::text;
