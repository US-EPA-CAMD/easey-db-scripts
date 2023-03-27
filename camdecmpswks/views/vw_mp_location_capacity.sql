-- View: camdecmpswks.vw_mp_location_capacity

DROP VIEW IF EXISTS camdecmpswks.vw_mp_location_capacity;

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
