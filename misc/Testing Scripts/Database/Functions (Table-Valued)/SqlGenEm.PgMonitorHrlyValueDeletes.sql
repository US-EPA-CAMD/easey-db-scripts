USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgMonitorHrlyValueDeletes]    Script Date: 2/8/2023 4:25:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION SqlGenEm.PgMonitorHrlyValueDeletes
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
                    'delete from camdecmpswks.MONITOR_HRLY_VALUE tar',
                    ' where  exists( select 1 from camdecmpswks.HRLY_OP_DATA hod where hod.HOUR_ID = tar.HOUR_ID and hod.MON_LOC_ID = ''', sel.MON_LOC_ID, ''' and hod.BEGIN_DATE = ''', format( sel.BEGIN_DATE, 'yyyy-MM-dd' ), ''' and hod.BEGIN_HOUR = ', sel.BEGIN_HOUR, ' )',
                    ' and  PARAMETER_CD = ''', sel.PARAMETER_CD, '''',
                    ' and  coalesce( MOISTURE_BASIS, ''B'' ) = ''', isnull( sel.MOISTURE_BASIS, 'B' ), '''',
                    ' and  coalesce( MODC_CD, ''00'' ) = ''', isnull( sel.MODC_CD, '00' ), '''', ';'
                )
            ) as SQL_STATEMENT
      from  (
                select  -- ECMPSP
                        lst.ORIS_CODE, 
                        lst.FACILITY_NAME, 
                        lst.LOCATIONS, 
                        lst.QUARTER, 
                        lst.LOCATION_NAME,
                        mhv.PARAMETER_CD,
                        mhv.MOISTURE_BASIS,
                        mhv.MODC_CD,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.MON_LOC_ID,
                        hod.RPT_PERIOD_ID
                    from  @TestInformationTable lst
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.HRLY_OP_DATA hod 
                            on hod.MON_LOC_ID = lst.MON_LOC_ID
                            and hod.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.MONITOR_HRLY_VALUE mhv 
                            on mhv.HOUR_ID = hod.HOUR_ID
                except
                select  -- ECMPS_WORKING
                        lst.ORIS_CODE, 
                        lst.FACILITY_NAME, 
                        lst.LOCATIONS, 
                        lst.QUARTER, 
                        lst.LOCATION_NAME,
                        mhv.PARAMETER_CD,
                        mhv.MOISTURE_BASIS,
                        mhv.MODC_CD,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.MON_LOC_ID,
                        hod.RPT_PERIOD_ID
                    from  @TestInformationTable lst
                        join ECMPS.dbo.HRLY_OP_DATA hod 
                            on hod.MON_LOC_ID = lst.MON_LOC_ID
                            and hod.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                        join ECMPS.dbo.MONITOR_HRLY_VALUE mhv 
                            on mhv.HOUR_ID = hod.HOUR_ID
            ) sel
)
GO


