USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgTeeInformation]    Script Date: 11/28/2022 10:37:13 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE or ALTER FUNCTION SqlGenQa.PgTeeInformation
(	
	@OrisCode           integer,
    @LocationNameFilter varchar(6)
)
RETURNS TABLE 
AS
RETURN 
(
	
    select  tee.TEST_EXTENSION_EXEMPTION_ID,
            fac.ORIS_CODE,
            fac.FACILITY_NAME,
            isnull( unt.UNITID, stp.STACK_NAME ) as LOCATION_NAME,
            prd.PERIOD_ABBREVIATION as QUARTER,
            tee.EXTENS_EXEMPT_CD,
            sys.SYSTEM_IDENTIFIER,
            sys.SYS_TYPE_CD,
            cmp.COMPONENT_IDENTIFIER,
            cmp.COMPONENT_TYPE_CD
      from  ECMPS.dbo.TEST_EXTENSION_EXEMPTION tee
            join ECMPS.dbo.MONITOR_LOCATION loc on loc.MON_LOC_ID = tee.MON_LOC_ID
            left join ECMPS.dbo.UNIT unt on unt.UNIT_ID = loc.UNIT_ID
            left join ECMPS.dbo.STACK_PIPE stp on stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
            join ECMPS.dbo.FACILITY fac on fac.FAC_ID in ( unt.FAC_ID, stp.FAC_ID )
            join ECMPS.dbo.REPORTING_PERIOD prd on prd.RPT_PERIOD_ID = tee.RPT_PERIOD_ID
            left join ECMPS.dbo.MONITOR_SYSTEM sys on sys.MON_SYS_ID = tee.MON_SYS_ID
            left join ECMPS.dbo.COMPONENT cmp on cmp.COMPONENT_ID = tee.COMPONENT_ID
     where  ( fac.ORIS_CODE = @OrisCode or @OrisCode is null )
       and  ( isnull( unt.UNITID, stp.STACK_NAME ) = @LocationNameFilter or @LocationNameFilter is null )
    
)
GO
