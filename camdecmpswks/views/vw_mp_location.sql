-- View: camdecmpswks.vw_mp_location

DROP VIEW IF EXISTS camdecmpswks.vw_mp_location;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_location
 AS
 SELECT mpl.mon_loc_id,
    ml.stack_pipe_id,
    ml.unit_id,
    mp.mon_plan_id,
    mp.fac_id,
    sp.stack_name,
    u.unitid,
    u.non_load_based_ind,
    sp.active_date,
    sp.retire_date,
        CASE
            WHEN u.unit_id IS NOT NULL THEN u.unitid
            WHEN sp.stack_pipe_id IS NOT NULL THEN sp.stack_name
            ELSE NULL::character varying
        END AS location_identifier,
    COALESCE(u.comr_op_date::timestamp without time zone, dsp.comr_op_date) AS comr_op_date,
        CASE
            WHEN ml.unit_id IS NOT NULL THEN 'UN'::text
            ELSE substr(sp.stack_name::text, 1, 2)
        END AS location_type
   FROM camdecmpswks.monitor_plan_location mpl
     JOIN camdecmpswks.monitor_location ml ON mpl.mon_loc_id::text = ml.mon_loc_id::text
     JOIN camdecmpswks.monitor_plan mp ON mpl.mon_plan_id::text = mp.mon_plan_id::text
     LEFT JOIN camd.unit u ON ml.unit_id = u.unit_id
     LEFT JOIN camdecmpswks.stack_pipe sp ON ml.stack_pipe_id::text = sp.stack_pipe_id::text
     LEFT JOIN ( SELECT usc.stack_pipe_id,
            min(COALESCE(unit.comr_op_date::timestamp without time zone, '9999-12-31 00:00:00'::timestamp without time zone)) AS comr_op_date
           FROM camd.unit unit
             JOIN camdecmpswks.unit_stack_configuration usc ON unit.unit_id = usc.unit_id
          GROUP BY usc.stack_pipe_id) dsp ON ml.stack_pipe_id::text = dsp.stack_pipe_id::text;
