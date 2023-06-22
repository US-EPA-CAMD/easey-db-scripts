USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgHrlyParamFuelFlowInserts]    Script Date: 2/8/2023 2:37:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER   FUNCTION SqlGenEm.PgHrlyParamFuelFlowInserts
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
                    'insert into camdecmpswks.HRLY_PARAM_FUEL_FLOW',
                    ' (',
                        ' HRLY_PARAM_FF_ID', ',',
                        ' HRLY_FUEL_FLOW_ID', ',',

                        ' MON_LOC_ID', ',',
                        ' RPT_PERIOD_ID', ',',
                        ' MON_SYS_ID', ',',
                        ' MON_FORM_ID', ',',
                        ' PARAMETER_CD', ',',
                        ' PARAM_VAL_FUEL', ',',
                        ' SAMPLE_TYPE_CD', ',',
                        ' OPERATING_CONDITION_CD', ',',
                        ' SEGMENT_NUM', ',',
                        ' PARAMETER_UOM_CD', ',',

                        ' USERID', ',',
                        ' ADD_DATE', ',',
                        ' UPDATE_DATE',
                    ' )',
                    ' values',
                    ' (',
                        '''UNITTEST-'' || uuid_generate_v4()', ', ',
                        ' (', 
                        ' select hff.HRLY_FUEL_FLOW_ID from camdecmpswks.HRLY_OP_DATA hod', 
                        ' join camdecmpswks.HRLY_FUEL_FLOW hff on hff.HOUR_ID = hod.HOUR_ID', 
                        ' where hod.MON_LOC_ID = ''', sel.MON_LOC_ID, ''' and hod.BEGIN_DATE = ''', format( sel.BEGIN_DATE, 'yyyy-MM-dd' ), ''' and hod.BEGIN_HOUR = ', sel.BEGIN_HOUR, 
                        ' and coalesce( hff.MON_SYS_ID, ''NULL'' ) = ''', isnull( sel.HFF_MON_SYS_ID, 'NULL' ), '''',
                        ' )', ', ',
                        
                        case when  tar.MON_LOC_ID                     is not null  then  concat( '''', tar.MON_LOC_ID, '''' ) else 'NULL' end, ', ',
                        case when  tar.RPT_PERIOD_ID                  is not null  then  cast( tar.RPT_PERIOD_ID as varchar ) else 'NULL' end, ', ',
                        case when  tar.MON_SYS_ID                     is not null  then  concat( '''', tar.MON_SYS_ID, '''' ) else 'NULL' end, ', ',
                        case when  tar.MON_FORM_ID                    is not null  then  concat( '''', tar.MON_FORM_ID, '''' ) else 'NULL' end, ', ',
                        case when  tar.PARAMETER_CD                   is not null  then  concat( '''', tar.PARAMETER_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.PARAM_VAL_FUEL                 is not null  then  cast( tar.PARAM_VAL_FUEL as varchar ) else 'NULL' end, ', ',
                        case when  tar.SAMPLE_TYPE_CD                 is not null  then  concat( '''', tar.SAMPLE_TYPE_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.OPERATING_CONDITION_CD         is not null  then  concat( '''', tar.OPERATING_CONDITION_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.SEGMENT_NUM                    is not null  then  cast( tar.SEGMENT_NUM as varchar ) else 'NULL' end, ', ',
                        case when  tar.PARAMETER_UOM_CD               is not null  then  concat( '''', tar.PARAMETER_UOM_CD, '''' ) else 'NULL' end, ', ',

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
                except
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
            ) sel
        join ECMPS.dbo.HRLY_OP_DATA hod
            on hod.MON_LOC_ID = sel.MON_LOC_ID
            and hod.BEGIN_DATE = sel.BEGIN_DATE
            and hod.BEGIN_HOUR = sel.BEGIN_HOUR
        join ECMPS.dbo.HRLY_FUEL_FLOW hff 
            on hff.HOUR_ID = hod.HOUR_ID
           and isnull( hff.MON_SYS_ID, 'NULL' ) = isnull( sel.HFF_MON_SYS_ID, 'NULL' )
        join ECMPS.dbo.HRLY_PARAM_FUEL_FLOW tar 
            on tar.HRLY_FUEL_FLOW_ID = hff.HRLY_FUEL_FLOW_ID
           and tar.PARAMETER_CD = sel.PARAMETER_CD
)
GO


