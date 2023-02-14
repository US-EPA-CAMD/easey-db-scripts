USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgHrlyParamFuelFlowDeletes]    Script Date: 2/11/2023 6:40:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION SqlGenEm.PgHrlyParamFuelFlowDeletes
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
                    'delete from camdecmpswks.HRLY_PARAM_FUEL_FLOW upd',
                    ' where exists',
                    ' (', 
                    ' select 1 from camdecmpswks.HRLY_OP_DATA hod', 
                    ' join camdecmpswks.HRLY_FUEL_FLOW hff on hff.HOUR_ID = hod.HOUR_ID', 
                    ' where hod.MON_LOC_ID = ''', sel.MON_LOC_ID, ''' and hod.BEGIN_DATE = ''', format( sel.BEGIN_DATE, 'yyyy-MM-dd' ), ''' and hod.BEGIN_HOUR = ', sel.BEGIN_HOUR,
                    ' and hff.MON_SYS_ID = ''', sel.HFF_MON_SYS_ID, '''',
                    ' and upd.HRLY_FUEL_FLOW_ID = hff.HRLY_FUEL_FLOW_ID',
                    ' and upd.PARAMETER_CD = ''', sel.PARAMETER_CD, '''',
                    ' )',
                    ';'
                )
            ) as SQL_STATEMENT
      from  (
                select  -- ECMPSP
                        lst.ORIS_CODE, 
                        lst.FACILITY_NAME, 
                        lst.LOCATIONS, 
                        lst.QUARTER, 
                        lst.LOCATION_NAME,
                        hff.MON_SYS_ID as HFF_MON_SYS_ID,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.MON_LOC_ID,
                        hod.RPT_PERIOD_ID,
                        hpf.PARAMETER_CD
                    from  @TestInformationTable lst
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.HRLY_OP_DATA hod 
                            on hod.MON_LOC_ID = lst.MON_LOC_ID
                            and hod.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.HRLY_FUEL_FLOW hff 
                            on hff.HOUR_ID = hod.HOUR_ID
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.HRLY_PARAM_FUEL_FLOW hpf 
                            on hpf.HRLY_FUEL_FLOW_ID = hff.HRLY_FUEL_FLOW_ID
                except
                select  -- ECMPS_WORKING
                        lst.ORIS_CODE, 
                        lst.FACILITY_NAME, 
                        lst.LOCATIONS, 
                        lst.QUARTER, 
                        lst.LOCATION_NAME,
                        hff.MON_SYS_ID as HFF_MON_SYS_ID,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.MON_LOC_ID,
                        hod.RPT_PERIOD_ID,
                        hpf.PARAMETER_CD
                    from  @TestInformationTable lst
                        join ECMPS.dbo.HRLY_OP_DATA hod 
                            on hod.MON_LOC_ID = lst.MON_LOC_ID
                            and hod.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                        join ECMPS.dbo.HRLY_FUEL_FLOW hff 
                            on hff.HOUR_ID = hod.HOUR_ID
                        join ECMPS.dbo.HRLY_PARAM_FUEL_FLOW hpf 
                            on hpf.HRLY_FUEL_FLOW_ID = hff.HRLY_FUEL_FLOW_ID
            ) sel
)
GO


