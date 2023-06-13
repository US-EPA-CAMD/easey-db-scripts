USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgMonitorHrlyValueInserts]    Script Date: 2/8/2023 2:37:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER   FUNCTION SqlGenEm.PgMonitorHrlyValueInserts
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
                    'insert into camdecmpswks.MONITOR_HRLY_VALUE',
                    ' (',
                        ' MONITOR_HRLY_VAL_ID', ',',
                        ' HOUR_ID', ',',

                        ' MON_LOC_ID', ',',
                        ' RPT_PERIOD_ID', ',',
                        ' MON_SYS_ID', ',',
                        ' COMPONENT_ID', ',',
                        ' PARAMETER_CD', ',',
                        ' APPLICABLE_BIAS_ADJ_FACTOR', ',',
                        ' UNADJUSTED_HRLY_VALUE', ',',
                        ' ADJUSTED_HRLY_VALUE', ',',
                        ' MODC_CD', ',',
                        ' PCT_AVAILABLE', ',',
                        ' MOISTURE_BASIS', ',',

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
                        case when  tar.COMPONENT_ID                   is not null  then  concat( '''', tar.COMPONENT_ID, '''' ) else 'NULL' end, ', ',
                        case when  tar.PARAMETER_CD                   is not null  then  concat( '''', tar.PARAMETER_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.APPLICABLE_BIAS_ADJ_FACTOR     is not null  then  cast( tar.APPLICABLE_BIAS_ADJ_FACTOR as varchar ) else 'NULL' end, ', ',
                        case when  tar.UNADJUSTED_HRLY_VALUE          is not null  then  cast( tar.UNADJUSTED_HRLY_VALUE as varchar ) else 'NULL' end, ', ',
                        case when  tar.ADJUSTED_HRLY_VALUE            is not null  then  cast( tar.ADJUSTED_HRLY_VALUE as varchar ) else 'NULL' end, ', ',
                        case when  tar.MODC_CD                        is not null  then  concat( '''', tar.MODC_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.PCT_AVAILABLE                  is not null  then  cast( tar.PCT_AVAILABLE as varchar ) else 'NULL' end, ', ',
                        case when  tar.MOISTURE_BASIS                 is not null  then  concat( '''', tar.MOISTURE_BASIS, '''' ) else 'NULL' end, ', ',

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
                except
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
            ) sel
        join ECMPS.dbo.HRLY_OP_DATA hod
            on hod.MON_LOC_ID = sel.MON_LOC_ID
            and hod.BEGIN_DATE = sel.BEGIN_DATE
            and hod.BEGIN_HOUR = sel.BEGIN_HOUR
        join ECMPS.dbo.MONITOR_HRLY_VALUE tar 
            on tar.HOUR_ID = hod.HOUR_ID
           and tar.PARAMETER_CD = sel.PARAMETER_CD
           and isnull( tar.MOISTURE_BASIS, 'B' ) = isnull( sel.MOISTURE_BASIS, 'B' )
           and isnull( tar.MODC_CD, '00' ) = isnull( sel.MODC_CD, '00' )
)
GO


