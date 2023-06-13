USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgHrlyFuelFlowInserts]    Script Date: 2/8/2023 2:37:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER   FUNCTION SqlGenEm.PgHrlyFuelFlowInserts
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
                    'insert into camdecmpswks.HRLY_FUEL_FLOW',
                    ' (',
                        ' HRLY_FUEL_FLOW_ID', ',',
                        ' HOUR_ID', ',',

                        ' MON_LOC_ID', ',',
                        ' RPT_PERIOD_ID', ',',
                        ' MON_SYS_ID', ',',
                        ' FUEL_CD', ',',
                        ' FUEL_USAGE_TIME', ',',
                        ' VOLUMETRIC_FLOW_RATE', ',',
                        ' VOLUMETRIC_UOM_CD', ',',
                        ' SOD_VOLUMETRIC_CD', ',',
                        ' MASS_FLOW_RATE', ',',
                        ' SOD_MASS_CD', ',',

                        ' USERID', ',',
                        ' ADD_DATE', ',',
                        ' UPDATE_DATE',
                    ' )',
                    ' values',
                    ' (',
                        '''UNITTEST-'' || uuid_generate_v4()', ', ',
                        '( select hod.HOUR_ID from camdecmpswks.HRLY_OP_DATA hod where hod.MON_LOC_ID = ''', sel.MON_LOC_ID, ''' and hod.BEGIN_DATE = ''', format( sel.BEGIN_DATE, 'yyyy-MM-dd' ), ''' and hod.BEGIN_HOUR = ', sel.BEGIN_HOUR, ' )', ', ',
                        
                        case when  tar.MON_LOC_ID                     is not null  then  concat( '''', tar.MON_LOC_ID, '''' ) else 'NULL' end, ', ',
                        case when  tar.RPT_PERIOD_ID                  is not null  then  cast( tar.RPT_PERIOD_ID as varchar ) else 'NULL' end, ', ',
                        case when  tar.MON_SYS_ID                     is not null  then  concat( '''', tar.MON_SYS_ID, '''' ) else 'NULL' end, ', ',
                        case when  tar.FUEL_CD                        is not null  then  concat( '''', tar.FUEL_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.FUEL_USAGE_TIME                is not null  then  cast( tar.FUEL_USAGE_TIME as varchar ) else 'NULL' end, ', ',
                        case when  tar.VOLUMETRIC_FLOW_RATE           is not null  then  cast( tar.VOLUMETRIC_FLOW_RATE as varchar ) else 'NULL' end, ', ',
                        case when  tar.VOLUMETRIC_UOM_CD              is not null  then  concat( '''', tar.VOLUMETRIC_UOM_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.SOD_VOLUMETRIC_CD              is not null  then  concat( '''', tar.SOD_VOLUMETRIC_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.MASS_FLOW_RATE                 is not null  then  cast( tar.MASS_FLOW_RATE as varchar ) else 'NULL' end, ', ',
                        case when  tar.SOD_MASS_CD                    is not null  then  concat( '''', tar.SOD_MASS_CD, '''' ) else 'NULL' end, ', ',

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
                        hff.MON_SYS_ID,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.MON_LOC_ID,
                        hod.RPT_PERIOD_ID
                    from  @TestInformationTable lst
                        join ECMPS.dbo.HRLY_OP_DATA hod 
                            on hod.MON_LOC_ID = lst.MON_LOC_ID
                            and hod.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                        join ECMPS.dbo.HRLY_FUEL_FLOW hff 
                            on hff.HOUR_ID = hod.HOUR_ID
                except
                select  -- ECMPSP
                        lst.ORIS_CODE, 
                        lst.FACILITY_NAME, 
                        lst.LOCATIONS, 
                        lst.QUARTER, 
                        lst.LOCATION_NAME,
                        hff.MON_SYS_ID,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.MON_LOC_ID,
                        hod.RPT_PERIOD_ID
                    from  @TestInformationTable lst
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.HRLY_OP_DATA hod 
                            on hod.MON_LOC_ID = lst.MON_LOC_ID
                            and hod.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.HRLY_FUEL_FLOW hff 
                            on hff.HOUR_ID = hod.HOUR_ID
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


