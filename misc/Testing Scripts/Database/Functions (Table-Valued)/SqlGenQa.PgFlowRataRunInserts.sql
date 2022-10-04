USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgFlowRataRunInserts]    Script Date: 9/20/2022 4:53:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION [SqlGenQa].[PgFlowRataRunInserts] 
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
                    'camdecmpswks.FLOW_RATA_RUN', 
                    ' ( ', 
                        'FLOW_RATA_RUN_ID', ', ',
                        'RATA_RUN_ID', ', ',
                        'NUM_TRAVERSE_POINT', ', ',
                        'BAROMETRIC_PRESSURE', ', ',
                        'STATIC_STACK_PRESSURE', ', ',
                        'PERCENT_CO2', ', ',
                        'PERCENT_O2', ', ',
                        'PERCENT_MOISTURE', ', ',
                        'DRY_MOLECULAR_WEIGHT', ', ',
                        'CALC_DRY_MOLECULAR_WEIGHT', ', ',
                        'WET_MOLECULAR_WEIGHT', ', ',
                        'CALC_WET_MOLECULAR_WEIGHT', ', ',
                        'AVG_VEL_WO_WALL', ', ',
                        'CALC_AVG_VEL_WO_WALL', ', ',
                        'AVG_VEL_W_WALL', ', ',
                        'CALC_AVG_VEL_W_WALL', ', ',
                        'CALC_WAF', ', ',
                        'CALC_CALC_WAF', ', ',
                        'AVG_STACK_FLOW_RATE', ', ',
                        'USERID', ', ',
                        'UPDATE_DATE', ', ',
                        'ADD_DATE',
                    ' ) values ( ',
                    case when dat.FLOW_RATA_RUN_ID is not null then '''' + dat.FLOW_RATA_RUN_ID + '''' else 'NULL' end, ', ',
                    case when dat.RATA_RUN_ID is not null then '''' + dat.RATA_RUN_ID + '''' else 'NULL' end, ', ',
                    case when dat.NUM_TRAVERSE_POINT is not null then cast(dat.NUM_TRAVERSE_POINT as varchar) else 'NULL' end, ', ',
                    case when dat.BAROMETRIC_PRESSURE is not null then cast(dat.BAROMETRIC_PRESSURE as varchar) else 'NULL' end, ', ',
                    case when dat.STATIC_STACK_PRESSURE is not null then cast(dat.STATIC_STACK_PRESSURE as varchar) else 'NULL' end, ', ',
                    case when dat.PERCENT_CO2 is not null then cast(dat.PERCENT_CO2 as varchar) else 'NULL' end, ', ',
                    case when dat.PERCENT_O2 is not null then cast(dat.PERCENT_O2 as varchar) else 'NULL' end, ', ',
                    case when dat.PERCENT_MOISTURE is not null then cast(dat.PERCENT_MOISTURE as varchar) else 'NULL' end, ', ',
                    case when dat.DRY_MOLECULAR_WEIGHT is not null then cast(dat.DRY_MOLECULAR_WEIGHT as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_DRY_MOLECULAR_WEIGHT is not null then cast(dat.CALC_DRY_MOLECULAR_WEIGHT as varchar) else 'NULL' end, ', ',
                    case when dat.WET_MOLECULAR_WEIGHT is not null then cast(dat.WET_MOLECULAR_WEIGHT as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_WET_MOLECULAR_WEIGHT is not null then cast(dat.CALC_WET_MOLECULAR_WEIGHT as varchar) else 'NULL' end, ', ',
                    case when dat.AVG_VEL_WO_WALL is not null then cast(dat.AVG_VEL_WO_WALL as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_AVG_VEL_WO_WALL is not null then cast(dat.CALC_AVG_VEL_WO_WALL as varchar) else 'NULL' end, ', ',
                    case when dat.AVG_VEL_W_WALL is not null then cast(dat.AVG_VEL_W_WALL as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_AVG_VEL_W_WALL is not null then cast(dat.CALC_AVG_VEL_W_WALL as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_WAF is not null then cast(dat.CALC_WAF as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_CALC_WAF is not null then cast(dat.CALC_CALC_WAF as varchar) else 'NULL' end, ', ',
                    case when dat.AVG_STACK_FLOW_RATE is not null then cast(dat.AVG_STACK_FLOW_RATE as varchar) else 'NULL' end, ', ',
                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end,
                    ' ) on conflict (', 
                    'FLOW_RATA_RUN_ID', 
                    ') do update set ',
                        'RATA_RUN_ID = EXCLUDED.RATA_RUN_ID, ',
                        'NUM_TRAVERSE_POINT = EXCLUDED.NUM_TRAVERSE_POINT, ',
                        'BAROMETRIC_PRESSURE = EXCLUDED.BAROMETRIC_PRESSURE, ',
                        'STATIC_STACK_PRESSURE = EXCLUDED.STATIC_STACK_PRESSURE, ',
                        'PERCENT_CO2 = EXCLUDED.PERCENT_CO2, ',
                        'PERCENT_O2 = EXCLUDED.PERCENT_O2, ',
                        'PERCENT_MOISTURE = EXCLUDED.PERCENT_MOISTURE, ',
                        'DRY_MOLECULAR_WEIGHT = EXCLUDED.DRY_MOLECULAR_WEIGHT, ',
                        'CALC_DRY_MOLECULAR_WEIGHT = EXCLUDED.CALC_DRY_MOLECULAR_WEIGHT, ',
                        'WET_MOLECULAR_WEIGHT = EXCLUDED.WET_MOLECULAR_WEIGHT, ',
                        'CALC_WET_MOLECULAR_WEIGHT = EXCLUDED.CALC_WET_MOLECULAR_WEIGHT, ',
                        'AVG_VEL_WO_WALL = EXCLUDED.AVG_VEL_WO_WALL, ',
                        'CALC_AVG_VEL_WO_WALL = EXCLUDED.CALC_AVG_VEL_WO_WALL, ',
                        'AVG_VEL_W_WALL = EXCLUDED.AVG_VEL_W_WALL, ',
                        'CALC_AVG_VEL_W_WALL = EXCLUDED.CALC_AVG_VEL_W_WALL, ',
                        'CALC_WAF = EXCLUDED.CALC_WAF, ',
                        'CALC_CALC_WAF = EXCLUDED.CALC_CALC_WAF, ',
                        'AVG_STACK_FLOW_RATE = EXCLUDED.AVG_STACK_FLOW_RATE, ',
                        'USERID = EXCLUDED.USERID, ',
                        'ADD_DATE = EXCLUDED.ADD_DATE, ',
                        'UPDATE_DATE = EXCLUDED.UPDATE_DATE;'
                )
            ) as SQL_STATEMENT
      from  @TestInformationTable lst
            join ECMPS.dbo.RATA lk1
              on lk1.TEST_SUM_ID = lst.TEST_SUM_ID
            join ECMPS.dbo.RATA_SUMMARY lk2
              on lk2.RATA_ID = lk1.RATA_ID
            join ECMPS.dbo.RATA_RUN lk3
              on lk3.RATA_SUM_ID = lk2.RATA_SUM_ID
            join ECMPS.dbo.FLOW_RATA_RUN dat
              on dat.RATA_RUN_ID = lk3.RATA_RUN_ID
)
GO


