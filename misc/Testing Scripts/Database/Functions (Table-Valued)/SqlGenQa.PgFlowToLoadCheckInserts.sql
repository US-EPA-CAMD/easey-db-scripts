USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgFlowToLoadCheckInserts]    Script Date: 109/13/2022 3:22:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION [SqlGenQa].[PgFlowToLoadCheckInserts] 
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
                    'camdecmpswks.FLOW_TO_LOAD_CHECK', 
                    ' ( ', 
                        'FLOW_LOAD_CHECK_ID', ', ',
                        'TEST_SUM_ID', ', ',
                        'TEST_BASIS_CD', ', ',
                        'AVG_ABS_PCT_DIFF', ', ',
                        'NUM_HRS', ', ',
                        'NHE_FUEL', ', ',
                        'NHE_RAMPING', ', ',
                        'NHE_BYPASS', ', ',
                        'NHE_PRE_RATA', ', ',
                        'NHE_TEST', ', ',
                        'NHE_MAIN_BYPASS', ', ',
                        'BIAS_ADJUSTED_IND', ', ',
                        'USERID', ', ',
                        'ADD_DATE', ', ',
                        'UPDATE_DATE', ', ',
                        'OP_LEVEL_CD',
                    ' ) values ( ',
                    case when dat.FLOW_LOAD_CHECK_ID is not null then '''' + dat.FLOW_LOAD_CHECK_ID + '''' else 'NULL' end, ', ',
                    case when dat.TEST_SUM_ID is not null then '''' + dat.TEST_SUM_ID + '''' else 'NULL' end, ', ',
                    case when dat.TEST_BASIS_CD is not null then '''' + dat.TEST_BASIS_CD + '''' else 'NULL' end, ', ',
                    case when dat.AVG_ABS_PCT_DIFF is not null then cast(dat.AVG_ABS_PCT_DIFF as varchar) else 'NULL' end, ', ',
                    case when dat.NUM_HRS is not null then cast(dat.NUM_HRS as varchar) else 'NULL' end, ', ',
                    case when dat.NHE_FUEL is not null then cast(dat.NHE_FUEL as varchar) else 'NULL' end, ', ',
                    case when dat.NHE_RAMPING is not null then cast(dat.NHE_RAMPING as varchar) else 'NULL' end, ', ',
                    case when dat.NHE_BYPASS is not null then cast(dat.NHE_BYPASS as varchar) else 'NULL' end, ', ',
                    case when dat.NHE_PRE_RATA is not null then cast(dat.NHE_PRE_RATA as varchar) else 'NULL' end, ', ',
                    case when dat.NHE_TEST is not null then cast(dat.NHE_TEST as varchar) else 'NULL' end, ', ',
                    case when dat.NHE_MAIN_BYPASS is not null then cast(dat.NHE_MAIN_BYPASS as varchar) else 'NULL' end, ', ',
                    case when dat.BIAS_ADJUSTED_IND is not null then cast(dat.BIAS_ADJUSTED_IND as varchar) else 'NULL' end, ', ',
                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.OP_LEVEL_CD is not null then '''' + dat.OP_LEVEL_CD + '''' else 'NULL' end,
                    ' ) on conflict (', 
                    'FLOW_LOAD_CHECK_ID', 
                    ') do update set ',
                        'TEST_SUM_ID = EXCLUDED.TEST_SUM_ID, ',
                        'TEST_BASIS_CD = EXCLUDED.TEST_BASIS_CD, ',
                        'AVG_ABS_PCT_DIFF = EXCLUDED.AVG_ABS_PCT_DIFF, ',
                        'NUM_HRS = EXCLUDED.NUM_HRS, ',
                        'NHE_FUEL = EXCLUDED.NHE_FUEL, ',
                        'NHE_RAMPING = EXCLUDED.NHE_RAMPING, ',
                        'NHE_BYPASS = EXCLUDED.NHE_BYPASS, ',
                        'NHE_PRE_RATA = EXCLUDED.NHE_PRE_RATA, ',
                        'NHE_TEST = EXCLUDED.NHE_TEST, ',
                        'NHE_MAIN_BYPASS = EXCLUDED.NHE_MAIN_BYPASS, ',
                        'BIAS_ADJUSTED_IND = EXCLUDED.BIAS_ADJUSTED_IND, ',
                        'OP_LEVEL_CD = EXCLUDED.OP_LEVEL_CD, ',

                        'USERID', ' = EXCLUDED.', 'USERID', ', ',
                        'ADD_DATE', ' = EXCLUDED.', 'ADD_DATE', ', ',
                        'UPDATE_DATE', ' = EXCLUDED.', 'UPDATE_DATE', ';'
                )
            ) as SQL_STATEMENT
      from  @TestInformationTable lst
            join ECMPS.dbo.FLOW_TO_LOAD_CHECK dat
              on dat.TEST_SUM_ID = lst.TEST_SUM_ID
)
GO


