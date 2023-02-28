USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgDailyFuelUpdates]    Script Date: 2/7/2023 1:29:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE or ALTER FUNCTION SqlGenEm.PgDailyFuelUpdates
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
                    'update camdecmpswks.DAILY_FUEL tar set',

                    ' FUEL_CD                        = ',  case when  tar.FUEL_CD                        is not null  then  concat( '''', tar.FUEL_CD, '''' ) else 'NULL' end, ', ',
                    ' DAILY_FUEL_FEED                = ',  case when  tar.DAILY_FUEL_FEED                is not null  then  cast( tar.DAILY_FUEL_FEED as varchar ) else 'NULL' end, ', ',
                    ' CARBON_CONTENT_USED            = ',  case when  tar.CARBON_CONTENT_USED            is not null  then  cast( tar.CARBON_CONTENT_USED as varchar ) else 'NULL' end, ', ',
                    ' FUEL_CARBON_BURNED             = ',  case when  tar.FUEL_CARBON_BURNED             is not null  then  cast( tar.FUEL_CARBON_BURNED as varchar ) else 'NULL' end, ', ',

                    ' USERID                         = ', '''UNITTEST''', ', ',
                    ' UPDATE_DATE                    = ', concat( '''', format( getdate(), 'yyyy-MM-dd'), '''' ),

                    ' where  exists( select 1 from camdecmpswks.DAILY_EMISSION dem where dem.DAILY_EMISSION_ID = tar.DAILY_EMISSION_ID and dem.MON_LOC_ID = ''', sel.MON_LOC_ID, ''' and dem.BEGIN_DATE = ''', format( sel.BEGIN_DATE, 'yyyy-MM-dd' ), ''' )',
                    ' and  FUEL_CD = ''', sel.FUEL_CD, '''', ';'
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
                        dat.FUEL_CD,
                        count( 1 ) as ROW_COUNT
                  from  (
                            select  -- ECMPSP
                                    lst.ORIS_CODE, 
                                    lst.FACILITY_NAME, 
                                    lst.LOCATIONS, 
                                    lst.QUARTER, 
                                    lst.LOCATION_NAME,
                                    tar.FUEL_CD,
                                    tar.DAILY_FUEL_FEED,
                                    tar.CARBON_CONTENT_USED,
                                    tar.FUEL_CARBON_BURNED,
                                    dem.BEGIN_DATE,
                                    dem.MON_LOC_ID,
                                    dem.RPT_PERIOD_ID
                                from  @TestInformationTable lst
                                    join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.DAILY_EMISSION dem 
                                        on dem.MON_LOC_ID = lst.MON_LOC_ID
                                        and dem.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                                    join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.DAILY_FUEL tar 
                                        on tar.DAILY_EMISSION_ID = dem.DAILY_EMISSION_ID
                            union
                            select  -- ECMPS_WORKING
                                    lst.ORIS_CODE, 
                                    lst.FACILITY_NAME, 
                                    lst.LOCATIONS, 
                                    lst.QUARTER, 
                                    lst.LOCATION_NAME,
                                    tar.FUEL_CD,
                                    tar.DAILY_FUEL_FEED,
                                    tar.CARBON_CONTENT_USED,
                                    tar.FUEL_CARBON_BURNED,
                                    dem.BEGIN_DATE,
                                    dem.MON_LOC_ID,
                                    dem.RPT_PERIOD_ID
                                from  @TestInformationTable lst
                                    join ECMPS.dbo.DAILY_EMISSION dem 
                                        on dem.MON_LOC_ID = lst.MON_LOC_ID
                                        and dem.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                                    join ECMPS.dbo.DAILY_FUEL tar 
                                        on tar.DAILY_EMISSION_ID = dem.DAILY_EMISSION_ID
                        ) dat
                 group
                    by  dat.ORIS_CODE, 
                        dat.FACILITY_NAME, 
                        dat.LOCATIONS, 
                        dat.QUARTER, 
                        dat.LOCATION_NAME,
                        dat.MON_LOC_ID,
                        dat.BEGIN_DATE,
                        dat.RPT_PERIOD_ID,
                        dat.FUEL_CD
                having  ( count( 1 ) > 1 )
            ) sel
        join ECMPS.dbo.DAILY_EMISSION dem
            on dem.MON_LOC_ID = sel.MON_LOC_ID
            and dem.BEGIN_DATE = sel.BEGIN_DATE
        join ECMPS.dbo.DAILY_FUEL tar 
            on tar.DAILY_EMISSION_ID = dem.DAILY_EMISSION_ID
           and tar.FUEL_CD = sel.FUEL_CD
)
GO


