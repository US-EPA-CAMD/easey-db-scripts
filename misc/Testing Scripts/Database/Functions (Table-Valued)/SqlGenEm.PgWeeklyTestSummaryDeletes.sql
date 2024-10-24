USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgWeeklyTestSummaryDeletes]    Script Date: 2/8/2023 4:25:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION SqlGenEm.PgWeeklyTestSummaryDeletes
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
                    'delete from camdecmpswks.WEEKLY_TEST_SUMMARY',
                    ' where MON_LOC_ID = ''', sel.MON_LOC_ID, ''' and RPT_PERIOD_ID = ', sel.RPT_PERIOD_ID, ' and TEST_TYPE_CD = ''', sel.TEST_TYPE_CD, '''',
                    ' and coalesce( COMPONENT_ID, ''nothing'' ) = ''', isnull( sel.COMPONENT_ID, 'nothing' ), '''',
                    ' and coalesce( MON_SYS_ID, ''nothing'' ) = ''', isnull( sel.MON_SYS_ID, 'nothing' ), '''',
                    ' and TEST_DATE = ''', format( sel.TEST_DATE, 'yyyy-MM-dd' ), ''' and TEST_HOUR = ', sel.TEST_HOUR, ' and TEST_MIN = ', sel.TEST_MIN,
                    ' and coalesce( SPAN_SCALE_CD, ''nothing'' ) = ''', isnull( sel.SPAN_SCALE_CD, 'nothing' ), '''',
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
                        tar.TEST_TYPE_CD,
                        tar.COMPONENT_ID,
                        tar.MON_SYS_ID,
                        tar.TEST_DATE,
                        tar.TEST_HOUR,
                        tar.TEST_MIN,
                        tar.SPAN_SCALE_CD
                    from  @TestInformationTable lst
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.WEEKLY_TEST_SUMMARY tar 
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
                        tar.TEST_TYPE_CD,
                        tar.COMPONENT_ID,
                        tar.MON_SYS_ID,
                        tar.TEST_DATE,
                        tar.TEST_HOUR,
                        tar.TEST_MIN,
                        tar.SPAN_SCALE_CD
                    from  @TestInformationTable lst
                        join ECMPS.dbo.WEEKLY_TEST_SUMMARY tar 
                            on tar.MON_LOC_ID = lst.MON_LOC_ID
                            and tar.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
            ) sel
)
GO


