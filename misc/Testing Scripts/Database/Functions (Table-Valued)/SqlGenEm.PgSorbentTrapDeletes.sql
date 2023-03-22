USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgSorbentTrapDeletes]    Script Date: 2/8/2023 4:25:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION SqlGenEm.PgSorbentTrapDeletes
(	
	@TestInformationTable SqlGenEm.Em_Information_Table readonly,
    @TestOrder  integer
)
RETURNS TABLE 
AS
RETURN 
(
    select  SqlGenEm.FormatSql
            (
                sel.ORIS_CODE, sel.FACILITY_NAME, sel.LOCATIONS, sel.QUARTER, sel.LOCATION_NAME,  @TestOrder,
                concat
                (
                    'delete from camdecmpswks.SORBENT_TRAP',
                    ' where MON_LOC_ID = ''', sel.MON_LOC_ID, ''' and RPT_PERIOD_ID = ', sel.RPT_PERIOD_ID,
                    ' and coalesce( MON_SYS_ID, ''nothing'' ) = ''', isnull( sel.MON_SYS_ID, 'nothing' ), '''',
                    ' and BEGIN_DATE = ''', format( sel.BEGIN_DATE, 'yyyy-MM-dd' ), ''' and BEGIN_HOUR = ', sel.BEGIN_HOUR,
                    ' and END_DATE = ''', format( sel.END_DATE, 'yyyy-MM-dd' ), ''' and END_HOUR = ', sel.END_HOUR,
                    ';' 
                )
            ) as SQL_STATEMENT
      from  (
                select  -- ECMPSP
                        lst.ORIS_CODE, 
                        lst.FACILITY_NAME, 
                        lst.LOCATIONS, 
                        lst.QUARTER, 
                        lst.LOCATION_NAME,
                        tar.MON_LOC_ID,
                        tar.RPT_PERIOD_ID,
                        tar.MON_SYS_ID,
                        tar.BEGIN_DATE,
                        tar.BEGIN_HOUR,
                        tar.END_DATE,
                        tar.END_HOUR
                    from  @TestInformationTable lst
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.SORBENT_TRAP tar 
                            on tar.MON_LOC_ID = lst.MON_LOC_ID
                            and tar.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                except
                select  -- ECMPS_WORKING
                        lst.ORIS_CODE, 
                        lst.FACILITY_NAME, 
                        lst.LOCATIONS, 
                        lst.QUARTER, 
                        lst.LOCATION_NAME,
                        tar.MON_LOC_ID,
                        tar.RPT_PERIOD_ID,
                        tar.MON_SYS_ID,
                        tar.BEGIN_DATE,
                        tar.BEGIN_HOUR,
                        tar.END_DATE,
                        tar.END_HOUR
                    from  @TestInformationTable lst
                        join ECMPS.dbo.SORBENT_TRAP tar 
                            on tar.MON_LOC_ID = lst.MON_LOC_ID
                            and tar.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
            ) sel
)
GO


