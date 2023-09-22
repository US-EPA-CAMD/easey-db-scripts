DO $$
DECLARE
	t record;
	rptPeriodId integer := 1;
BEGIN
	FOR t IN (
		SELECT table_name FROM information_schema.tables
		WHERE table_schema = 'camdecmps' AND table_type = 'BASE TABLE' AND table_name like 'emission_view_%'
	) LOOP
		FOR year IN 1993..2023 LOOP
			FOR qtr IN 1..4 LOOP
				rptPeriodId = ((year - 1993) * 4) + qtr;
				EXECUTE format('
					CREATE TABLE IF NOT EXISTS camdecmps.%s_%s_q%s PARTITION OF camdecmps.%s
					FOR VALUES FROM (%s) TO (%s);
				', t.table_name, year, qtr, t.table_name, rptPeriodId, rptPeriodId+1);
			END LOOP;
		END LOOP;
	END LOOP;
END $$;
