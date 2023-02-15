USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgDailyFuelDeletes]    Script Date: 2/8/2023 4:25:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION SqlGenEm.PgDailyFuelDeletes
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
                    'delete from camdecmpswks.DAILY_FUEL tar',
                    ' where  exists( select 1 from camdecmpswks.DAILY_EMISSION dem where dem.DAILY_EMISSION_ID = tar.DAILY_EMISSION_ID and dem.MON_LOC_ID = ''', sel.MON_LOC_ID, ''' and dem.BEGIN_DATE = ''', format( sel.BEGIN_DATE, 'yyyy-MM-dd' ), ''' )',
                    ' and  FUEL_CD = ''', sel.FUEL_CD, '''', ';'
                )
            ) as SQL_STATEMENT
      from  (
                select  -- ECMPSP
                        lst.ORIS_CODE, 
                        lst.FACILITY_NAME, 
                        lst.LOCATIONS, 
                        lst.QUARTER, 
                        lst.LOCATION_NAME,
                        dfl.FUEL_CD,
                        dem.BEGIN_DATE,
                        lst.MON_LOC_ID,
                        lst.RPT_PERIOD_ID
                    from  @TestInformationTable lst
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.DAILY_EMISSION dem 
                            on dem.MON_LOC_ID = lst.MON_LOC_ID
                            and dem.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.DAILY_FUEL dfl 
                            on dfl.DAILY_EMISSION_ID = dem.DAILY_EMISSION_ID
                except
                select  -- ECMPS_WORKING
                        lst.ORIS_CODE, 
                        lst.FACILITY_NAME, 
                        lst.LOCATIONS, 
                        lst.QUARTER, 
                        lst.LOCATION_NAME,
                        dfl.FUEL_CD,
                        dem.BEGIN_DATE,
                        lst.MON_LOC_ID,
                        lst.RPT_PERIOD_ID
                    from  @TestInformationTable lst
                        join ECMPS.dbo.DAILY_EMISSION dem 
                            on dem.MON_LOC_ID = lst.MON_LOC_ID
                            and dem.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                        join ECMPS.dbo.DAILY_FUEL dfl 
                            on dfl.DAILY_EMISSION_ID = dem.DAILY_EMISSION_ID
            ) sel
)
GO


