USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgSummaryValueInserts]    Script Date: 2/8/2023 2:37:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER   FUNCTION SqlGenEm.PgSummaryValueInserts
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
                    'insert into camdecmpswks.SUMMARY_VALUE',
                    ' (',
                        ' SUM_VALUE_ID', ',',

                        ' RPT_PERIOD_ID', ',',
                        ' MON_LOC_ID', ',',
                        ' PARAMETER_CD', ',',
                        ' CURRENT_RPT_PERIOD_TOTAL', ',',
                        ' OS_TOTAL', ',',
                        ' YEAR_TOTAL', ',',

                        ' USERID', ',',
                        ' ADD_DATE', ',',
                        ' UPDATE_DATE',
                    ' )',
                    ' values',
                    ' (',
                        '''UNITTEST-'' || uuid_generate_v4()', ', ',
                        
                        case when  tar.RPT_PERIOD_ID                  is not null  then  cast( tar.RPT_PERIOD_ID as varchar ) else 'NULL' end, ', ',
                        case when  tar.MON_LOC_ID                     is not null  then  concat( '''', tar.MON_LOC_ID, '''' ) else 'NULL' end, ', ',
                        case when  tar.PARAMETER_CD                   is not null  then  concat( '''', tar.PARAMETER_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.CURRENT_RPT_PERIOD_TOTAL       is not null  then  cast( tar.CURRENT_RPT_PERIOD_TOTAL as varchar ) else 'NULL' end, ', ',
                        case when  tar.OS_TOTAL                       is not null  then  cast( tar.OS_TOTAL as varchar ) else 'NULL' end, ', ',
                        case when  tar.YEAR_TOTAL                     is not null  then  cast( tar.YEAR_TOTAL as varchar ) else 'NULL' end, ', ',

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
                        tar.RPT_PERIOD_ID,
                        tar.MON_LOC_ID,
                        tar.PARAMETER_CD
                    from  @TestInformationTable lst
                        join ECMPS.dbo.SUMMARY_VALUE tar 
                            on tar.MON_LOC_ID = lst.MON_LOC_ID
                            and tar.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                except
                select  -- ECMPSP
                        lst.ORIS_CODE, 
                        lst.FACILITY_NAME, 
                        lst.LOCATIONS, 
                        lst.QUARTER, 
                        lst.LOCATION_NAME,
                        tar.RPT_PERIOD_ID,
                        tar.MON_LOC_ID,
                        tar.PARAMETER_CD
                    from  @TestInformationTable lst
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.SUMMARY_VALUE tar 
                            on tar.MON_LOC_ID = lst.MON_LOC_ID
                            and tar.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
            ) sel
        join ECMPS.dbo.SUMMARY_VALUE tar
            on tar.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
            and tar.MON_LOC_ID = sel.MON_LOC_ID
            and tar.PARAMETER_CD = sel.PARAMETER_CD
)
GO


