USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgHrlyFuelFlowUpdates]    Script Date: 2/7/2023 1:29:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE or ALTER FUNCTION SqlGenEm.PgHrlyFuelFlowUpdates
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
                    'update camdecmpswks.HRLY_FUEL_FLOW dhv set',

                    ' MON_LOC_ID                     = ',  case when  tar.MON_LOC_ID                     is not null  then  concat( '''', tar.MON_LOC_ID, '''' ) else 'NULL' end, ', ',
                    ' RPT_PERIOD_ID                  = ',  case when  tar.RPT_PERIOD_ID                  is not null  then  cast( tar.RPT_PERIOD_ID as varchar ) else 'NULL' end, ', ',
                    ' MON_SYS_ID                     = ',  case when  tar.MON_SYS_ID                     is not null  then  concat( '''', tar.MON_SYS_ID, '''' ) else 'NULL' end, ', ',
                    ' FUEL_CD                        = ',  case when  tar.FUEL_CD                        is not null  then  concat( '''', tar.FUEL_CD, '''' ) else 'NULL' end, ', ',
                    ' FUEL_USAGE_TIME                = ',  case when  tar.FUEL_USAGE_TIME                is not null  then  cast( tar.FUEL_USAGE_TIME as varchar ) else 'NULL' end, ', ',
                    ' VOLUMETRIC_FLOW_RATE           = ',  case when  tar.VOLUMETRIC_FLOW_RATE           is not null  then  cast( tar.VOLUMETRIC_FLOW_RATE as varchar ) else 'NULL' end, ', ',
                    ' VOLUMETRIC_UOM_CD              = ',  case when  tar.VOLUMETRIC_UOM_CD              is not null  then  concat( '''', tar.VOLUMETRIC_UOM_CD, '''' ) else 'NULL' end, ', ',
                    ' SOD_VOLUMETRIC_CD              = ',  case when  tar.SOD_VOLUMETRIC_CD              is not null  then  concat( '''', tar.SOD_VOLUMETRIC_CD, '''' ) else 'NULL' end, ', ',
                    ' MASS_FLOW_RATE                 = ',  case when  tar.MASS_FLOW_RATE                 is not null  then  cast( tar.MASS_FLOW_RATE as varchar ) else 'NULL' end, ', ',
                    ' SOD_MASS_CD                    = ',  case when  tar.SOD_MASS_CD                    is not null  then  concat( '''', tar.SOD_MASS_CD, '''' ) else 'NULL' end, ', ',

                    ' USERID                         = ', '''UNITTEST''', ', ',
                    ' UPDATE_DATE                    = ', concat( '''', format( getdate(), 'yyyy-MM-dd'), '''' ),

                    ' where  exists( select 1 from camdecmpswks.HRLY_OP_DATA hod where hod.HOUR_ID = dhv.HOUR_ID and hod.MON_LOC_ID = ''', sel.MON_LOC_ID, ''' and hod.BEGIN_DATE = ''', format( sel.BEGIN_DATE, 'yyyy-MM-dd' ), ''' and hod.BEGIN_HOUR = ', sel.BEGIN_HOUR, ' )',
                    ' and  MON_SYS_ID = ''', sel.MON_SYS_ID, '''', ';'
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
                        dat.BEGIN_HOUR,
                        dat.MON_SYS_ID,
                        count( 1 ) as ROW_COUNT
                  from  (
                            select  -- ECMPSP
                                    lst.ORIS_CODE, 
                                    lst.FACILITY_NAME, 
                                    lst.LOCATIONS, 
                                    lst.QUARTER, 
                                    lst.LOCATION_NAME,
                                    hod.BEGIN_DATE,
                                    hod.BEGIN_HOUR,
                                    hff.MON_LOC_ID,
                                    hff.RPT_PERIOD_ID,
                                    hff.MON_SYS_ID,
                                    hff.FUEL_CD,
                                    hff.FUEL_USAGE_TIME,
                                    hff.VOLUMETRIC_FLOW_RATE,
                                    hff.VOLUMETRIC_UOM_CD,
                                    hff.SOD_VOLUMETRIC_CD,
                                    hff.MASS_FLOW_RATE,
                                    hff.SOD_MASS_CD
                              from  @TestInformationTable lst
                                    join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.HRLY_OP_DATA hod 
                                      on hod.MON_LOC_ID = lst.MON_LOC_ID
                                     and hod.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                                    join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.HRLY_FUEL_FLOW hff 
                                        on hff.HOUR_ID = hod.HOUR_ID
                            union
                            select  -- ECMPS_WORKING
                                    lst.ORIS_CODE, 
                                    lst.FACILITY_NAME, 
                                    lst.LOCATIONS, 
                                    lst.QUARTER, 
                                    lst.LOCATION_NAME,
                                    hod.BEGIN_DATE,
                                    hod.BEGIN_HOUR,
                                    hff.MON_LOC_ID,
                                    hff.RPT_PERIOD_ID,
                                    hff.MON_SYS_ID,
                                    hff.FUEL_CD,
                                    hff.FUEL_USAGE_TIME,
                                    hff.VOLUMETRIC_FLOW_RATE,
                                    hff.VOLUMETRIC_UOM_CD,
                                    hff.SOD_VOLUMETRIC_CD,
                                    hff.MASS_FLOW_RATE,
                                    hff.SOD_MASS_CD
                              from  @TestInformationTable lst
                                    join ECMPS.dbo.HRLY_OP_DATA hod 
                                      on hod.MON_LOC_ID = lst.MON_LOC_ID
                                     and hod.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                                    join ECMPS.dbo.HRLY_FUEL_FLOW hff 
                                        on hff.HOUR_ID = hod.HOUR_ID
                        ) dat
                 group
                    by  dat.ORIS_CODE, 
                        dat.FACILITY_NAME, 
                        dat.LOCATIONS, 
                        dat.QUARTER, 
                        dat.LOCATION_NAME,
                        dat.MON_LOC_ID,
                        dat.BEGIN_DATE,
                        dat.BEGIN_HOUR,
                        dat.RPT_PERIOD_ID,
                        dat.MON_SYS_ID
                having  ( count( 1 ) > 1 )
            ) sel
        join ECMPS.dbo.HRLY_OP_DATA hod
            on hod.MON_LOC_ID = sel.MON_LOC_ID
            and hod.BEGIN_DATE = sel.BEGIN_DATE
            and hod.BEGIN_HOUR = sel.BEGIN_HOUR
        join ECMPS.dbo.HRLY_FUEL_FLOW tar 
            on tar.HOUR_ID = hod.HOUR_ID
           and isnull( tar.MON_SYS_ID, 'NULL' ) = isnull( sel.MON_SYS_ID, 'NULL' )
)
GO


