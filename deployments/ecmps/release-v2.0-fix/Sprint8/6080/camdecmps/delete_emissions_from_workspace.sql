DROP PROCEDURE IF EXISTS camdecmps.delete_emissions_from_workspace(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmps.delete_emissions_from_workspace(
  monPlanId character varying(45), rptPeriodId numeric
) LANGUAGE 'plpgsql' AS $BODY$ DECLARE monLocIds text[];
BEGIN 
SELECT 
  ARRAY(
    SELECT 
      mon_loc_id 
    FROM 
      camdecmpswks.monitor_plan_location 
    WHERE 
      mon_plan_id = monPlanId
  ) INTO monLocIds;

  -- DELETE WORKSPACE DATA
  DELETE
  FROM   camdecmpswks.check_session
  WHERE  chk_session_id =
         (
                SELECT chk_session_id
                FROM   camdecmpswks.emission_evaluation
                WHERE  mon_plan_id = monplanid
                AND    rpt_period_id = rptperiodid );
  
  CALL camdecmpswks.delete_monitor_plan_emissions_data_from_workspace(monPlanId, rptPeriodId);
END
$BODY$;