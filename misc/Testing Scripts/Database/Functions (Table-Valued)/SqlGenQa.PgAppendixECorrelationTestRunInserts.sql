USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgAppendixECorrelationTestRunInserts]    Script Date: 10/12/2022 4:52:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION [SqlGenQa].[PgAppendixECorrelationTestRunInserts] 
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
                    'camdecmpswks.AE_CORRELATION_TEST_RUN', 
                    ' ( ', 
                        'AE_CORR_TEST_RUN_ID', ', ',
                        'AE_CORR_TEST_SUM_ID', ', ',
                        'BEGIN_DATE', ', ',
                        'BEGIN_HOUR', ', ',
                        'BEGIN_MIN', ', ',
                        'END_DATE', ', ',
                        'END_HOUR', ', ',
                        'END_MIN', ', ',
                        'RUN_NUM', ', ',
                        'REF_VALUE', ', ',
                        'RESPONSE_TIME', ', ',
                        'TOTAL_HI', ', ',
                        'CALC_TOTAL_HI', ', ',
                        'HOURLY_HI_RATE', ', ',
                        'CALC_HOURLY_HI_RATE', ', ',
                        'USERID', ', ',
                        'ADD_DATE', ', ',
                        'UPDATE_DATE',
                    ' ) values ( ',
                    case when dat.AE_CORR_TEST_RUN_ID is not null then '''' + dat.AE_CORR_TEST_RUN_ID + '''' else 'NULL' end, ', ',
                    case when dat.AE_CORR_TEST_SUM_ID is not null then '''' + dat.AE_CORR_TEST_SUM_ID + '''' else 'NULL' end, ', ',
                    case when dat.BEGIN_DATE is not null then '''' + convert(varchar(10), dat.BEGIN_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.BEGIN_HOUR is not null then cast(dat.BEGIN_HOUR as varchar) else 'NULL' end, ', ',
                    case when dat.BEGIN_MIN is not null then cast(dat.BEGIN_MIN as varchar) else 'NULL' end, ', ',
                    case when dat.END_DATE is not null then '''' + convert(varchar(10), dat.END_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.END_HOUR is not null then cast(dat.END_HOUR as varchar) else 'NULL' end, ', ',
                    case when dat.END_MIN is not null then cast(dat.END_MIN as varchar) else 'NULL' end, ', ',
                    case when dat.RUN_NUM is not null then cast(dat.RUN_NUM as varchar) else 'NULL' end, ', ',
                    case when dat.REF_VALUE is not null then cast(dat.REF_VALUE as varchar) else 'NULL' end, ', ',
                    case when dat.RESPONSE_TIME is not null then cast(dat.RESPONSE_TIME as varchar) else 'NULL' end, ', ',
                    case when dat.TOTAL_HI is not null then cast(dat.TOTAL_HI as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_TOTAL_HI is not null then cast(dat.CALC_TOTAL_HI as varchar) else 'NULL' end, ', ',
                    case when dat.HOURLY_HI_RATE is not null then cast(dat.HOURLY_HI_RATE as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_HOURLY_HI_RATE is not null then cast(dat.CALC_HOURLY_HI_RATE as varchar) else 'NULL' end, ', ',
                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end,
                    ' ) on conflict (', 
                    'AE_CORR_TEST_RUN_ID', 
                    ') do update set ',
                        'AE_CORR_TEST_SUM_ID = EXCLUDED.AE_CORR_TEST_SUM_ID, ',
                        'BEGIN_DATE = EXCLUDED.BEGIN_DATE, ',
                        'BEGIN_HOUR = EXCLUDED.BEGIN_HOUR, ',
                        'BEGIN_MIN = EXCLUDED.BEGIN_MIN, ',
                        'END_DATE = EXCLUDED.END_DATE, ',
                        'END_HOUR = EXCLUDED.END_HOUR, ',
                        'END_MIN = EXCLUDED.END_MIN, ',
                        'RUN_NUM = EXCLUDED.RUN_NUM, ',
                        'REF_VALUE = EXCLUDED.REF_VALUE, ',
                        'RESPONSE_TIME = EXCLUDED.RESPONSE_TIME, ',
                        'TOTAL_HI = EXCLUDED.TOTAL_HI, ',
                        'CALC_TOTAL_HI = EXCLUDED.CALC_TOTAL_HI, ',
                        'HOURLY_HI_RATE = EXCLUDED.HOURLY_HI_RATE, ',
                        'CALC_HOURLY_HI_RATE = EXCLUDED.CALC_HOURLY_HI_RATE, ',

                        'USERID = EXCLUDED.USERID, ',
                        'ADD_DATE = EXCLUDED.ADD_DATE, ',
                        'UPDATE_DATE = EXCLUDED.UPDATE_DATE;'
                )
            ) as SQL_STATEMENT
      from  @TestInformationTable lst
            join ECMPS.dbo.AE_CORRELATION_TEST_SUM lk1
              on lk1.TEST_SUM_ID = lst.TEST_SUM_ID
            join ECMPS.dbo.AE_CORRELATION_TEST_RUN dat
              on dat.AE_CORR_TEST_SUM_ID = lk1.AE_CORR_TEST_SUM_ID
)
GO


