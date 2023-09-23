do $$
declare
	col record;
begin
	ALTER TABLE IF EXISTS camddmw.allowance_holding_dim ALTER COLUMN userid TYPE character varying(160);
	ALTER TABLE IF EXISTS camddmw.annual_unit_data ALTER COLUMN userid TYPE character varying(160);
	ALTER TABLE IF EXISTS camddmw.control_year_dim ALTER COLUMN userid TYPE character varying(160);
	ALTER TABLE IF EXISTS camddmw.day_unit_data ALTER COLUMN userid TYPE character varying(160);
	ALTER TABLE IF EXISTS camddmw.fuel_year_dim ALTER COLUMN userid TYPE character varying(160);
	ALTER TABLE IF EXISTS camddmw.hour_unit_data ALTER COLUMN userid TYPE character varying(160);
	ALTER TABLE IF EXISTS camddmw.hour_unit_mats_data ALTER COLUMN userid TYPE character varying(160);
	ALTER TABLE IF EXISTS camddmw.month_unit_data ALTER COLUMN userid TYPE character varying(160);
	ALTER TABLE IF EXISTS camddmw.ozone_unit_data ALTER COLUMN userid TYPE character varying(160);
	ALTER TABLE IF EXISTS camddmw.program_year_dim ALTER COLUMN userid TYPE character varying(160);
	ALTER TABLE IF EXISTS camddmw.quarter_unit_data ALTER COLUMN userid TYPE character varying(160);
	ALTER TABLE IF EXISTS camddmw.rep_year_dim ALTER COLUMN userid TYPE character varying(160);
	ALTER TABLE IF EXISTS camddmw.transaction_block_dim ALTER COLUMN userid TYPE character varying(160);
	ALTER TABLE IF EXISTS camddmw.transaction_fact ALTER COLUMN userid TYPE character varying(160);
	ALTER TABLE IF EXISTS camddmw.unit_fact ALTER COLUMN userid TYPE character varying(160);
	ALTER TABLE IF EXISTS camddmw.unit_type_year_dim ALTER COLUMN userid TYPE character varying(160);
	ALTER TABLE IF EXISTS camddmw_arch.annual_unit_data_a ALTER COLUMN userid TYPE character varying(160);
	ALTER TABLE IF EXISTS camddmw_arch.day_unit_data_a ALTER COLUMN userid TYPE character varying(160);
	ALTER TABLE IF EXISTS camddmw_arch.hour_unit_data_a ALTER COLUMN userid TYPE character varying(160);
	ALTER TABLE IF EXISTS camddmw_arch.hour_unit_mats_data_a ALTER COLUMN userid TYPE character varying(160);
	ALTER TABLE IF EXISTS camddmw_arch.month_unit_data_a ALTER COLUMN userid TYPE character varying(160);
	ALTER TABLE IF EXISTS camddmw_arch.ozone_unit_data_a ALTER COLUMN userid TYPE character varying(160);
	ALTER TABLE IF EXISTS camddmw_arch.quarter_unit_data_a ALTER COLUMN userid TYPE character varying(160);

	for col in (
		select *
		from information_schema.columns
		where table_schema like 'camd%'
		and table_name like 'vw_%'
		and column_name = 'userid'
		and character_maximum_length <> 160
	) loop
		execute format(
			'DROP VIEW IF EXISTS %s.%s CASCADE;', col.table_schema, col.table_name
		);
	end loop;

	for col in (
		select *
		from information_schema.columns
		where table_schema like 'camd%'
		and table_name not like 'vw_%'
		and column_name = 'userid'
		and character_maximum_length <> 160
	) loop
		execute format(
			'ALTER TABLE IF EXISTS %s.%s ALTER COLUMN userid TYPE character varying(160);', col.table_schema, col.table_name
		);
	end loop;
end $$;