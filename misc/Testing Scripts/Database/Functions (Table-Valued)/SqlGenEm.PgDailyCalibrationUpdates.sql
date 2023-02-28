USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgDailyCalibrationUpdates]    Script Date: 2/7/2023 1:29:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE or ALTER FUNCTION SqlGenEm.PgDailyCalibrationUpdates
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
                    'update camdecmpswks.DAILY_CALIBRATION tar set',

                    ' ONLINE_OFFLINE_IND             = ',  case when  tar.ONLINE_OFFLINE_IND             is not null  then  cast( tar.ONLINE_OFFLINE_IND as varchar ) else 'NULL' end, ', ',
                    ' UPSCALE_GAS_LEVEL_CD           = ',  case when  tar.UPSCALE_GAS_LEVEL_CD           is not null  then  concat( '''', tar.UPSCALE_GAS_LEVEL_CD, '''' ) else 'NULL' end, ', ',
                    ' ZERO_INJECTION_DATE            = ',  case when  tar.ZERO_INJECTION_DATE            is not null  then  concat( '''', format( tar.ZERO_INJECTION_DATE, 'yyyy-MM-dd'), '''' ) else 'NULL' end, ', ',
                    ' ZERO_INJECTION_HOUR            = ',  case when  tar.ZERO_INJECTION_HOUR            is not null  then  cast( tar.ZERO_INJECTION_HOUR as varchar ) else 'NULL' end, ', ',
                    ' ZERO_INJECTION_MIN             = ',  case when  tar.ZERO_INJECTION_MIN             is not null  then  cast( tar.ZERO_INJECTION_MIN as varchar ) else 'NULL' end, ', ',
                    ' UPSCALE_INJECTION_DATE         = ',  case when  tar.UPSCALE_INJECTION_DATE         is not null  then  concat( '''', format( tar.UPSCALE_INJECTION_DATE, 'yyyy-MM-dd'), '''' ) else 'NULL' end, ', ',
                    ' UPSCALE_INJECTION_HOUR         = ',  case when  tar.UPSCALE_INJECTION_HOUR         is not null  then  cast( tar.UPSCALE_INJECTION_HOUR as varchar ) else 'NULL' end, ', ',
                    ' UPSCALE_INJECTION_MIN          = ',  case when  tar.UPSCALE_INJECTION_MIN          is not null  then  cast( tar.UPSCALE_INJECTION_MIN as varchar ) else 'NULL' end, ', ',
                    ' ZERO_MEASURED_VALUE            = ',  case when  tar.ZERO_MEASURED_VALUE            is not null  then  cast( tar.ZERO_MEASURED_VALUE as varchar ) else 'NULL' end, ', ',
                    ' UPSCALE_MEASURED_VALUE         = ',  case when  tar.UPSCALE_MEASURED_VALUE         is not null  then  cast( tar.UPSCALE_MEASURED_VALUE as varchar ) else 'NULL' end, ', ',
                    ' ZERO_APS_IND                   = ',  case when  tar.ZERO_APS_IND                   is not null  then  cast( tar.ZERO_APS_IND as varchar ) else 'NULL' end, ', ',
                    ' UPSCALE_APS_IND                = ',  case when  tar.UPSCALE_APS_IND                is not null  then  cast( tar.UPSCALE_APS_IND as varchar ) else 'NULL' end, ', ',
                    ' ZERO_CAL_ERROR                 = ',  case when  tar.ZERO_CAL_ERROR                 is not null  then  cast( tar.ZERO_CAL_ERROR as varchar ) else 'NULL' end, ', ',
                    ' UPSCALE_CAL_ERROR              = ',  case when  tar.UPSCALE_CAL_ERROR              is not null  then  cast( tar.UPSCALE_CAL_ERROR as varchar ) else 'NULL' end, ', ',
                    ' ZERO_REF_VALUE                 = ',  case when  tar.ZERO_REF_VALUE                 is not null  then  cast( tar.ZERO_REF_VALUE as varchar ) else 'NULL' end, ', ',
                    ' UPSCALE_REF_VALUE              = ',  case when  tar.UPSCALE_REF_VALUE              is not null  then  cast( tar.UPSCALE_REF_VALUE as varchar ) else 'NULL' end, ', ',
                    ' UPSCALE_GAS_TYPE_CD            = ',  case when  tar.UPSCALE_GAS_TYPE_CD            is not null  then  concat( '''', tar.UPSCALE_GAS_TYPE_CD, '''' ) else 'NULL' end, ', ',
                    ' CYLINDER_IDENTIFIER            = ',  case when  tar.CYLINDER_ID                    is not null  then  concat( '''', tar.CYLINDER_ID, '''' ) else 'NULL' end, ', ',
                    ' EXPIRATION_DATE                = ',  case when  tar.EXPIRATION_DATE                is not null  then  concat( '''', format( tar.EXPIRATION_DATE, 'yyyy-MM-dd'), '''' ) else 'NULL' end, ', ',
                    ' RPT_PERIOD_ID                  = ',  case when  tar.RPT_PERIOD_ID                  is not null  then  cast( tar.RPT_PERIOD_ID as varchar ) else 'NULL' end, ', ',
                    ' VENDOR_ID                      = ',  case when  tar.VENDOR_ID                      is not null  then  concat( '''', tar.VENDOR_ID, '''' ) else 'NULL' end, ', ',
                    ' INJECTION_PROTOCOL_CD          = ',  case when  tar.INJECTION_PROTOCOL_CD          is not null  then  concat( '''', tar.INJECTION_PROTOCOL_CD, '''' ) else 'NULL' end, ', ',

                    ' USERID                         = ', '''UNITTEST''', ', ',
                    ' UPDATE_DATE                    = ', concat( '''', format( getdate(), 'yyyy-MM-dd'), '''' ),

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
                select  dat.ORIS_CODE, 
                        dat.FACILITY_NAME, 
                        dat.LOCATIONS, 
                        dat.QUARTER, 
                        dat.LOCATION_NAME,
                        dat.MON_LOC_ID,
                        dat.RPT_PERIOD_ID,
                        dat.TEST_TYPE_CD,
                        dat.COMPONENT_ID,
                        dat.MON_SYS_ID,
                        dat.DAILY_TEST_DATE,
                        dat.DAILY_TEST_HOUR,
                        dat.DAILY_TEST_MIN,
                        dat.SPAN_SCALE_CD,
                        count( 1 ) as ROW_COUNT
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
                                    dts.SPAN_SCALE_CD,
                                    tar.ONLINE_OFFLINE_IND,
                                    tar.UPSCALE_GAS_LEVEL_CD,
                                    tar.ZERO_INJECTION_DATE,
                                    tar.ZERO_INJECTION_HOUR,
                                    tar.ZERO_INJECTION_MIN,
                                    tar.UPSCALE_INJECTION_DATE,
                                    tar.UPSCALE_INJECTION_HOUR,
                                    tar.UPSCALE_INJECTION_MIN,
                                    tar.ZERO_MEASURED_VALUE,
                                    tar.UPSCALE_MEASURED_VALUE,
                                    tar.ZERO_APS_IND,
                                    tar.UPSCALE_APS_IND,
                                    tar.ZERO_CAL_ERROR,
                                    tar.UPSCALE_CAL_ERROR,
                                    tar.ZERO_REF_VALUE,
                                    tar.UPSCALE_REF_VALUE,
                                    tar.UPSCALE_GAS_TYPE_CD,
                                    tar.CYLINDER_ID,
                                    tar.EXPIRATION_DATE,
                                    tar.VENDOR_ID,
                                    tar.INJECTION_PROTOCOL_CD
                              from  @TestInformationTable lst
                                    join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.DAILY_TEST_SUMMARY dts 
                                      on dts.MON_LOC_ID = lst.MON_LOC_ID
                                     and dts.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                                    join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.DAILY_CALIBRATION tar 
                                        on tar.DAILY_TEST_SUM_ID = dts.DAILY_TEST_SUM_ID
                            union
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
                                    dts.SPAN_SCALE_CD,
                                    tar.ONLINE_OFFLINE_IND,
                                    tar.UPSCALE_GAS_LEVEL_CD,
                                    tar.ZERO_INJECTION_DATE,
                                    tar.ZERO_INJECTION_HOUR,
                                    tar.ZERO_INJECTION_MIN,
                                    tar.UPSCALE_INJECTION_DATE,
                                    tar.UPSCALE_INJECTION_HOUR,
                                    tar.UPSCALE_INJECTION_MIN,
                                    tar.ZERO_MEASURED_VALUE,
                                    tar.UPSCALE_MEASURED_VALUE,
                                    tar.ZERO_APS_IND,
                                    tar.UPSCALE_APS_IND,
                                    tar.ZERO_CAL_ERROR,
                                    tar.UPSCALE_CAL_ERROR,
                                    tar.ZERO_REF_VALUE,
                                    tar.UPSCALE_REF_VALUE,
                                    tar.UPSCALE_GAS_TYPE_CD,
                                    tar.CYLINDER_ID,
                                    tar.EXPIRATION_DATE,
                                    tar.VENDOR_ID,
                                    tar.INJECTION_PROTOCOL_CD
                              from  @TestInformationTable lst
                                    join ECMPS.dbo.DAILY_TEST_SUMMARY dts 
                                      on dts.MON_LOC_ID = lst.MON_LOC_ID
                                     and dts.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                                    join ECMPS.dbo.DAILY_CALIBRATION tar 
                                        on tar.DAILY_TEST_SUM_ID = dts.DAILY_TEST_SUM_ID
                        ) dat
                 group
                    by  dat.ORIS_CODE, 
                        dat.FACILITY_NAME, 
                        dat.LOCATIONS, 
                        dat.QUARTER, 
                        dat.LOCATION_NAME,
                        dat.MON_LOC_ID,
                        dat.RPT_PERIOD_ID,
                        dat.TEST_TYPE_CD,
                        dat.COMPONENT_ID,
                        dat.MON_SYS_ID,
                        dat.DAILY_TEST_DATE,
                        dat.DAILY_TEST_HOUR,
                        dat.DAILY_TEST_MIN,
                        dat.SPAN_SCALE_CD
                having  ( count( 1 ) > 1 )
            ) sel
        join ECMPS.dbo.DAILY_TEST_SUMMARY dts
            on dts.MON_LOC_ID = sel.MON_LOC_ID
            and dts.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
            and dts.TEST_TYPE_CD = sel.TEST_TYPE_CD
            and isnull( dts.COMPONENT_ID, 'nothing' ) = isnull( sel.COMPONENT_ID, 'nothing' )
            and isnull( dts.MON_SYS_ID, 'nothing' ) = isnull( sel.MON_SYS_ID, 'nothing' )
            and dts.DAILY_TEST_DATE = sel.DAILY_TEST_DATE
            and dts.DAILY_TEST_HOUR = sel.DAILY_TEST_HOUR
            and dts.DAILY_TEST_MIN = sel.DAILY_TEST_MIN
            and isnull( dts.SPAN_SCALE_CD, 'nothing' ) = isnull( sel.SPAN_SCALE_CD, 'nothing' )
        join ECMPS.dbo.DAILY_CALIBRATION tar 
            on tar.DAILY_TEST_SUM_ID = dts.DAILY_TEST_SUM_ID
)
GO


