-- View: camdecmpswks.vw_unit_reporting_period

-- DROP VIEW camdecmpswks.vw_unit_reporting_period;

CREATE OR REPLACE VIEW camdecmpswks.vw_unit_reporting_period
 AS
 SELECT u.fac_id,
    u.unit_id,
    u.unitid,
    date_part('year'::text, up.begin_date) AS begin_year,
        CASE
            WHEN date_part('month'::text, up.begin_date) <= 3::double precision THEN 1
            WHEN date_part('month'::text, up.begin_date) <= 6::double precision THEN 2
            WHEN date_part('month'::text, up.begin_date) <= 9::double precision THEN 3
            ELSE 4
        END AS begin_quarter,
        CASE
            WHEN ret2.retire_date IS NULL THEN NULL::double precision
            ELSE date_part('year'::text, ret2.retire_date)
        END AS end_year,
        CASE
            WHEN ret2.retire_date IS NULL THEN NULL::integer
            WHEN date_part('month'::text, ret2.retire_date) <= 3::double precision THEN 1
            WHEN date_part('month'::text, ret2.retire_date) <= 6::double precision THEN 2
            WHEN date_part('month'::text, ret2.retire_date) <= 9::double precision THEN 3
            ELSE 4
        END AS end_quarter
   FROM camd.unit u
     JOIN ( SELECT vw_monitor_method.unit_id,
            min(vw_monitor_method.begin_date) AS begin_date
           FROM camdecmpswks.vw_monitor_method
          GROUP BY vw_monitor_method.unit_id) up ON u.unit_id = up.unit_id
     LEFT JOIN ( SELECT ret.unit_id,
            max(ret.retire_date) AS retire_date
           FROM ( SELECT unit_op_status.unit_id,
                    unit_op_status.begin_date - 1 AS retire_date
                   FROM camd.unit_op_status
                  WHERE unit_op_status.op_status_cd::text = 'RET'::text AND unit_op_status.end_date IS NULL) ret
          GROUP BY ret.unit_id) ret2 ON u.unit_id = ret2.unit_id
  WHERE ret2.retire_date IS NULL OR ret2.retire_date >= up.begin_date;
