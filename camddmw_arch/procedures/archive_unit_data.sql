-- PROCEDURE: camddmw_arch.archive_unit_data(integer)

-- DROP PROCEDURE camddmw_arch.archive_unit_data(integer);

CREATE OR REPLACE PROCEDURE camddmw_arch.archive_unit_data(
	year integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	-- CREATE ARCHIVE PARTITIONS FOR THE SPECIFIED YEAR
	CALL camddmw_arch.create_unit_data_a_partitions(year);

	--INSERT RECORDS INTO ARCHIVE TABLES FROM LIVE TABLES
	INSERT INTO camddmw_arch.ozone_unit_data_a(
		unit_id, op_year, count_op_time, sum_op_time, gload, sload, tload, heat_input, so2_mass, so2_mass_lbs, so2_rate, so2_rate_sum, so2_rate_count, co2_mass, co2_rate, co2_rate_sum, co2_rate_count, nox_mass, nox_mass_lbs, nox_rate, nox_rate_sum, nox_rate_count, num_months_reported, data_source, userid, add_date
	) SELECT * FROM camddmw.ozone_unit_data WHERE op_year = year;

	INSERT INTO camddmw_arch.annual_unit_data_a(
		unit_id, op_year, count_op_time, sum_op_time, gload, sload, tload, heat_input, so2_mass, so2_mass_lbs, so2_rate, so2_rate_sum, so2_rate_count, co2_mass, co2_rate, co2_rate_sum, co2_rate_count, nox_mass, nox_mass_lbs, nox_rate, nox_rate_sum, nox_rate_count, num_months_reported, data_source, userid, add_date
	) SELECT * FROM camddmw.annual_unit_data WHERE op_year = year;
	
	INSERT INTO camddmw_arch.quarter_unit_data_a(
		unit_id, op_year, op_quarter, count_op_time, sum_op_time, gload, sload, tload, heat_input, so2_mass, so2_mass_lbs, so2_rate, so2_rate_sum, so2_rate_count, co2_mass, co2_rate, co2_rate_sum, co2_rate_count, nox_mass, nox_mass_lbs, nox_rate, nox_rate_sum, nox_rate_count, num_months_reported, rpt_period_id, data_source, userid, add_date
	) SELECT * FROM camddmw.quarter_unit_data WHERE op_year = year;

	INSERT INTO camddmw_arch.month_unit_data_a(
		unit_id, op_year, op_month, month_description, count_op_time, sum_op_time, gload, sload, tload, heat_input, so2_mass, so2_mass_lbs, so2_rate, so2_rate_sum, so2_rate_count, co2_mass, co2_rate, co2_rate_sum, co2_rate_count, nox_mass, nox_mass_lbs, nox_rate, nox_rate_sum, nox_rate_count, rpt_period_id, op_quarter, data_source, userid, add_date
	) SELECT * FROM camddmw.month_unit_data WHERE op_year = year;

	INSERT INTO camddmw_arch.day_unit_data_a(
		unit_id, op_date, count_op_time, sum_op_time, gload, sload, tload, heat_input, so2_mass, so2_mass_lbs, so2_rate, so2_rate_sum, so2_rate_count, co2_mass, co2_rate, co2_rate_sum, co2_rate_count, nox_mass, nox_mass_lbs, nox_rate, nox_rate_sum, nox_rate_count, rpt_period_id, op_year, op_month, data_source, userid, add_date
	) SELECT * FROM camddmw.day_unit_data WHERE op_year = year;

	INSERT INTO camddmw_arch.hour_unit_data_a(
		unit_id, op_date, op_hour, op_time, gload, sload, tload, heat_input, heat_input_measure_flg, so2_mass, so2_mass_measure_flg, so2_rate, so2_rate_measure_flg, co2_mass, co2_mass_measure_flg, co2_rate, co2_rate_measure_flg, nox_mass, nox_mass_measure_flg, nox_rate, nox_rate_measure_flg, rpt_period_id, op_year, data_source, userid, add_date
	) SELECT * FROM camddmw.hour_unit_data WHERE op_year = year;

	INSERT INTO camddmw_arch.hour_unit_mats_data_a(
		unit_id, op_date, op_hour, op_time, gload, sload, tload, heat_input, heat_input_measure_flg, hg_rate_eo, hg_rate_hi, hg_mass, hg_measure_flg, hcl_rate_eo, hcl_rate_hi, hcl_mass, hcl_measure_flg, hf_rate_eo, hf_rate_hi, hf_mass, hf_measure_flg, rpt_period_id, op_year, data_source, userid, add_date
	) SELECT * FROM camddmw.hour_unit_mats_data WHERE op_year = year;
END
$BODY$;
