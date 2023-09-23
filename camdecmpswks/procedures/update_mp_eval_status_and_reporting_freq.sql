-- PROCEDURE: camdecmpswks.update_mp_eval_status_and_reporting_freq()

-- DROP PROCEDURE camdecmpswks.update_mp_eval_status_and_reporting_freq();

CREATE OR REPLACE PROCEDURE camdecmpswks.update_mp_eval_status_and_reporting_freq(
)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
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

-----------------------------------------------------------------------------------------------------------------------------

	--DELETE INVALID OS MPRF RECORD
	DELETE FROM camdecmpswks.monitor_plan_reporting_freq
	WHERE mon_plan_rf_id IN (
		SELECT mon_plan_rf_id FROM (
			SELECT DISTINCT unit_id
			FROM camdaux.inventory_status_log
			WHERE data_type_cd = 'UNIT_PROGRAM'
		) d
		JOIN camdecmps.monitor_location ml USING(unit_id)
		JOIN camdecmps.monitor_plan_location mpl USING(mon_loc_id)
		JOIN camdecmps.monitor_plan_reporting_freq mprf USING(mon_plan_id)
		JOIN camdecmps.monitor_plan mp USING(mon_plan_id)
		JOIN camd.unit_program up USING(unit_id)
		JOIN camdmd.program_code newPrg USING(prg_cd)
		JOIN camdecmpsmd.reporting_period mprfBeginPrd ON mprf.begin_rpt_period_id = mprfBeginPrd.rpt_period_id
		LEFT JOIN camdecmpsmd.reporting_period mprfEndPrd ON mprf.end_rpt_period_id = mprfEndPrd.rpt_period_id
		WHERE newPrg.os_ind = 0
		AND mprf.report_freq_cd = 'OS'
		AND mp.end_rpt_period_id IS null
		AND mprfBeginPrd.begin_date <= up.unit_monitor_cert_begin_date AND (
			mprf.end_rpt_period_id IS null OR
			mprfEndPrd.end_date > (
				SELECT end_date FROM camdecmpsmd.reporting_period
				WHERE up.unit_monitor_cert_begin_date BETWEEN begin_date AND end_date
			)
		)
	);

	--UPDATE MPRF RECORD TO END Q4 OF YEAR PRIOR TO UMCBD
	UPDATE camdecmpswks.monitor_plan_reporting_freq
	SET end_rpt_period_id = (
			SELECT rpt_period_id FROM camdecmpsmd.reporting_period
			WHERE calendar_year = left((up.unit_monitor_cert_begin_date::date - interval '1 year')::text, 4)::numeric
			AND quarter = 4
		),
		userid = 'SYSTEM',
		update_date = current_timestamp
	WHERE mon_plan_rf_id IN (
		SELECT mon_plan_rf_id FROM (
			SELECT DISTINCT unit_id
			FROM camdaux.inventory_status_log
			WHERE data_type_cd = 'UNIT_PROGRAM'
		) d
		JOIN camdecmps.monitor_location ml USING(unit_id)
		JOIN camdecmps.monitor_plan_location mpl USING(mon_loc_id)
		JOIN camdecmps.monitor_plan_reporting_freq mprf USING(mon_plan_id)
		JOIN camdecmps.monitor_plan mp USING(mon_plan_id)
		JOIN camd.unit_program up USING(unit_id)
		JOIN camdmd.program_code newPrg USING(prg_cd)
		JOIN camdecmpsmd.reporting_period mprfBeginPrd ON mprf.begin_rpt_period_id = mprfBeginPrd.rpt_period_id
		LEFT JOIN camdecmpsmd.reporting_period mprfEndPrd ON mprf.end_rpt_period_id = mprfEndPrd.rpt_period_id
		WHERE newPrg.os_ind = 0
		AND mprf.report_freq_cd = 'OS'
		AND mp.end_rpt_period_id IS null
		AND mprfBeginPrd.begin_date > up.unit_monitor_cert_begin_date AND (
			mprf.end_rpt_period_id IS null OR
			mprfEndPrd.end_date > (
				SELECT end_date FROM camdecmpsmd.reporting_period
				WHERE up.unit_monitor_cert_begin_date BETWEEN begin_date AND end_date
			)
		)
	);

	--ADD NEW MPRF Q RECORD
	INSERT INTO camdecmpswks.monitor_plan_reporting_freq(
		mon_plan_rf_id, mon_plan_id, report_freq_cd, end_rpt_period_id, begin_rpt_period_id, userid, add_date, update_date
	)
	SELECT
		uuid_generate_v4(),
		mp.mon_plan_id,
		'Q',
		null,
		(SELECT rpt_period_id FROM camdecmpsmd.reporting_period WHERE up.unit_monitor_cert_begin_date BETWEEN begin_date AND end_date),
		'SYSTEM',
		current_timestamp,
		current_timestamp
	FROM (
		SELECT DISTINCT unit_id
		FROM camdaux.inventory_status_log
		WHERE data_type_cd = 'UNIT_PROGRAM'
	) d
	JOIN camdecmps.monitor_location ml USING(unit_id)
	JOIN camdecmps.monitor_plan_location mpl USING(mon_loc_id)
	JOIN camdecmps.monitor_plan_reporting_freq mprf USING(mon_plan_id)
	JOIN camdecmps.monitor_plan mp USING(mon_plan_id)
	JOIN camd.unit_program up USING(unit_id)
	JOIN camdmd.program_code newPrg USING(prg_cd)
	JOIN camdecmpsmd.reporting_period mprfBeginPrd ON mprf.begin_rpt_period_id = mprfBeginPrd.rpt_period_id
	LEFT JOIN camdecmpsmd.reporting_period mprfEndPrd ON mprf.end_rpt_period_id = mprfEndPrd.rpt_period_id
	WHERE newPrg.os_ind = 0
	AND mprf.report_freq_cd = 'OS'
	AND mp.end_rpt_period_id IS null
	AND mprfBeginPrd.begin_date > up.unit_monitor_cert_begin_date AND (
		mprf.end_rpt_period_id IS null OR
		mprfEndPrd.end_date > (
			SELECT end_date FROM camdecmpsmd.reporting_period
			WHERE up.unit_monitor_cert_begin_date BETWEEN begin_date AND end_date
		)
	);

	UPDATE camdecmpswks.monitor_plan
	SET needs_eval_flg = 'Y',
		eval_status_cd = 'EVAL',
		userid = 'SYSTEM',
		update_date = current_timestamp
	WHERE mon_plan_id IN (
		SELECT mon_plan_id FROM (
			SELECT DISTINCT unit_id
			FROM camdaux.inventory_status_log
			WHERE data_type_cd IN ('INVENTORY')
		) d
		JOIN camdecmps.monitor_location ml USING(unit_id)
		JOIN camdecmps.monitor_plan_location mpl USING(mon_loc_id)
		JOIN camdecmps.monitor_plan mp USING(mon_plan_id)
		WHERE mp.end_rpt_period_id IS null
	);

	UPDATE camdecmpswks.monitor_plan
	SET needs_eval_flg = 'Y',
		eval_status_cd = 'EVAL',
		userid = 'SYSTEM',
		update_date = current_timestamp
	WHERE mon_plan_id IN (
		SELECT mon_plan_id FROM (
			SELECT DISTINCT unit_id
			FROM camdaux.inventory_status_log
			WHERE data_type_cd = 'UNIT_PROGRAM'
		) d
		JOIN camdecmps.monitor_location ml USING(unit_id)
		JOIN camdecmps.monitor_plan_location mpl USING(mon_loc_id)
		JOIN camdecmps.monitor_plan_reporting_freq mprf USING(mon_plan_id)
		JOIN camdecmps.monitor_plan mp USING(mon_plan_id)
		JOIN camd.unit_program up USING(unit_id)
		JOIN camdmd.program_code newPrg USING(prg_cd)
		JOIN camdecmpsmd.reporting_period mprfBeginPrd ON mprf.begin_rpt_period_id = mprfBeginPrd.rpt_period_id
		LEFT JOIN camdecmpsmd.reporting_period mprfEndPrd ON mprf.end_rpt_period_id = mprfEndPrd.rpt_period_id
		WHERE newPrg.os_ind = 0
		AND mprf.report_freq_cd = 'OS'
		AND mp.end_rpt_period_id IS null
		AND (
			mprf.end_rpt_period_id IS null OR
			mprfEndPrd.end_date > (
				SELECT end_date FROM camdecmpsmd.reporting_period
				WHERE up.unit_monitor_cert_begin_date BETWEEN begin_date AND end_date
			)
		)
	);
END;
$BODY$;