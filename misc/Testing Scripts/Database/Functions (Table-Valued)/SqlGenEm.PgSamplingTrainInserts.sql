USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgSamplingTrainInserts]    Script Date: 2/8/2023 2:37:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER   FUNCTION SqlGenEm.PgSamplingTrainInserts
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
                    'insert into camdecmpswks.SAMPLING_TRAIN',
                    ' (',
                        ' TRAP_TRAIN_ID', ',',
                        ' TRAP_ID', ',',

                        ' MON_LOC_ID', ',',
                        ' RPT_PERIOD_ID', ',',
                        ' COMPONENT_ID', ',',
                        ' SORBENT_TRAP_SERIAL_NUMBER', ',',
                        ' MAIN_TRAP_HG', ',',
                        ' BREAKTHROUGH_TRAP_HG', ',',
                        ' SPIKE_TRAP_HG', ',',
                        ' SPIKE_REF_VALUE', ',',
                        ' TOTAL_SAMPLE_VOLUME', ',',
                        ' REF_FLOW_TO_SAMPLING_RATIO', ',',
                        ' HG_CONCENTRATION', ',',
                        ' PERCENT_BREAKTHROUGH', ',',
                        ' PERCENT_SPIKE_RECOVERY', ',',
                        ' SAMPLING_RATIO_TEST_RESULT_CD', ',',
                        ' POST_LEAK_TEST_RESULT_CD', ',',
                        ' TRAIN_QA_STATUS_CD', ',',
                        ' SAMPLE_DAMAGE_EXPLANATION', ',',

                        ' USERID', ',',
                        ' ADD_DATE', ',',
                        ' UPDATE_DATE',
                    ' )',
                    ' values',
                    ' (',
                        '''UNITTEST-'' || uuid_generate_v4()', ', ',
                        ' ( ', 
                        ' select trp.TRAP_ID from camdecmpswks.SORBENT_TRAP trp',
                        ' where MON_LOC_ID = ''', sel.MON_LOC_ID, '''',
                        ' and RPT_PERIOD_ID = ', sel.RPT_PERIOD_ID,
                        ' and MON_SYS_ID = ''', sel.MON_SYS_ID, '''',
                        ' and BEGIN_DATE = ''', format( sel.BEGIN_DATE, 'yyyy-MM-dd' ), ''' and BEGIN_HOUR = ', sel.BEGIN_HOUR,
                        ' and END_DATE = ''', format( sel.END_DATE, 'yyyy-MM-dd' ), ''' and END_HOUR = ', sel.END_HOUR,
                        ' )', ', ',
                        
                        case when  tar.MON_LOC_ID                     is not null  then  concat( '''', tar.MON_LOC_ID, '''' ) else 'NULL' end, ', ',
                        case when  tar.RPT_PERIOD_ID                  is not null  then  cast( tar.RPT_PERIOD_ID as varchar ) else 'NULL' end, ', ',
                        case when  tar.COMPONENT_ID                   is not null  then  concat( '''', tar.COMPONENT_ID, '''' ) else 'NULL' end, ', ',
                        case when  tar.SORBENT_TRAP_SERIAL_NUMBER     is not null  then  concat( '''', tar.SORBENT_TRAP_SERIAL_NUMBER, '''' ) else 'NULL' end, ', ',
                        case when  tar.MAIN_TRAP_HG                   is not null  then  concat( '''', tar.MAIN_TRAP_HG, '''' ) else 'NULL' end, ', ',
                        case when  tar.BREAKTHROUGH_TRAP_HG           is not null  then  concat( '''', tar.BREAKTHROUGH_TRAP_HG, '''' ) else 'NULL' end, ', ',
                        case when  tar.SPIKE_TRAP_HG                  is not null  then  concat( '''', tar.SPIKE_TRAP_HG, '''' ) else 'NULL' end, ', ',
                        case when  tar.SPIKE_REF_VALUE                is not null  then  concat( '''', tar.SPIKE_REF_VALUE, '''' ) else 'NULL' end, ', ',
                        case when  tar.TOTAL_SAMPLE_VOLUME            is not null  then  cast( tar.TOTAL_SAMPLE_VOLUME as varchar ) else 'NULL' end, ', ',
                        case when  tar.REF_FLOW_TO_SAMPLING_RATIO     is not null  then  cast( tar.REF_FLOW_TO_SAMPLING_RATIO as varchar ) else 'NULL' end, ', ',
                        case when  tar.HG_CONCENTRATION               is not null  then  concat( '''', tar.HG_CONCENTRATION, '''' ) else 'NULL' end, ', ',
                        case when  tar.PERCENT_BREAKTHROUGH           is not null  then  cast( tar.PERCENT_BREAKTHROUGH as varchar ) else 'NULL' end, ', ',
                        case when  tar.PERCENT_SPIKE_RECOVERY         is not null  then  cast( tar.PERCENT_SPIKE_RECOVERY as varchar ) else 'NULL' end, ', ',
                        case when  tar.SAMPLING_RATIO_TEST_RESULT_CD  is not null  then  concat( '''', tar.SAMPLING_RATIO_TEST_RESULT_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.POST_LEAK_TEST_RESULT_CD       is not null  then  concat( '''', tar.POST_LEAK_TEST_RESULT_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.TRAIN_QA_STATUS_CD             is not null  then  concat( '''', tar.TRAIN_QA_STATUS_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.SAMPLE_DAMAGE_EXPLANATION      is not null  then  concat( '''', tar.SAMPLE_DAMAGE_EXPLANATION, '''' ) else 'NULL' end, ', ',

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
                        trp.MON_LOC_ID,
                        trp.RPT_PERIOD_ID,
                        trp.MON_SYS_ID,
                        trp.BEGIN_DATE,
                        trp.BEGIN_HOUR,
                        trp.END_DATE,
                        trp.END_HOUR,
                        tar.COMPONENT_ID
                    from  @TestInformationTable lst
                        join ECMPS.dbo.SORBENT_TRAP trp 
                            on trp.MON_LOC_ID = lst.MON_LOC_ID
                            and trp.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                        join ECMPS.dbo.SAMPLING_TRAIN tar 
                            on tar.TRAP_ID = trp.TRAP_ID
                except
                select  -- ECMPSP
                        lst.ORIS_CODE, 
                        lst.FACILITY_NAME, 
                        lst.LOCATIONS, 
                        lst.QUARTER, 
                        lst.LOCATION_NAME,
                        trp.MON_LOC_ID,
                        trp.RPT_PERIOD_ID,
                        trp.MON_SYS_ID,
                        trp.BEGIN_DATE,
                        trp.BEGIN_HOUR,
                        trp.END_DATE,
                        trp.END_HOUR,
                        tar.COMPONENT_ID
                    from  @TestInformationTable lst
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.SORBENT_TRAP trp 
                            on trp.MON_LOC_ID = lst.MON_LOC_ID
                            and trp.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.SAMPLING_TRAIN tar 
                            on tar.TRAP_ID = trp.TRAP_ID
            ) sel
        join ECMPS.dbo.SORBENT_TRAP trp
            on trp.MON_LOC_ID = sel.MON_LOC_ID
            and trp.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
            and trp.MON_SYS_ID = sel.MON_SYS_ID
            and trp.BEGIN_DATE = sel.BEGIN_DATE
            and trp.BEGIN_HOUR = sel.BEGIN_HOUR
            and trp.END_DATE = sel.END_DATE
            and trp.END_HOUR = sel.END_HOUR
        join ECMPS.dbo.SAMPLING_TRAIN tar 
            on tar.TRAP_ID = trp.TRAP_ID
           and tar.COMPONENT_ID = sel.COMPONENT_ID
)
GO


