-- PROCEDURE: camddmw.day_unit_data_sync()

DROP PROCEDURE IF EXISTS camddmw.day_unit_data_sync();

CREATE OR REPLACE PROCEDURE camddmw.day_unit_data_sync(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	DELETE FROM camddmw.day_unit_data dud
	USING (
		SELECT unit_id, op_date
		FROM camddmw.day_unit_data_log
		WHERE sql_function = 'D'
		GROUP BY unit_id, op_date
	) d
	WHERE dud.unit_id = d.unit_id
		AND dud.op_date = d.op_date;

	INSERT INTO camddmw.day_unit_data
	SELECT l.unit_id, l.op_date, count_op_time, sum_op_time, gload, sload, tload, heat_input, so2_mass, so2_mass_lbs, so2_rate, so2_rate_sum, so2_rate_count, co2_mass, co2_rate, co2_rate_sum, co2_rate_count, nox_mass, nox_mass_lbs, nox_rate, nox_rate_sum, nox_rate_count, rpt_period_id, op_year, op_month, data_source, userid, add_date
	FROM camddmw.day_unit_data_log l
	JOIN (
		SELECT unit_id, op_date, MAX(skey) AS skey
		FROM camddmw.day_unit_data_log
		WHERE sql_function = 'I'
		GROUP BY unit_id, op_date
	) d USING(skey);

	UPDATE camddmw.day_unit_data dud
		SET count_op_time = l.count_op_time,
			sum_op_time = l.sum_op_time,
			gload = l.gload,
			sload = l.sload,
			tload = l.tload,
			heat_input = l.heat_input,
			so2_mass = l.so2_mass,
			so2_mass_lbs = l.so2_mass_lbs,
			so2_rate = l.so2_rate,
			so2_rate_sum = l.so2_rate_sum,
			so2_rate_count = l.so2_rate_count,
			co2_mass = l.co2_mass,
			co2_rate = l.co2_rate,
			co2_rate_sum = l.co2_rate_sum,
			co2_rate_count = l.co2_rate_count,
			nox_mass = l.nox_mass,
			nox_mass_lbs = l.nox_mass_lbs,
			nox_rate = l.nox_rate,
			nox_rate_sum = l.nox_rate_sum,
			nox_rate_count = l.nox_rate_count,
			rpt_period_id = l.rpt_period_id,			
			op_year = l.op_year,
			op_month = l.op_month,
			data_source = l.data_source,
			userid = l.userid,
			add_date = l.add_date
	FROM camddmw.day_unit_data_log l
	JOIN (
		SELECT unit_id, op_date, MAX(skey) AS skey
		FROM camddmw.day_unit_data_log
		WHERE sql_function = 'U'
		GROUP BY unit_id, op_date
	) d USING(skey)
	WHERE dud.unit_id = d.unit_id
		AND dud.op_date = d.op_date;
END
$BODY$;
