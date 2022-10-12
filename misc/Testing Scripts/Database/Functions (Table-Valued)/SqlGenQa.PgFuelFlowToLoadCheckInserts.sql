USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgFuelFlowToLoadCheckInserts]    Script Date: 10/7/2022 10:54:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION [SqlGenQa].[PgFuelFlowToLoadCheckInserts] 
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
                    'camdecmpswks.FUEL_FLOW_TO_LOAD_CHECK', 
                    ' ( ', 
                        'FUEL_FLOW_LOAD_ID', ', ',
                        'TEST_SUM_ID', ', ',
                        'TEST_BASIS_CD', ', ',
                        'AVG_DIFF', ', ',
                        'NUM_HRS', ', ',
                        'NHE_COFIRING', ', ',
                        'NHE_RAMPING', ', ',
                        'NHE_LOW_RANGE', ', ',
                        'USERID', ', ',
                        'ADD_DATE', ', ',
                        'UPDATE_DATE',
                    ' ) values ( ',
                    case when dat.FUEL_FLOW_LOAD_ID is not null then '''' + dat.FUEL_FLOW_LOAD_ID + '''' else 'NULL' end, ', ',
                    case when dat.TEST_SUM_ID is not null then '''' + dat.TEST_SUM_ID + '''' else 'NULL' end, ', ',
                    case when dat.TEST_BASIS_CD is not null then '''' + dat.TEST_BASIS_CD + '''' else 'NULL' end, ', ',
                    case when dat.AVG_DIFF is not null then cast(dat.AVG_DIFF as varchar) else 'NULL' end, ', ',
                    case when dat.NUM_HRS is not null then cast(dat.NUM_HRS as varchar) else 'NULL' end, ', ',
                    case when dat.NHE_COFIRING is not null then cast(dat.NHE_COFIRING as varchar) else 'NULL' end, ', ',
                    case when dat.NHE_RAMPING is not null then cast(dat.NHE_RAMPING as varchar) else 'NULL' end, ', ',
                    case when dat.NHE_LOW_RANGE is not null then cast(dat.NHE_LOW_RANGE as varchar) else 'NULL' end, ', ',
                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end,
                    ' ) on conflict (', 
                    'FUEL_FLOW_LOAD_ID', 
                    ') do update set ',
                        'TEST_SUM_ID = EXCLUDED.TEST_SUM_ID, ',
                        'TEST_BASIS_CD = EXCLUDED.TEST_BASIS_CD, ',
                        'AVG_DIFF = EXCLUDED.AVG_DIFF, ',
                        'NUM_HRS = EXCLUDED.NUM_HRS, ',
                        'NHE_COFIRING = EXCLUDED.NHE_COFIRING, ',
                        'NHE_RAMPING = EXCLUDED.NHE_RAMPING, ',
                        'NHE_LOW_RANGE = EXCLUDED.NHE_LOW_RANGE, ',

                        'USERID', ' = EXCLUDED.', 'USERID', ', ',
                        'ADD_DATE', ' = EXCLUDED.', 'ADD_DATE', ', ',
                        'UPDATE_DATE', ' = EXCLUDED.', 'UPDATE_DATE', ';'
                )
            ) as SQL_STATEMENT
      from  @TestInformationTable lst
            join ECMPS.dbo.FUEL_FLOW_TO_LOAD_CHECK dat
              on dat.TEST_SUM_ID = lst.TEST_SUM_ID
)
GO


