CREATE OR REPLACE PROCEDURE camdecmpswks.revert_to_official_record_delete_emissions
(
	IN monplanid text
)
LANGUAGE 'plpgsql'
AS $BODY$

DECLARE
	monLocIds 		text[];
	rptPeriodIds    int[]; 
BEGIN
	-- GET LIST OF LOCATION IDs IN THE MONITOR PLAN
	SELECT ARRAY(
		SELECT mon_loc_id
		FROM camdecmpswks.monitor_plan_location
		WHERE mon_plan_id = monplanid
	) INTO monLocIds;

	-- Get list of report period IDs from both schemas 
	SELECT ARRAY(
		  SELECT rpt_period_id
		   from CAMDECMPSWKS.EMISSION_EVALUATION
           where MON_PLAN_ID= monplanid
		union
		   SELECT rpt_period_id
		   from CAMDECMPS.EMISSION_EVALUATION
            where MON_PLAN_ID= monplanid
	) INTO rptPeriodIds;
		
	DELETE FROM camdecmpswks.emission_evaluation
	WHERE mon_plan_id = monPlanId
	and rpt_period_id = ANY(rptPeriodIds); 

	DELETE FROM camdecmpswks.sorbent_trap
	 WHERE mon_loc_id = ANY(monLocIds)
	 and rpt_period_id = ANY(rptPeriodIds);
    
	DELETE FROM camdecmpswks.hrly_op_data
	WHERE mon_loc_id = ANY(monLocIds)
	and rpt_period_id = ANY(rptPeriodIds);
	
	DELETE FROM camdecmpswks.summary_value
	WHERE mon_loc_id = ANY(monLocIds)
      and rpt_period_id = ANY(rptPeriodIds);
	  
	DELETE FROM camdecmpswks.nsps4t_summary
	WHERE mon_loc_id = ANY(monLocIds)
     and rpt_period_id = ANY(rptPeriodIds);
	 
	DELETE FROM camdecmpswks.daily_emission
	 WHERE mon_loc_id = ANY(monLocIds)
     and rpt_period_id = ANY(rptPeriodIds);
	 
	DELETE FROM camdecmpswks.daily_backstop
	 WHERE mon_loc_id = ANY(monLocIds)
     and rpt_period_id = ANY(rptPeriodIds);

	DELETE FROM camdecmpswks.daily_test_summary
	 WHERE mon_loc_id = ANY(monLocIds)
     and rpt_period_id = ANY(rptPeriodIds);
	
	DELETE FROM camdecmpswks.weekly_test_summary
	 WHERE mon_loc_id = ANY(monLocIds)
     and rpt_period_id = ANY(rptPeriodIds);
	
	DELETE FROM camdecmpswks.long_term_fuel_flow
	 WHERE mon_loc_id = ANY(monLocIds)
     and rpt_period_id = ANY(rptPeriodIds);

	DELETE FROM camdecmpswks.component_op_supp_data
	WHERE mon_loc_id = ANY(monLocIds)
    and rpt_period_id = ANY(rptPeriodIds);
	
	DELETE FROM camdecmpswks.daily_test_supp_data
	WHERE mon_loc_id = ANY(monLocIds)
    and rpt_period_id = ANY(rptPeriodIds);
	
	DELETE FROM camdecmpswks.last_qa_value_supp_data
	WHERE mon_loc_id = ANY(monLocIds)
	 and rpt_period_id = ANY(rptPeriodIds);
	 
	DELETE FROM camdecmpswks.operating_supp_data
	WHERE mon_loc_id = ANY(monLocIds)
	 and rpt_period_id = ANY( rptPeriodIds);
	 
	DELETE FROM camdecmpswks.sorbent_trap_supp_data
	WHERE mon_loc_id = ANY(monLocIds)
	 and rpt_period_id = ANY(rptPeriodIds);
	 
	DELETE FROM camdecmpswks.system_op_supp_data
	 WHERE mon_loc_id = ANY(monLocIds)
	 and rpt_period_id = ANY(rptPeriodIds);

	DELETE FROM camdecmpswks.QA_CERT_EVENT_SUPP_DATA
     WHERE mon_loc_id = ANY(monLocIds)
	and rpt_period_id = ANY(rptPeriodIds);
	
END;
$BODY$;
