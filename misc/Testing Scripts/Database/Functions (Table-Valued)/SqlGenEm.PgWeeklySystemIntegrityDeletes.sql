USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgWeeklySystemIntegrityDeletes]    Script Date: 2/11/2023 6:40:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION SqlGenEm.PgWeeklySystemIntegrityDeletes
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
                    'delete from camdecmpswks.WEEKLY_SYSTEM_INTEGRITY tar',
                    ' where  exists', 
                    ' (', 
                    ' select 1 from camdecmpswks.WEEKLY_TEST_SUMMARY wts', 
                    ' where MON_LOC_ID = ''', sel.MON_LOC_ID, ''' and RPT_PERIOD_ID = ', sel.RPT_PERIOD_ID, ' and TEST_TYPE_CD = ''', sel.TEST_TYPE_CD, '''',
                    ' and coalesce( COMPONENT_ID, ''nothing'' ) = ''', isnull( sel.COMPONENT_ID, 'nothing' ), '''',
                    ' and coalesce( MON_SYS_ID, ''nothing'' ) = ''', isnull( sel.MON_SYS_ID, 'nothing' ), '''',
                    ' and TEST_DATE = ''', format( sel.TEST_DATE, 'yyyy-MM-dd' ), ''' and TEST_HOUR = ', sel.TEST_HOUR, ' and TEST_MIN = ', sel.TEST_MIN,
                    ' and coalesce( SPAN_SCALE_CD, ''nothing'' ) = ''', isnull( sel.SPAN_SCALE_CD, 'nothing' ), '''',
                    ' and tar.WEEKLY_TEST_SUM_ID = wts.WEEKLY_TEST_SUM_ID',
                    ' )',
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
                        wts.MON_LOC_ID,
                        wts.RPT_PERIOD_ID,
                        wts.TEST_TYPE_CD,
                        wts.COMPONENT_ID,
                        wts.MON_SYS_ID,
                        wts.TEST_DATE,
                        wts.TEST_HOUR,
                        wts.TEST_MIN,
                        wts.SPAN_SCALE_CD
                    from  @TestInformationTable lst
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.WEEKLY_TEST_SUMMARY wts 
                            on wts.MON_LOC_ID = lst.MON_LOC_ID
                            and wts.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.WEEKLY_SYSTEM_INTEGRITY tar 
                            on tar.WEEKLY_TEST_SUM_ID = wts.WEEKLY_TEST_SUM_ID
                except
                select  -- ECMPS_WORKING
                        lst.ORIS_CODE, 
                        lst.FACILITY_NAME, 
                        lst.LOCATIONS, 
                        lst.QUARTER, 
                        lst.LOCATION_NAME,
                        wts.MON_LOC_ID,
                        wts.RPT_PERIOD_ID,
                        wts.TEST_TYPE_CD,
                        wts.COMPONENT_ID,
                        wts.MON_SYS_ID,
                        wts.TEST_DATE,
                        wts.TEST_HOUR,
                        wts.TEST_MIN,
                        wts.SPAN_SCALE_CD
                    from  @TestInformationTable lst
                        join ECMPS.dbo.WEEKLY_TEST_SUMMARY wts 
                            on wts.MON_LOC_ID = lst.MON_LOC_ID
                            and wts.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                        join ECMPS.dbo.WEEKLY_SYSTEM_INTEGRITY tar 
                            on tar.WEEKLY_TEST_SUM_ID = wts.WEEKLY_TEST_SUM_ID
            ) sel
)
GO


