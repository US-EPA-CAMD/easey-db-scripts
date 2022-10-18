USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgAppendixECorrelationTestSummaryInserts]    Script Date: 10/12/2022 4:47:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION [SqlGenQa].[PgAppendixECorrelationTestSummaryInserts] 
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
                    'camdecmpswks.AE_CORRELATION_TEST_SUM', 
                    ' ( ', 
                        'AE_CORR_TEST_SUM_ID', ', ',
                        'TEST_SUM_ID', ', ',
                        'MEAN_REF_VALUE', ', ',
                        'CALC_MEAN_REF_VALUE', ', ',
                        'F_FACTOR', ', ',
                        'AVG_HRLY_HI_RATE', ', ',
                        'CALC_AVG_HRLY_HI_RATE', ', ',
                        'OP_LEVEL_NUM', ', ',
                        'USERID', ', ',
                        'ADD_DATE', ', ',
                        'UPDATE_DATE',
                    ' ) values ( ',
                    case when dat.AE_CORR_TEST_SUM_ID is not null then '''' + dat.AE_CORR_TEST_SUM_ID + '''' else 'NULL' end, ', ',
                    case when dat.TEST_SUM_ID is not null then '''' + dat.TEST_SUM_ID + '''' else 'NULL' end, ', ',
                    case when dat.MEAN_REF_VALUE is not null then cast(dat.MEAN_REF_VALUE as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_MEAN_REF_VALUE is not null then cast(dat.CALC_MEAN_REF_VALUE as varchar) else 'NULL' end, ', ',
                    case when dat.F_FACTOR is not null then cast(dat.F_FACTOR as varchar) else 'NULL' end, ', ',
                    case when dat.AVG_HRLY_HI_RATE is not null then cast(dat.AVG_HRLY_HI_RATE as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_AVG_HRLY_HI_RATE is not null then cast(dat.CALC_AVG_HRLY_HI_RATE as varchar) else 'NULL' end, ', ',
                    case when dat.OP_LEVEL_NUM is not null then cast(dat.OP_LEVEL_NUM as varchar) else 'NULL' end, ', ',
                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end,
                    ' ) on conflict (', 
                    'AE_CORR_TEST_SUM_ID', 
                    ') do update set ',
                        'TEST_SUM_ID = EXCLUDED.TEST_SUM_ID, ',
                        'MEAN_REF_VALUE = EXCLUDED.MEAN_REF_VALUE, ',
                        'CALC_MEAN_REF_VALUE = EXCLUDED.CALC_MEAN_REF_VALUE, ',
                        'F_FACTOR = EXCLUDED.F_FACTOR, ',
                        'AVG_HRLY_HI_RATE = EXCLUDED.AVG_HRLY_HI_RATE, ',
                        'CALC_AVG_HRLY_HI_RATE = EXCLUDED.CALC_AVG_HRLY_HI_RATE, ',
                        'OP_LEVEL_NUM = EXCLUDED.OP_LEVEL_NUM, ',

                        'USERID', ' = EXCLUDED.', 'USERID', ', ',
                        'ADD_DATE', ' = EXCLUDED.', 'ADD_DATE', ', ',
                        'UPDATE_DATE', ' = EXCLUDED.', 'UPDATE_DATE', ';'
                )
            ) as SQL_STATEMENT
      from  @TestInformationTable lst
            join ECMPS.dbo.AE_CORRELATION_TEST_SUM dat
              on dat.TEST_SUM_ID = lst.TEST_SUM_ID
)
GO


