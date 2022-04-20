-- PROCEDURE: camddmw.hour_unit_mats_data_sync()

-- DROP PROCEDURE camddmw.hour_unit_mats_data_sync();

CREATE OR REPLACE PROCEDURE camddmw.hour_unit_mats_data_sync(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	DELETE FROM camddmw.hour_unit_mats_data hud
	USING (
		SELECT unit_id, op_date, op_hour
		FROM camddmw.hour_unit_mats_data_log
		WHERE sql_function = 'D'
		GROUP BY unit_id, op_date, op_hour
	) d
	WHERE hud.unit_id = d.unit_id
		AND hud.op_date = d.op_date
		AND hud.op_hour = d.op_hour;

	INSERT INTO camddmw.hour_unit_mats_data
	SELECT l.unit_id, l.op_date, l.op_hour, op_time, gload, sload, tload, heat_input, heat_input_measure_flg, hg_rate_eo, hg_rate_hi, hg_mass, hg_measure_flg, hcl_rate_eo, hcl_rate_hi, hcl_mass, hcl_measure_flg, hf_rate_eo, hf_rate_hi, hf_mass, hf_measure_flg, rpt_period_id, op_year, data_source, userid, add_date
	FROM camddmw.hour_unit_mats_data_log l
	JOIN (
		SELECT unit_id, op_date, op_hour, MAX(skey) AS skey
		FROM camddmw.hour_unit_mats_data_log
		WHERE sql_function = 'I'
		GROUP BY unit_id, op_date, op_hour
	) d USING(skey);

	UPDATE camddmw.hour_unit_mats_data hud
		SET op_time = l.op_time,
			gload = l.gload,
			sload = l.sload,
			tload = l.tload,
			heat_input = l.heat_input,
			heat_input_measure_flg = l.heat_input_measure_flg,
			hg_rate_eo = l.hg_rate_eo,
			hg_rate_hi = l.hg_rate_hi,
			hg_mass = l.hg_mass,
			hg_measure_flg = l.hg_measure_flg,
			hcl_rate_eo = l.hcl_rate_eo,
			hcl_rate_hi = l.hcl_rate_hi,
			hcl_mass = l.hcl_mass,
			hcl_measure_flg = l.hcl_measure_flg,
			hf_rate_eo = l.hf_rate_eo,
			hf_rate_hi = l.hf_rate_hi,
			hf_mass = l.hf_mass,
			hf_measure_flg = l.hf_measure_flg,
			rpt_period_id = l.rpt_period_id,
			op_year = l.op_year,
			data_source = l.data_source,
			userid = l.userid,
			add_date = l.add_date
	FROM camddmw.hour_unit_mats_data_log l
	JOIN (
		SELECT unit_id, op_date, op_hour, MAX(skey) AS skey
		FROM camddmw.hour_unit_mats_data_log
		WHERE sql_function = 'U'
		GROUP BY unit_id, op_date, op_hour
	) d USING(skey)
	WHERE hud.unit_id = l.unit_id
		AND hud.op_date = l.op_date
		AND hud.op_hour = l.op_hour;
END
$BODY$;
