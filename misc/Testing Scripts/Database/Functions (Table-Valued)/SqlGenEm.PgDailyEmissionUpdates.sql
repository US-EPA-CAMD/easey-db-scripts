USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgDailyEmissionUpdates]    Script Date: 2/7/2023 1:29:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE or ALTER FUNCTION SqlGenEm.PgDailyEmissionUpdates
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
                    'update camdecmpswks.DAILY_EMISSION set',

                    ' RPT_PERIOD_ID                  = ',  case when  tar.RPT_PERIOD_ID                  is not null  then  cast( tar.RPT_PERIOD_ID as varchar ) else 'NULL' end, ', ',
                    ' MON_LOC_ID                     = ',  case when  tar.MON_LOC_ID                     is not null  then  concat( '''', tar.MON_LOC_ID, '''' ) else 'NULL' end, ', ',
                    ' PARAMETER_CD                   = ',  case when  tar.PARAMETER_CD                   is not null  then  concat( '''', tar.PARAMETER_CD, '''' ) else 'NULL' end, ', ',
                    ' BEGIN_DATE                     = ',  case when  tar.BEGIN_DATE                     is not null  then  concat( '''', format( tar.BEGIN_DATE, 'yyyy-MM-dd'), '''' ) else 'NULL' end, ', ',
                    ' TOTAL_DAILY_EMISSION           = ',  case when  tar.TOTAL_DAILY_EMISSION           is not null  then  cast( tar.TOTAL_DAILY_EMISSION as varchar ) else 'NULL' end, ', ',
                    ' ADJUSTED_DAILY_EMISSION        = ',  case when  tar.ADJUSTED_DAILY_EMISSION        is not null  then  cast( tar.ADJUSTED_DAILY_EMISSION as varchar ) else 'NULL' end, ', ',
                    ' UNADJUSTED_DAILY_EMISSION      = ',  case when  tar.UNADJUSTED_DAILY_EMISSION      is not null  then  cast( tar.UNADJUSTED_DAILY_EMISSION as varchar ) else 'NULL' end, ', ',
                    ' SORBENT_MASS_EMISSION          = ',  case when  tar.SORBENT_MASS_EMISSION          is not null  then  cast( tar.SORBENT_MASS_EMISSION as varchar ) else 'NULL' end, ', ',
                    ' TOTAL_CARBON_BURNED            = ',  case when  tar.TOTAL_CARBON_BURNED            is not null  then  cast( tar.TOTAL_CARBON_BURNED as varchar ) else 'NULL' end, ', ',

                    'USERID                          = ', '''UNITTEST''', ', ',
                    'UPDATE_DATE                     = ', concat( '''', format( getdate(), 'yyyy-MM-dd'), '''' ),

                    ' where MON_LOC_ID = ''', tar.MON_LOC_ID, ''' and BEGIN_DATE = ''', format( tar.BEGIN_DATE, 'yyyy-MM-dd' ), ''';' 
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
                        dat.BEGIN_DATE,
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
                                    tar.BEGIN_DATE,
                                    tar.TOTAL_DAILY_EMISSION,
                                    tar.ADJUSTED_DAILY_EMISSION,
                                    tar.UNADJUSTED_DAILY_EMISSION,
                                    tar.SORBENT_MASS_EMISSION,
                                    tar.TOTAL_CARBON_BURNED
                              from  @TestInformationTable lst
                                    join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.DAILY_EMISSION tar 
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
                                    tar.BEGIN_DATE,
                                    tar.TOTAL_DAILY_EMISSION,
                                    tar.ADJUSTED_DAILY_EMISSION,
                                    tar.UNADJUSTED_DAILY_EMISSION,
                                    tar.SORBENT_MASS_EMISSION,
                                    tar.TOTAL_CARBON_BURNED
                              from  @TestInformationTable lst
                                    join ECMPS.dbo.DAILY_EMISSION tar 
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
                        dat.BEGIN_DATE,
                        dat.RPT_PERIOD_ID
                having  ( count( 1 ) > 1 )
            ) sel
        join ECMPS.dbo.DAILY_EMISSION tar
            on tar.MON_LOC_ID = sel.MON_LOC_ID
            and tar.BEGIN_DATE = sel.BEGIN_DATE
)
GO


