USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgQatInformation]    Script Date: 2/7/2023 1:56:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE or ALTER FUNCTION SqlGenEm.PgEmInformation
(	
	@OrisCode           integer,
    @Year               integer,
    @Quarter            integer,
    @LocationNameFilter varchar(6)
)
RETURNS TABLE 
AS
RETURN 
(
    -- ECMPS_WORKING
    select  fac.ORIS_CODE,
            fac.FACILITY_NAME,
            ECMPS.dbo.ConcatMonitorPlanLocations( ems.MON_PLAN_ID ) as LOCATIONS,
            prd.PERIOD_ABBREVIATION as QUARTER,
            isnull( unt.UNITID, stp.STACK_NAME ) as LOCATION_NAME,
            ems.MON_PLAN_ID,
            ems.RPT_PERIOD_ID,
            mpl.MON_LOC_ID
      from  ECMPS.dbo.EMISSION_EVALUATION ems
            join ECMPS.dbo.REPORTING_PERIOD prd
              on prd.RPT_PERIOD_ID = ems.RPT_PERIOD_ID
            join ECMPS.dbo.MONITOR_PLAN_LOCATION mpl
              on mpl.MON_PLAN_ID = EMS.MON_PLAN_ID
            join ECMPS.dbo.MONITOR_LOCATION loc
              ON loc.MON_LOC_ID = mpl.MON_LOC_ID
            left join ECMPS.dbo.UNIT unt 
              on unt.UNIT_ID = loc.UNIT_ID
            left join ECMPS.dbo.STACK_PIPE stp 
              on stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
            join ECMPS.dbo.FACILITY fac 
              on fac.FAC_ID in ( unt.FAC_ID, stp.FAC_ID )
     where  ( fac.ORIS_CODE = @OrisCode or @OrisCode is null )
       and  ( prd.CALENDAR_YEAR = @Year or @Year is null )
       and  ( prd.QUARTER = @Quarter or @Quarter is null )
       and  ( 
                @LocationNameFilter is null
                or
                exists  
                ( 
                    select  1
                      from  ECMPS.dbo.MONITOR_PLAN_LOCATION xpl
                            join ECMPS.dbo.MONITOR_LOCATION xlc
                              on xlc.MON_LOC_ID = xpl.MON_LOC_ID
                            left join ECMPS.dbo.UNIT xun
                              on xun.UNIT_ID = xlc.UNIT_ID
                            left join ECMPS.dbo.STACK_PIPE xsp
                              on xsp.STACK_PIPE_ID = xlc.STACK_PIPE_ID
                     where  xpl.MON_PLAN_ID = ems.MON_PLAN_ID
                       and  isnull( xun.UNITID, xsp.STACK_NAME ) = @LocationNameFilter
                )
            )
    union
    -- ECMPSP
    select  fac.ORIS_CODE,
            fac.FACILITY_NAME,
            ECMPS.dbo.ConcatMonitorPlanLocations( ems.MON_PLAN_ID ) as LOCATIONS,
            prd.PERIOD_ABBREVIATION as QUARTER,
            isnull( unt.UNITID, stp.STACK_NAME ) as LOCATION_NAME,
            ems.MON_PLAN_ID,
            ems.RPT_PERIOD_ID,
            mpl.MON_LOC_ID
      from  [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.EMISSION_EVALUATION ems
            join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.REPORTING_PERIOD prd
              on prd.RPT_PERIOD_ID = ems.RPT_PERIOD_ID
            join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.MONITOR_PLAN_LOCATION mpl
              on mpl.MON_PLAN_ID = EMS.MON_PLAN_ID
            join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.MONITOR_LOCATION loc
              ON loc.MON_LOC_ID = mpl.MON_LOC_ID
            left join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.UNIT unt 
              on unt.UNIT_ID = loc.UNIT_ID
            left join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.STACK_PIPE stp 
              on stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
            join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.FACILITY fac 
              on fac.FAC_ID in ( unt.FAC_ID, stp.FAC_ID )
     where  ( fac.ORIS_CODE = @OrisCode or @OrisCode is null )
       and  ( prd.CALENDAR_YEAR = @Year or @Year is null )
       and  ( prd.QUARTER = @Quarter or @Quarter is null )
       and  ( 
                @LocationNameFilter is null
                or
                exists  
                ( 
                    select  1
                      from  [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.MONITOR_PLAN_LOCATION xpl
                            join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.MONITOR_LOCATION xlc
                              on xlc.MON_LOC_ID = xpl.MON_LOC_ID
                            left join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.UNIT xun
                              on xun.UNIT_ID = xlc.UNIT_ID
                            left join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.STACK_PIPE xsp
                              on xsp.STACK_PIPE_ID = xlc.STACK_PIPE_ID
                     where  xpl.MON_PLAN_ID = ems.MON_PLAN_ID
                       and  isnull( xun.UNITID, xsp.STACK_NAME ) = @LocationNameFilter
                )
            )
)
GO


