USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgDailyTestSummaryInserts]    Script Date: 2/8/2023 2:37:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER   FUNCTION SqlGenEm.PgDailyTestSummaryInserts
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
                    'insert into camdecmpswks.DAILY_TEST_SUMMARY',
                    ' (',
                        ' DAILY_TEST_SUM_ID', ',',

                        ' RPT_PERIOD_ID', ',',
                        ' MON_LOC_ID', ',',
                        ' MON_SYS_ID', ',',
                        ' COMPONENT_ID', ',',
                        ' DAILY_TEST_DATE', ',',
                        ' DAILY_TEST_HOUR', ',',
                        ' DAILY_TEST_MIN', ',',
                        ' TEST_TYPE_CD', ',',
                        ' TEST_RESULT_CD', ',',
                        ' SPAN_SCALE_CD', ',',

                        ' USERID', ',',
                        ' ADD_DATE', ',',
                        ' UPDATE_DATE',
                    ' )',
                    ' values',
                    ' (',
                        '''UNITTEST-'' || uuid_generate_v4()', ', ',
                        
                        case when  tar.RPT_PERIOD_ID                  is not null  then  cast( tar.RPT_PERIOD_ID as varchar ) else 'NULL' end, ', ',
                        case when  tar.MON_LOC_ID                     is not null  then  concat( '''', tar.MON_LOC_ID, '''' ) else 'NULL' end, ', ',
                        case when  tar.MON_SYS_ID                     is not null  then  concat( '''', tar.MON_SYS_ID, '''' ) else 'NULL' end, ', ',
                        case when  tar.COMPONENT_ID                   is not null  then  concat( '''', tar.COMPONENT_ID, '''' ) else 'NULL' end, ', ',
                        case when  tar.DAILY_TEST_DATE                is not null  then  concat( '''', format( tar.DAILY_TEST_DATE, 'yyyy-MM-dd'), '''' ) else 'NULL' end, ', ',
                        case when  tar.DAILY_TEST_HOUR                is not null  then  cast( tar.DAILY_TEST_HOUR as varchar ) else 'NULL' end, ', ',
                        case when  tar.DAILY_TEST_MIN                 is not null  then  cast( tar.DAILY_TEST_MIN as varchar ) else 'NULL' end, ', ',
                        case when  tar.TEST_TYPE_CD                   is not null  then  concat( '''', tar.TEST_TYPE_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.TEST_RESULT_CD                 is not null  then  concat( '''', tar.TEST_RESULT_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.SPAN_SCALE_CD                  is not null  then  concat( '''', tar.SPAN_SCALE_CD, '''' ) else 'NULL' end, ', ',

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
                        tar.MON_LOC_ID,
                        tar.RPT_PERIOD_ID,
                        tar.TEST_TYPE_CD,
                        tar.COMPONENT_ID,
                        tar.MON_SYS_ID,
                        tar.DAILY_TEST_DATE,
                        tar.DAILY_TEST_HOUR,
                        tar.DAILY_TEST_MIN,
                        tar.SPAN_SCALE_CD
                    from  @TestInformationTable lst
                        join ECMPS.dbo.DAILY_TEST_SUMMARY tar 
                            on tar.MON_LOC_ID = lst.MON_LOC_ID
                            and tar.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                except
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
                        tar.DAILY_TEST_DATE,
                        tar.DAILY_TEST_HOUR,
                        tar.DAILY_TEST_MIN,
                        tar.SPAN_SCALE_CD
                    from  @TestInformationTable lst
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.DAILY_TEST_SUMMARY tar 
                            on tar.MON_LOC_ID = lst.MON_LOC_ID
                            and tar.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
            ) sel
        join ECMPS.dbo.DAILY_TEST_SUMMARY tar
            on tar.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
            and tar.MON_LOC_ID = sel.MON_LOC_ID
            and tar.TEST_TYPE_CD = sel.TEST_TYPE_CD
            and isnull( tar.COMPONENT_ID, 'nothing' ) = isnull( sel.COMPONENT_ID, 'nothing' )
            and isnull( tar.MON_SYS_ID, 'nothing' ) = isnull( sel.MON_SYS_ID, 'nothing' )
            and tar.DAILY_TEST_DATE = sel.DAILY_TEST_DATE
            and tar.DAILY_TEST_HOUR = sel.DAILY_TEST_HOUR
            and isnull( tar.DAILY_TEST_MIN, -1 ) = isnull( sel.DAILY_TEST_MIN, -1 )
            and isnull( tar.SPAN_SCALE_CD, 'nothing' ) = isnull( sel.SPAN_SCALE_CD, 'nothing' )
)
GO


