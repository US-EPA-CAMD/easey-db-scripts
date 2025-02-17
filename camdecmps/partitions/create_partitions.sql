-- PROCEDURE: camdecmps.create_partitions(smallint, boolean)

-- DROP PROCEDURE IF EXISTS camdecmps.create_partitions(smallint, boolean);

CREATE OR REPLACE PROCEDURE camdecmps.create_partitions(
	IN vYear smallint,
	IN vExecuteFlag boolean DEFAULT false)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
  -- Table List Array Variable
    vTables text[] = ARRAY
                     [
                        [ 'daily_backstop',             '125', '2024', '1' ],
                        [ 'daily_calibration',          '41',  '2003', '1' ],
                        [ 'daily_emission',             '41',  '2003', '1' ],
                        [ 'daily_fuel',                 '75',  '2011', '3' ],
                        [ 'daily_test_summary',         '41',  '2003', '1' ],
                        [ 'derived_hrly_value',         '41',  '2003', '1' ],
                        [ 'emission_evaluation',        '41',  '2003', '1' ],
                        [ 'hrly_fuel_flow',             '41',  '2003', '1' ],
                        [ 'hrly_gas_flow_meter',        '89',  '2015', '1' ],
                        [ 'hrly_op_data',               '41',  '2003', '1' ],
                        [ 'hrly_param_fuel_flow',       '41',  '2003', '1' ],
                        [ 'long_term_fuel_flow',        '41',  '2003', '1' ],
                        [ 'mats_derived_hrly_value',    '89',  '2015', '1' ],
                        [ 'mats_monitor_hrly_value',    '89',  '2015', '1' ],
                        [ 'monitor_hrly_value',         '41',  '2003', '1' ],
                        [ 'nsps4t_annual',              '100', '2017', '4' ],
                        [ 'nsps4t_compliance_period',   '100', '2017', '4' ],
                        [ 'nsps4t_summary',             '100', '2017', '4' ],
                        [ 'sampling_train',             '89',  '2015', '1' ],
                        [ 'sorbent_trap',               '89',  '2015', '1' ],
                        [ 'summary_value',              '41',  '2003', '1' ],
                        [ 'weekly_system_integrity',    '89',  '2015', '1' ],
                        [ 'weekly_test_summary',        '89',  '2015', '1' ]
                     ];
    
    -- Other Variables
    vTable text[];
    vTableName text;
    vEarliestRptPeriodId smallint;
    vEarliestYear smallint;
    vEarliestQuarter smallint;
    vSqlStatement text;
    prd record;
    tbl record;
BEGIN
   -- Handle Emission Data Tables
    foreach vTable slice 1 in array vTables
    loop
        vTableName = vTable[1];
        vEarliestRptPeriodId = vTable[2]::smallint;
        vEarliestYear = vTable[3]::smallint;
        vEarliestQuarter = vTable[4]::smallint;
        
        for prd in
        (
            select  rpt_period_id,
                    calendar_year,
                    quarter
              from  camdecmpsmd.REPORTING_PERIOD
             where  calendar_year = vYear
               and  vYear >= 2003
               and  (
                        calendar_year > vEarliestYear
                        or
                        calendar_year = vEarliestYear and quarter >= vEarliestQuarter
                    )
        )
        loop
            
            vSqlStatement = format('CREATE TABLE IF NOT EXISTS camdecmps.%s_%s_q%s PARTITION OF camdecmps.%s FOR VALUES FROM (%s) TO (%s);  ', 
                                    vTableName, prd.calendar_year, prd.quarter, vTableName, prd.rpt_period_id, prd.rpt_period_id + 1 );
            
            if vExecuteFlag then
                raise notice '%', vSqlStatement;
                raise notice 'UNCOMMENT EXECUTION';
                --execute vSqlStatement;
            else
                raise notice 'Dry Run includes "%".', vSqlStatement;
            end if;
            
        end loop;
        
    end loop;
    
    
    -- Handle Emission View Tables
    for tbl in
    (
        select  table_name
          from  information_schema.TABLES
         where  table_schema = 'camdecmps'
           and  table_type = 'BASE TABLE'
           and  table_name like 'emission_view_%'
           and  table_name not like 'emission_view_%q%'
    )
    loop
        
        for prd in
        (
            select  rpt_period_id,
                    calendar_year,
                    quarter
              from  camdecmpsmd.REPORTING_PERIOD
             where  calendar_year = vYear
               and  vYear >= 2003
               and  (
                        tbl.table_name not like 'emission_view_mats%'
                        or
                        vYear >= 2015
                    )
        )
        loop
            
            vSqlStatement = format('CREATE TABLE IF NOT EXISTS camdecmps.%s_%s_q%s PARTITION OF camdecmps.%s FOR VALUES FROM (%s) TO (%s);    ', 
                                    tbl.table_name, prd.calendar_year, prd.quarter, tbl.table_name, prd.rpt_period_id, prd.rpt_period_id + 1 );
            
            if vExecuteFlag then
                raise notice '%', vSqlStatement;
                raise notice 'UNCOMMENT EXECUTION';
                --execute vSqlStatement;
            else
                raise notice 'Dry Run includes "%".', vSqlStatement;
            end if;
            
        end loop;
        
    end loop;

END 
$BODY$;