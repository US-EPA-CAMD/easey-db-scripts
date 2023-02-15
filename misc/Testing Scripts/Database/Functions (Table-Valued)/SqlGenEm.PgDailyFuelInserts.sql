USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgDailyFuelInserts]    Script Date: 2/8/2023 2:37:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER   FUNCTION SqlGenEm.PgDailyFuelInserts
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
                    'insert into camdecmpswks.DAILY_FUEL',
                    ' (',
                        ' DAILY_FUEL_ID', ',',
                        ' DAILY_EMISSION_ID', ',',

                        ' FUEL_CD', ',',
                        ' DAILY_FUEL_FEED', ',',
                        ' CARBON_CONTENT_USED', ',',
                        ' FUEL_CARBON_BURNED', ',',

                        ' USERID', ',',
                        ' ADD_DATE', ',',
                        ' UPDATE_DATE',
                    ' )',
                    ' values',
                    ' (',
                        '''UNITTEST-'' || uuid_generate_v4()', ', ',
                        '( select dem.DAILY_EMISSION_ID from camdecmpswks.DAILY_EMISSION dem where dem.MON_LOC_ID = ''', sel.MON_LOC_ID, ''' and dem.BEGIN_DATE = ''', format( sel.BEGIN_DATE, 'yyyy-MM-dd' ), ''' )', ', ',
                        
                        case when  tar.FUEL_CD                        is not null  then  concat( '''', tar.FUEL_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.DAILY_FUEL_FEED                is not null  then  cast( tar.DAILY_FUEL_FEED as varchar ) else 'NULL' end, ', ',
                        case when  tar.CARBON_CONTENT_USED            is not null  then  cast( tar.CARBON_CONTENT_USED as varchar ) else 'NULL' end, ', ',
                        case when  tar.FUEL_CARBON_BURNED             is not null  then  cast( tar.FUEL_CARBON_BURNED as varchar ) else 'NULL' end, ', ',

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
                        dfl.FUEL_CD,
                        dem.BEGIN_DATE,
                        dem.MON_LOC_ID,
                        dem.RPT_PERIOD_ID
                    from  @TestInformationTable lst
                        join ECMPS.dbo.DAILY_EMISSION dem 
                            on dem.MON_LOC_ID = lst.MON_LOC_ID
                            and dem.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                        join ECMPS.dbo.DAILY_FUEL dfl 
                            on dfl.DAILY_EMISSION_ID = dem.DAILY_EMISSION_ID
                except
                select  -- ECMPSP
                        lst.ORIS_CODE, 
                        lst.FACILITY_NAME, 
                        lst.LOCATIONS, 
                        lst.QUARTER, 
                        lst.LOCATION_NAME,
                        dfl.FUEL_CD,
                        dem.BEGIN_DATE,
                        dem.MON_LOC_ID,
                        dem.RPT_PERIOD_ID
                    from  @TestInformationTable lst
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.DAILY_EMISSION dem 
                            on dem.MON_LOC_ID = lst.MON_LOC_ID
                            and dem.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.DAILY_FUEL dfl 
                            on dfl.DAILY_EMISSION_ID = dem.DAILY_EMISSION_ID
            ) sel
        join ECMPS.dbo.DAILY_EMISSION dem
            on dem.MON_LOC_ID = sel.MON_LOC_ID
            and dem.BEGIN_DATE = sel.BEGIN_DATE
        join ECMPS.dbo.DAILY_FUEL tar 
            on tar.DAILY_EMISSION_ID = dem.DAILY_EMISSION_ID
           and tar.FUEL_CD = sel.FUEL_CD
)
GO


