USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgSummaryValueUpdates]    Script Date: 2/7/2023 1:29:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE or ALTER FUNCTION SqlGenEm.PgSummaryValueUpdates
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
                    'update camdecmpswks.SUMMARY_VALUE set',

                    ' RPT_PERIOD_ID                  = ',  case when  tar.RPT_PERIOD_ID                  is not null  then  cast( tar.RPT_PERIOD_ID as varchar ) else 'NULL' end, ', ',
                    ' MON_LOC_ID                     = ',  case when  tar.MON_LOC_ID                     is not null  then  concat( '''', tar.MON_LOC_ID, '''' ) else 'NULL' end, ', ',
                    ' PARAMETER_CD                   = ',  case when  tar.PARAMETER_CD                   is not null  then  concat( '''', tar.PARAMETER_CD, '''' ) else 'NULL' end, ', ',
                    ' CURRENT_RPT_PERIOD_TOTAL       = ',  case when  tar.CURRENT_RPT_PERIOD_TOTAL       is not null  then  cast( tar.CURRENT_RPT_PERIOD_TOTAL as varchar ) else 'NULL' end, ', ',
                    ' OS_TOTAL                       = ',  case when  tar.OS_TOTAL                       is not null  then  cast( tar.OS_TOTAL as varchar ) else 'NULL' end, ', ',
                    ' YEAR_TOTAL                     = ',  case when  tar.YEAR_TOTAL                     is not null  then  cast( tar.YEAR_TOTAL as varchar ) else 'NULL' end, ', ',

                    ' USERID                          = ', '''UNITTEST''', ', ',
                    ' UPDATE_DATE                     = ', concat( '''', format( getdate(), 'yyyy-MM-dd'), '''' ),

                    ' where MON_LOC_ID = ''', sel.MON_LOC_ID, ''' and RPT_PERIOD_ID = ', sel.RPT_PERIOD_ID, ' and PARAMETER_CD = ''', sel.PARAMETER_CD, ''';' 
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
                        dat.PARAMETER_CD,
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
                                    tar.PARAMETER_CD,
                                    tar.CURRENT_RPT_PERIOD_TOTAL,
                                    tar.OS_TOTAL,
                                    tar.YEAR_TOTAL
                              from  @TestInformationTable lst
                                    join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.SUMMARY_VALUE tar 
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
                                    tar.PARAMETER_CD,
                                    tar.CURRENT_RPT_PERIOD_TOTAL,
                                    tar.OS_TOTAL,
                                    tar.YEAR_TOTAL
                              from  @TestInformationTable lst
                                    join ECMPS.dbo.SUMMARY_VALUE tar 
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
                        dat.PARAMETER_CD
                having  ( count( 1 ) > 1 )
            ) sel
        join ECMPS.dbo.SUMMARY_VALUE tar
            on tar.MON_LOC_ID = sel.MON_LOC_ID
            and tar.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
            and tar.PARAMETER_CD = sel.PARAMETER_CD
)
GO


