USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgUnitDefaultTestInserts]    Script Date: 10/12/2022 10:35:13 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION [SqlGenQa].[PgUnitDefaultTestInserts] 
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
                    'camdecmpswks.UNIT_DEFAULT_TEST', 
                    ' ( ', 
                        'UNIT_DEFAULT_TEST_SUM_ID', ', ',
                        'TEST_SUM_ID', ', ',
                        'FUEL_CD', ', ',
                        'OPERATING_CONDITION_CD', ', ',
                        'NOX_DEFAULT_RATE', ', ',
                        'CALC_NOX_DEFAULT_RATE', ', ',
                        'GROUP_ID', ', ',
                        'NUM_UNITS_IN_GROUP', ', ',
                        'NUM_TESTS_FOR_GROUP', ', ',
                        'USERID', ', ',
                        'ADD_DATE', ', ',
                        'UPDATE_DATE',
                    ' ) values ( ',
                    case when dat.UNIT_DEFAULT_TEST_SUM_ID is not null then '''' + dat.UNIT_DEFAULT_TEST_SUM_ID + '''' else 'NULL' end, ', ',
                    case when dat.TEST_SUM_ID is not null then '''' + dat.TEST_SUM_ID + '''' else 'NULL' end, ', ',
                    case when dat.FUEL_CD is not null then '''' + dat.FUEL_CD + '''' else 'NULL' end, ', ',
                    case when dat.OPERATING_CONDITION_CD is not null then '''' + dat.OPERATING_CONDITION_CD + '''' else 'NULL' end, ', ',
                    case when dat.NOX_DEFAULT_RATE is not null then cast(dat.NOX_DEFAULT_RATE as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_NOX_DEFAULT_RATE is not null then cast(dat.CALC_NOX_DEFAULT_RATE as varchar) else 'NULL' end, ', ',
                    case when dat.GROUP_ID is not null then '''' + dat.GROUP_ID + '''' else 'NULL' end, ', ',
                    case when dat.NUM_UNITS_IN_GROUP is not null then cast(dat.NUM_UNITS_IN_GROUP as varchar) else 'NULL' end, ', ',
                    case when dat.NUM_TESTS_FOR_GROUP is not null then cast(dat.NUM_TESTS_FOR_GROUP as varchar) else 'NULL' end, ', ',
                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end,
                    ' ) on conflict (', 
                    'UNIT_DEFAULT_TEST_SUM_ID', 
                    ') do update set ',
                        'TEST_SUM_ID = EXCLUDED.TEST_SUM_ID, ',
                        'FUEL_CD = EXCLUDED.FUEL_CD, ',
                        'OPERATING_CONDITION_CD = EXCLUDED.OPERATING_CONDITION_CD, ',
                        'NOX_DEFAULT_RATE = EXCLUDED.NOX_DEFAULT_RATE, ',
                        'CALC_NOX_DEFAULT_RATE = EXCLUDED.CALC_NOX_DEFAULT_RATE, ',
                        'GROUP_ID = EXCLUDED.GROUP_ID, ',
                        'NUM_UNITS_IN_GROUP = EXCLUDED.NUM_UNITS_IN_GROUP, ',
                        'NUM_TESTS_FOR_GROUP = EXCLUDED.NUM_TESTS_FOR_GROUP, ',

                        'USERID', ' = EXCLUDED.', 'USERID', ', ',
                        'ADD_DATE', ' = EXCLUDED.', 'ADD_DATE', ', ',
                        'UPDATE_DATE', ' = EXCLUDED.', 'UPDATE_DATE', ';'
                )
            ) as SQL_STATEMENT
      from  @TestInformationTable lst
            join ECMPS.dbo.UNIT_DEFAULT_TEST dat
              on dat.TEST_SUM_ID = lst.TEST_SUM_ID
)
GO


