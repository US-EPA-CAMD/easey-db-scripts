USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgRataInserts]    Script Date: 9/20/2022 4:13:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION [SqlGenQa].[PgRataInserts] 
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
                    'camdecmpswks.RATA', 
                    ' ( ', 
                        'RATA_ID', ', ',
                        'TEST_SUM_ID', ', ',
                        'RATA_FREQUENCY_CD', ', ',
                        'CALC_RATA_FREQUENCY_CD', ', ',
                        'RELATIVE_ACCURACY', ', ',
                        'CALC_RELATIVE_ACCURACY', ', ',
                        'OVERALL_BIAS_ADJ_FACTOR', ', ',
                        'CALC_OVERALL_BIAS_ADJ_FACTOR', ', ',
                        'NUM_LOAD_LEVEL', ', ',
                        'CALC_NUM_LOAD_LEVEL', ', ',
                        'USERID', ', ',
                        'ADD_DATE', ', ',
                        'UPDATE_DATE',
                    ' ) values ( ',
                    case when dat.RATA_ID is not null then '''' + dat.RATA_ID + '''' else 'NULL' end, ', ',
                    case when dat.TEST_SUM_ID is not null then '''' + dat.TEST_SUM_ID + '''' else 'NULL' end, ', ',
                    case when dat.RATA_FREQUENCY_CD is not null then '''' + dat.RATA_FREQUENCY_CD + '''' else 'NULL' end, ', ',
                    case when dat.CALC_RATA_FREQUENCY_CD is not null then '''' + dat.CALC_RATA_FREQUENCY_CD + '''' else 'NULL' end, ', ',
                    case when dat.RELATIVE_ACCURACY is not null then cast(dat.RELATIVE_ACCURACY as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_RELATIVE_ACCURACY is not null then cast(dat.CALC_RELATIVE_ACCURACY as varchar) else 'NULL' end, ', ',
                    case when dat.OVERALL_BIAS_ADJ_FACTOR is not null then cast(dat.OVERALL_BIAS_ADJ_FACTOR as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_OVERALL_BIAS_ADJ_FACTOR is not null then cast(dat.CALC_OVERALL_BIAS_ADJ_FACTOR as varchar) else 'NULL' end, ', ',
                    case when dat.NUM_LOAD_LEVEL is not null then cast(dat.NUM_LOAD_LEVEL as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_NUM_LOAD_LEVEL is not null then cast(dat.CALC_NUM_LOAD_LEVEL as varchar) else 'NULL' end, ', ',
                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end,
                    ' ) on conflict (', 
                    'RATA_ID', 
                    ') do update set ',
                        'TEST_SUM_ID', ' = EXCLUDED.', 'TEST_SUM_ID', ', ',
                        'RATA_FREQUENCY_CD', ' = EXCLUDED.', 'RATA_FREQUENCY_CD', ', ',
                        'CALC_RATA_FREQUENCY_CD', ' = EXCLUDED.', 'CALC_RATA_FREQUENCY_CD', ', ',
                        'RELATIVE_ACCURACY', ' = EXCLUDED.', 'RELATIVE_ACCURACY', ', ',
                        'CALC_RELATIVE_ACCURACY', ' = EXCLUDED.', 'CALC_RELATIVE_ACCURACY', ', ',
                        'OVERALL_BIAS_ADJ_FACTOR', ' = EXCLUDED.', 'OVERALL_BIAS_ADJ_FACTOR', ', ',
                        'CALC_OVERALL_BIAS_ADJ_FACTOR', ' = EXCLUDED.', 'CALC_OVERALL_BIAS_ADJ_FACTOR', ', ',
                        'NUM_LOAD_LEVEL', ' = EXCLUDED.', 'NUM_LOAD_LEVEL', ', ',
                        'CALC_NUM_LOAD_LEVEL', ' = EXCLUDED.', 'CALC_NUM_LOAD_LEVEL', ', ',
                        'USERID', ' = EXCLUDED.', 'USERID', ', ',
                        'ADD_DATE', ' = EXCLUDED.', 'ADD_DATE', ', ',
                        'UPDATE_DATE', ' = EXCLUDED.', 'UPDATE_DATE', ';'
                )
            ) as SQL_STATEMENT
      from  @TestInformationTable lst
            join ECMPS.dbo.RATA dat
              on dat.TEST_SUM_ID = lst.TEST_SUM_ID
)
GO


