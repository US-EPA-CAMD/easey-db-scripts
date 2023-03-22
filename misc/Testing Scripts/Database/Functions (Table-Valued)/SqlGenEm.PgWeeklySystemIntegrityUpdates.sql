USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgWeeklySystemIntegrityUpdates]    Script Date: 2/7/2023 1:29:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE or ALTER FUNCTION SqlGenEm.PgWeeklySystemIntegrityUpdates
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
                    'update camdecmpswks.WEEKLY_SYSTEM_INTEGRITY tar set',

                    ' GAS_LEVEL_CD                   = ',  case when  tar.GAS_LEVEL_CD                   is not null  then  concat( '''', tar.GAS_LEVEL_CD, '''' ) else 'NULL' end, ', ',
                    ' REF_VALUE                      = ',  case when  tar.REF_VALUE                      is not null  then  cast( tar.REF_VALUE as varchar ) else 'NULL' end, ', ',
                    ' MEASURED_VALUE                 = ',  case when  tar.MEASURED_VALUE                 is not null  then  cast( tar.MEASURED_VALUE as varchar ) else 'NULL' end, ', ',
                    ' SYSTEM_INTEGRITY_ERROR         = ',  case when  tar.SYSTEM_INTEGRITY_ERROR         is not null  then  cast( tar.SYSTEM_INTEGRITY_ERROR as varchar ) else 'NULL' end, ', ',
                    ' APS_IND                        = ',  case when  tar.APS_IND                        is not null  then  cast( tar.APS_IND as varchar ) else 'NULL' end, ', ',

                    ' USERID                         = ', '''UNITTEST''', ', ',
                    ' UPDATE_DATE                    = ', concat( '''', format( getdate(), 'yyyy-MM-dd'), '''' ),

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
                        dat.TEST_DATE,
                        dat.TEST_HOUR,
                        dat.TEST_MIN,
                        dat.SPAN_SCALE_CD,
                        count( 1 ) as ROW_COUNT
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
                                    wts.SPAN_SCALE_CD,
                                    tar.GAS_LEVEL_CD,
                                    tar.REF_VALUE,
                                    tar.MEASURED_VALUE,
                                    tar.SYSTEM_INTEGRITY_ERROR,
                                    tar.APS_IND
                              from  @TestInformationTable lst
                                    join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.WEEKLY_TEST_SUMMARY wts 
                                      on wts.MON_LOC_ID = lst.MON_LOC_ID
                                     and wts.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                                    join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.WEEKLY_SYSTEM_INTEGRITY tar 
                                        on tar.WEEKLY_TEST_SUM_ID = wts.WEEKLY_TEST_SUM_ID
                            union
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
                                    wts.SPAN_SCALE_CD,
                                    tar.GAS_LEVEL_CD,
                                    tar.REF_VALUE,
                                    tar.MEASURED_VALUE,
                                    tar.SYSTEM_INTEGRITY_ERROR,
                                    tar.APS_IND
                              from  @TestInformationTable lst
                                    join ECMPS.dbo.WEEKLY_TEST_SUMMARY wts 
                                      on wts.MON_LOC_ID = lst.MON_LOC_ID
                                     and wts.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                                    join ECMPS.dbo.WEEKLY_SYSTEM_INTEGRITY tar 
                                        on tar.WEEKLY_TEST_SUM_ID = wts.WEEKLY_TEST_SUM_ID
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
                        dat.TEST_DATE,
                        dat.TEST_HOUR,
                        dat.TEST_MIN,
                        dat.SPAN_SCALE_CD
                having  ( count( 1 ) > 1 )
            ) sel
        join ECMPS.dbo.WEEKLY_TEST_SUMMARY wts
            on wts.MON_LOC_ID = sel.MON_LOC_ID
            and wts.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
            and wts.TEST_TYPE_CD = sel.TEST_TYPE_CD
            and isnull( wts.COMPONENT_ID, 'nothing' ) = isnull( sel.COMPONENT_ID, 'nothing' )
            and isnull( wts.MON_SYS_ID, 'nothing' ) = isnull( sel.MON_SYS_ID, 'nothing' )
            and wts.TEST_DATE = sel.TEST_DATE
            and wts.TEST_HOUR = sel.TEST_HOUR
            and wts.TEST_MIN = sel.TEST_MIN
            and isnull( wts.SPAN_SCALE_CD, 'nothing' ) = isnull( sel.SPAN_SCALE_CD, 'nothing' )
        join ECMPS.dbo.WEEKLY_SYSTEM_INTEGRITY tar 
            on tar.WEEKLY_TEST_SUM_ID = wts.WEEKLY_TEST_SUM_ID
)
GO


