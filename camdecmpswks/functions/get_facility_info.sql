-- FUNCTION: camdecmpswks.get_facility_info(character varying, character varying)

DROP FUNCTION IF EXISTS camdecmpswks.get_facility_info(character varying, character varying) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.get_facility_info(
	lookuptype character varying,
	lookupid character varying)
    RETURNS TABLE(facid integer, firstecmpsrptperiodid integer, error_msg character varying) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
DECLARE
 
    -- Each lookup type indicates what column the lookup id matches:
	--	Type	Id
	--  ----	---------------------------
	--	MP		Mon_Plan_Id
	--	TEST	Test_Sum_Id
	--	QAC		QA_Cert_Event_Id
	--	TEE		Test_Extension_Exemption_Id
	--	ORIS	ORIS_Code
  	verror_msg    character varying :=null;
	vfacid        integer;
	vfirstEcmpsRptPeriodId	integer;
BEGIN  
    if lookupType ='MP'  then
       SELECT fac.FAC_ID, fac.FIRST_ECMPS_RPT_PERIOD_ID 
		 into facid, firstEcmpsRptPeriodId
		FROM camdecmpswks.MONITOR_PLAN pln
		   INNER JOIN camd.plant fac ON fac.FAC_ID = pln.FAC_ID
				where pln.MON_PLAN_ID = lookupid; 
		  if facid is null then
			error_msg:='camdecmpswks.get_facility_info: Unable to determine Facility ID 
			       for MON_PLAN_ID: '||lookupid;
		   END if;
		   
	 elsif lookupType ='ML'  then
		SELECT	fac.FAC_ID, fac.FIRST_ECMPS_RPT_PERIOD_ID into facid, firstEcmpsRptPeriodId
			FROM camdecmpswks.MONITOR_LOCATION ml
		LEFT OUTER JOIN camdecmpswks.STACK_PIPE sp on sp.STACK_PIPE_ID = ml.STACK_PIPE_ID
		LEFT OUTER JOIN camd.UNIT u on u.UNIT_ID = ml.UNIT_ID
		INNER JOIN  camd.plant fac on fac.FAC_ID = COALESCE(sp.FAC_ID,u.FAC_ID)
		   WHERE ml.MON_LOC_ID = lookupid;

		   IF facid is null then 
				error_msg:= 'camdecmpswks.get_facility_info: Unable to determine Facility ID 
				for MON_LOC_ID: '||lookupid;
			END if;
			
	/*   --copy the codes from SQL script here in case it's needed later on
	--Anna edit 1/21/2022 */
	  ELSEIF lookupType = 'TEST' then
	   SELECT fac.FAC_ID, fac.FIRST_ECMPS_RPT_PERIOD_ID into facid, firstEcmpsRptPeriodId
			FROM camdecmpswks.TEST_SUMMARY tst
				JOIN camdecmpswks.MONITOR_LOCATION loc ON loc.MON_LOC_ID = tst.MON_LOC_ID
				LEFT JOIN camd.UNIT unt ON unt.UNIT_ID = loc.UNIT_ID
				LEFT JOIN camdecmpswks.STACK_PIPE stp ON stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
				JOIN camd.plant fac ON fac.FAC_ID IN (unt.FAC_ID, stp.FAC_ID)
			WHERE tst.TEST_SUM_ID = lookupid;
	  
	      if facid is null then 
				error_msg:= 'camdecmpswks.get_facility_info: Unable to determine Facility ID 
				for TEST_SUM_ID: '||lookupid;
			END if;		  
	 
	 	/* Anna edit 6/3/2022 for QCE, TEE */
	ELSEIF lookupType = 'QCE' then
	   SELECT fac.FAC_ID, fac.FIRST_ECMPS_RPT_PERIOD_ID into facid, firstEcmpsRptPeriodId	
			FROM camdecmpswks.QA_CERT_EVENT qac
				JOIN camdecmpswks.MONITOR_LOCATION loc ON loc.MON_LOC_ID = qac.MON_LOC_ID
				LEFT JOIN camd.UNIT unt ON unt.UNIT_ID = loc.UNIT_ID
				LEFT JOIN camdecmpswks.STACK_PIPE stp ON stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
				JOIN camd.plant fac ON fac.FAC_ID IN (unt.FAC_ID, stp.FAC_ID)
			WHERE qac.QA_CERT_EVENT_ID = lookupid;
		if facid is null then 
				error_msg:= 'camdecmpswks.get_facility_info: Unable to determine Facility ID 
				for QA_CERT_EVENT_ID: '||lookupid;
			END if;
			
	 ELSEIF lookupType ='TEE' then
		SELECT	fac.FAC_ID, fac.FIRST_ECMPS_RPT_PERIOD_ID into facid, firstEcmpsRptPeriodId
			FROM camdecmpswks.TEST_EXTENSION_EXEMPTION tee
				JOIN camdecmpswks.MONITOR_LOCATION loc ON loc.MON_LOC_ID = tee.MON_LOC_ID
				LEFT JOIN camd.UNIT unt ON unt.UNIT_ID = loc.UNIT_ID
				LEFT JOIN camdecmpswks.STACK_PIPE stp ON stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
				JOIN camd.plant fac ON fac.FAC_ID IN (unt.FAC_ID, stp.FAC_ID)
				WHERE tee.TEST_EXTENSION_EXEMPTION_ID = lookupid;

			if facid is null then 
				error_msg:= 'camdecmpswks.get_facility_info: Unable to determine Facility ID 
				for TEE_ID: '||lookupid;
			END if; 
		
	ELSEIF lookupType = 'ORIS' then
	   SELECT fac.FAC_ID, fac.FIRST_ECMPS_RPT_PERIOD_ID into facid, firstEcmpsRptPeriodId	
			FROM camd.plant fac
			WHERE CAST(fac.ORIS_CODE AS VARCHAR) = lookupid;
		if facid is null then 
				error_msg:= 'camdecmpswks.get_facility_info: Unable to determine Facility ID 
				for ORIS_CODE: '||lookupid;
			END if;
	
	ELSEIF lookupType = 'FAC' then
		SELECT	fac.FAC_ID, fac.FIRST_ECMPS_RPT_PERIOD_ID into facid, firstEcmpsRptPeriodId
			FROM camd.plant fac
			WHERE CAST(fac.FAC_ID AS VARCHAR) = lookupid;
           if facid is null then 
				error_msg:= 'camdecmpswks.get_facility_info: Unable to determine Facility ID 
				for FAC_ID: '||lookupid;
		    else  
			END if;
	ELSE
			error_msg:= 'camdecmpswks.get_facility_info: Unhandled lookup type';
	end if;
RETURN NEXT;
   
EXCEPTION
		WHEN OTHERS THEN
		   get stacked diagnostics 
		   error_msg := message_text;           				
END;
$BODY$;
