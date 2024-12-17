CREATE OR REPLACE VIEW camdecmps.vw_em_eval_and_submit AS
SELECT 
  fac.oris_code, 
  fac.facility_name, 
  sel.mon_plan_id, 
  (
    SELECT 
      string_agg(
        coalesce(unt.unitid, stp.stack_name), 
        ', ' :: text 
        ORDER BY 
          unt.unitid, 
          stp.stack_name
      ) 
    FROM 
      camdecmps.monitor_plan_location mpl 
      JOIN camdecmps.monitor_location loc ON loc.mon_loc_id = mpl.mon_loc_id 
      LEFT JOIN camd.unit unt ON unt.unit_id = loc.unit_id 
      LEFT JOIN camdecmps.stack_pipe stp ON stp.stack_pipe_id = loc.stack_pipe_id 
    WHERE 
      mpl.mon_plan_id = sel.mon_plan_id
  ) AS configuration, 
  sel.userid ::varchar(160), 
  sel.last_updated AS update_date, 
  (
    SELECT 
      esa.sub_availability_cd 
    FROM 
      (
        SELECT 
          sub.mon_plan_id, 
          sub.rpt_period_id, 
          max(sub.access_begin_date) AS last_access_begin_date 
        FROM 
          camdecmpsaux.em_submission_access sub 
        WHERE 
          sub.mon_plan_id = sel.mon_plan_id 
          AND sub.rpt_period_id = sel.rpt_period_id 
        GROUP BY 
          sub.mon_plan_id, 
          sub.rpt_period_id
      ) lst1 
      JOIN camdecmpsaux.EM_SUBMISSION_ACCESS esa ON esa.mon_plan_id = lst1.mon_plan_id 
      AND esa.rpt_period_id = lst1.rpt_period_id 
      AND esa.access_begin_date = lst1.last_access_begin_date
  ) AS window_status, 
  prd.period_abbreviation 
FROM 
  (
    SELECT 
      ems.mon_plan_id, 
      ems.rpt_period_id, 
      ems.last_updated, 
      (
        SELECT 
          max(smv.Userid) 
        FROM 
          camdecmps.MONITOR_PLAN_LOCATION mpl 
          JOIN camdecmps.SUMMARY_VALUE smv ON smv.Mon_Loc_Id = mpl.Mon_Loc_Id 
          and smv.rpt_period_id = ems.rpt_period_id 
        where 
          mpl.Mon_Plan_Id = ems.Mon_Plan_Id
      ) AS Userid 
    FROM 
      (
        SELECT 
          ems.Mon_Plan_Id, 
          max(ems.last_updated) AS last_updated 
        FROM 
          camdecmps.EMISSION_EVALUATION ems
        GROUP BY 
          ems.Mon_Plan_Id
      ) sel 
      JOIN camdecmps.EMISSION_EVALUATION ems ON ems.Mon_Plan_Id = sel.Mon_Plan_Id 
      AND ems.last_updated = sel.last_updated
  ) sel 
  JOIN camdecmpsmd.reporting_period prd ON prd.rpt_period_id = sel.rpt_period_id 
  JOIN camdecmps.monitor_plan pln ON pln.mon_plan_id = sel.mon_plan_id 
  JOIN camd.plant fac ON fac.fac_id = pln.fac_id;