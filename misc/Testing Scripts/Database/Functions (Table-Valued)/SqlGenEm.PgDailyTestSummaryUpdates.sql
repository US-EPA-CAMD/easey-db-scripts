USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgDailyTestSummaryUpdates]    Script Date: 2/7/2023 1:29:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE or ALTER FUNCTION SqlGenEm.PgDailyTestSummaryUpdates
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
                    'update camdecmpswks.DAILY_TEST_SUMMARY set',

                    ' RPT_PERIOD_ID                  = ',  case when  tar.RPT_PERIOD_ID                  is not null  then  cast( tar.RPT_PERIOD_ID as varchar ) else 'NULL' end, ', ',
                    ' MON_LOC_ID                     = ',  case when  tar.MON_LOC_ID                     is not null  then  concat( '''', tar.MON_LOC_ID, '''' ) else 'NULL' end, ', ',
                    ' MON_SYS_ID                     = ',  case when  tar.MON_SYS_ID                     is not null  then  concat( '''', tar.MON_SYS_ID, '''' ) else 'NULL' end, ', ',
                    ' COMPONENT_ID                   = ',  case when  tar.COMPONENT_ID                   is not null  then  concat( '''', tar.COMPONENT_ID, '''' ) else 'NULL' end, ', ',
                    ' DAILY_TEST_DATE                = ',  case when  tar.DAILY_TEST_DATE                is not null  then  concat( '''', format( tar.DAILY_TEST_DATE, 'yyyy-MM-dd'), '''' ) else 'NULL' end, ', ',
                    ' DAILY_TEST_HOUR                = ',  case when  tar.DAILY_TEST_HOUR                is not null  then  cast( tar.DAILY_TEST_HOUR as varchar ) else 'NULL' end, ', ',
                    ' DAILY_TEST_MIN                 = ',  case when  tar.DAILY_TEST_MIN                 is not null  then  cast( tar.DAILY_TEST_MIN as varchar ) else 'NULL' end, ', ',
                    ' TEST_TYPE_CD                   = ',  case when  tar.TEST_TYPE_CD                   is not null  then  concat( '''', tar.TEST_TYPE_CD, '''' ) else 'NULL' end, ', ',
                    ' TEST_RESULT_CD                 = ',  case when  tar.TEST_RESULT_CD                 is not null  then  concat( '''', tar.TEST_RESULT_CD, '''' ) else 'NULL' end, ', ',
                    ' SPAN_SCALE_CD                  = ',  case when  tar.SPAN_SCALE_CD                  is not null  then  concat( '''', tar.SPAN_SCALE_CD, '''' ) else 'NULL' end, ', ',

                    ' USERID                          = ', '''UNITTEST''', ', ',
                    ' UPDATE_DATE                     = ', concat( '''', format( getdate(), 'yyyy-MM-dd'), '''' ),

                    ' where MON_LOC_ID = ''', sel.MON_LOC_ID, ''' and RPT_PERIOD_ID = ', sel.RPT_PERIOD_ID, ' and TEST_TYPE_CD = ''', sel.TEST_TYPE_CD, '''',
                    ' and coalesce( COMPONENT_ID, ''nothing'' ) = ''', isnull( sel.COMPONENT_ID, 'nothing' ), '''',
                    ' and coalesce( MON_SYS_ID, ''nothing'' ) = ''', isnull( sel.MON_SYS_ID, 'nothing' ), '''',
                    ' and DAILY_TEST_DATE = ''', format( sel.DAILY_TEST_DATE, 'yyyy-MM-dd' ), ''' and DAILY_TEST_HOUR = ', sel.DAILY_TEST_HOUR, ' and DAILY_TEST_MIN = ', sel.DAILY_TEST_MIN,
                    ' and coalesce( SPAN_SCALE_CD, ''nothing'' ) = ''', isnull( sel.SPAN_SCALE_CD, 'nothing' ), '''',
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
                                    tar.RPT_PERIOD_ID,
                                    tar.MON_LOC_ID,
                                    tar.MON_SYS_ID,
                                    tar.COMPONENT_ID,
                                    tar.DAILY_TEST_DATE,
                                    tar.DAILY_TEST_HOUR,
                                    tar.DAILY_TEST_MIN,
                                    tar.TEST_TYPE_CD,
                                    tar.TEST_RESULT_CD,
                                    tar.SPAN_SCALE_CD
                              from  @TestInformationTable lst
                                    join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.DAILY_TEST_SUMMARY tar 
                                      on tar.MON_LOC_ID = lst.MON_LOC_ID
                                     and tar.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                            union
                            select  -- ECMPS_WORKING
                                    lst.ORIS_CODE, 
                                    lst.FACILITY_NAME, 
                                    lst.LOCATIONS, 
                                    lst.QUARTER, 
                                    lst.LOCATION_NAME,
                                    tar.RPT_PERIOD_ID,
                                    tar.MON_LOC_ID,
                                    tar.MON_SYS_ID,
                                    tar.COMPONENT_ID,
                                    tar.DAILY_TEST_DATE,
                                    tar.DAILY_TEST_HOUR,
                                    tar.DAILY_TEST_MIN,
                                    tar.TEST_TYPE_CD,
                                    tar.TEST_RESULT_CD,
                                    tar.SPAN_SCALE_CD
                              from  @TestInformationTable lst
                                    join ECMPS.dbo.DAILY_TEST_SUMMARY tar 
                                      on tar.MON_LOC_ID = lst.MON_LOC_ID
                                     and tar.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
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
        join ECMPS.dbo.DAILY_TEST_SUMMARY tar
            on tar.MON_LOC_ID = sel.MON_LOC_ID
            and tar.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
            and tar.TEST_TYPE_CD = sel.TEST_TYPE_CD
            and isnull( tar.COMPONENT_ID, 'nothing' ) = isnull( sel.COMPONENT_ID, 'nothing' )
            and isnull( tar.MON_SYS_ID, 'nothing' ) = isnull( sel.MON_SYS_ID, 'nothing' )
            and tar.DAILY_TEST_DATE = sel.DAILY_TEST_DATE
            and tar.DAILY_TEST_HOUR = sel.DAILY_TEST_HOUR
            and tar.DAILY_TEST_MIN = sel.DAILY_TEST_MIN
            and isnull( tar.SPAN_SCALE_CD, 'nothing' ) = isnull( sel.SPAN_SCALE_CD, 'nothing' )
)
GO


