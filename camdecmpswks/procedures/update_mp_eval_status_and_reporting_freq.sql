-- PROCEDURE: camdecmpswks.update_mp_eval_status_and_reporting_freq()

DROP PROCEDURE IF EXISTS camdecmpswks.update_mp_eval_status_and_reporting_freq();

CREATE OR REPLACE PROCEDURE camdecmpswks.update_mp_eval_status_and_reporting_freq()
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	I record;
	V_USERID text := 'SYSTEM';
	V_RPT_PERIOD_ID numeric := 0;
	V_CURRENT_DATETIME timestamp without time zone := CURRENT_TIMESTAMP;
BEGIN
/*
	--UNIT: 91310
	--FAC_ID: 7554
	--MP: HWLTJDVZQN-7EB726799BA74A8B801B9D515177E184
	--Begin Period: 2019 Q4 started 2019-10-01
	--ARP added with UMCBD 2023-04-12
	INSERT INTO camdaux.inventory_status_log(
		inventory_status_log_id, fac_id, unit_id, data_type_cd, userid, last_updated)
	VALUES (1, 7554, 91310, 'UNIT_PROGRAM', 'jwhitehead', current_timestamp);
	INSERT INTO camd.unit_program(
		up_id, unit_id, prg_id, prg_cd, class_cd, app_status_cd, optin_ind, def_ind, def_end_date, up_comment, unit_monitor_cert_begin_date, unit_monitor_cert_deadline, emissions_recording_begin_date, trueup_begin_year, end_date, non_egu_ind, nonstandard_cd, nonstandard_comment, so2_affect_year, so2_phase, userid, add_date, update_date)
	VALUES (
		(SELECT max(up_id)+1 FROM camd.unit_program),--53421
		91310, 1, 'ARP', 'P2', 'I', 0, 0, null, null, '2023-04-12', null, null, null, null, 0, null, null, null, null, 'jwhitehead', current_timestamp, current_timestamp
	);

	--UNIT: 91154
	--FAC_ID: 8107
	--MP: NAES003755-19BAD4D2C2EC47B699AEC6D6E239BDC6
	--Begin Period: 2021 Q2 started 2021-04-01
	--ARP added with UMCBD 2021-01-01
	INSERT INTO camdaux.inventory_status_log(
		inventory_status_log_id, fac_id, unit_id, data_type_cd, userid, last_updated)
	VALUES (2, 8107, 91154, 'UNIT_PROGRAM', 'jwhitehead', current_timestamp);
	INSERT INTO camd.unit_program(
		up_id, unit_id, prg_id, prg_cd, class_cd, app_status_cd, optin_ind, def_ind, def_end_date, up_comment, unit_monitor_cert_begin_date, unit_monitor_cert_deadline, emissions_recording_begin_date, trueup_begin_year, end_date, non_egu_ind, nonstandard_cd, nonstandard_comment, so2_affect_year, so2_phase, userid, add_date, update_date)
	VALUES (
		(SELECT max(up_id)+1 FROM camd.unit_program),--53422
		91154, 1, 'ARP', 'P2', 'I', 0, 0, null, null, '2021-01-01', null, null, null, null, 0, null, null, null, null, 'jwhitehead', current_timestamp, current_timestamp
	);

	--INVENTORY CHANGE
	INSERT INTO camdaux.inventory_status_log(
		inventory_status_log_id, fac_id, unit_id, data_type_cd, userid, last_updated)
	VALUES (3, 1, 1, 'INVENTORY', 'jwhitehead', current_timestamp);
*/
-----------------------------------------------------------------------------------------------------------------------------
	--Update this unit's MP to have "Q" as the report freq...
	FOR I IN (
		SELECT
			MPRF.MON_PLAN_ID,
			MPRF.MON_PLAN_RF_ID,
			(RPB.CALENDAR_YEAR::text || RPB.QUARTER::text)::numeric AS MPRF_BEGIN_YEAR_QTR,
			UMCBD.YEAR_QTR AS UMCBD_YEAR_QTR
		FROM camdecmps.MONITOR_PLAN_REPORTING_FREQ AS MPRF
		JOIN (
			SELECT DISTINCT
				ISL.UNIT_ID,
				MP.MON_PLAN_ID, (
					SELECT (CALENDAR_YEAR::text || QUARTER::text)::numeric
					FROM camdecmpsmd.REPORTING_PERIOD
					WHERE UP.UNIT_MONITOR_CERT_BEGIN_DATE BETWEEN BEGIN_DATE AND END_DATE
				) AS YEAR_QTR
			FROM camdecmps.MONITOR_PLAN AS MP
			JOIN camdecmps.MONITOR_PLAN_LOCATION AS MPL USING(MON_PLAN_ID)
			JOIN camdecmps.MONITOR_LOCATION AS ML USING(MON_LOC_ID)
			JOIN camdaux.INVENTORY_STATUS_LOG AS ISL USING(UNIT_ID)
			JOIN camd.UNIT_PROGRAM AS UP USING(UNIT_ID)
			JOIN camdmd.PROGRAM_CODE AS PC USING(PRG_CD)
			WHERE ISL.DATA_TYPE_CD = 'UNIT_PROGRAM' AND PC.OS_IND <> 1
			AND MP.END_RPT_PERIOD_ID IS NULL
		) AS UMCBD ON MPRF.MON_PLAN_ID = UMCBD.MON_PLAN_ID
		JOIN camdecmpsmd.REPORTING_PERIOD AS RPB
			ON MPRF.BEGIN_RPT_PERIOD_ID = RPB.RPT_PERIOD_ID
		LEFT JOIN camdecmpsmd.REPORTING_PERIOD AS RPE
			ON MPRF.END_RPT_PERIOD_ID = RPE.RPT_PERIOD_ID
		WHERE MPRF.REPORT_FREQ_CD = 'OS' AND (
			(RPE.CALENDAR_YEAR::text || RPE.QUARTER::text)::numeric > UMCBD.YEAR_QTR OR
			RPE.CALENDAR_YEAR IS NULL
		)
	) LOOP
		IF (I.UMCBD_YEAR_QTR) < I.MPRF_BEGIN_YEAR_QTR THEN
			--OS record exists entirely after the UMCBD; delete this record
			DELETE FROM camdecmpswks.MONITOR_PLAN_REPORTING_FREQ
			WHERE MON_PLAN_RF_ID = I.MON_PLAN_RF_ID;
		ELSE
			SELECT RPT_PERIOD_ID INTO V_RPT_PERIOD_ID
			FROM camdecmpsmd.REPORTING_PERIOD
			WHERE CALENDAR_YEAR = LEFT(I.UMCBD_YEAR_QTR::text, 4)::numeric - 1
			AND QUARTER = 4;

			-- record overlaps the UMCBD; end this record
			UPDATE camdecmpswks.MONITOR_PLAN_REPORTING_FREQ
			SET END_RPT_PERIOD_ID = V_RPT_PERIOD_ID,
				USERID = V_USERID,
				UPDATE_DATE = V_CURRENT_DATETIME
			WHERE MON_PLAN_RF_ID = I.MON_PLAN_RF_ID;
		END IF;

		--add a new Q record starting with the quarter of the UMCBD
		SELECT RPT_PERIOD_ID INTO V_RPT_PERIOD_ID
		FROM camdecmpsmd.REPORTING_PERIOD
		WHERE CALENDAR_YEAR = LEFT(I.UMCBD_YEAR_QTR::text, 4)::numeric
		AND QUARTER = RIGHT(I.UMCBD_YEAR_QTR::text, 1)::numeric;

		INSERT INTO camdecmpswks.MONITOR_PLAN_REPORTING_FREQ(
			MON_PLAN_RF_ID,
			MON_PLAN_ID,
			REPORT_FREQ_CD,
			END_RPT_PERIOD_ID,
			BEGIN_RPT_PERIOD_ID,
			USERID,
			ADD_DATE,
			UPDATE_DATE
		)
		VALUES(
			uuid_generate_v4(),
			I.MON_PLAN_ID,
			'Q',
			NULL,
			V_RPT_PERIOD_ID,
			V_USERID,
			V_CURRENT_DATETIME,
			NULL
		);

		UPDATE camdecmpswks.MONITOR_PLAN
		SET needs_eval_flg = 'Y',
			eval_status_cd = 'EVAL',
			submission_availability_cd = 'GRANTED',
			userid = V_USERID,
			update_date = V_CURRENT_DATETIME
		WHERE MON_PLAN_ID = I.MON_PLAN_ID;
	END LOOP;

	UPDATE camdecmpswks.MONITOR_PLAN
	SET needs_eval_flg = 'Y',
		eval_status_cd = 'EVAL',
		submission_availability_cd = 'GRANTED',
		userid = V_USERID,
		update_date = V_CURRENT_DATETIME
	WHERE mon_plan_id IN (
		SELECT mon_plan_id FROM (
			SELECT DISTINCT unit_id
			FROM camdaux.inventory_status_log
			WHERE data_type_cd IN ('INVENTORY')
		) AS d
		JOIN camdecmps.monitor_location AS ml USING(unit_id)
		JOIN camdecmps.monitor_plan_location AS mpl USING(mon_loc_id)
		JOIN camdecmps.monitor_plan AS mp USING(mon_plan_id)
		WHERE mp.end_rpt_period_id IS null
	);
END
$BODY$;
