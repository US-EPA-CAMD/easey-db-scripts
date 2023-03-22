-- PROCEDURE: camddmw.hour_unit_data_sync()

DROP PROCEDURE IF EXISTS camddmw.hour_unit_data_sync();

CREATE OR REPLACE PROCEDURE camddmw.hour_unit_data_sync(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	DELETE FROM camddmw.hour_unit_data hud
	USING (
		SELECT unit_id, op_date, op_hour
		FROM camddmw.hour_unit_data_log
		WHERE sql_function = 'D'
		GROUP BY unit_id, op_date, op_hour
	) d
	WHERE hud.unit_id = d.unit_id
		AND hud.op_date = d.op_date
		AND hud.op_hour = d.op_hour;

	INSERT INTO camddmw.hour_unit_data
	SELECT l.unit_id, l.op_date, l.op_hour, op_time, gload, sload, tload, heat_input, heat_input_measure_flg, so2_mass, so2_mass_measure_flg, so2_rate, so2_rate_measure_flg, co2_mass, co2_mass_measure_flg, co2_rate, co2_rate_measure_flg, nox_mass, nox_mass_measure_flg, nox_rate, nox_rate_measure_flg, rpt_period_id, op_year, data_source, userid, add_date
	FROM camddmw.hour_unit_data_log l
	JOIN (
		SELECT unit_id, op_date, op_hour, MAX(skey) AS skey
		FROM camddmw.hour_unit_data_log
		WHERE sql_function = 'I'
		GROUP BY unit_id, op_date, op_hour
	) d USING(skey);

	UPDATE camddmw.hour_unit_data hud
		SET op_time = l.op_time,
			gload = l.gload,
			sload = l.sload,
			tload = l.tload,
			heat_input = l.heat_input,
			heat_input_measure_flg = l.heat_input_measure_flg,
			so2_mass = l.so2_mass,
			so2_mass_measure_flg = l.so2_mass_measure_flg,
			so2_rate = l.so2_rate,
			so2_rate_measure_flg = l.so2_rate_measure_flg,
			co2_mass = l.co2_mass,
			co2_mass_measure_flg = l.co2_mass_measure_flg,
			co2_rate = l.co2_rate,
			co2_rate_measure_flg = l.co2_rate_measure_flg,
			nox_mass = l.nox_mass,
			nox_mass_measure_flg = l.nox_mass_measure_flg,
			nox_rate = l.nox_rate,
			nox_rate_measure_flg = l.nox_rate_measure_flg,
			rpt_period_id = l.rpt_period_id,
			op_year = l.op_year,
			data_source = l.data_source,
			userid = l.userid,
			add_date = l.add_date
	FROM camddmw.hour_unit_data_log l
	JOIN (
		SELECT unit_id, op_date, op_hour, MAX(skey) AS skey
		FROM camddmw.hour_unit_data_log
		WHERE sql_function = 'U'
		GROUP BY unit_id, op_date, op_hour
	) d USING(skey)
	WHERE hud.unit_id = l.unit_id
		AND hud.op_date = l.op_date
		AND hud.op_hour = l.op_hour;
END
$BODY$;
