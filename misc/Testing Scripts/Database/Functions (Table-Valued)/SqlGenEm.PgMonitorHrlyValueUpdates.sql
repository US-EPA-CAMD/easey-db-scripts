USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgMonitorHrlyValueUpdates]    Script Date: 2/7/2023 1:29:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE or ALTER FUNCTION SqlGenEm.PgMonitorHrlyValueUpdates
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
                    'update camdecmpswks.MONITOR_HRLY_VALUE dhv set',

                    ' MON_LOC_ID                     = ',  case when  tar.MON_LOC_ID                     is not null  then  concat( '''', tar.MON_LOC_ID, '''' ) else 'NULL' end, ', ',
                    ' RPT_PERIOD_ID                  = ',  case when  tar.RPT_PERIOD_ID                  is not null  then  cast( tar.RPT_PERIOD_ID as varchar ) else 'NULL' end, ', ',
                    ' MON_SYS_ID                     = ',  case when  tar.MON_SYS_ID                     is not null  then  concat( '''', tar.MON_SYS_ID, '''' ) else 'NULL' end, ', ',
                    ' COMPONENT_ID                   = ',  case when  tar.COMPONENT_ID                   is not null  then  concat( '''', tar.COMPONENT_ID, '''' ) else 'NULL' end, ', ',
                    ' PARAMETER_CD                   = ',  case when  tar.PARAMETER_CD                   is not null  then  concat( '''', tar.PARAMETER_CD, '''' ) else 'NULL' end, ', ',
                    ' APPLICABLE_BIAS_ADJ_FACTOR     = ',  case when  tar.APPLICABLE_BIAS_ADJ_FACTOR     is not null  then  cast( tar.APPLICABLE_BIAS_ADJ_FACTOR as varchar ) else 'NULL' end, ', ',
                    ' UNADJUSTED_HRLY_VALUE          = ',  case when  tar.UNADJUSTED_HRLY_VALUE          is not null  then  cast( tar.UNADJUSTED_HRLY_VALUE as varchar ) else 'NULL' end, ', ',
                    ' ADJUSTED_HRLY_VALUE            = ',  case when  tar.ADJUSTED_HRLY_VALUE            is not null  then  cast( tar.ADJUSTED_HRLY_VALUE as varchar ) else 'NULL' end, ', ',
                    ' MODC_CD                        = ',  case when  tar.MODC_CD                        is not null  then  concat( '''', tar.MODC_CD, '''' ) else 'NULL' end, ', ',
                    ' PCT_AVAILABLE                  = ',  case when  tar.PCT_AVAILABLE                  is not null  then  cast( tar.PCT_AVAILABLE as varchar ) else 'NULL' end, ', ',
                    ' MOISTURE_BASIS                 = ',  case when  tar.MOISTURE_BASIS                 is not null  then  concat( '''', tar.MOISTURE_BASIS, '''' ) else 'NULL' end, ', ',

                    ' USERID                         = ', '''UNITTEST''', ', ',
                    ' UPDATE_DATE                    = ', concat( '''', format( getdate(), 'yyyy-MM-dd'), '''' ),

                    ' where  exists( select 1 from camdecmpswks.HRLY_OP_DATA hod where hod.HOUR_ID = dhv.HOUR_ID and hod.MON_LOC_ID = ''', sel.MON_LOC_ID, ''' and hod.BEGIN_DATE = ''', format( sel.BEGIN_DATE, 'yyyy-MM-dd' ), ''' and hod.BEGIN_HOUR = ', sel.BEGIN_HOUR, ' )',
                    ' and  PARAMETER_CD = ''', sel.PARAMETER_CD, '''', ';'
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
                                    mhv.MON_LOC_ID,
                                    mhv.RPT_PERIOD_ID,
                                    mhv.MON_SYS_ID,
                                    mhv.COMPONENT_ID,
                                    mhv.PARAMETER_CD,
                                    mhv.APPLICABLE_BIAS_ADJ_FACTOR,
                                    mhv.UNADJUSTED_HRLY_VALUE,
                                    mhv.ADJUSTED_HRLY_VALUE,
                                    mhv.MODC_CD,
                                    mhv.PCT_AVAILABLE,
                                    mhv.MOISTURE_BASIS
                              from  @TestInformationTable lst
                                    join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.HRLY_OP_DATA hod 
                                      on hod.MON_LOC_ID = lst.MON_LOC_ID
                                     and hod.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                                    join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.MONITOR_HRLY_VALUE mhv 
                                        on mhv.HOUR_ID = hod.HOUR_ID
                            union
                            select  -- ECMPS_WORKING
                                    lst.ORIS_CODE, 
                                    lst.FACILITY_NAME, 
                                    lst.LOCATIONS, 
                                    lst.QUARTER, 
                                    lst.LOCATION_NAME,
                                    hod.BEGIN_DATE,
                                    hod.BEGIN_HOUR,
                                    mhv.MON_LOC_ID,
                                    mhv.RPT_PERIOD_ID,
                                    mhv.MON_SYS_ID,
                                    mhv.COMPONENT_ID,
                                    mhv.PARAMETER_CD,
                                    mhv.APPLICABLE_BIAS_ADJ_FACTOR,
                                    mhv.UNADJUSTED_HRLY_VALUE,
                                    mhv.ADJUSTED_HRLY_VALUE,
                                    mhv.MODC_CD,
                                    mhv.PCT_AVAILABLE,
                                    mhv.MOISTURE_BASIS
                              from  @TestInformationTable lst
                                    join ECMPS.dbo.HRLY_OP_DATA hod 
                                      on hod.MON_LOC_ID = lst.MON_LOC_ID
                                     and hod.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                                    join ECMPS.dbo.MONITOR_HRLY_VALUE mhv 
                                        on mhv.HOUR_ID = hod.HOUR_ID
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
                        dat.PARAMETER_CD
                having  ( count( 1 ) > 1 )
            ) sel
        join ECMPS.dbo.HRLY_OP_DATA hod
            on hod.MON_LOC_ID = sel.MON_LOC_ID
            and hod.BEGIN_DATE = sel.BEGIN_DATE
            and hod.BEGIN_HOUR = sel.BEGIN_HOUR
        join ECMPS.dbo.MONITOR_HRLY_VALUE tar 
            on tar.HOUR_ID = hod.HOUR_ID
           and tar.PARAMETER_CD = sel.PARAMETER_CD
)
GO


