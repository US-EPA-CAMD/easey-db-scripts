USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgLinearitySummaryInserts]    Script Date: 9/6/2022 1:23:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION [SqlGenQa].[PgLinearitySummaryInserts] 
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
                    'camdecmpswks.LINEARITY_SUMMARY', 
                    ' ( ', 
                        'LIN_SUM_ID, TEST_SUM_ID, ',
                        'MEAN_REF_VALUE, MEAN_MEASURED_VALUE, PERCENT_ERROR, APS_IND, GAS_LEVEL_CD, ',
                        'CALC_MEAN_REF_VALUE, CALC_MEAN_MEASURED_VALUE, CALC_PERCENT_ERROR, CALC_APS_IND, ',
                        'USERID, ADD_DATE, UPDATE_DATE',
                    ' ) values ( ',
                    case when dat.LIN_SUM_ID is not null then '''' + dat.LIN_SUM_ID + '''' else 'NULL' end, ', ',
                    case when dat.TEST_SUM_ID is not null then '''' + dat.TEST_SUM_ID + '''' else 'NULL' end, ', ',
                
                    case when dat.MEAN_REF_VALUE is not null then cast(dat.MEAN_REF_VALUE as varchar) else 'NULL' end, ', ', 
                    case when dat.MEAN_MEASURED_VALUE is not null then cast(dat.MEAN_MEASURED_VALUE as varchar) else 'NULL' end, ', ', 
                    case when dat.PERCENT_ERROR is not null then cast(dat.PERCENT_ERROR as varchar) else 'NULL' end, ', ', 
                    case when dat.APS_IND is not null then cast(dat.APS_IND as varchar) else 'NULL' end, ', ', 
                    case when dat.GAS_LEVEL_CD is not null then '''' + dat.GAS_LEVEL_CD + '''' else 'NULL' end, ', ',
                
                    case when dat.CALC_MEAN_REF_VALUE is not null then cast(dat.CALC_MEAN_REF_VALUE as varchar) else 'NULL' end, ', ', 
                    case when dat.CALC_MEAN_MEASURED_VALUE is not null then cast(dat.CALC_MEAN_MEASURED_VALUE as varchar) else 'NULL' end, ', ', 
                    case when dat.CALC_PERCENT_ERROR is not null then cast(dat.CALC_PERCENT_ERROR as varchar) else 'NULL' end, ', ', 
                    case when dat.CALC_APS_IND is not null then cast(dat.CALC_APS_IND as varchar) else 'NULL' end, ', ', 

                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end,
                    ' ) on conflict (', 
                    'LIN_SUM_ID', 
                    ') do update set ',
                        'TEST_SUM_ID', ' = EXCLUDED.', 'TEST_SUM_ID', ', ',

                        'MEAN_REF_VALUE', ' = EXCLUDED.', 'MEAN_REF_VALUE', ', ',
                        'MEAN_MEASURED_VALUE', ' = EXCLUDED.', 'MEAN_MEASURED_VALUE', ', ',
                        'PERCENT_ERROR', ' = EXCLUDED.', 'PERCENT_ERROR', ', ',
                        'APS_IND', ' = EXCLUDED.', 'APS_IND', ', ',
                        'GAS_LEVEL_CD', ' = EXCLUDED.', 'GAS_LEVEL_CD', ', ',

                        'CALC_MEAN_REF_VALUE', ' = EXCLUDED.', 'CALC_MEAN_REF_VALUE', ', ',
                        'CALC_MEAN_MEASURED_VALUE', ' = EXCLUDED.', 'CALC_MEAN_MEASURED_VALUE', ', ',
                        'CALC_PERCENT_ERROR', ' = EXCLUDED.', 'CALC_PERCENT_ERROR', ', ',
                        'CALC_APS_IND', ' = EXCLUDED.', 'CALC_APS_IND', ', ',

                        'USERID', ' = EXCLUDED.', 'USERID', ', ',
                        'ADD_DATE', ' = EXCLUDED.', 'ADD_DATE', ', ',
                        'UPDATE_DATE', ' = EXCLUDED.', 'UPDATE_DATE', ';'
                )
            ) as SQL_STATEMENT
      from  @TestInformationTable lst
            join ECMPS.dbo.LINEARITY_SUMMARY dat
              on dat.TEST_SUM_ID = lst.TEST_SUM_ID
)
GO


