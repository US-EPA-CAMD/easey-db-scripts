USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgLinearityInjectionInserts]    Script Date: 9/20/2022 4:23:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION [SqlGenQa].[PgRataSummaryInserts] 
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
                    'camdecmpswks.RATA_SUMMARY', 
                    ' ( ', 
                        'RATA_SUM_ID', ', ',
                        'RATA_ID', ', ',
                        'RELATIVE_ACCURACY', ', ',
                        'CALC_RELATIVE_ACCURACY', ', ',
                        'BIAS_ADJ_FACTOR', ', ',
                        'CALC_BIAS_ADJ_FACTOR', ', ',
                        'MEAN_CEM_VALUE', ', ',
                        'CALC_MEAN_CEM_VALUE', ', ',
                        'MEAN_RATA_REF_VALUE', ', ',
                        'CALC_MEAN_RATA_REF_VALUE', ', ',
                        'OP_LEVEL_CD', ', ',
                        'MEAN_DIFF', ', ',
                        'CALC_MEAN_DIFF', ', ',
                        'DEFAULT_WAF', ', ',
                        'AVG_GROSS_UNIT_LOAD', ', ',
                        'CALC_AVG_GROSS_UNIT_LOAD', ', ',
                        'APS_IND', ', ',
                        'CALC_APS_IND', ', ',
                        'STND_DEV_DIFF', ', ',
                        'CALC_STND_DEV_DIFF', ', ',
                        'CONFIDENCE_COEF', ', ',
                        'CALC_CONFIDENCE_COEF', ', ',
                        'CO2_O2_REF_METHOD_CD', ', ',
                        'REF_METHOD_CD', ', ',
                        'T_VALUE', ', ',
                        'CALC_T_VALUE', ', ',
                        'STACK_DIAMETER', ', ',
                        'STACK_AREA', ', ',
                        'CALC_STACK_AREA', ', ',
                        'CALC_WAF', ', ',
                        'CALC_CALC_WAF', ', ',
                        'NUM_TRAVERSE_POINT', ', ',
                        'USERID', ', ',
                        'ADD_DATE', ', ',
                        'UPDATE_DATE', ', ',
                        'APS_CD',
                    ' ) values ( ',
                    case when dat.RATA_SUM_ID is not null then '''' + dat.RATA_SUM_ID + '''' else 'NULL' end, ', ',
                    case when dat.RATA_ID is not null then '''' + dat.RATA_ID + '''' else 'NULL' end, ', ',
                    case when dat.RELATIVE_ACCURACY is not null then cast(dat.RELATIVE_ACCURACY as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_RELATIVE_ACCURACY is not null then cast(dat.CALC_RELATIVE_ACCURACY as varchar) else 'NULL' end, ', ',
                    case when dat.BIAS_ADJ_FACTOR is not null then cast(dat.BIAS_ADJ_FACTOR as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_BIAS_ADJ_FACTOR is not null then cast(dat.CALC_BIAS_ADJ_FACTOR as varchar) else 'NULL' end, ', ',
                    case when dat.MEAN_CEM_VALUE is not null then cast(dat.MEAN_CEM_VALUE as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_MEAN_CEM_VALUE is not null then cast(dat.CALC_MEAN_CEM_VALUE as varchar) else 'NULL' end, ', ',
                    case when dat.MEAN_RATA_REF_VALUE is not null then cast(dat.MEAN_RATA_REF_VALUE as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_MEAN_RATA_REF_VALUE is not null then cast(dat.CALC_MEAN_RATA_REF_VALUE as varchar) else 'NULL' end, ', ',
                    case when dat.OP_LEVEL_CD is not null then '''' + dat.OP_LEVEL_CD + '''' else 'NULL' end, ', ',
                    case when dat.MEAN_DIFF is not null then cast(dat.MEAN_DIFF as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_MEAN_DIFF is not null then cast(dat.CALC_MEAN_DIFF as varchar) else 'NULL' end, ', ',
                    case when dat.DEFAULT_WAF is not null then cast(dat.DEFAULT_WAF as varchar) else 'NULL' end, ', ',
                    case when dat.AVG_GROSS_UNIT_LOAD is not null then cast(dat.AVG_GROSS_UNIT_LOAD as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_AVG_GROSS_UNIT_LOAD is not null then cast(dat.CALC_AVG_GROSS_UNIT_LOAD as varchar) else 'NULL' end, ', ',
                    case when dat.APS_IND is not null then cast(dat.APS_IND as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_APS_IND is not null then cast(dat.CALC_APS_IND as varchar) else 'NULL' end, ', ',
                    case when dat.STND_DEV_DIFF is not null then cast(dat.STND_DEV_DIFF as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_STND_DEV_DIFF is not null then cast(dat.CALC_STND_DEV_DIFF as varchar) else 'NULL' end, ', ',
                    case when dat.CONFIDENCE_COEF is not null then cast(dat.CONFIDENCE_COEF as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_CONFIDENCE_COEF is not null then cast(dat.CALC_CONFIDENCE_COEF as varchar) else 'NULL' end, ', ',
                    case when dat.CO2_O2_REF_METHOD_CD is not null then '''' + dat.CO2_O2_REF_METHOD_CD + '''' else 'NULL' end, ', ',
                    case when dat.REF_METHOD_CD is not null then '''' + dat.REF_METHOD_CD + '''' else 'NULL' end, ', ',
                    case when dat.T_VALUE is not null then cast(dat.T_VALUE as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_T_VALUE is not null then cast(dat.CALC_T_VALUE as varchar) else 'NULL' end, ', ',
                    case when dat.STACK_DIAMETER is not null then cast(dat.STACK_DIAMETER as varchar) else 'NULL' end, ', ',
                    case when dat.STACK_AREA is not null then cast(dat.STACK_AREA as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_STACK_AREA is not null then cast(dat.CALC_STACK_AREA as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_WAF is not null then cast(dat.CALC_WAF as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_CALC_WAF is not null then cast(dat.CALC_CALC_WAF as varchar) else 'NULL' end, ', ',
                    case when dat.NUM_TRAVERSE_POINT is not null then cast(dat.NUM_TRAVERSE_POINT as varchar) else 'NULL' end, ', ',
                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.APS_CD is not null then '''' + dat.APS_CD + '''' else 'NULL' end,
                    ' ) on conflict (', 
                    'RATA_SUM_ID', 
                    ') do update set ',
                        'RATA_ID = EXCLUDED.RATA_ID, ',
                        'RELATIVE_ACCURACY = EXCLUDED.RELATIVE_ACCURACY, ',
                        'CALC_RELATIVE_ACCURACY = EXCLUDED.CALC_RELATIVE_ACCURACY, ',
                        'BIAS_ADJ_FACTOR = EXCLUDED.BIAS_ADJ_FACTOR, ',
                        'CALC_BIAS_ADJ_FACTOR = EXCLUDED.CALC_BIAS_ADJ_FACTOR, ',
                        'MEAN_CEM_VALUE = EXCLUDED.MEAN_CEM_VALUE, ',
                        'CALC_MEAN_CEM_VALUE = EXCLUDED.CALC_MEAN_CEM_VALUE, ',
                        'MEAN_RATA_REF_VALUE = EXCLUDED.MEAN_RATA_REF_VALUE, ',
                        'CALC_MEAN_RATA_REF_VALUE = EXCLUDED.CALC_MEAN_RATA_REF_VALUE, ',
                        'OP_LEVEL_CD = EXCLUDED.OP_LEVEL_CD, ',
                        'MEAN_DIFF = EXCLUDED.MEAN_DIFF, ',
                        'CALC_MEAN_DIFF = EXCLUDED.CALC_MEAN_DIFF, ',
                        'DEFAULT_WAF = EXCLUDED.DEFAULT_WAF, ',
                        'AVG_GROSS_UNIT_LOAD = EXCLUDED.AVG_GROSS_UNIT_LOAD, ',
                        'CALC_AVG_GROSS_UNIT_LOAD = EXCLUDED.CALC_AVG_GROSS_UNIT_LOAD, ',
                        'APS_IND = EXCLUDED.APS_IND, ',
                        'CALC_APS_IND = EXCLUDED.CALC_APS_IND, ',
                        'STND_DEV_DIFF = EXCLUDED.STND_DEV_DIFF, ',
                        'CALC_STND_DEV_DIFF = EXCLUDED.CALC_STND_DEV_DIFF, ',
                        'CONFIDENCE_COEF = EXCLUDED.CONFIDENCE_COEF, ',
                        'CALC_CONFIDENCE_COEF = EXCLUDED.CALC_CONFIDENCE_COEF, ',
                        'CO2_O2_REF_METHOD_CD = EXCLUDED.CO2_O2_REF_METHOD_CD, ',
                        'REF_METHOD_CD = EXCLUDED.REF_METHOD_CD, ',
                        'T_VALUE = EXCLUDED.T_VALUE, ',
                        'CALC_T_VALUE = EXCLUDED.CALC_T_VALUE, ',
                        'STACK_DIAMETER = EXCLUDED.STACK_DIAMETER, ',
                        'STACK_AREA = EXCLUDED.STACK_AREA, ',
                        'CALC_STACK_AREA = EXCLUDED.CALC_STACK_AREA, ',
                        'CALC_WAF = EXCLUDED.CALC_WAF, ',
                        'CALC_CALC_WAF = EXCLUDED.CALC_CALC_WAF, ',
                        'NUM_TRAVERSE_POINT = EXCLUDED.NUM_TRAVERSE_POINT, ',
                        'APS_CD = EXCLUDED.APS_CD, ',
                        'USERID = EXCLUDED.USERID, ',
                        'ADD_DATE = EXCLUDED.ADD_DATE, ',
                        'UPDATE_DATE = EXCLUDED.UPDATE_DATE;'
                )
            ) as SQL_STATEMENT
      from  @TestInformationTable lst
            join ECMPS.dbo.RATA lk1
              on lk1.TEST_SUM_ID = lst.TEST_SUM_ID
            join ECMPS.dbo.RATA_SUMMARY dat
              on dat.RATA_ID = lk1.RATA_ID
)
GO


