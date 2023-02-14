USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgHrlyParamFuelFlowUpdates]    Script Date: 2/7/2023 1:29:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE or ALTER FUNCTION SqlGenEm.PgHrlyParamFuelFlowUpdates
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
                    'update camdecmpswks.HRLY_PARAM_FUEL_FLOW upd set',

                    ' MON_LOC_ID                     = ',  case when  tar.MON_LOC_ID                     is not null  then  concat( '''', tar.MON_LOC_ID, '''' ) else 'NULL' end, ', ',
                    ' RPT_PERIOD_ID                  = ',  case when  tar.RPT_PERIOD_ID                  is not null  then  cast( tar.RPT_PERIOD_ID as varchar ) else 'NULL' end, ', ',
                    ' MON_SYS_ID                     = ',  case when  tar.MON_SYS_ID                     is not null  then  concat( '''', tar.MON_SYS_ID, '''' ) else 'NULL' end, ', ',
                    ' MON_FORM_ID                    = ',  case when  tar.MON_FORM_ID                    is not null  then  concat( '''', tar.MON_FORM_ID, '''' ) else 'NULL' end, ', ',
                    ' PARAMETER_CD                   = ',  case when  tar.PARAMETER_CD                   is not null  then  concat( '''', tar.PARAMETER_CD, '''' ) else 'NULL' end, ', ',
                    ' PARAM_VAL_FUEL                 = ',  case when  tar.PARAM_VAL_FUEL                 is not null  then  cast( tar.PARAM_VAL_FUEL as varchar ) else 'NULL' end, ', ',
                    ' SAMPLE_TYPE_CD                 = ',  case when  tar.SAMPLE_TYPE_CD                 is not null  then  concat( '''', tar.SAMPLE_TYPE_CD, '''' ) else 'NULL' end, ', ',
                    ' OPERATING_CONDITION_CD         = ',  case when  tar.OPERATING_CONDITION_CD         is not null  then  concat( '''', tar.OPERATING_CONDITION_CD, '''' ) else 'NULL' end, ', ',
                    ' SEGMENT_NUM                    = ',  case when  tar.SEGMENT_NUM                    is not null  then  cast( tar.SEGMENT_NUM as varchar ) else 'NULL' end, ', ',
                    ' PARAMETER_UOM_CD               = ',  case when  tar.PARAMETER_UOM_CD               is not null  then  concat( '''', tar.PARAMETER_UOM_CD, '''' ) else 'NULL' end, ', ',

                    ' USERID                         = ', '''UNITTEST''', ', ',
                    ' UPDATE_DATE                    = ', concat( '''', format( getdate(), 'yyyy-MM-dd'), '''' ),

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
                select  dat.ORIS_CODE, 
                        dat.FACILITY_NAME, 
                        dat.LOCATIONS, 
                        dat.QUARTER, 
                        dat.LOCATION_NAME,
                        dat.MON_LOC_ID,
                        dat.RPT_PERIOD_ID,
                        dat.BEGIN_DATE,
                        dat.BEGIN_HOUR,
                        dat.HFF_MON_SYS_ID,
                        dat.PARAMETER_CD,
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
                                    hff.MON_SYS_ID as HFF_MON_SYS_ID,
                                    hpf.MON_LOC_ID,
                                    hpf.RPT_PERIOD_ID,
                                    hpf.MON_SYS_ID,
                                    hpf.MON_FORM_ID,
                                    hpf.PARAMETER_CD,
                                    hpf.PARAM_VAL_FUEL,
                                    hpf.SAMPLE_TYPE_CD,
                                    hpf.OPERATING_CONDITION_CD,
                                    hpf.SEGMENT_NUM,
                                    hpf.PARAMETER_UOM_CD
                              from  @TestInformationTable lst
                                    join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.HRLY_OP_DATA hod 
                                      on hod.MON_LOC_ID = lst.MON_LOC_ID
                                     and hod.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                                    join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.HRLY_FUEL_FLOW hff 
                                        on hff.HOUR_ID = hod.HOUR_ID
                                    join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.HRLY_PARAM_FUEL_FLOW hpf 
                                        on hpf.HRLY_FUEL_FLOW_ID = hff.HRLY_FUEL_FLOW_ID
                            union
                            select  -- ECMPS_WORKING
                                    lst.ORIS_CODE, 
                                    lst.FACILITY_NAME, 
                                    lst.LOCATIONS, 
                                    lst.QUARTER, 
                                    lst.LOCATION_NAME,
                                    hod.BEGIN_DATE,
                                    hod.BEGIN_HOUR,
                                    hff.MON_SYS_ID as HFF_MON_SYS_ID,
                                    hpf.MON_LOC_ID,
                                    hpf.RPT_PERIOD_ID,
                                    hpf.MON_SYS_ID,
                                    hpf.MON_FORM_ID,
                                    hpf.PARAMETER_CD,
                                    hpf.PARAM_VAL_FUEL,
                                    hpf.SAMPLE_TYPE_CD,
                                    hpf.OPERATING_CONDITION_CD,
                                    hpf.SEGMENT_NUM,
                                    hpf.PARAMETER_UOM_CD
                              from  @TestInformationTable lst
                                    join ECMPS.dbo.HRLY_OP_DATA hod 
                                      on hod.MON_LOC_ID = lst.MON_LOC_ID
                                     and hod.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                                    join ECMPS.dbo.HRLY_FUEL_FLOW hff 
                                        on hff.HOUR_ID = hod.HOUR_ID
                                    join ECMPS.dbo.HRLY_PARAM_FUEL_FLOW hpf 
                                        on hpf.HRLY_FUEL_FLOW_ID = hff.HRLY_FUEL_FLOW_ID
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
                        dat.HFF_MON_SYS_ID,
                        dat.PARAMETER_CD
                having  ( count( 1 ) > 1 )
            ) sel
        join ECMPS.dbo.HRLY_OP_DATA hod
            on hod.MON_LOC_ID = sel.MON_LOC_ID
            and hod.BEGIN_DATE = sel.BEGIN_DATE
            and hod.BEGIN_HOUR = sel.BEGIN_HOUR
        join ECMPS.dbo.HRLY_FUEL_FLOW hff 
            on hff.HOUR_ID = hod.HOUR_ID
           and hff.MON_SYS_ID = sel.HFF_MON_SYS_ID
        join ECMPS.dbo.HRLY_PARAM_FUEL_FLOW tar 
            on tar.HRLY_FUEL_FLOW_ID = hff.HRLY_FUEL_FLOW_ID
           and tar.PARAMETER_CD = sel.PARAMETER_CD
)
GO


