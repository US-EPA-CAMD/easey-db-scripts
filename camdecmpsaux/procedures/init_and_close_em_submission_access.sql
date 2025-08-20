-- PROCEDURE: camdecmpsaux.init_and_close_em_submission_access(text, numeric, text, text)

DROP PROCEDURE IF EXISTS camdecmpsaux.init_and_close_em_submission_access(text, numeric, text, text);

CREATE OR REPLACE PROCEDURE camdecmpsaux.init_and_close_em_submission_access(
	v_sysdate text,
	v_fac_id numeric,
	INOUT v_result text,
	INOUT v_error_msg text)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	V_SYSDATE_AS_DATE   	DATE;
	V_CALENDAR_YEAR       	NUMERIC;
	V_QUARTER             	NUMERIC;
	V_PERIOD_ID           	NUMERIC;
	V_BEGINDATE           	DATE;
	V_ENDDATE             	DATE;
	V_CURRENT_MONTH       	TEXT;
	V_CURRENT_DAY         	TEXT;
	V_ACCESS_BEGIN_DATE   	DATE;
	V_EM_SUB_ACCESS_ID		NUMERIC;
	V_SUB_AVAILABILITY_CD 	TEXT;
	V_EM_STATUS_CD        	TEXT;
	V_PENDING             	TEXT;
	V_EM_SUB_STATUS       	TEXT;
	V_SEND_INITIAL_WINDOW_NOTIFICATION	BOOLEAN;
	V_CUR_SUBMISSION_ID   	BIGINT;
	V_CUR_SUB_STAGE_CD    	TEXT;
	V_CUR_SEVERITY_CD     	TEXT;
	SUB_ACCESS_REC			RECORD;
	CLOSE_ACCESS_REC		RECORD;
	CURR_SUB_STATUS         RECORD;
BEGIN	
	v_result := 'T';
	v_error_msg := '';

	-- Convert text parameter to date
	V_SYSDATE_AS_DATE := TO_DATE(v_sysdate, 'YYYY-MM-DD');
	SELECT EXTRACT(MONTH FROM V_SYSDATE_AS_DATE)::TEXT INTO V_CURRENT_MONTH;
	SELECT EXTRACT(DAY FROM V_SYSDATE_AS_DATE)::TEXT INTO V_CURRENT_DAY;
	SELECT EXTRACT(YEAR FROM V_SYSDATE_AS_DATE)::INT INTO V_CALENDAR_YEAR;

	-- determine relevant quarter to use to open windows (if any)
	IF (V_CURRENT_MONTH = '3' AND V_CURRENT_DAY >= '25') OR
		(V_CURRENT_MONTH = '4' AND V_CURRENT_DAY <= '30') THEN
		V_QUARTER := 1;
		V_BEGINDATE := TO_DATE('04/01/' || V_CALENDAR_YEAR::TEXT, 'MM/DD/YYYY');
	ELSIF V_CURRENT_MONTH = '6' AND V_CURRENT_DAY >= '24' OR
		(V_CURRENT_MONTH = '7' AND V_CURRENT_DAY <= '30') THEN
		V_QUARTER := 2;
		V_BEGINDATE := TO_DATE('07/01/' || V_CALENDAR_YEAR::TEXT, 'MM/DD/YYYY');
	ELSIF V_CURRENT_MONTH = '9' AND V_CURRENT_DAY >= '24' OR
		(V_CURRENT_MONTH = '10' AND V_CURRENT_DAY <= '30') THEN
		V_QUARTER := 3;
		V_BEGINDATE := TO_DATE('10/01/' || V_CALENDAR_YEAR::TEXT, 'MM/DD/YYYY');
	ELSIF (V_CURRENT_MONTH = '12' AND V_CURRENT_DAY >= '25') OR
		(V_CURRENT_MONTH = '1' AND V_CURRENT_DAY <= '30') THEN
		V_QUARTER := 4;
		IF V_CURRENT_MONTH = '1' THEN
			V_CALENDAR_YEAR := V_CALENDAR_YEAR - 1;
		END IF;
		V_BEGINDATE := TO_DATE('01/01/' || (V_CALENDAR_YEAR + 1)::TEXT, 'MM/DD/YYYY');
	END IF;
	
	IF V_BEGINDATE IS NOT NULL THEN
		
		-- set window end date (adjusted to the following Monday if it would fall on the weekend)
		V_ENDDATE := V_BEGINDATE + INTERVAL '29 days';
		IF EXTRACT(DOW FROM V_ENDDATE) = 1 THEN
			V_ENDDATE := V_ENDDATE + INTERVAL '1 day';
		ELSIF EXTRACT(DOW FROM V_ENDDATE) = 0 THEN
			V_ENDDATE := V_ENDDATE + INTERVAL '2 days';
		END IF;	
		
		-- get reporting period id
		SELECT RPT_PERIOD_ID INTO V_PERIOD_ID
		FROM CAMDECMPSMD.REPORTING_PERIOD I
		WHERE CALENDAR_YEAR = V_CALENDAR_YEAR
		AND QUARTER = V_QUARTER;
			
		FOR SUB_ACCESS_REC IN  
		SELECT swjo.MON_PLAN_ID, 
			   swjo.EM_SUB_STATUS, 
			   swjo.em_sub_access_id,
			   swjo.create_pending
			FROM camdecmpsaux.vw_submission_window_job_open swjo
			WHERE swjo.rpt_period_id = V_PERIOD_ID 
	  		AND COALESCE(V_FAC_ID, swjo.FAC_ID) = swjo.FAC_ID
		LOOP
			V_EM_SUB_ACCESS_ID := SUB_ACCESS_REC.em_sub_access_id;

			IF V_EM_SUB_ACCESS_ID IS NULL THEN
				-- no window exists; create one
				
				-- MPs with locations that have not previously submitted data get pending windows that must be manually approved
				V_PENDING := swjo.create_pending;
	
				INSERT INTO CAMDECMPSAUX.EM_SUBMISSION_ACCESS
					(
					MON_PLAN_ID,
					RPT_PERIOD_ID,
					ACCESS_BEGIN_DATE,
					ACCESS_END_DATE,
					EM_SUB_TYPE_CD,
					USERID,
					ADD_DATE,
					EM_STATUS_CD,
					SUB_AVAILABILITY_CD)
				VALUES
					(
					SUB_ACCESS_REC.MON_PLAN_ID,
					V_PERIOD_ID,
					V_BEGINDATE,
					V_ENDDATE,
					'INITIAL',
					'ECMPSOPN',
					CURRENT_TIMESTAMP,
					CASE WHEN V_PENDING = 'T' THEN 'PENDING' ELSE 'APPRVD' END,
					CASE WHEN V_SYSDATE_AS_DATE < V_BEGINDATE OR V_PENDING = 'T' THEN NULL ELSE 'REQUIRE' END);

				IF V_SYSDATE_AS_DATE >= V_BEGINDATE::date AND V_PENDING = 'F' THEN
					-- send notifications when initial windows are created after the start of the reporting period
					V_SEND_INITIAL_WINDOW_NOTIFICATION := TRUE;
				END IF;

			ELSE
				-- window already exists; open it when it is time to do so (only if it is approved)
				
				-- make sure we only act on the latest window for this monitoring plan and reporting period
				SELECT EM.ACCESS_BEGIN_DATE,
					EM.EM_SUB_ACCESS_ID,
					EM.SUB_AVAILABILITY_CD,
					EM.EM_STATUS_CD
				INTO V_ACCESS_BEGIN_DATE,
					V_EM_SUB_ACCESS_ID,
					V_SUB_AVAILABILITY_CD,
					V_EM_STATUS_CD
				FROM CAMDECMPSAUX.EM_SUBMISSION_ACCESS EM
				JOIN (
					SELECT MON_PLAN_ID,
						RPT_PERIOD_ID,
						MAX(ACCESS_BEGIN_DATE) AS ACCESS_BEGIN_DATE
					FROM CAMDECMPSAUX.EM_SUBMISSION_ACCESS
					GROUP BY MON_PLAN_ID, RPT_PERIOD_ID
				) X ON EM.MON_PLAN_ID = X.MON_PLAN_ID
					AND EM.RPT_PERIOD_ID = X.RPT_PERIOD_ID
					AND EM.ACCESS_BEGIN_DATE = X.ACCESS_BEGIN_DATE
				WHERE EM.MON_PLAN_ID = SUB_ACCESS_REC.MON_PLAN_ID
					AND EM.RPT_PERIOD_ID = V_PERIOD_ID;
					
				IF V_SYSDATE_AS_DATE >= V_ACCESS_BEGIN_DATE AND
					V_SUB_AVAILABILITY_CD IS NULL AND V_EM_STATUS_CD = 'APPRVD' THEN
				
					-- OPEN ALREADY EXISTING WINDOW                 
					UPDATE CAMDECMPSAUX.EM_SUBMISSION_ACCESS
					SET SUB_AVAILABILITY_CD = 'REQUIRE',
						USERID = 'ECMPSOPN',
						UPDATE_DATE = CURRENT_TIMESTAMP
					WHERE EM_SUB_ACCESS_ID = V_EM_SUB_ACCESS_ID;

					-- send notification when initial windows are opened
					V_SEND_INITIAL_WINDOW_NOTIFICATION := TRUE;
				END IF;
			END IF;

			IF V_SEND_INITIAL_WINDOW_NOTIFICATION THEN
				CALL camdecmpsaux.ADD_WINDOW_EMAIL('155', 'windowNotification',
												SUB_ACCESS_REC.MON_PLAN_ID,
												V_PERIOD_ID,
												V_EM_SUB_ACCESS_ID,
												V_RESULT,
												V_ERROR_MSG);
				
				--testing result of event call
				IF V_RESULT = 'F' THEN
					RAISE EXCEPTION 'Failed queueing 155 windowNotification email for existing window: % % %',
						V_ERROR_MSG,
						SUB_ACCESS_REC.MON_PLAN_ID,
						V_PERIOD_ID;
				END IF;				
			END IF;
		END LOOP;
	END IF;

	FOR CLOSE_ACCESS_REC IN
    SELECT swjc.MON_PLAN_ID,
       swjc.RPT_PERIOD_ID,
       swjc.EM_SUB_ACCESS_ID,
       swjc.ACCESS_BEGIN_DATE,
       swjc.ACCESS_END_DATE,
       swjc.SUB_AVAILABILITY_CD,
       swjc.EM_STATUS_CD,
       swjc.EM_SUB_TYPE_CD,
       swjc.SUBMISSION_STATUS_CD,
       swjc.SEVERITY_CD,
       swjc.CALENDAR_YEAR,
       swjc.QUARTER,
	   swjc.REOPEN_CRIT2,
	   swjc.CHECK_FOR_REMINDER,
       swjc.EXTEND_WINDOW,
	   swjc.FAC_ID
    FROM camdecmpsaux.vw_submission_window_job_close swjc
    WHERE COALESCE(V_FAC_ID, swjc.FAC_ID) = swjc.FAC_ID
	LOOP
		-- get expected reporting status for this monitoring plan and reporting period			
		SELECT max(ers.em_reporting_status)
			INTO V_EM_SUB_STATUS
		FROM camdecmps.vw_em_reporting_status ers
		WHERE ers.mon_plan_id = CLOSE_ACCESS_REC.MON_PLAN_ID
			AND ers.rpt_period_id = CLOSE_ACCESS_REC.RPT_PERIOD_ID
			AND ers.em_reporting_status IS NOT NULL
			AND ers.fac_id = CLOSE_ACCESS_REC.FAC_ID;

		IF CLOSE_ACCESS_REC.ACCESS_END_DATE >= V_SYSDATE_AS_DATE THEN
			-- window is still active
			--	determine if a reminder should be sent
			--  windows with CRIT2 submissions will be re-opened
			--	windows that are no longer needed will be closed and marked as deleted (no notification sent)

			IF CLOSE_ACCESS_REC.REOPEN_CRIT2 = 'T' THEN
				-- REOPEN NON-EXPIRED WINDOW FOR CRIT2 SUBMISSION				
				UPDATE CAMDECMPSAUX.EM_SUBMISSION_ACCESS
					 SET SUB_AVAILABILITY_CD = 'REQUIRE',
							 USERID          = 'ECMPSOPN',
							 UPDATE_DATE     = SYSDATE
				 WHERE EM_SUB_ACCESS_ID = CLOSE_ACCESS_REC.EM_SUB_ACCESS_ID;
			END IF;

			IF (V_CURRENT_MONTH = '1' OR V_CURRENT_MONTH = '4' OR
				V_CURRENT_MONTH = '7' OR V_CURRENT_MONTH = '10') AND
				V_CURRENT_DAY = '20' AND CLOSE_ACCESS_REC.QUARTER = V_QUARTER AND
				CLOSE_ACCESS_REC.CALENDAR_YEAR = V_CALENDAR_YEAR AND
				CLOSE_ACCESS_REC.CHECK_FOR_REMINDER = 'T' THEN
				-- 20th day of the reporting period - send appropriate reminder

				IF V_EM_SUB_STATUS IS NULL THEN
					-- unused window is no longer needed 
					-- 	close it and mark it as deleted
					--	do not send a reminder
					UPDATE CAMDECMPSAUX.EM_SUBMISSION_ACCESS
					SET ACCESS_END_DATE     = GREATEST(V_SYSDATE_AS_DATE - 1, ACCESS_BEGIN_DATE),
						SUB_AVAILABILITY_CD = 'DELETE',
						USERID              = 'ECMPSCLS',
						UPDATE_DATE         = CURRENT_TIMESTAMP
				 	WHERE EM_SUB_ACCESS_ID = CLOSE_ACCESS_REC.EM_SUB_ACCESS_ID;
				
				ELSIF CLOSE_ACCESS_REC.SUBMISSION_STATUS_CD IS NULL THEN
					-- unused window 
					-- 	send day 20 no submission warning email to agent					
					CALL camdecmpsaux.ADD_WINDOW_EMAIL('151', 'submissionReminder',
													CLOSE_ACCESS_REC.MON_PLAN_ID,
													CLOSE_ACCESS_REC.RPT_PERIOD_ID,
													CLOSE_ACCESS_REC.EM_SUB_ACCESS_ID,
													V_RESULT,
													V_ERROR_MSG);
					
					--MEH 4/10/2010 - testing result of event call
					IF V_RESULT = 'F' THEN
						RAISE EXCEPTION 'Failed queueing 151 no submission submissionReminder email: % % %',
							V_ERROR_MSG,
							CLOSE_ACCESS_REC.MON_PLAN_ID,
							CLOSE_ACCESS_REC.RPT_PERIOD_ID;
					END IF;

				ELSIF CLOSE_ACCESS_REC.SUBMISSION_STATUS_CD = 'RECCRIT' OR
							CLOSE_ACCESS_REC.SEVERITY_CD = 'CRIT2' THEN
					-- used window with CRIT1 or CRIT2 submission
					-- send day 20 critical error warning email to agent					           
					CALL camdecmpsaux.ADD_WINDOW_EMAIL('152', 'submissionReminder',
																 CLOSE_ACCESS_REC.MON_PLAN_ID,
																 CLOSE_ACCESS_REC.RPT_PERIOD_ID,
																 CLOSE_ACCESS_REC.EM_SUB_ACCESS_ID,
																 V_RESULT,
																 V_ERROR_MSG);					
				
					--MEH 4/10/2010 - testing result of event call
					IF V_RESULT = 'F' THEN
						RAISE EXCEPTION 'Failed queueing 152 critical submission submissionReminder email: % % %',
							V_ERROR_MSG,
							CLOSE_ACCESS_REC.MON_PLAN_ID,
							CLOSE_ACCESS_REC.RPT_PERIOD_ID;
					END IF;
				END IF;
			END IF;

		ELSIF CLOSE_ACCESS_REC.SUB_AVAILABILITY_CD <> 'UPDATED' OR CLOSE_ACCESS_REC.REOPEN_CRIT2 = 'T' THEN
			-- window access end date has passed
			--	determine if a notification should be sent
			--	windows that are no longer needed will be closed and marked as deleted (no notification sent)
			--  initial windows with no submission will be extended
			--  windows with failed submissions will be extended		
			--  windows with citical submissions will be extended (no notification sent)
			--  resubmission windows with no submission will be closed

			IF V_EM_SUB_STATUS IS NULL THEN
				-- unused window is no longer needed 
				-- 	close it and mark it as deleted
				--	do not send a reminder
				UPDATE CAMDECMPSAUX.EM_SUBMISSION_ACCESS
				SET ACCESS_END_DATE     = GREATEST(V_SYSDATE_AS_DATE - 1, ACCESS_BEGIN_DATE),
					SUB_AVAILABILITY_CD = 'DELETE',
					USERID              = 'ECMPSCLS',
					UPDATE_DATE         = CURRENT_TIMESTAMP
				WHERE EM_SUB_ACCESS_ID = CLOSE_ACCESS_REC.EM_SUB_ACCESS_ID;

			ELSIF CLOSE_ACCESS_REC.EXTEND_WINDOW = 'T' THEN
				-- extend window
				UPDATE CAMDECMPSAUX.EM_SUBMISSION_ACCESS
				SET ACCESS_END_DATE = CLOSE_ACCESS_REC.ACCESS_END_DATE + 30,
					USERID          = 'ECMPSEXT',
					UPDATE_DATE     = CURRENT_TIMESTAMP
				WHERE EM_SUB_ACCESS_ID = CLOSE_ACCESS_REC.EM_SUB_ACCESS_ID;
			
				IF CLOSE_ACCESS_REC.SUBMISSION_STATUS_CD IS NULL OR
					CLOSE_ACCESS_REC.SUBMISSION_STATUS_CD = 'NOLOAD' THEN
					-- send extension notification for missing and failed submissions 					
					CALL camdecmpsaux.ADD_WINDOW_EMAIL('156', 'submissionReminder',
											CLOSE_ACCESS_REC.MON_PLAN_ID,
											CLOSE_ACCESS_REC.RPT_PERIOD_ID,
											CLOSE_ACCESS_REC.EM_SUB_ACCESS_ID,
											V_RESULT,
											V_ERROR_MSG);							

					--MEH 4/10/2010 - testing result of event call
					IF V_RESULT = 'F' THEN
						RAISE EXCEPTION 'Failed queueing 156 missing of failed submissionReminder email: % (%, %)', V_ERROR_MSG, CLOSE_ACCESS_REC.MON_PLAN_ID, CLOSE_ACCESS_REC.RPT_PERIOD_ID;
					END IF;
				END IF;
			
			ELSIF CLOSE_ACCESS_REC.SUBMISSION_STATUS_CD IS NULL THEN
				-- unsued resubmission window
				--	close it and send notification
				UPDATE CAMDECMPSAUX.EM_SUBMISSION_ACCESS
				SET SUB_AVAILABILITY_CD = 'NOTSUB',
						USERID              = 'ECMPSCLS',
						UPDATE_DATE         = CURRENT_TIMESTAMP
				WHERE EM_SUB_ACCESS_ID = CLOSE_ACCESS_REC.EM_SUB_ACCESS_ID;

				-- send closing of resubmission window email to DR				
				CALL camdecmpsaux.ADD_WINDOW_EMAIL('157', 'windowNotification',
					CLOSE_ACCESS_REC.MON_PLAN_ID,
					CLOSE_ACCESS_REC.RPT_PERIOD_ID,
					CLOSE_ACCESS_REC.EM_SUB_ACCESS_ID,
					V_RESULT,
					V_ERROR_MSG);				

				--MEH 4/10/2010 - testing result of event call
				IF V_RESULT = 'F' THEN
					RAISE EXCEPTION 'Failed queueing 157 windowNotification email: % (%, %)', V_ERROR_MSG, CLOSE_ACCESS_REC.MON_PLAN_ID, CLOSE_ACCESS_REC.RPT_PERIOD_ID;
				END IF;

			END IF;

		END IF;
	END LOOP;
	
	EXCEPTION
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS V_RESULT = PG_EXCEPTION_DETAIL,
                            V_ERROR_MSG = PG_EXCEPTION_HINT;
        V_RESULT := 'F';
        V_ERROR_MSG := SQLERRM ||
                       COALESCE(V_ERROR_MSG, '');

END
$BODY$;
