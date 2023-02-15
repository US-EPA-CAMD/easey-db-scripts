USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgHrlyGasFlowMeterInserts]    Script Date: 2/8/2023 2:37:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER   FUNCTION SqlGenEm.PgHrlyGasFlowMeterInserts
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
                    'insert into camdecmpswks.HRLY_GAS_FLOW_METER',
                    ' (',
                        ' HRLY_GAS_FLOW_METER_ID', ',',
                        ' HOUR_ID', ',',

                        ' MON_LOC_ID', ',',
                        ' RPT_PERIOD_ID', ',',
                        ' COMPONENT_ID', ',',
                        ' BEGIN_END_HOUR_FLG', ',',
                        ' GFM_READING', ',',
                        ' AVG_SAMPLING_RATE', ',',
                        ' SAMPLING_RATE_UOM', ',',
                        ' FLOW_TO_SAMPLING_RATIO', ',',

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
                        case when  tar.COMPONENT_ID                   is not null  then  concat( '''', tar.COMPONENT_ID, '''' ) else 'NULL' end, ', ',
                        case when  tar.BEGIN_END_HOUR_FLG             is not null  then  concat( '''', tar.BEGIN_END_HOUR_FLG, '''' ) else 'NULL' end, ', ',
                        case when  tar.GFM_READING                    is not null  then  cast( tar.GFM_READING as varchar ) else 'NULL' end, ', ',
                        case when  tar.AVG_SAMPLING_RATE              is not null  then  cast( tar.AVG_SAMPLING_RATE as varchar ) else 'NULL' end, ', ',
                        case when  tar.SAMPLING_RATE_UOM              is not null  then  concat( '''', tar.SAMPLING_RATE_UOM, '''' ) else 'NULL' end, ', ',
                        case when  tar.FLOW_TO_SAMPLING_RATIO         is not null  then  cast( tar.FLOW_TO_SAMPLING_RATIO as varchar ) else 'NULL' end, ', ',

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
                        hgf.COMPONENT_ID,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.MON_LOC_ID,
                        hod.RPT_PERIOD_ID
                    from  @TestInformationTable lst
                        join ECMPS.dbo.HRLY_OP_DATA hod 
                            on hod.MON_LOC_ID = lst.MON_LOC_ID
                            and hod.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                        join ECMPS.dbo.HRLY_GAS_FLOW_METER hgf 
                            on hgf.HOUR_ID = hod.HOUR_ID
                except
                select  -- ECMPSP
                        lst.ORIS_CODE, 
                        lst.FACILITY_NAME, 
                        lst.LOCATIONS, 
                        lst.QUARTER, 
                        lst.LOCATION_NAME,
                        hgf.COMPONENT_ID,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.MON_LOC_ID,
                        hod.RPT_PERIOD_ID
                    from  @TestInformationTable lst
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.HRLY_OP_DATA hod 
                            on hod.MON_LOC_ID = lst.MON_LOC_ID
                            and hod.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.HRLY_GAS_FLOW_METER hgf 
                            on hgf.HOUR_ID = hod.HOUR_ID
            ) sel
        join ECMPS.dbo.HRLY_OP_DATA hod
            on hod.MON_LOC_ID = sel.MON_LOC_ID
            and hod.BEGIN_DATE = sel.BEGIN_DATE
            and hod.BEGIN_HOUR = sel.BEGIN_HOUR
        join ECMPS.dbo.HRLY_GAS_FLOW_METER tar 
            on tar.HOUR_ID = hod.HOUR_ID
           and tar.COMPONENT_ID = sel.COMPONENT_ID
)
GO


