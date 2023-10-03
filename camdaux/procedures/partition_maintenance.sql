DROP PROCEDURE IF EXISTS camdaux.partition_maintenance();

CREATE OR REPLACE PROCEDURE camdaux.partition_maintenance(
) LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	t1 text;
	t2 record;
	curentYear integer := LEFT(CURRENT_DATE::text, 4)::numeric;
	tableList text[] := ARRAY[
		'daily_calibration',
		'daily_emission',
		'daily_fuel',
		'daily_test_summary',
		'derived_hrly_value',
		'emission_evaluation',
		'hrly_fuel_flow',
		'hrly_gas_flow_meter',
		'hrly_op_data',
		'hrly_param_fuel_flow',
		'long_term_fuel_flow',
		'mats_derived_hrly_value',
		'mats_monitor_hrly_value',
		'monitor_hrly_value',
		'nsps4t_annual',
		'nsps4t_compliance_period',
		'nsps4t_summary',
		'sampling_train',
		'sorbent_trap',
		'summary_value',
		'weekly_system_integrity',
		'weekly_test_summary'
	];
BEGIN
	-- DATAMART (ALL BY YEAR)
	CALL camdaux.manage_partitions_by_year('camddmw', 'allowance_holding_dim', curentYear+40);
	CALL camdaux.manage_partitions_by_year('camddmw', 'control_year_dim', curentYear+1);
	CALL camdaux.manage_partitions_by_year('camddmw', 'fuel_year_dim', curentYear+1);
	CALL camdaux.manage_partitions_by_year('camddmw', 'program_year_dim', curentYear+1);
	CALL camdaux.manage_partitions_by_year('camddmw', 'rep_year_dim', curentYear+1);
	CALL camdaux.manage_partitions_by_year('camddmw', 'unit_fact', curentYear+1);
	CALL camdaux.manage_partitions_by_year('camddmw', 'unit_type_year_dim', curentYear+1);

	-- APPORTIONED EMISSIONS
	CALL camdaux.manage_partitions_by_week('camddmw', 'hour_unit_data', curentYear+1);
	CALL camdaux.manage_partitions_by_week('camddmw', 'hour_unit_mats_data', curentYear+1);
	CALL camdaux.manage_partitions_by_week('camddmw', 'day_unit_data', curentYear+1);
	CALL camdaux.manage_partitions_by_month('camddmw', 'month_unit_data', curentYear+1);
	CALL camdaux.manage_partitions_by_quarter('camddmw', 'quarter_unit_data', curentYear+1);
	CALL camdaux.manage_partitions_by_year('camddmw', 'annual_unit_data', curentYear+1);
	CALL camdaux.manage_partitions_by_year('camddmw', 'ozone_unit_data', curentYear+1);

	-- EMISSIONS
	FOREACH t1 IN ARRAY tableList LOOP
		CALL camdaux.manage_partitions_by_rpt_period_id('camdecmps', t1.table_name, curentYear+1);
	END LOOP;

	-- EMISSIONS VIEWS
	FOR t2 IN (
		SELECT table_name FROM information_schema.tables
		WHERE table_schema = 'camdecmps' AND table_type = 'BASE TABLE' AND table_name like 'emission_view_%'
		AND table_name not like '%q1' AND table_name not like '%q2' AND table_name not like '%q3' AND table_name not like '%q4'
	) LOOP
		CALL camdaux.manage_partitions_by_rpt_period_id('camdecmps', t2.table_name, curentYear+1);
	END LOOP;
END
$BODY$;
