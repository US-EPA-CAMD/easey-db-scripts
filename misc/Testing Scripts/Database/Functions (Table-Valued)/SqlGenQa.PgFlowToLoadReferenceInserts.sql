USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgFlowToLoadReferenceInserts]    Script Date: 109/14/2022 11:252:13 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION [SqlGenQa].[PgFlowToLoadReferenceInserts] 
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
                    'camdecmpswks.FLOW_TO_LOAD_REFERENCE', 
                    ' ( ', 
                        'FLOW_LOAD_REF_ID', ', ',
                        'TEST_SUM_ID', ', ',
                        'OP_LEVEL_CD', ', ',
                        'AVG_REF_METHOD_FLOW', ', ',
                        'CALC_AVG_REF_METHOD_FLOW', ', ',
                        'RATA_TEST_NUM', ', ',
                        'AVG_GROSS_UNIT_LOAD', ', ',
                        'CALC_AVG_GROSS_UNIT_LOAD', ', ',
                        'REF_FLOW_LOAD_RATIO', ', ',
                        'CALC_REF_FLOW_LOAD_RATIO', ', ',
                        'AVG_HRLY_HI_RATE', ', ',
                        'REF_GHR', ', ',
                        'CALC_REF_GHR', ', ',
                        'USERID', ', ',
                        'ADD_DATE', ', ',
                        'UPDATE_DATE', ', ',
                        'CALC_SEP_REF_IND',
                    ' ) values ( ',
                    case when dat.FLOW_LOAD_REF_ID is not null then '''' + dat.FLOW_LOAD_REF_ID + '''' else 'NULL' end, ', ',
                    case when dat.TEST_SUM_ID is not null then '''' + dat.TEST_SUM_ID + '''' else 'NULL' end, ', ',
                    case when dat.OP_LEVEL_CD is not null then '''' + dat.OP_LEVEL_CD + '''' else 'NULL' end, ', ',
                    case when dat.AVG_REF_METHOD_FLOW is not null then cast(dat.AVG_REF_METHOD_FLOW as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_AVG_REF_METHOD_FLOW is not null then cast(dat.CALC_AVG_REF_METHOD_FLOW as varchar) else 'NULL' end, ', ',
                    case when dat.RATA_TEST_NUM is not null then '''' + dat.RATA_TEST_NUM + '''' else 'NULL' end, ', ',
                    case when dat.AVG_GROSS_UNIT_LOAD is not null then cast(dat.AVG_GROSS_UNIT_LOAD as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_AVG_GROSS_UNIT_LOAD is not null then cast(dat.CALC_AVG_GROSS_UNIT_LOAD as varchar) else 'NULL' end, ', ',
                    case when dat.REF_FLOW_LOAD_RATIO is not null then cast(dat.REF_FLOW_LOAD_RATIO as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_REF_FLOW_LOAD_RATIO is not null then cast(dat.CALC_REF_FLOW_LOAD_RATIO as varchar) else 'NULL' end, ', ',
                    case when dat.AVG_HRLY_HI_RATE is not null then cast(dat.AVG_HRLY_HI_RATE as varchar) else 'NULL' end, ', ',
                    case when dat.REF_GHR is not null then cast(dat.REF_GHR as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_REF_GHR is not null then cast(dat.CALC_REF_GHR as varchar) else 'NULL' end, ', ',
                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.CALC_SEP_REF_IND is not null then cast(dat.CALC_SEP_REF_IND as varchar) else 'NULL' end,
                    ' ) on conflict (', 
                    'FLOW_LOAD_REF_ID', 
                    ') do update set ',
                        'TEST_SUM_ID = EXCLUDED.TEST_SUM_ID, ',
                        'OP_LEVEL_CD = EXCLUDED.OP_LEVEL_CD, ',
                        'AVG_REF_METHOD_FLOW = EXCLUDED.AVG_REF_METHOD_FLOW, ',
                        'CALC_AVG_REF_METHOD_FLOW = EXCLUDED.CALC_AVG_REF_METHOD_FLOW, ',
                        'RATA_TEST_NUM = EXCLUDED.RATA_TEST_NUM, ',
                        'AVG_GROSS_UNIT_LOAD = EXCLUDED.AVG_GROSS_UNIT_LOAD, ',
                        'CALC_AVG_GROSS_UNIT_LOAD = EXCLUDED.CALC_AVG_GROSS_UNIT_LOAD, ',
                        'REF_FLOW_LOAD_RATIO = EXCLUDED.REF_FLOW_LOAD_RATIO, ',
                        'CALC_REF_FLOW_LOAD_RATIO = EXCLUDED.CALC_REF_FLOW_LOAD_RATIO, ',
                        'AVG_HRLY_HI_RATE = EXCLUDED.AVG_HRLY_HI_RATE, ',
                        'REF_GHR = EXCLUDED.REF_GHR, ',
                        'CALC_REF_GHR = EXCLUDED.CALC_REF_GHR, ',
                        'CALC_SEP_REF_IND = EXCLUDED.CALC_SEP_REF_IND, ',

                        'USERID', ' = EXCLUDED.', 'USERID', ', ',
                        'ADD_DATE', ' = EXCLUDED.', 'ADD_DATE', ', ',
                        'UPDATE_DATE', ' = EXCLUDED.', 'UPDATE_DATE', ';'
                )
            ) as SQL_STATEMENT
      from  @TestInformationTable lst
            join ECMPS.dbo.FLOW_TO_LOAD_REFERENCE dat
              on dat.TEST_SUM_ID = lst.TEST_SUM_ID
)
GO
