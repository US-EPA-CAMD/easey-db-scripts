USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgQceInformation]    Script Date: 11/23/2022 2:29:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE or ALTER FUNCTION SqlGenQa.PgQceInformation
(	
	@OrisCode           integer,
    @LocationNameFilter varchar(6)
)
RETURNS TABLE 
AS
RETURN 
(
	
    select  qce.QA_CERT_EVENT_ID,
            fac.ORIS_CODE,
            fac.FACILITY_NAME,
            isnull( unt.UNITID, stp.STACK_NAME ) as LOCATION_NAME,
            qce.QA_CERT_EVENT_CD,
            qce.QA_CERT_EVENT_DATE,
            qce.QA_CERT_EVENT_HOUR,
            sys.SYSTEM_IDENTIFIER,
            sys.SYS_TYPE_CD,
            cmp.COMPONENT_IDENTIFIER,
            cmp.COMPONENT_TYPE_CD
      from  ECMPS.dbo.QA_CERT_EVENT qce
            join ECMPS.dbo.MONITOR_LOCATION loc on loc.MON_LOC_ID = qce.MON_LOC_ID
            left join ECMPS.dbo.UNIT unt on unt.UNIT_ID = loc.UNIT_ID
            left join ECMPS.dbo.STACK_PIPE stp on stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
            join ECMPS.dbo.FACILITY fac on fac.FAC_ID in ( unt.FAC_ID, stp.FAC_ID )
            left join ECMPS.dbo.MONITOR_SYSTEM sys on sys.MON_SYS_ID = qce.MON_SYS_ID
            left join ECMPS.dbo.COMPONENT cmp on cmp.COMPONENT_ID = qce.COMPONENT_ID
     where  ( fac.ORIS_CODE = @OrisCode or @OrisCode is null )
       and  ( isnull( unt.UNITID, stp.STACK_NAME ) = @LocationNameFilter or @LocationNameFilter is null )
    
)
GO
