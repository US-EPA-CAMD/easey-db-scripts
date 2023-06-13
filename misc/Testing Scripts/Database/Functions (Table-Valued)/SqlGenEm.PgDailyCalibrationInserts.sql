USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgDailyCalibrationInserts]    Script Date: 2/8/2023 2:37:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER   FUNCTION SqlGenEm.PgDailyCalibrationInserts
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
                    'insert into camdecmpswks.DAILY_CALIBRATION',
                    ' (',
                        ' CAL_INJ_ID', ',',
                        ' DAILY_TEST_SUM_ID', ',',

                        ' ONLINE_OFFLINE_IND', ',',
                        ' UPSCALE_GAS_LEVEL_CD', ',',
                        ' ZERO_INJECTION_DATE', ',',
                        ' ZERO_INJECTION_HOUR', ',',
                        ' ZERO_INJECTION_MIN', ',',
                        ' UPSCALE_INJECTION_DATE', ',',
                        ' UPSCALE_INJECTION_HOUR', ',',
                        ' UPSCALE_INJECTION_MIN', ',',
                        ' ZERO_MEASURED_VALUE', ',',
                        ' UPSCALE_MEASURED_VALUE', ',',
                        ' ZERO_APS_IND', ',',
                        ' UPSCALE_APS_IND', ',',
                        ' ZERO_CAL_ERROR', ',',
                        ' UPSCALE_CAL_ERROR', ',',
                        ' ZERO_REF_VALUE', ',',
                        ' UPSCALE_REF_VALUE', ',',
                        ' UPSCALE_GAS_TYPE_CD', ',',
                        ' CYLINDER_IDENTIFIER', ',',
                        ' EXPIRATION_DATE', ',',
                        ' RPT_PERIOD_ID', ',',
                        ' VENDOR_ID', ',',
                        ' INJECTION_PROTOCOL_CD', ',',

                        ' USERID', ',',
                        ' ADD_DATE', ',',
                        ' UPDATE_DATE',
                    ' )',
                    ' values',
                    ' (',
                        '''UNITTEST-'' || uuid_generate_v4()', ', ',
                        ' ( ', 
                        ' select dts.DAILY_TEST_SUM_ID from camdecmpswks.DAILY_TEST_SUMMARY dts',
                        ' where dts.MON_LOC_ID = ''', sel.MON_LOC_ID, ''' and dts.RPT_PERIOD_ID = ', sel.RPT_PERIOD_ID, ' and dts.TEST_TYPE_CD = ''', sel.TEST_TYPE_CD, '''',
                        ' and coalesce( dts.COMPONENT_ID, ''nothing'' ) = ''', isnull( sel.COMPONENT_ID, 'nothing' ), '''',
                        ' and coalesce( dts.MON_SYS_ID, ''nothing'' ) = ''', isnull( sel.MON_SYS_ID, 'nothing' ), '''',
                        ' and dts.DAILY_TEST_DATE = ''', format( sel.DAILY_TEST_DATE, 'yyyy-MM-dd' ), ''' and dts.DAILY_TEST_HOUR = ', sel.DAILY_TEST_HOUR, ' and coalesce( dts.DAILY_TEST_MIN, -1 ) = ', coalesce( sel.DAILY_TEST_MIN, -1 ),
                        ' and coalesce( dts.SPAN_SCALE_CD, ''nothing'' ) = ''', isnull( sel.SPAN_SCALE_CD, 'nothing' ), '''',
                        ' )', ', ',
                        
                        case when  tar.ONLINE_OFFLINE_IND             is not null  then  cast( tar.ONLINE_OFFLINE_IND as varchar ) else 'NULL' end, ', ',
                        case when  tar.UPSCALE_GAS_LEVEL_CD           is not null  then  concat( '''', tar.UPSCALE_GAS_LEVEL_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.ZERO_INJECTION_DATE            is not null  then  concat( '''', format( tar.ZERO_INJECTION_DATE, 'yyyy-MM-dd'), '''' ) else 'NULL' end, ', ',
                        case when  tar.ZERO_INJECTION_HOUR            is not null  then  cast( tar.ZERO_INJECTION_HOUR as varchar ) else 'NULL' end, ', ',
                        case when  tar.ZERO_INJECTION_MIN             is not null  then  cast( tar.ZERO_INJECTION_MIN as varchar ) else 'NULL' end, ', ',
                        case when  tar.UPSCALE_INJECTION_DATE         is not null  then  concat( '''', format( tar.UPSCALE_INJECTION_DATE, 'yyyy-MM-dd'), '''' ) else 'NULL' end, ', ',
                        case when  tar.UPSCALE_INJECTION_HOUR         is not null  then  cast( tar.UPSCALE_INJECTION_HOUR as varchar ) else 'NULL' end, ', ',
                        case when  tar.UPSCALE_INJECTION_MIN          is not null  then  cast( tar.UPSCALE_INJECTION_MIN as varchar ) else 'NULL' end, ', ',
                        case when  tar.ZERO_MEASURED_VALUE            is not null  then  cast( tar.ZERO_MEASURED_VALUE as varchar ) else 'NULL' end, ', ',
                        case when  tar.UPSCALE_MEASURED_VALUE         is not null  then  cast( tar.UPSCALE_MEASURED_VALUE as varchar ) else 'NULL' end, ', ',
                        case when  tar.ZERO_APS_IND                   is not null  then  cast( tar.ZERO_APS_IND as varchar ) else 'NULL' end, ', ',
                        case when  tar.UPSCALE_APS_IND                is not null  then  cast( tar.UPSCALE_APS_IND as varchar ) else 'NULL' end, ', ',
                        case when  tar.ZERO_CAL_ERROR                 is not null  then  cast( tar.ZERO_CAL_ERROR as varchar ) else 'NULL' end, ', ',
                        case when  tar.UPSCALE_CAL_ERROR              is not null  then  cast( tar.UPSCALE_CAL_ERROR as varchar ) else 'NULL' end, ', ',
                        case when  tar.ZERO_REF_VALUE                 is not null  then  cast( tar.ZERO_REF_VALUE as varchar ) else 'NULL' end, ', ',
                        case when  tar.UPSCALE_REF_VALUE              is not null  then  cast( tar.UPSCALE_REF_VALUE as varchar ) else 'NULL' end, ', ',
                        case when  tar.UPSCALE_GAS_TYPE_CD            is not null  then  concat( '''', tar.UPSCALE_GAS_TYPE_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.CYLINDER_ID                    is not null  then  concat( '''', tar.CYLINDER_ID, '''' ) else 'NULL' end, ', ',
                        case when  tar.EXPIRATION_DATE                is not null  then  concat( '''', format( tar.EXPIRATION_DATE, 'yyyy-MM-dd'), '''' ) else 'NULL' end, ', ',
                        case when  tar.RPT_PERIOD_ID                  is not null  then  cast( tar.RPT_PERIOD_ID as varchar ) else 'NULL' end, ', ',
                        case when  tar.VENDOR_ID                      is not null  then  concat( '''', tar.VENDOR_ID, '''' ) else 'NULL' end, ', ',
                        case when  tar.INJECTION_PROTOCOL_CD          is not null  then  concat( '''', tar.INJECTION_PROTOCOL_CD, '''' ) else 'NULL' end, ', ',

                        '''UNITTEST''', ', ',
                        concat( '''', format( getdate(), 'yyyy-MM-dd'), '''' ), ', ',
                        'NULL',
                    ' );'
                )
            ) as SQL_STATEMENT
      from  (
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
                except
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
            ) sel
        join ECMPS.dbo.DAILY_TEST_SUMMARY dts
            on dts.MON_LOC_ID = sel.MON_LOC_ID
            and dts.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
            and dts.TEST_TYPE_CD = sel.TEST_TYPE_CD
            and isnull( dts.COMPONENT_ID, 'nothing' ) = isnull( sel.COMPONENT_ID, 'nothing' )
            and isnull( dts.MON_SYS_ID, 'nothing' ) = isnull( sel.MON_SYS_ID, 'nothing' )
            and dts.DAILY_TEST_DATE = sel.DAILY_TEST_DATE
            and dts.DAILY_TEST_HOUR = sel.DAILY_TEST_HOUR
            and isnull( dts.DAILY_TEST_MIN, -1 ) = isnull( sel.DAILY_TEST_MIN, -1 )
            and isnull( dts.SPAN_SCALE_CD, 'nothing' ) = isnull( sel.SPAN_SCALE_CD, 'nothing' )
        join ECMPS.dbo.DAILY_CALIBRATION tar 
            on tar.DAILY_TEST_SUM_ID = dts.DAILY_TEST_SUM_ID
)
GO


