USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgCycleTimeInjectionInserts]    Script Date: 11/18/2022 19:50:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION SqlGenQa.PgCycleTimeInjectionInserts 
(	
	@TestInformationTable SqlGenQa.Test_Information_Table readonly,
    @TestOrder  integer
)
RETURNS TABLE 
AS
RETURN 
(
    select  SqlGenQa.FormatSql
            ( 
                lst.ORIS_CODE, lst.FACILITY_NAME, lst.LOCATION_NAME, lst.TEST_TYPE_CD, lst.TEST_NUM,  @TestOrder, 
                concat
                (
                    'insert into ', 
                    'camdecmpswks.CYCLE_TIME_INJECTION', 
                    ' ( ', 
                        'CYCLE_TIME_INJ_ID', ', ',
                        'CYCLE_TIME_SUM_ID', ', ',
                        'BEGIN_MONITOR_VALUE', ', ',
                        'END_MONITOR_VALUE', ', ',
                        'BEGIN_DATE', ', ',
                        'BEGIN_HOUR', ', ',
                        'BEGIN_MIN', ', ',
                        'END_DATE', ', ',
                        'END_HOUR', ', ',
                        'END_MIN', ', ',
                        'GAS_LEVEL_CD', ', ',
                        'CAL_GAS_VALUE', ', ',
                        'INJECTION_CYCLE_TIME', ', ',
                        'CALC_INJECTION_CYCLE_TIME', ', ',

                        'USERID', ', ',
                        'ADD_DATE', ', ',
                        'UPDATE_DATE',
                    ' ) values ( ',
                    case when dat.CYCLE_TIME_INJ_ID is not null then '''' + dat.CYCLE_TIME_INJ_ID + '''' else 'NULL' end, ', ',
                    case when dat.CYCLE_TIME_SUM_ID is not null then '''' + dat.CYCLE_TIME_SUM_ID + '''' else 'NULL' end, ', ',
                    case when dat.BEGIN_MONITOR_VALUE is not null then cast(dat.BEGIN_MONITOR_VALUE as varchar) else 'NULL' end, ', ',
                    case when dat.END_MONITOR_VALUE is not null then cast(dat.END_MONITOR_VALUE as varchar) else 'NULL' end, ', ',
                    case when dat.BEGIN_DATE is not null then '''' + convert(varchar(10), dat.BEGIN_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.BEGIN_HOUR is not null then cast(dat.BEGIN_HOUR as varchar) else 'NULL' end, ', ',
                    case when dat.BEGIN_MIN is not null then cast(dat.BEGIN_MIN as varchar) else 'NULL' end, ', ',
                    case when dat.END_DATE is not null then '''' + convert(varchar(10), dat.END_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.END_HOUR is not null then cast(dat.END_HOUR as varchar) else 'NULL' end, ', ',
                    case when dat.END_MIN is not null then cast(dat.END_MIN as varchar) else 'NULL' end, ', ',
                    case when dat.GAS_LEVEL_CD is not null then '''' + dat.GAS_LEVEL_CD + '''' else 'NULL' end, ', ',
                    case when dat.CAL_GAS_VALUE is not null then cast(dat.CAL_GAS_VALUE as varchar) else 'NULL' end, ', ',
                    case when dat.INJECTION_CYCLE_TIME is not null then cast(dat.INJECTION_CYCLE_TIME as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_INJECTION_CYCLE_TIME is not null then cast(dat.CALC_INJECTION_CYCLE_TIME as varchar) else 'NULL' end, ', ',

                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end,
                    ' ) on conflict (', 
                    'CYCLE_TIME_INJ_ID', 
                    ') do update set ',
                        'CYCLE_TIME_SUM_ID = EXCLUDED.CYCLE_TIME_SUM_ID, ',
                        'BEGIN_MONITOR_VALUE = EXCLUDED.BEGIN_MONITOR_VALUE, ',
                        'END_MONITOR_VALUE = EXCLUDED.END_MONITOR_VALUE, ',
                        'BEGIN_DATE = EXCLUDED.BEGIN_DATE, ',
                        'BEGIN_HOUR = EXCLUDED.BEGIN_HOUR, ',
                        'BEGIN_MIN = EXCLUDED.BEGIN_MIN, ',
                        'END_DATE = EXCLUDED.END_DATE, ',
                        'END_HOUR = EXCLUDED.END_HOUR, ',
                        'END_MIN = EXCLUDED.END_MIN, ',
                        'GAS_LEVEL_CD = EXCLUDED.GAS_LEVEL_CD, ',
                        'CAL_GAS_VALUE = EXCLUDED.CAL_GAS_VALUE, ',
                        'INJECTION_CYCLE_TIME = EXCLUDED.INJECTION_CYCLE_TIME, ',
                        'CALC_INJECTION_CYCLE_TIME = EXCLUDED.CALC_INJECTION_CYCLE_TIME, ',

                        'USERID', ' = EXCLUDED.', 'USERID', ', ',
                        'ADD_DATE', ' = EXCLUDED.', 'ADD_DATE', ', ',
                        'UPDATE_DATE', ' = EXCLUDED.', 'UPDATE_DATE', ';'
                )
            ) as SQL_STATEMENT
      from  @TestInformationTable lst
            join ECMPS.dbo.CYCLE_TIME_SUMMARY par
              on par.TEST_SUM_ID = lst.TEST_SUM_ID
            join ECMPS.dbo.CYCLE_TIME_INJECTION dat
              on dat.CYCLE_TIME_SUM_ID = par.CYCLE_TIME_SUM_ID
)
GO


