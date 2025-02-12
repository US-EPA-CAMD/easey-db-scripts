-- PROCEDURE: camdecmps.create_partitions(integer, character)

-- DROP PROCEDURE IF EXISTS camdecmps.create_partitions(integer, character);

CREATE OR REPLACE PROCEDURE camdecmps.create_partitions(
	IN year integer,
	IN executeflag character DEFAULT 'N'::bpchar)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
  t1 text;
  t2 record;
  t3 text;
  addflag text;

  rptPeriodId integer := 1;
  --For tables started 2003 Q1
  tableList1 text[] := ARRAY[
    'daily_calibration',
    'daily_emission',
    'daily_test_summary',
    'derived_hrly_value',
    'emission_evaluation',
    'hrly_fuel_flow',
    'hrly_op_data',
    'hrly_param_fuel_flow',
    'long_term_fuel_flow',
    'monitor_hrly_value',
    'summary_value'];
   --Other tables started later, exclude emission_view_XXXX
  tableList3 text[] := ARRAY[
    'daily_fuel',
    'hrly_gas_flow_meter',
    'mats_derived_hrly_value',
    'mats_monitor_hrly_value',
    'nsps4t_annual',
    'nsps4t_compliance_period',
    'nsps4t_summary',
    'sampling_train',
    'sorbent_trap',
    'weekly_system_integrity',
    'weekly_test_summary'];

BEGIN
    IF executeFlag = 'N' THEN
		 RAISE NOTICE 'The executeFlag is set to ''N'' so partitions will not be created. DRY RUN ONLY! Set executeFlag to ''Y'' to create partitions.';
	  END IF;	

    --DAILY_BACKSTOP IS NEW FOR MATS 2.0/GNP SO NO DATA REPORTED UNTIL 2024
    --DAILY_BACKSTOP 2023 PARTITIONS ARE ONLY NEEDED FOR TESTING AND VERIFICATION
     -- All tables start year 2003Q1 and after
 IF executeFlag = 'Y' and year >2002 THEN
      -- Tables start 2003Q1 
      FOREACH t1 IN ARRAY tableList1 LOOP
        FOR qtr IN 1..4 LOOP
          rptPeriodId = ((year - 1993) * 4) + qtr;
            EXECUTE format('
              CREATE TABLE IF NOT EXISTS camdecmps.%s_%s_q%s PARTITION OF camdecmps.%s
              FOR VALUES FROM (%s) TO (%s);	', t1, year, qtr, t1, rptPeriodId, rptPeriodId+1);
          END LOOP;
        END LOOP;
	
   -- Tables start later 
     If year>2010 then
      FOREACH t3 IN ARRAY tableList3 LOOP
         Addflag:='No';
         If t3='daily_fuel' and year>2010 then
				    Addflag:='Yes';
         elsif t3 in ('hrly_gas_flow_meter','mats_derived_hrly_value','mats_monitor_hrly_value',
                    'sampling_train','sorbent_trap','weekly_system_integrity','weekly_test_summary')
              and year>2014 then
               Addflag:='Yes';
          elsif t3 in ('nsps4t_annual','nsps4t_compliance_period','nsps4t_summary')  and year>2016 then
               Addflag:='Yes';
          elsif t3 ='daily_backstop' and year>2023 then
               Addflag:='Yes';
         end if;
         If Addflag='Yes' then
		     FOR qtr IN 1..4 LOOP
		    	rptPeriodId = ((year - 1993) * 4) + qtr;      
			   	EXECUTE format('
					CREATE TABLE IF NOT EXISTS camdecmps.%s_%s_q%s PARTITION OF camdecmps.%s
					FOR VALUES FROM (%s) TO (%s);	', t3, year, qtr, t3, rptPeriodId, rptPeriodId+1);
			 END LOOP;
	     end if;
	  end loop;
     end if; 
		

  -- For Tables emission_view_xxxx start from 2015 Q1
  if year>2014 then
	 FOR t2 IN (
		SELECT table_name FROM information_schema.tables
		WHERE table_schema = 'camdecmps' AND table_type = 'BASE TABLE' AND table_name like 'emission_view_%'
		AND table_name not like '%q1' AND table_name not like '%q2' AND table_name not like '%q3' AND table_name not like '%q4'
	) LOOP
				FOR qtr IN 1..4 LOOP
				rptPeriodId = ((year - 1993) * 4) + qtr;
				EXECUTE format('
					CREATE TABLE IF NOT EXISTS camdecmps.%s_%s_q%s PARTITION OF camdecmps.%s
					FOR VALUES FROM (%s) TO (%s);', t2.table_name, year, qtr, t2.table_name, rptPeriodId, rptPeriodId+1);
			   END LOOP;
		END LOOP;
  end if;

  END IF;  --executeFlag
END 
$BODY$;
