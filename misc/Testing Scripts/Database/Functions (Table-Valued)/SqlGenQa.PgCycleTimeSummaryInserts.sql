USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgCycleTimeSummaryInserts]    Script Date: 11/18/2022 19:49:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION SqlGenQa.PgCycleTimeSummaryInserts 
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
                    'camdecmpswks.CYCLE_TIME_SUMMARY', 
                    ' ( ', 
                        'CYCLE_TIME_SUM_ID', ', ',
                        'TEST_SUM_ID', ', ',
                        'TOTAL_TIME', ', ',
                        'CALC_TOTAL_TIME', ', ',
                        'USERID', ', ',
                        'ADD_DATE', ', ',
                        'UPDATE_DATE',
                    ' ) values ( ',
                    case when dat.CYCLE_TIME_SUM_ID is not null then '''' + dat.CYCLE_TIME_SUM_ID + '''' else 'NULL' end, ', ',
                    case when dat.TEST_SUM_ID is not null then '''' + dat.TEST_SUM_ID + '''' else 'NULL' end, ', ',
                    case when dat.TOTAL_TIME is not null then cast(dat.TOTAL_TIME as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_TOTAL_TIME is not null then cast(dat.CALC_TOTAL_TIME as varchar) else 'NULL' end, ', ',

                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end,
                    ' ) on conflict (', 
                    'CYCLE_TIME_SUM_ID', 
                    ') do update set ',
                        'TEST_SUM_ID = EXCLUDED.TEST_SUM_ID, ',
                        'TOTAL_TIME = EXCLUDED.TOTAL_TIME, ',
                        'CALC_TOTAL_TIME = EXCLUDED.CALC_TOTAL_TIME, ',

                        'USERID', ' = EXCLUDED.', 'USERID', ', ',
                        'ADD_DATE', ' = EXCLUDED.', 'ADD_DATE', ', ',
                        'UPDATE_DATE', ' = EXCLUDED.', 'UPDATE_DATE', ';'
                )
            ) as SQL_STATEMENT
      from  @TestInformationTable lst
            join ECMPS.dbo.CYCLE_TIME_SUMMARY dat
              on dat.TEST_SUM_ID = lst.TEST_SUM_ID
)
GO


