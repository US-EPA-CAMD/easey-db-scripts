USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgFuelFlowToLoadBaselineInserts]    Script Date: 10/11/2022 2:58:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION [SqlGenQa].[PgFuelFlowToLoadBaselineInserts] 
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
                    'camdecmpswks.FUEL_FLOW_TO_LOAD_BASELINE', 
                    ' ( ', 
                        'FUEL_FLOW_BASELINE_ID', ', ',
                        'TEST_SUM_ID', ', ',
                        'ACCURACY_TEST_NUMBER', ', ',
                        'PEI_TEST_NUMBER', ', ',
                        'AVG_FUEL_FLOW_RATE', ', ',
                        'AVG_LOAD', ', ',
                        'BASELINE_FUEL_FLOW_LOAD_RATIO', ', ',
                        'AVG_HRLY_HI_RATE', ', ',
                        'BASELINE_GHR', ', ',
                        'NHE_COFIRING', ', ',
                        'NHE_RAMPING', ', ',
                        'NHE_LOW_RANGE', ', ',
                        'USERID', ', ',
                        'ADD_DATE', ', ',
                        'UPDATE_DATE', ', ',
                        'FUEL_FLOW_LOAD_UOM_CD', ', ',
                        'GHR_UOM_CD',
                    ' ) values ( ',
                    case when dat.FUEL_FLOW_BASELINE_ID is not null then '''' + dat.FUEL_FLOW_BASELINE_ID + '''' else 'NULL' end, ', ',
                    case when dat.TEST_SUM_ID is not null then '''' + dat.TEST_SUM_ID + '''' else 'NULL' end, ', ',
                    case when dat.ACCURACY_TEST_NUMBER is not null then '''' + dat.ACCURACY_TEST_NUMBER + '''' else 'NULL' end, ', ',
                    case when dat.PEI_TEST_NUMBER is not null then '''' + dat.PEI_TEST_NUMBER + '''' else 'NULL' end, ', ',
                    case when dat.AVG_FUEL_FLOW_RATE is not null then cast(dat.AVG_FUEL_FLOW_RATE as varchar) else 'NULL' end, ', ',
                    case when dat.AVG_LOAD is not null then cast(dat.AVG_LOAD as varchar) else 'NULL' end, ', ',
                    case when dat.BASELINE_FUEL_FLOW_LOAD_RATIO is not null then cast(dat.BASELINE_FUEL_FLOW_LOAD_RATIO as varchar) else 'NULL' end, ', ',
                    case when dat.AVG_HRLY_HI_RATE is not null then cast(dat.AVG_HRLY_HI_RATE as varchar) else 'NULL' end, ', ',
                    case when dat.BASELINE_GHR is not null then cast(dat.BASELINE_GHR as varchar) else 'NULL' end, ', ',
                    case when dat.NHE_COFIRING is not null then cast(dat.NHE_COFIRING as varchar) else 'NULL' end, ', ',
                    case when dat.NHE_RAMPING is not null then cast(dat.NHE_RAMPING as varchar) else 'NULL' end, ', ',
                    case when dat.NHE_LOW_RANGE is not null then cast(dat.NHE_LOW_RANGE as varchar) else 'NULL' end, ', ',
                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.FUEL_FLOW_LOAD_UOM_CD is not null then '''' + dat.FUEL_FLOW_LOAD_UOM_CD + '''' else 'NULL' end, ', ',
                    case when dat.GHR_UOM_CD is not null then '''' + dat.GHR_UOM_CD + '''' else 'NULL' end,
                    ' ) on conflict (', 
                    'FUEL_FLOW_BASELINE_ID', 
                    ') do update set ',
                        'TEST_SUM_ID = EXCLUDED.TEST_SUM_ID, ',
                        'ACCURACY_TEST_NUMBER = EXCLUDED.ACCURACY_TEST_NUMBER, ',
                        'PEI_TEST_NUMBER = EXCLUDED.PEI_TEST_NUMBER, ',
                        'AVG_FUEL_FLOW_RATE = EXCLUDED.AVG_FUEL_FLOW_RATE, ',
                        'AVG_LOAD = EXCLUDED.AVG_LOAD, ',
                        'BASELINE_FUEL_FLOW_LOAD_RATIO = EXCLUDED.BASELINE_FUEL_FLOW_LOAD_RATIO, ',
                        'AVG_HRLY_HI_RATE = EXCLUDED.AVG_HRLY_HI_RATE, ',
                        'BASELINE_GHR = EXCLUDED.BASELINE_GHR, ',
                        'NHE_COFIRING = EXCLUDED.NHE_COFIRING, ',
                        'NHE_RAMPING = EXCLUDED.NHE_RAMPING, ',
                        'NHE_LOW_RANGE = EXCLUDED.NHE_LOW_RANGE, ',
                        'FUEL_FLOW_LOAD_UOM_CD = EXCLUDED.FUEL_FLOW_LOAD_UOM_CD, ',
                        'GHR_UOM_CD = EXCLUDED.GHR_UOM_CD, ',

                        'USERID', ' = EXCLUDED.', 'USERID', ', ',
                        'ADD_DATE', ' = EXCLUDED.', 'ADD_DATE', ', ',
                        'UPDATE_DATE', ' = EXCLUDED.', 'UPDATE_DATE', ';'
                )
            ) as SQL_STATEMENT
      from  @TestInformationTable lst
            join ECMPS.dbo.FUEL_FLOW_TO_LOAD_BASELINE dat
              on dat.TEST_SUM_ID = lst.TEST_SUM_ID
)
GO


