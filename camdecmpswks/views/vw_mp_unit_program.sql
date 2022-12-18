-- View: camdecmpswks.vw_mp_unit_program

DROP VIEW IF EXISTS camdecmpswks.vw_mp_unit_program;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_unit_program
 AS
 SELECT up.up_id,
    mp.mon_plan_id,
    ml.mon_loc_id,
    u.unit_id,
    u.unitid,
    up.prg_cd,
    up.class_cd AS class,
    up.unit_monitor_cert_begin_date,
    up.emissions_recording_begin_date,
    up.end_date,
        CASE
            WHEN up.unit_monitor_cert_begin_date IS NULL THEN NULL::text
            ELSE date_part('year'::text, up.unit_monitor_cert_begin_date)::character varying(4)::text ||
            CASE
                WHEN date_part('month'::text, up.unit_monitor_cert_begin_date) = ANY (ARRAY[1::double precision, 2::double precision, 3::double precision]) THEN 1
                WHEN date_part('month'::text, up.unit_monitor_cert_begin_date) = ANY (ARRAY[4::double precision, 5::double precision, 6::double precision]) THEN 2
                WHEN date_part('month'::text, up.unit_monitor_cert_begin_date) = ANY (ARRAY[7::double precision, 8::double precision, 9::double precision]) THEN 3
                ELSE 4
            END
        END AS unit_monitor_cert_begin_quarter,
        CASE
            WHEN up.end_date IS NULL THEN NULL::text
            ELSE date_part('year'::text, up.end_date)::character varying(4)::text ||
            CASE
                WHEN date_part('month'::text, up.end_date) = ANY (ARRAY[1::double precision, 2::double precision, 3::double precision]) THEN 1
                WHEN date_part('month'::text, up.end_date) = ANY (ARRAY[4::double precision, 5::double precision, 6::double precision]) THEN 2
                WHEN date_part('month'::text, up.end_date) = ANY (ARRAY[7::double precision, 8::double precision, 9::double precision]) THEN 3
                ELSE 4
            END
        END AS end_quarter,
    up.prg_id
   FROM camdecmpswks.monitor_plan_location mpl
     JOIN camdecmpswks.monitor_location ml ON mpl.mon_loc_id::text = ml.mon_loc_id::text
     JOIN camdecmpswks.monitor_plan mp ON mpl.mon_plan_id::text = mp.mon_plan_id::text
     JOIN (camd.unit_program up
     JOIN camd.unit u ON up.unit_id = u.unit_id) ON ml.unit_id = u.unit_id;
