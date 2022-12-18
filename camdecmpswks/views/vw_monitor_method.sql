-- View: camdecmpswks.vw_monitor_method

DROP VIEW IF EXISTS camdecmpswks.vw_monitor_method;

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
