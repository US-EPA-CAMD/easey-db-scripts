USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgHrlyOpDataUpdates]    Script Date: 2/7/2023 1:29:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION SqlGenEm.PgHrlyOpDataUpdates
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
                    'update camdecmpswks.DERIVED_HRLY_VALUE set',

                    ' RPT_PERIOD_ID                  = ',  case when  tar.RPT_PERIOD_ID                  is not null  then  cast( tar.RPT_PERIOD_ID as varchar ) else 'NULL' end, ', ',
                    ' MON_LOC_ID                     = ',  case when  tar.MON_LOC_ID                     is not null  then  concat( '''', tar.MON_LOC_ID, '''' ) else 'NULL' end, ', ',
                    ' BEGIN_DATE                     = ',  case when  tar.BEGIN_DATE                     is not null  then  concat( '''', format( tar.BEGIN_DATE, 'yyyy-MM-dd'), '''' ) else 'NULL' end, ', ',
                    ' BEGIN_HOUR                     = ',  case when  tar.BEGIN_HOUR                     is not null  then  cast( tar.BEGIN_HOUR as varchar ) else 'NULL' end, ', ',
                    ' OP_TIME                        = ',  case when  tar.OP_TIME                        is not null  then  cast( tar.OP_TIME as varchar ) else 'NULL' end, ', ',
                    ' HR_LOAD                        = ',  case when  tar.HR_LOAD                        is not null  then  cast( tar.HR_LOAD as varchar ) else 'NULL' end, ', ',
                    ' LOAD_UOM_CD                    = ',  case when  tar.LOAD_UOM_CD                    is not null  then  concat( '''', tar.LOAD_UOM_CD, '''' ) else 'NULL' end, ', ',
                    ' LOAD_RANGE                     = ',  case when  tar.LOAD_RANGE                     is not null  then  cast( tar.LOAD_RANGE as varchar ) else 'NULL' end, ', ',
                    ' COMMON_STACK_LOAD_RANGE        = ',  case when  tar.COMMON_STACK_LOAD_RANGE        is not null  then  cast( tar.COMMON_STACK_LOAD_RANGE as varchar ) else 'NULL' end, ', ',
                    ' FC_FACTOR                      = ',  case when  tar.FC_FACTOR                      is not null  then  cast( tar.FC_FACTOR as varchar ) else 'NULL' end, ', ',
                    ' FD_FACTOR                      = ',  case when  tar.FD_FACTOR                      is not null  then  cast( tar.FD_FACTOR as varchar ) else 'NULL' end, ', ',
                    ' FW_FACTOR                      = ',  case when  tar.FW_FACTOR                      is not null  then  cast( tar.FW_FACTOR as varchar ) else 'NULL' end, ', ',
                    ' FUEL_CD                        = ',  case when  tar.FUEL_CD                        is not null  then  concat( '''', tar.FUEL_CD, '''' ) else 'NULL' end, ', ',
                    ' MULTI_FUEL_FLG                 = ',  case when  tar.MULTI_FUEL_FLG                 is not null  then  concat( '''', tar.MULTI_FUEL_FLG, '''' ) else 'NULL' end, ', ',
                    ' OPERATING_CONDITION_CD         = ',  case when  tar.OPERATING_CONDITION_CD         is not null  then  concat( '''', tar.OPERATING_CONDITION_CD, '''' ) else 'NULL' end, ', ',
                    ' FUEL_CD_LIST                   = ',  case when  tar.FUEL_CD_LIST                   is not null  then  concat( '''', tar.FUEL_CD_LIST, '''' ) else 'NULL' end, ', ',
                    ' MHHI_INDICATOR                 = ',  case when  tar.MHHI_INDICATOR                 is not null  then  cast( tar.MHHI_INDICATOR as varchar ) else 'NULL' end, ', ',
                    ' MATS_LOAD                      = ',  case when  tar.MATS_LOAD                      is not null  then  cast( tar.MATS_LOAD as varchar ) else 'NULL' end, ', ',
                    ' MATS_STARTUP_SHUTDOWN_FLG      = ',  case when  tar.MATS_STARTUP_SHUTDOWN_FLG      is not null  then  concat( '''', tar.MATS_STARTUP_SHUTDOWN_FLG, '''' ) else 'NULL' end, ', ',

                    ' where exists( select 1 from camdecmps.HRLY_OP_DATA hod where hod.HOUR_ID = dhv.HOUR_ID and hod.MON_LOC_ID = ''', tar.MON_LOC_ID, ''' and hod.BEGIN_DATE = ''', format( tar.BEGIN_DATE, 'yyyy-MM-dd' ), ''' and hod.BEGIN_HOUR = ', tar.BEGIN_HOUR, ' )', ''';' 
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
                        count( 1 ) as ROW_COUNT
                  from  (
                            select  -- ECMPSP
                                    lst.ORIS_CODE, 
                                    lst.FACILITY_NAME, 
                                    lst.LOCATIONS, 
                                    lst.QUARTER, 
                                    lst.LOCATION_NAME,
                                    hod.RPT_PERIOD_ID,
                                    hod.MON_LOC_ID,
                                    hod.BEGIN_DATE,
                                    hod.BEGIN_HOUR,
                                    hod.OP_TIME,
                                    hod.HR_LOAD,
                                    hod.LOAD_UOM_CD,
                                    hod.LOAD_RANGE,
                                    hod.COMMON_STACK_LOAD_RANGE,
                                    hod.FC_FACTOR,
                                    hod.FD_FACTOR,
                                    hod.FW_FACTOR,
                                    hod.FUEL_CD,
                                    hod.MULTI_FUEL_FLG,
                                    hod.OPERATING_CONDITION_CD,
                                    hod.FUEL_CD_LIST,
                                    hod.MHHI_INDICATOR,
                                    hod.MATS_LOAD,
                                    hod.MATS_STARTUP_SHUTDOWN_FLG
                              from  @TestInformationTable lst
                                    join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.HRLY_OP_DATA hod 
                                      on hod.MON_LOC_ID = lst.MON_LOC_ID
                                     and hod.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                            union
                            select  -- ECMPS_WORKING
                                    lst.ORIS_CODE, 
                                    lst.FACILITY_NAME, 
                                    lst.LOCATIONS, 
                                    lst.QUARTER, 
                                    lst.LOCATION_NAME,
                                    hod.RPT_PERIOD_ID,
                                    hod.MON_LOC_ID,
                                    hod.BEGIN_DATE,
                                    hod.BEGIN_HOUR,
                                    hod.OP_TIME,
                                    hod.HR_LOAD,
                                    hod.LOAD_UOM_CD,
                                    hod.LOAD_RANGE,
                                    hod.COMMON_STACK_LOAD_RANGE,
                                    hod.FC_FACTOR,
                                    hod.FD_FACTOR,
                                    hod.FW_FACTOR,
                                    hod.FUEL_CD,
                                    hod.MULTI_FUEL_FLG,
                                    hod.OPERATING_CONDITION_CD,
                                    hod.FUEL_CD_LIST,
                                    hod.MHHI_INDICATOR,
                                    hod.MATS_LOAD,
                                    hod.MATS_STARTUP_SHUTDOWN_FLG
                              from  @TestInformationTable lst
                                    join ECMPS.dbo.HRLY_OP_DATA hod 
                                      on hod.MON_LOC_ID = lst.MON_LOC_ID
                                     and hod.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
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
                        dat.RPT_PERIOD_ID
                having  ( count( 1 ) > 1 )
            ) sel
        join ECMPS.dbo.HRLY_OP_DATA tar
            on tar.MON_LOC_ID = sel.MON_LOC_ID
            and tar.BEGIN_DATE = sel.BEGIN_DATE
            and tar.BEGIN_HOUR = sel.BEGIN_HOUR
)
GO


