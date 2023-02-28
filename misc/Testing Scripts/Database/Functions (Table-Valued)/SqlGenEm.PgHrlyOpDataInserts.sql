USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgHrlyOpDataInserts]    Script Date: 2/8/2023 2:37:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER   FUNCTION SqlGenEm.PgHrlyOpDataInserts
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
                    'insert into camdecmpswks.HRLY_OP_DATA',
                    ' (',
                        ' HOUR_ID', ',',

                        ' RPT_PERIOD_ID', ',',
                        ' MON_LOC_ID', ',',
                        ' BEGIN_DATE', ',',
                        ' BEGIN_HOUR', ',',
                        ' OP_TIME', ',',
                        ' HR_LOAD', ',',
                        ' LOAD_UOM_CD', ',',
                        ' LOAD_RANGE', ',',
                        ' COMMON_STACK_LOAD_RANGE', ',',
                        ' FC_FACTOR', ',',
                        ' FD_FACTOR', ',',
                        ' FW_FACTOR', ',',
                        ' FUEL_CD', ',',
                        ' MULTI_FUEL_FLG', ',',
                        ' OPERATING_CONDITION_CD', ',',
                        ' FUEL_CD_LIST', ',',
                        ' MHHI_INDICATOR', ',',
                        ' MATS_LOAD', ',',
                        ' MATS_STARTUP_SHUTDOWN_FLG', ',',

                        ' USERID', ',',
                        ' ADD_DATE', ',',
                        ' UPDATE_DATE',
                    ' )',
                    ' values',
                    ' (',
                        '''UNITTEST-'' || uuid_generate_v4()', ', ',
                        
                        case when  tar.RPT_PERIOD_ID                  is not null  then  cast( tar.RPT_PERIOD_ID as varchar ) else 'NULL' end, ', ',
                        case when  tar.MON_LOC_ID                     is not null  then  concat( '''', tar.MON_LOC_ID, '''' ) else 'NULL' end, ', ',
                        case when  tar.BEGIN_DATE                     is not null  then  concat( '''', format( tar.BEGIN_DATE, 'yyyy-MM-dd'), '''' ) else 'NULL' end, ', ',
                        case when  tar.BEGIN_HOUR                     is not null  then  cast( tar.BEGIN_HOUR as varchar ) else 'NULL' end, ', ',
                        case when  tar.OP_TIME                        is not null  then  cast( tar.OP_TIME as varchar ) else 'NULL' end, ', ',
                        case when  tar.HR_LOAD                        is not null  then  cast( tar.HR_LOAD as varchar ) else 'NULL' end, ', ',
                        case when  tar.LOAD_UOM_CD                    is not null  then  concat( '''', tar.LOAD_UOM_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.LOAD_RANGE                     is not null  then  cast( tar.LOAD_RANGE as varchar ) else 'NULL' end, ', ',
                        case when  tar.COMMON_STACK_LOAD_RANGE        is not null  then  cast( tar.COMMON_STACK_LOAD_RANGE as varchar ) else 'NULL' end, ', ',
                        case when  tar.FC_FACTOR                      is not null  then  cast( tar.FC_FACTOR as varchar ) else 'NULL' end, ', ',
                        case when  tar.FD_FACTOR                      is not null  then  cast( tar.FD_FACTOR as varchar ) else 'NULL' end, ', ',
                        case when  tar.FW_FACTOR                      is not null  then  cast( tar.FW_FACTOR as varchar ) else 'NULL' end, ', ',
                        case when  tar.FUEL_CD                        is not null  then  concat( '''', tar.FUEL_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.MULTI_FUEL_FLG                 is not null  then  concat( '''', tar.MULTI_FUEL_FLG, '''' ) else 'NULL' end, ', ',
                        case when  tar.OPERATING_CONDITION_CD         is not null  then  concat( '''', tar.OPERATING_CONDITION_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.FUEL_CD_LIST                   is not null  then  concat( '''', tar.FUEL_CD_LIST, '''' ) else 'NULL' end, ', ',
                        case when  tar.MHHI_INDICATOR                 is not null  then  cast( tar.MHHI_INDICATOR as varchar ) else 'NULL' end, ', ',
                        case when  tar.MATS_LOAD                      is not null  then  cast( tar.MATS_LOAD as varchar ) else 'NULL' end, ', ',
                        case when  tar.MATS_STARTUP_SHUTDOWN_FLG      is not null  then  concat( '''', tar.MATS_STARTUP_SHUTDOWN_FLG, '''' ) else 'NULL' end, ', ',

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
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.MON_LOC_ID,
                        hod.RPT_PERIOD_ID
                    from  @TestInformationTable lst
                        join ECMPS.dbo.HRLY_OP_DATA hod 
                            on hod.MON_LOC_ID = lst.MON_LOC_ID
                            and hod.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                except
                select  -- ECMPSP
                        lst.ORIS_CODE, 
                        lst.FACILITY_NAME, 
                        lst.LOCATIONS, 
                        lst.QUARTER, 
                        lst.LOCATION_NAME,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.MON_LOC_ID,
                        hod.RPT_PERIOD_ID
                    from  @TestInformationTable lst
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.HRLY_OP_DATA hod 
                            on hod.MON_LOC_ID = lst.MON_LOC_ID
                            and hod.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
            ) sel
        join ECMPS.dbo.HRLY_OP_DATA tar
            on tar.MON_LOC_ID = sel.MON_LOC_ID
            and tar.BEGIN_DATE = sel.BEGIN_DATE
            and tar.BEGIN_HOUR = sel.BEGIN_HOUR
)
GO


