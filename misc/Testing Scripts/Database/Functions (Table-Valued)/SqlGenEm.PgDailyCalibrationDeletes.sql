USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgDailyCalibrationDeletes]    Script Date: 2/11/2023 6:40:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION SqlGenEm.PgDailyCalibrationDeletes
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
                    'delete from camdecmpswks.DAILY_CALIBRATION tar',
                    ' where  exists', 
                    ' (', 
                    ' select 1 from camdecmpswks.DAILY_TEST_SUMMARY dts', 
                    ' where MON_LOC_ID = ''', sel.MON_LOC_ID, ''' and RPT_PERIOD_ID = ', sel.RPT_PERIOD_ID, ' and TEST_TYPE_CD = ''', sel.TEST_TYPE_CD, '''',
                    ' and coalesce( COMPONENT_ID, ''nothing'' ) = ''', isnull( sel.COMPONENT_ID, 'nothing' ), '''',
                    ' and coalesce( MON_SYS_ID, ''nothing'' ) = ''', isnull( sel.MON_SYS_ID, 'nothing' ), '''',
                    ' and DAILY_TEST_DATE = ''', format( sel.DAILY_TEST_DATE, 'yyyy-MM-dd' ), ''' and DAILY_TEST_HOUR = ', sel.DAILY_TEST_HOUR, ' and DAILY_TEST_MIN = ', sel.DAILY_TEST_MIN,
                    ' and coalesce( SPAN_SCALE_CD, ''nothing'' ) = ''', isnull( sel.SPAN_SCALE_CD, 'nothing' ), '''',
                    ' and tar.DAILY_TEST_SUM_ID = dts.DAILY_TEST_SUM_ID',
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
                        dts.MON_LOC_ID,
                        dts.RPT_PERIOD_ID,
                        dts.TEST_TYPE_CD,
                        dts.COMPONENT_ID,
                        dts.MON_SYS_ID,
                        dts.DAILY_TEST_DATE,
                        dts.DAILY_TEST_HOUR,
                        dts.DAILY_TEST_MIN,
                        dts.SPAN_SCALE_CD
                    from  @TestInformationTable lst
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.DAILY_TEST_SUMMARY dts 
                            on dts.MON_LOC_ID = lst.MON_LOC_ID
                            and dts.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.DAILY_CALIBRATION tar 
                            on tar.DAILY_TEST_SUM_ID = dts.DAILY_TEST_SUM_ID
                except
                select  -- ECMPS_WORKING
                        lst.ORIS_CODE, 
                        lst.FACILITY_NAME, 
                        lst.LOCATIONS, 
                        lst.QUARTER, 
                        lst.LOCATION_NAME,
                        dts.MON_LOC_ID,
                        dts.RPT_PERIOD_ID,
                        dts.TEST_TYPE_CD,
                        dts.COMPONENT_ID,
                        dts.MON_SYS_ID,
                        dts.DAILY_TEST_DATE,
                        dts.DAILY_TEST_HOUR,
                        dts.DAILY_TEST_MIN,
                        dts.SPAN_SCALE_CD
                    from  @TestInformationTable lst
                        join ECMPS.dbo.DAILY_TEST_SUMMARY dts 
                            on dts.MON_LOC_ID = lst.MON_LOC_ID
                            and dts.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                        join ECMPS.dbo.DAILY_CALIBRATION tar 
                            on tar.DAILY_TEST_SUM_ID = dts.DAILY_TEST_SUM_ID
            ) sel
)
GO


