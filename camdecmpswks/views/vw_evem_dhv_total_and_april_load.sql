-- View: camdecmpswks.vw_evem_dhv_total_and_april_load

DROP VIEW IF EXISTS camdecmpswks.vw_evem_dhv_total_and_april_load;

CREATE OR REPLACE VIEW camdecmpswks.vw_evem_dhv_total_and_april_load
 AS
 SELECT pln.mon_plan_id,
    pln.fac_id,
    mpl.mon_loc_id,
    fac.oris_code,
        CASE
            WHEN unt.unit_id IS NOT NULL THEN unt.unitid
            WHEN stp.stack_pipe_id IS NOT NULL THEN stp.stack_name
            ELSE NULL::character varying
        END AS location_name,
    hod.rpt_period_id,
    dhv.parameter_cd,
    dhv.modc_cd,
    sum(
        CASE
            WHEN hod.hr_load >= 0::numeric AND hod.op_time > 0::numeric AND hod.op_time <= 1::numeric AND dhv.hour_id IS NOT NULL AND dhv.modc_cd IS NULL THEN hod.op_time * hod.hr_load
            ELSE NULL::numeric
        END) AS total,
    sum(
        CASE
            WHEN hod.hr_load >= 0::numeric AND hod.op_time > 0::numeric AND hod.op_time <= 1::numeric AND dhv.hour_id IS NOT NULL AND dhv.modc_cd IS NULL AND date_part('month'::text, hod.begin_date::timestamp without time zone) = 4::double precision THEN hod.op_time * hod.hr_load
            ELSE NULL::numeric
        END) AS april,
    sum(
        CASE
            WHEN hod.op_time > 0::numeric AND hod.op_time <= 1::numeric AND dhv.hour_id IS NOT NULL AND dhv.modc_cd IS NULL THEN hod.op_time
            ELSE NULL::numeric
        END) AS total_optime,
    sum(
        CASE
            WHEN hod.op_time > 0::numeric AND hod.op_time <= 1::numeric AND dhv.hour_id IS NOT NULL AND dhv.modc_cd IS NULL AND date_part('month'::text, hod.begin_date::timestamp without time zone) = 4::double precision THEN hod.op_time
            ELSE NULL::numeric
        END) AS april_optime,
    max(
        CASE
            WHEN hod.hr_load >= 0::numeric AND hod.op_time > 0::numeric AND hod.op_time <= 1::numeric THEN
            CASE
                WHEN dhv.hour_id IS NULL AND (hod.hr_load > 0::numeric OR hod.op_time > 0::numeric) THEN 1
                ELSE 0
            END
            ELSE 1
        END) AS problem_occurred
   FROM camdecmpswks.monitor_plan pln
     LEFT JOIN camd.plant fac ON fac.fac_id = pln.fac_id
     JOIN camdecmpswks.monitor_plan_location mpl ON mpl.mon_plan_id::text = pln.mon_plan_id::text
     JOIN camdecmpswks.monitor_location loc ON loc.mon_loc_id::text = mpl.mon_loc_id::text
     LEFT JOIN camd.unit unt ON unt.unit_id = loc.unit_id
     LEFT JOIN camdecmpswks.stack_pipe stp ON stp.stack_pipe_id::text = loc.stack_pipe_id::text
     JOIN camdecmpswks.hrly_op_data hod ON hod.mon_loc_id::text = loc.mon_loc_id::text
     LEFT JOIN camdecmpswks.derived_hrly_value dhv ON dhv.hour_id::text = hod.hour_id::text AND dhv.parameter_cd::text = 'HIT'::text
  WHERE hod.op_time <> 0::numeric OR hod.hr_load IS NOT NULL
  GROUP BY pln.mon_plan_id, pln.fac_id, mpl.mon_loc_id, fac.oris_code, unt.unit_id, unt.unitid, stp.stack_pipe_id, stp.stack_name, hod.rpt_period_id, dhv.parameter_cd, dhv.modc_cd;
