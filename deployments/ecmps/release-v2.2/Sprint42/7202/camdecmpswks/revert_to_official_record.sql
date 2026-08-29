-- PROCEDURE: camdecmpswks.revert_to_official_record(text)

/****************************************************************************************************************************************************
    Maintenance History:
    
    Date        Programmer      Ticket      Description
    ----------  --------------  ----------  ---------------------------------------------------------------------------------------------------------
    2026-07-10  Dwayne Whitten  #7202       Addition of FAC_ID as an argument for the call to COPY_MONITOR_PLAN_TO_WORKSPACE.
****************************************************************************************************************************************************/
CREATE OR REPLACE PROCEDURE camdecmpswks.revert_to_official_record
(
	monplanid text
)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	monLocIds 		text[];
    facId           numeric;
BEGIN
	SELECT ARRAY(
		SELECT mon_loc_id
		FROM camdecmpswks.monitor_plan_location
		WHERE mon_plan_id = monPlanId
	) INTO monLocIds;
    
    SELECT  FAC_ID
      INTO  facId
      FROM  camdecmpswks.MONITOR_PLAN
     WHERE  MON_PLAN_ID = monPlanId;
    
	DELETE FROM camdecmpswks.check_session WHERE mon_plan_id = monPlanId;
    CALL camdecmpswks.delete_emissions_views( monplanid );
    CALL camdecmpswks.delete_monitor_plan_emissions_data_from_workspace( monplanid );
	CALL camdecmpswks.delete_monitor_plan_qa_data_from_workspace( monplanid );
	CALL camdecmpswks.delete_monitor_plan_data_from_workspace( monplanid );
	CALL camdecmpswks.copy_monitor_plan_to_workspace( monplanid, monLocIds, facId );
    CALL camdecmpswks.copy_monitor_plan_qa_data_to_workspace( monplanid );
    CALL camdecmpswks.copy_monitor_plan_emissions_data_to_workspace( monplanid );
END;
$BODY$;
