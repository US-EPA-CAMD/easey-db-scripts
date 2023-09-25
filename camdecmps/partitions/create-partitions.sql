DO $$
DECLARE
  t1 text;
  t2 record;
  rptPeriodId integer := 1;
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
  --DAILY_BACKSTOP IS NEW FOR MATS 2.0/GNP SO NO DATA REPORTED UNTIL 2024
  --DAILY_BACKSTOP 2023 PARTITIONS ARE ONLY NEEDED FOR TESTING AND VERIFICATION
  CREATE TABLE IF NOT EXISTS camdecmps.daily_backstop_2023_q1 PARTITION OF camdecmps.daily_backstop
	FOR VALUES FROM (121) TO (122);
  CREATE TABLE IF NOT EXISTS camdecmps.daily_backstop_2023_q2 PARTITION OF camdecmps.daily_backstop
	FOR VALUES FROM (122) TO (123);
  CREATE TABLE IF NOT EXISTS camdecmps.daily_backstop_2023_q3 PARTITION OF camdecmps.daily_backstop
	FOR VALUES FROM (123) TO (124);
  CREATE TABLE IF NOT EXISTS camdecmps.daily_backstop_2023_q4 PARTITION OF camdecmps.daily_backstop
	FOR VALUES FROM (124) TO (125);
  CREATE TABLE IF NOT EXISTS camdecmps.daily_backstop_2024_q1 PARTITION OF camdecmps.daily_backstop
	FOR VALUES FROM (125) TO (126);
  CREATE TABLE IF NOT EXISTS camdecmps.daily_backstop_2024_q2 PARTITION OF camdecmps.daily_backstop
	FOR VALUES FROM (126) TO (127);
  CREATE TABLE IF NOT EXISTS camdecmps.daily_backstop_2024_q3 PARTITION OF camdecmps.daily_backstop
	FOR VALUES FROM (127) TO (128);
  CREATE TABLE IF NOT EXISTS camdecmps.daily_backstop_2024_q4 PARTITION OF camdecmps.daily_backstop
	FOR VALUES FROM (128) TO (129);

	FOREACH t1 IN ARRAY tableList LOOP
		FOR year IN 1993..2024 LOOP
			FOR qtr IN 1..4 LOOP
				rptPeriodId = ((year - 1993) * 4) + qtr;
				EXECUTE format('
					CREATE TABLE IF NOT EXISTS camdecmps.%s_%s_q%s PARTITION OF camdecmps.%s
					FOR VALUES FROM (%s) TO (%s);
				', t1, year, qtr, t1, rptPeriodId, rptPeriodId+1);
			END LOOP;
		END LOOP;
	END LOOP;

	FOR t2 IN (
		SELECT table_name FROM information_schema.tables
		WHERE table_schema = 'camdecmps' AND table_type = 'BASE TABLE' AND table_name like 'emission_view_%'
		AND table_name not like '%q1' AND table_name not like '%q2' AND table_name not like '%q3' AND table_name not like '%q4'
	) LOOP
		FOR year IN 1993..2024 LOOP
			FOR qtr IN 1..4 LOOP
				rptPeriodId = ((year - 1993) * 4) + qtr;
				EXECUTE format('
					CREATE TABLE IF NOT EXISTS camdecmps.%s_%s_q%s PARTITION OF camdecmps.%s
					FOR VALUES FROM (%s) TO (%s);
				', t2.table_name, year, qtr, t2.table_name, rptPeriodId, rptPeriodId+1);
			END LOOP;
		END LOOP;
	END LOOP;
END $$;
