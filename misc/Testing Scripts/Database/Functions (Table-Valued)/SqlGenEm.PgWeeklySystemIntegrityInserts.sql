USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgWeeklySystemIntegrityInserts]    Script Date: 2/8/2023 2:37:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER   FUNCTION SqlGenEm.PgWeeklySystemIntegrityInserts
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
                    'insert into camdecmpswks.WEEKLY_SYSTEM_INTEGRITY',
                    ' (',
                        ' WEEKLY_SYS_INTEGRITY_ID', ',',
                        ' WEEKLY_TEST_SUM_ID', ',',

                        ' GAS_LEVEL_CD', ',',
                        ' REF_VALUE', ',',
                        ' MEASURED_VALUE', ',',
                        ' SYSTEM_INTEGRITY_ERROR', ',',
                        ' APS_IND', ',',

                        ' MON_LOC_ID', ',',
                        ' RPT_PERIOD_ID', ',',

                        ' USERID', ',',
                        ' ADD_DATE', ',',
                        ' UPDATE_DATE',
                    ' )',
                    ' values',
                    ' (',
                        '''UNITTEST-'' || uuid_generate_v4()', ', ',
                        ' ( ', 
                        ' select wts.WEEKLY_TEST_SUM_ID from camdecmpswks.WEEKLY_TEST_SUMMARY wts',
                        ' where wts.MON_LOC_ID = ''', sel.MON_LOC_ID, ''' and wts.RPT_PERIOD_ID = ', sel.RPT_PERIOD_ID, ' and wts.TEST_TYPE_CD = ''', sel.TEST_TYPE_CD, '''',
                        ' and coalesce( wts.COMPONENT_ID, ''nothing'' ) = ''', isnull( sel.COMPONENT_ID, 'nothing' ), '''',
                        ' and coalesce( wts.MON_SYS_ID, ''nothing'' ) = ''', isnull( sel.MON_SYS_ID, 'nothing' ), '''',
                        ' and wts.TEST_DATE = ''', format( sel.TEST_DATE, 'yyyy-MM-dd' ), ''' and wts.TEST_HOUR = ', sel.TEST_HOUR, ' and wts.TEST_MIN = ', sel.TEST_MIN,
                        ' and coalesce( wts.SPAN_SCALE_CD, ''nothing'' ) = ''', isnull( sel.SPAN_SCALE_CD, 'nothing' ), '''',
                        ' )', ', ',
                        
                        case when  tar.GAS_LEVEL_CD                   is not null  then  concat( '''', tar.GAS_LEVEL_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.REF_VALUE                      is not null  then  cast( tar.REF_VALUE as varchar ) else 'NULL' end, ', ',
                        case when  tar.MEASURED_VALUE                 is not null  then  cast( tar.MEASURED_VALUE as varchar ) else 'NULL' end, ', ',
                        case when  tar.SYSTEM_INTEGRITY_ERROR         is not null  then  cast( tar.SYSTEM_INTEGRITY_ERROR as varchar ) else 'NULL' end, ', ',
                        case when  tar.APS_IND                        is not null  then  cast( tar.APS_IND as varchar ) else 'NULL' end, ', ',

                        case when  wts.MON_LOC_ID                   is not null  then  concat( '''', wts.MON_LOC_ID, '''' ) else 'NULL' end, ', ',
                        case when  wts.RPT_PERIOD_ID                      is not null  then  cast( wts.RPT_PERIOD_ID as varchar ) else 'NULL' end, ', ',

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
                except
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


