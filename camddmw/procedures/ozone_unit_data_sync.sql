-- PROCEDURE: camddmw.ozone_unit_data_sync()

DROP PROCEDURE IF EXISTS camddmw.ozone_unit_data_sync();

CREATE OR REPLACE PROCEDURE camddmw.ozone_unit_data_sync()
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	DELETE FROM camddmw.ozone_unit_data oud
	USING (
		SELECT unit_id, op_year
		FROM camddmw.ozone_unit_data_log
		WHERE sql_function = 'D'
		GROUP BY unit_id, op_year
	) d
	WHERE oud.unit_id = d.unit_id
		AND oud.op_year = d.op_year;

	INSERT INTO camddmw.ozone_unit_data
	SELECT l.unit_id, l.op_year, count_op_time, sum_op_time, gload, sload, tload, heat_input, so2_mass, so2_mass_lbs, so2_rate, so2_rate_sum, so2_rate_count, co2_mass, co2_rate, co2_rate_sum, co2_rate_count, nox_mass, nox_mass_lbs, nox_rate, nox_rate_sum, nox_rate_count, num_months_reported, data_source, userid, add_date
	FROM camddmw.ozone_unit_data_log l
	JOIN (
		SELECT unit_id, op_year, MAX(skey) AS skey
		FROM camddmw.ozone_unit_data_log
		WHERE sql_function = 'I'
		GROUP BY unit_id, op_year
	) d USING(skey);

	UPDATE camddmw.ozone_unit_data oud
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
			num_months_reported = l.num_months_reported,
			data_source = l.data_source,
			userid = l.userid,
			add_date = l.add_date
	FROM camddmw.ozone_unit_data_log l
	JOIN (
		SELECT unit_id, op_year, MAX(skey) AS skey
		FROM camddmw.ozone_unit_data_log
		WHERE sql_function = 'U'
		GROUP BY unit_id, op_year
	) d USING(skey)
	WHERE oud.unit_id = l.unit_id
		AND oud.op_year = l.op_year;
END
$BODY$;
