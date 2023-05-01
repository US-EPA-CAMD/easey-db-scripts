DO $$
DECLARE
	t record;
	columnList text;
	pkColumns text;
	pkColumnToDrop text;
	rptPeriodId integer := 1;
BEGIN
	FOR t IN (
		SELECT table_name FROM information_schema.tables
		WHERE table_schema = 'camdecmps' AND table_type = 'BASE TABLE' AND table_name like 'emission_view_%'
		AND table_name not like 'emission_view_count%'
		AND table_name not like 'emission_view_all%' --DONE
		AND table_name not like 'emission_view_co2appd%' --DONE
		AND table_name not like 'emission_view_co2calc%' --DONE
		AND table_name not like 'emission_view_co2cems%' --DONE
		AND table_name not like 'emission_view_co2dailyfuel%' --DONE
		AND table_name not like 'emission_view_dailycal%' --DONE
		AND table_name not like 'emission_view_hiappd%' --DONE
		AND table_name not like 'emission_view_hicems%' --DONE
		AND table_name not like 'emission_view_hiunitstack%' --DONE
		AND table_name not like 'emission_view_lme%' --DONE
		AND table_name not like 'emission_view_massoilcalc%' --DONE
		AND table_name not like 'emission_view_matshcl%' --DONE
		AND table_name not like 'emission_view_matshf%' --DONE
		AND table_name not like 'emission_view_matshg%' --DONE
		AND table_name not like 'emission_view_matsso2%' --DONE
		AND table_name not like 'emission_view_matssorbent%' --DONE
		AND table_name not like 'emission_view_matsweekly%' --DONE
		AND table_name not like 'emission_view_moisture%' --DONE
		AND table_name not like 'emission_view_noxappemixedfuel%' --DONE
		AND table_name not like 'emission_view_noxappesinglefuel%' --DONE
		AND table_name not like 'emission_view_noxmasscems%' --DONE
		AND table_name not like 'emission_view_noxratecems%' --DONE
		AND table_name not like 'emission_view_otherdaily%' --DONE
		AND table_name not like 'emission_view_so2appd%' --DONE
		AND table_name not like 'emission_view_so2cems%' --DONE
	) LOOP
		EXECUTE format('
			SELECT column_name FROM information_schema.columns
			WHERE table_schema = ''camdecmps'' AND table_name = %L AND ordinal_position = 1;
		', t.table_name) INTO pkColumnToDrop;

		pkColumns := 'mon_plan_id, mon_loc_id, rpt_period_id' ||
			CASE
				WHEN t.table_name = 'emission_view_co2appd' OR t.table_name = 'emission_view_hiappd' OR
					 t.table_name = 'emission_view_noxappesinglefuel' OR t.table_name = 'emission_view_so2appd'
					THEN ', fuel_type, fuel_sys_id, date_hour'
				WHEN t.table_name = 'emission_view_massoilcalc'
					THEN ', oil_type, fuel_sys_id, date_hour'
				WHEN t.table_name = 'emission_view_co2dailyfuel'
					THEN ', fuel_cd, date'
				WHEN t.table_name = 'emission_view_dailycal' OR t.table_name = 'emission_view_otherdaily'
					THEN ', test_sum_id'
				WHEN t.table_name = 'emission_view_matssorbent'
					THEN ', system_identifier, date_hour, end_date_time'
				WHEN t.table_name = 'emission_view_matsweekly'
					THEN ', weekly_test_sum_id'
				WHEN t.table_name = 'emission_view_noxappemixedfuel'
					THEN ', system_id, date_hour'
				ELSE ', date_hour'
			END;

		EXECUTE format('
			ALTER TABLE camdecmps.%s
				DROP COLUMN IF EXISTS %s;

			ALTER TABLE camdecmps.%s RENAME TO %s_tmp;

			CREATE TABLE camdecmps.%s (LIKE camdecmps.%s_tmp INCLUDING DEFAULTS INCLUDING CONSTRAINTS)
			PARTITION BY RANGE (rpt_period_id);

			ALTER TABLE camdecmps.%s
				ADD CONSTRAINT pk_%s PRIMARY KEY (%s);
		', t.table_name, pkColumnToDrop, t.table_name, t.table_name, t.table_name, t.table_name, t.table_name, t.table_name, pkColumns);

		FOR year IN 1993..2023 LOOP
			FOR qtr IN 1..4 LOOP
				rptPeriodId = ((year - 1993) * 4) + qtr;
				EXECUTE format('
					CREATE TABLE IF NOT EXISTS camdecmps.%s_%s_q%s PARTITION OF camdecmps.%s
					FOR VALUES FROM (%s) TO (%s);
				', t.table_name, year, qtr, t.table_name, rptPeriodId, rptPeriodId+1);
			END LOOP;
		END LOOP;
		
		EXECUTE format('
			SELECT string_agg(column_name, '', '')
			FROM information_schema.columns
			WHERE table_schema = ''camdecmps'' AND table_name = %L;
		', t.table_name) INTO columnList;		

		EXECUTE format('
			INSERT INTO camdecmps.%s(%s)
			SELECT %s FROM camdecmps.%s_tmp;
		', t.table_name, columnList, columnList, t.table_name);
	END LOOP;
END
$$;
