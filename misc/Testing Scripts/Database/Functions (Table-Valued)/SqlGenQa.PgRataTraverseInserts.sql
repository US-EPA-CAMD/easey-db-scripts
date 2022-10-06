USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgRataTraverseInserts]    Script Date: 9/20/2022 4:58:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION [SqlGenQa].[PgRataTraverseInserts] 
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
                    'camdecmpswks.RATA_TRAVERSE', 
                    ' ( ', 
                        'RATA_TRAVERSE_ID', ', ',
                        'FLOW_RATA_RUN_ID', ', ',
                        'PROBEID', ', ',
                        'PROBE_TYPE_CD', ', ',
                        'METHOD_TRAVERSE_POINT_ID', ', ',
                        'VEL_CAL_COEF', ', ',
                        'LAST_PROBE_DATE', ', ',
                        'AVG_VEL_DIFF_PRESSURE', ', ',
                        'AVG_SQ_VEL_DIFF_PRESSURE', ', ',
                        'T_STACK_TEMP', ', ',
                        'NUM_WALL_EFFECTS_POINTS', ', ',
                        'YAW_ANGLE', ', ',
                        'PITCH_ANGLE', ', ',
                        'CALC_VEL', ', ',
                        'CALC_CALC_VEL', ', ',
                        'REP_VEL', ', ',
                        'PRESSURE_MEAS_CD', ', ',
                        'USERID', ', ',
                        'ADD_DATE', ', ',
                        'UPDATE_DATE', ', ',
                        'POINT_USED_IND',
                    ' ) values ( ',
                    case when dat.RATA_TRAVERSE_ID is not null then '''' + dat.RATA_TRAVERSE_ID + '''' else 'NULL' end, ', ',
                    case when dat.FLOW_RATA_RUN_ID is not null then '''' + dat.FLOW_RATA_RUN_ID + '''' else 'NULL' end, ', ',
                    case when dat.PROBEID is not null then '''' + dat.PROBEID + '''' else 'NULL' end, ', ',
                    case when dat.PROBE_TYPE_CD is not null then '''' + dat.PROBE_TYPE_CD + '''' else 'NULL' end, ', ',
                    case when dat.METHOD_TRAVERSE_POINT_ID is not null then '''' + dat.METHOD_TRAVERSE_POINT_ID + '''' else 'NULL' end, ', ',
                    case when dat.VEL_CAL_COEF is not null then cast(dat.VEL_CAL_COEF as varchar) else 'NULL' end, ', ',
                    case when dat.LAST_PROBE_DATE is not null then '''' + convert(varchar(10), dat.LAST_PROBE_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.AVG_VEL_DIFF_PRESSURE is not null then cast(dat.AVG_VEL_DIFF_PRESSURE as varchar) else 'NULL' end, ', ',
                    case when dat.AVG_SQ_VEL_DIFF_PRESSURE is not null then cast(dat.AVG_SQ_VEL_DIFF_PRESSURE as varchar) else 'NULL' end, ', ',
                    case when dat.T_STACK_TEMP is not null then cast(dat.T_STACK_TEMP as varchar) else 'NULL' end, ', ',
                    case when dat.NUM_WALL_EFFECTS_POINTS is not null then cast(dat.NUM_WALL_EFFECTS_POINTS as varchar) else 'NULL' end, ', ',
                    case when dat.YAW_ANGLE is not null then cast(dat.YAW_ANGLE as varchar) else 'NULL' end, ', ',
                    case when dat.PITCH_ANGLE is not null then cast(dat.PITCH_ANGLE as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_VEL is not null then cast(dat.CALC_VEL as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_CALC_VEL is not null then cast(dat.CALC_CALC_VEL as varchar) else 'NULL' end, ', ',
                    case when dat.REP_VEL is not null then cast(dat.REP_VEL as varchar) else 'NULL' end, ', ',
                    case when dat.PRESSURE_MEAS_CD is not null then '''' + dat.PRESSURE_MEAS_CD + '''' else 'NULL' end, ', ',
                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.POINT_USED_IND is not null then cast(dat.POINT_USED_IND as varchar) else 'NULL' end,
                    ' ) on conflict (', 
                    'RATA_TRAVERSE_ID', 
                    ') do update set ',
                        'FLOW_RATA_RUN_ID = EXCLUDED.FLOW_RATA_RUN_ID, ',
                        'PROBEID = EXCLUDED.PROBEID, ',
                        'PROBE_TYPE_CD = EXCLUDED.PROBE_TYPE_CD, ',
                        'METHOD_TRAVERSE_POINT_ID = EXCLUDED.METHOD_TRAVERSE_POINT_ID, ',
                        'VEL_CAL_COEF = EXCLUDED.VEL_CAL_COEF, ',
                        'LAST_PROBE_DATE = EXCLUDED.LAST_PROBE_DATE, ',
                        'AVG_VEL_DIFF_PRESSURE = EXCLUDED.AVG_VEL_DIFF_PRESSURE, ',
                        'AVG_SQ_VEL_DIFF_PRESSURE = EXCLUDED.AVG_SQ_VEL_DIFF_PRESSURE, ',
                        'T_STACK_TEMP = EXCLUDED.T_STACK_TEMP, ',
                        'NUM_WALL_EFFECTS_POINTS = EXCLUDED.NUM_WALL_EFFECTS_POINTS, ',
                        'YAW_ANGLE = EXCLUDED.YAW_ANGLE, ',
                        'PITCH_ANGLE = EXCLUDED.PITCH_ANGLE, ',
                        'CALC_VEL = EXCLUDED.CALC_VEL, ',
                        'CALC_CALC_VEL = EXCLUDED.CALC_CALC_VEL, ',
                        'REP_VEL = EXCLUDED.REP_VEL, ',
                        'PRESSURE_MEAS_CD = EXCLUDED.PRESSURE_MEAS_CD, ',
                        'POINT_USED_IND = EXCLUDED.POINT_USED_IND, ',
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
            join ECMPS.dbo.FLOW_RATA_RUN lk4
              on lk4.RATA_RUN_ID = lk3.RATA_RUN_ID
            join ECMPS.dbo.RATA_TRAVERSE dat
              on dat.FLOW_RATA_RUN_ID = lk4.FLOW_RATA_RUN_ID
)
GO


