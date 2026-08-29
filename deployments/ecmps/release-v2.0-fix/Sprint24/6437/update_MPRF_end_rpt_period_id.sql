/* Formatted on 3/11/2026 4:15:04 PM (QP5 v5.300) */
MERGE INTO MONITOR_PLAN_REPORTING_FREQ d
     USING (    SELECT mp.mon_plan_rf_id,
         mp.mon_plan_id,
         mp.REPORT_FREQ_CD,
         mp.begin_rpt_period_id,
         MAX (ee.rpt_period_id) AS last_em_rpt_period_Id,
         ret.min_retire_date,
         rp.RPT_PERIOD_ID     AS ret_rpt_period_id
    FROM monitor_plan_reporting_freq mp
         INNER JOIN
         (  SELECT mpl.mon_plan_id, COUNT (ml.unit_id) AS unit_count
              FROM monitor_plan_location mpl
                   INNER JOIN monitor_location ml
                       ON     mpl.MON_LOC_ID = ml.MON_LOC_ID
                          AND ml.unit_id IS NOT NULL
          GROUP BY mpl.mon_plan_id) mp_unit_count
             ON mp.MON_PLAN_ID = mp_unit_count.mon_plan_id
         INNER JOIN
         (  SELECT mpl.mon_plan_id, COUNT (ml.unit_id) AS ret_unit_count
              FROM monitor_plan_location mpl
                   INNER JOIN monitor_location ml
                       ON     mpl.MON_LOC_ID = ml.MON_LOC_ID
                          AND ml.unit_id IS NOT NULL
                   INNER JOIN unit_op_status uos
                       ON     ml.unit_Id = uos.unit_Id
                          AND uos.op_status_cd = 'RET'
                          AND uos.end_date IS NULL
          GROUP BY mpl.mon_plan_id) mp_ret_unit_count
             ON mp.MON_PLAN_ID = mp_ret_unit_count.mon_plan_id
         LEFT OUTER JOIN emission_evaluation ee
             ON mp.MON_PLAN_ID = ee.MON_PLAN_ID
         LEFT OUTER JOIN
         (  SELECT mon_plan_id, MIN (retire_date) AS min_retire_date
              FROM (SELECT mpl.mon_plan_id, uos.begin_date AS retire_date
                      FROM unit_op_status uos
                           INNER JOIN monitor_location ml
                               ON uos.unit_id = ml.unit_Id
                           INNER JOIN monitor_plan_location mpl
                               ON ml.mon_loc_id = mpl.mon_loc_id
                     WHERE uos.op_status_cd = 'RET' AND uos.end_date IS NULL
                    UNION ALL
                    SELECT mpl.mon_plan_id, sp.retire_date
                      FROM stack_pipe sp
                           INNER JOIN monitor_location ml
                               ON sp.stack_pipe_id = ml.stack_pipe_Id
                           INNER JOIN monitor_plan_location mpl
                               ON ml.mon_loc_id = mpl.mon_loc_id
                     WHERE sp.retire_date IS NOT NULL)
          GROUP BY mon_plan_id) ret
             ON mp.mon_plan_id = ret.mon_plan_Id
         LEFT OUTER JOIN reporting_period rp
             ON (ret.min_retire_date - 1) BETWEEN rp.BEGIN_DATE AND rp.end_date
   WHERE     mp.end_rpt_period_id IS NULL
         AND mp_unit_count.unit_count = mp_ret_unit_count.ret_unit_count
GROUP BY mp.mon_plan_rf_id,
         mp.mon_plan_id,
         mp.REPORT_FREQ_CD,
         mp.begin_rpt_period_id,
         ret.min_retire_date,
         rp.RPT_PERIOD_ID) s
        ON (d.MON_PLAN_RF_ID = s.MON_PLAN_RF_ID)
WHEN MATCHED
THEN
    UPDATE SET
        d.USERID = 'ECMPS20',
        d.UPDATE_DATE = SYSDATE,
        d.END_RPT_PERIOD_ID =
            GREATEST (ret_rpt_period_id,
                   NVL (ret_rpt_period_id, last_em_rpt_period_Id));
