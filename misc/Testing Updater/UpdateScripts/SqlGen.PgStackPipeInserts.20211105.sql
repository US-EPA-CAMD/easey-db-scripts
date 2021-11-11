USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGen].[PgStackPipeInserts]    Script Date: 11/5/2021 11:59:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER FUNCTION [SqlGen].[PgStackPipeInserts] 
(	
	@vMonitorPlanIdTable SqlGen.Monitor_Plan_Id_Table readonly
)
RETURNS TABLE 
AS
RETURN 
(
    select  concat
            (
                'insert into ', 
                'STACK_PIPE', 
                ' ( ', 
                'STACK_PIPE_ID, FAC_ID, STACK_NAME, ACTIVE_DATE, RETIRE_DATE, USERID, ADD_DATE, UPDATE_DATE', 
                ' ) values ( ',
                case when dat.STACK_PIPE_ID is not null then '''' + dat.STACK_PIPE_ID + '''' else 'NULL' end, ', ',
                case when dat.FAC_ID is not null then cast(dat.FAC_ID as varchar) else 'NULL' end, ', ', 
                case when dat.STACK_NAME is not null then '''' + dat.STACK_NAME + '''' else 'NULL' end, ', ',
                case when ACTIVE_DATE is not null then '''' + convert(varchar(10), ACTIVE_DATE, 120) + '''' else 'NULL' end, ', ', 
                case when RETIRE_DATE is not null then '''' + convert(varchar(10), RETIRE_DATE, 120) + '''' else 'NULL' end, ', ', 
                case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end,
                ' ) on conflict (', 
                'STACK_PIPE_ID', 
                ') do update set ',
                'FAC_ID', ' = EXCLUDED.', 'FAC_ID', ', ',
                'STACK_NAME', ' = EXCLUDED.', 'STACK_NAME', ', ',
                'ACTIVE_DATE', ' = EXCLUDED.', 'ACTIVE_DATE', ', ',
                'RETIRE_DATE', ' = EXCLUDED.', 'RETIRE_DATE', ', ',
                'USERID', ' = EXCLUDED.', 'USERID', ', ',
                'ADD_DATE', ' = EXCLUDED.', 'ADD_DATE', ', ',
                'UPDATE_DATE', ' = EXCLUDED.', 'UPDATE_DATE', ';'
            ) as SQL_STATEMENT
      from  @vMonitorPlanIdTable lst
            join ECMPS.dbo.MONITOR_PLAN_LOCATION mpl
              on mpl.MON_PLAN_ID = lst.MON_PLAN_ID
            join ECMPS.dbo.MONITOR_LOCATION loc
              on loc.MON_LOC_ID = mpl.MON_LOC_ID
            join ECMPS.dbo.STACK_PIPE dat
              on dat.STACK_PIPE_ID = loc.STACK_PIPE_ID
)
GO


