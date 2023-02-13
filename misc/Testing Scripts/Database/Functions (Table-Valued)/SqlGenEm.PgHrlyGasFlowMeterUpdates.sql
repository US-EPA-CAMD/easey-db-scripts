USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgHrlyGasFlowMeterUpdates]    Script Date: 2/7/2023 1:29:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE or ALTER FUNCTION SqlGenEm.PgHrlyGasFlowMeterUpdates
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
                    'update camdecmpswks.HRLY_GAS_FLOW_METER dhv set',

                    ' MON_LOC_ID                     = ',  case when  tar.MON_LOC_ID                     is not null  then  concat( '''', tar.MON_LOC_ID, '''' ) else 'NULL' end, ', ',
                    ' RPT_PERIOD_ID                  = ',  case when  tar.RPT_PERIOD_ID                  is not null  then  cast( tar.RPT_PERIOD_ID as varchar ) else 'NULL' end, ', ',
                    ' COMPONENT_ID                   = ',  case when  tar.COMPONENT_ID                   is not null  then  concat( '''', tar.COMPONENT_ID, '''' ) else 'NULL' end, ', ',
                    ' BEGIN_END_HOUR_FLG             = ',  case when  tar.BEGIN_END_HOUR_FLG             is not null  then  concat( '''', tar.BEGIN_END_HOUR_FLG, '''' ) else 'NULL' end, ', ',
                    ' GFM_READING                    = ',  case when  tar.GFM_READING                    is not null  then  cast( tar.GFM_READING as varchar ) else 'NULL' end, ', ',
                    ' AVG_SAMPLING_RATE              = ',  case when  tar.AVG_SAMPLING_RATE              is not null  then  cast( tar.AVG_SAMPLING_RATE as varchar ) else 'NULL' end, ', ',
                    ' SAMPLING_RATE_UOM              = ',  case when  tar.SAMPLING_RATE_UOM              is not null  then  concat( '''', tar.SAMPLING_RATE_UOM, '''' ) else 'NULL' end, ', ',
                    ' FLOW_TO_SAMPLING_RATIO         = ',  case when  tar.FLOW_TO_SAMPLING_RATIO         is not null  then  cast( tar.FLOW_TO_SAMPLING_RATIO as varchar ) else 'NULL' end, ', ',

                    ' USERID                         = ', '''UNITTEST''', ', ',
                    ' UPDATE_DATE                    = ', concat( '''', format( getdate(), 'yyyy-MM-dd'), '''' ),

                    ' where  exists( select 1 from camdecmpswks.HRLY_OP_DATA hod where hod.HOUR_ID = dhv.HOUR_ID and hod.MON_LOC_ID = ''', sel.MON_LOC_ID, ''' and hod.BEGIN_DATE = ''', format( sel.BEGIN_DATE, 'yyyy-MM-dd' ), ''' and hod.BEGIN_HOUR = ', sel.BEGIN_HOUR, ' )',
                    ' and  COMPONENT_ID = ''', sel.COMPONENT_ID, '''', ';'
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
                        dat.COMPONENT_ID,
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
                                    hgf.MON_LOC_ID,
                                    hgf.RPT_PERIOD_ID,
                                    hgf.COMPONENT_ID,
                                    hgf.BEGIN_END_HOUR_FLG,
                                    hgf.GFM_READING,
                                    hgf.AVG_SAMPLING_RATE,
                                    hgf.SAMPLING_RATE_UOM,
                                    hgf.FLOW_TO_SAMPLING_RATIO
                              from  @TestInformationTable lst
                                    join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.HRLY_OP_DATA hod 
                                      on hod.MON_LOC_ID = lst.MON_LOC_ID
                                     and hod.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                                    join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.HRLY_GAS_FLOW_METER hgf 
                                        on hgf.HOUR_ID = hod.HOUR_ID
                            union
                            select  -- ECMPS_WORKING
                                    lst.ORIS_CODE, 
                                    lst.FACILITY_NAME, 
                                    lst.LOCATIONS, 
                                    lst.QUARTER, 
                                    lst.LOCATION_NAME,
                                    hod.BEGIN_DATE,
                                    hod.BEGIN_HOUR,
                                    hgf.MON_LOC_ID,
                                    hgf.RPT_PERIOD_ID,
                                    hgf.COMPONENT_ID,
                                    hgf.BEGIN_END_HOUR_FLG,
                                    hgf.GFM_READING,
                                    hgf.AVG_SAMPLING_RATE,
                                    hgf.SAMPLING_RATE_UOM,
                                    hgf.FLOW_TO_SAMPLING_RATIO
                              from  @TestInformationTable lst
                                    join ECMPS.dbo.HRLY_OP_DATA hod 
                                      on hod.MON_LOC_ID = lst.MON_LOC_ID
                                     and hod.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                                    join ECMPS.dbo.HRLY_GAS_FLOW_METER hgf 
                                        on hgf.HOUR_ID = hod.HOUR_ID
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
                        dat.COMPONENT_ID
                having  ( count( 1 ) > 1 )
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


