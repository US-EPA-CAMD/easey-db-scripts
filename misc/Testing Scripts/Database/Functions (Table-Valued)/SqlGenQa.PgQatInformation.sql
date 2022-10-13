USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgQatInserts]    Script Date: 9/6/2022 3:26:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE or ALTER FUNCTION SqlGenQa.PgQatInformation
(	
	@OrisCode           integer,
    @LocationNameFilter varchar(6),
    @TestTypeCdFilter   varchar(7)
)
RETURNS TABLE 
AS
RETURN 
(
	
    select  tst.TEST_SUM_ID,
            fac.ORIS_CODE,
            fac.FACILITY_NAME,
            isnull( unt.UNITID, stp.STACK_NAME ) as LOCATION_NAME,
            tst.TEST_TYPE_CD,
            tst.TEST_NUM
      from  ECMPS.dbo.MONITOR_LOCATION loc
            left join ECMPS.dbo.UNIT unt 
              on unt.UNIT_ID = loc.UNIT_ID
            left join ECMPS.dbo.STACK_PIPE stp 
              on stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
            join ECMPS.dbo.FACILITY fac 
              on fac.FAC_ID in ( unt.FAC_ID, stp.FAC_ID )
            join ECMPS.dbo.TEST_SUMMARY tst 
              on tst.MON_LOC_ID = loc.MON_LOC_ID
     where  ( fac.ORIS_CODE = @OrisCode or @OrisCode is null )
       and  ( isnull( unt.UNITID, stp.STACK_NAME ) = @LocationNameFilter or @LocationNameFilter is null )
       and  ( tst.TEST_TYPE_CD = @TestTypeCdFilter or @TestTypeCdFilter is null )
       and  tst.TEST_TYPE_CD in ( 'APPE', 'FF2LBAS','FF2LTST', 'HGLINE', 'HGSI3', 'LINE', 'RATA', 'UNITDEF' )
    
)
GO
