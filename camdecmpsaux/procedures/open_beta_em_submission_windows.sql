-- DROP PROCEDURE camdecmpsaux.open_beta_em_submission_windows();

CREATE OR REPLACE PROCEDURE camdecmpsaux.open_beta_em_submission_windows()
 LANGUAGE plpgsql
AS $procedure$
DECLARE
	vrptperiodid numeric;
	i            int;			
BEGIN			
	--get latest report period for current date 
	select (rpt_period_id -1) into vrptperiodid
	  from CAMDECMPSMD.REPORTING_PERIOD 
	 where CURRENT_DATE between begin_date and end_date;
	 
	-- loop over all reporting periods starting with 2024 Q4 thru the latest reporting period
	for i in 128..vrptperiodid LOOP
		INSERT INTO camdecmpsaux.em_submission_access(
			mon_plan_id,
			rpt_period_id,
			access_begin_date,
			access_end_date,
			em_sub_type_cd,
			resub_explanation,
			userid,
			add_date,
			update_date,
			em_status_cd,
			sub_availability_cd
		)
		SELECT
			mon_plan_id,
			i,
			CURRENT_DATE,
			CURRENT_DATE + interval '30 days',
			'RQRESUB',
			'opening window for ecmps 2.0 BETA testing',
			'WINMGMT',
			current_timestamp,
			current_timestamp,
			'APPRVD',
			'REQUIRE'
		FROM camdecmps.monitor_plan
		WHERE end_rpt_period_id IS NULL
		AND mon_plan_id NOT IN (
			SELECT DISTINCT mon_plan_id
			FROM camdecmpsaux.em_submission_access
			WHERE rpt_period_id = i
			AND em_status_cd IN ('PENDING','APPRVD')
			AND sub_availability_cd IN ('GRANTED','REQUIRE')
		); 
		
		UPDATE camdecmpsaux.em_submission_access
		SET access_end_date = CURRENT_DATE + interval '30 days', userid = 'WINMGMT', update_date = current_timestamp
		WHERE rpt_period_id = i
		AND em_status_cd IN ('PENDING','APPRVD')
		AND sub_availability_cd IN ('GRANTED','REQUIRE');
	END LOOP;		
EXCEPTION WHEN OTHERS THEN 
	RAISE NOTICE 'Error opening em submission windows: %', SQLERRM;
END
$procedure$
;;

