USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgSamplingTrainnUpdates]    Script Date: 2/7/2023 1:29:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE or ALTER FUNCTION SqlGenEm.PgSamplingTrainUpdates
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
                    'update camdecmpswks.SAMPLING_TRAIN tar set',

                    ' MON_LOC_ID                     = ',  case when  tar.MON_LOC_ID                     is not null  then  concat( '''', tar.MON_LOC_ID, '''' ) else 'NULL' end, ', ',
                    ' RPT_PERIOD_ID                  = ',  case when  tar.RPT_PERIOD_ID                  is not null  then  cast( tar.RPT_PERIOD_ID as varchar ) else 'NULL' end, ', ',
                    ' COMPONENT_ID                   = ',  case when  tar.COMPONENT_ID                   is not null  then  concat( '''', tar.COMPONENT_ID, '''' ) else 'NULL' end, ', ',
                    ' SORBENT_TRAP_SERIAL_NUMBER     = ',  case when  tar.SORBENT_TRAP_SERIAL_NUMBER     is not null  then  concat( '''', tar.SORBENT_TRAP_SERIAL_NUMBER, '''' ) else 'NULL' end, ', ',
                    ' MAIN_TRAP_HG                   = ',  case when  tar.MAIN_TRAP_HG                   is not null  then  concat( '''', tar.MAIN_TRAP_HG, '''' ) else 'NULL' end, ', ',
                    ' BREAKTHROUGH_TRAP_HG           = ',  case when  tar.BREAKTHROUGH_TRAP_HG           is not null  then  concat( '''', tar.BREAKTHROUGH_TRAP_HG, '''' ) else 'NULL' end, ', ',
                    ' SPIKE_TRAP_HG                  = ',  case when  tar.SPIKE_TRAP_HG                  is not null  then  concat( '''', tar.SPIKE_TRAP_HG, '''' ) else 'NULL' end, ', ',
                    ' SPIKE_REF_VALUE                = ',  case when  tar.SPIKE_REF_VALUE                is not null  then  concat( '''', tar.SPIKE_REF_VALUE, '''' ) else 'NULL' end, ', ',
                    ' TOTAL_SAMPLE_VOLUME            = ',  case when  tar.TOTAL_SAMPLE_VOLUME            is not null  then  cast( tar.TOTAL_SAMPLE_VOLUME as varchar ) else 'NULL' end, ', ',
                    ' REF_FLOW_TO_SAMPLING_RATIO     = ',  case when  tar.REF_FLOW_TO_SAMPLING_RATIO     is not null  then  cast( tar.REF_FLOW_TO_SAMPLING_RATIO as varchar ) else 'NULL' end, ', ',
                    ' HG_CONCENTRATION               = ',  case when  tar.HG_CONCENTRATION               is not null  then  concat( '''', tar.HG_CONCENTRATION, '''' ) else 'NULL' end, ', ',
                    ' PERCENT_BREAKTHROUGH           = ',  case when  tar.PERCENT_BREAKTHROUGH           is not null  then  cast( tar.PERCENT_BREAKTHROUGH as varchar ) else 'NULL' end, ', ',
                    ' PERCENT_SPIKE_RECOVERY         = ',  case when  tar.PERCENT_SPIKE_RECOVERY         is not null  then  cast( tar.PERCENT_SPIKE_RECOVERY as varchar ) else 'NULL' end, ', ',
                    ' SAMPLING_RATIO_TEST_RESULT_CD  = ',  case when  tar.SAMPLING_RATIO_TEST_RESULT_CD  is not null  then  concat( '''', tar.SAMPLING_RATIO_TEST_RESULT_CD, '''' ) else 'NULL' end, ', ',
                    ' POST_LEAK_TEST_RESULT_CD       = ',  case when  tar.POST_LEAK_TEST_RESULT_CD       is not null  then  concat( '''', tar.POST_LEAK_TEST_RESULT_CD, '''' ) else 'NULL' end, ', ',
                    ' TRAIN_QA_STATUS_CD             = ',  case when  tar.TRAIN_QA_STATUS_CD             is not null  then  concat( '''', tar.TRAIN_QA_STATUS_CD, '''' ) else 'NULL' end, ', ',
                    ' SAMPLE_DAMAGE_EXPLANATION      = ',  case when  tar.SAMPLE_DAMAGE_EXPLANATION      is not null  then  concat( '''', tar.SAMPLE_DAMAGE_EXPLANATION, '''' ) else 'NULL' end, ', ',

                    ' USERID                         = ', '''UNITTEST''', ', ',
                    ' UPDATE_DATE                    = ', concat( '''', format( getdate(), 'yyyy-MM-dd'), '''' ),

                    ' where  exists', 
                    ' (', 
                    ' select 1 from camdecmpswks.SORBENT_TRAP trp', 
                    ' join camdecmpswks.SAMPLING_TRAIN trn on trn.TRAP_ID = trp.TRAP_ID',
                    ' where trp.MON_LOC_ID = ''', sel.MON_LOC_ID, '''',
                    ' and trp.RPT_PERIOD_ID = ', sel.RPT_PERIOD_ID,
                    ' and trp.MON_SYS_ID = ''', sel.MON_SYS_ID, '''',
                    ' and trp.BEGIN_DATE = ''', format( sel.BEGIN_DATE, 'yyyy-MM-dd' ), ''' and trp.BEGIN_HOUR = ', sel.BEGIN_HOUR,
                    ' and trp.END_DATE = ''', format( sel.END_DATE, 'yyyy-MM-dd' ), ''' and trp.END_HOUR = ', sel.END_HOUR,
                    ' and trn.COMPONENT_ID = ''', sel.COMPONENT_ID, '''',
                    ' and trp.TRAP_ID = tar.TRAP_ID',
                    ' and trn.COMPONENT_ID = tar.COMPONENT_ID',
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
                        dat.MON_SYS_ID,
                        dat.BEGIN_DATE,
                        dat.BEGIN_HOUR,
                        dat.END_DATE,
                        dat.END_HOUR,
                        dat.COMPONENT_ID,
                        count( 1 ) as ROW_COUNT
                  from  (
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
                                    tar.COMPONENT_ID,
                                    tar.SORBENT_TRAP_SERIAL_NUMBER,
                                    tar.MAIN_TRAP_HG,
                                    tar.BREAKTHROUGH_TRAP_HG,
                                    tar.SPIKE_TRAP_HG,
                                    tar.SPIKE_REF_VALUE,
                                    tar.TOTAL_SAMPLE_VOLUME,
                                    tar.REF_FLOW_TO_SAMPLING_RATIO,
                                    tar.HG_CONCENTRATION,
                                    tar.PERCENT_BREAKTHROUGH,
                                    tar.PERCENT_SPIKE_RECOVERY,
                                    tar.SAMPLING_RATIO_TEST_RESULT_CD,
                                    tar.POST_LEAK_TEST_RESULT_CD,
                                    tar.TRAIN_QA_STATUS_CD,
                                    tar.SAMPLE_DAMAGE_EXPLANATION
                              from  @TestInformationTable lst
                                    join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.SORBENT_TRAP trp 
                                      on trp.MON_LOC_ID = lst.MON_LOC_ID
                                     and trp.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                                    join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.SAMPLING_TRAIN tar 
                                        on tar.TRAP_ID = trp.TRAP_ID
                            union
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
                                    tar.COMPONENT_ID,
                                    tar.SORBENT_TRAP_SERIAL_NUMBER,
                                    tar.MAIN_TRAP_HG,
                                    tar.BREAKTHROUGH_TRAP_HG,
                                    tar.SPIKE_TRAP_HG,
                                    tar.SPIKE_REF_VALUE,
                                    tar.TOTAL_SAMPLE_VOLUME,
                                    tar.REF_FLOW_TO_SAMPLING_RATIO,
                                    tar.HG_CONCENTRATION,
                                    tar.PERCENT_BREAKTHROUGH,
                                    tar.PERCENT_SPIKE_RECOVERY,
                                    tar.SAMPLING_RATIO_TEST_RESULT_CD,
                                    tar.POST_LEAK_TEST_RESULT_CD,
                                    tar.TRAIN_QA_STATUS_CD,
                                    tar.SAMPLE_DAMAGE_EXPLANATION
                              from  @TestInformationTable lst
                                    join ECMPS.dbo.SORBENT_TRAP trp 
                                      on trp.MON_LOC_ID = lst.MON_LOC_ID
                                     and trp.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                                    join ECMPS.dbo.SAMPLING_TRAIN tar 
                                        on tar.TRAP_ID = trp.TRAP_ID
                        ) dat
                 group
                    by  dat.ORIS_CODE, 
                        dat.FACILITY_NAME, 
                        dat.LOCATIONS, 
                        dat.QUARTER, 
                        dat.LOCATION_NAME,
                        dat.MON_LOC_ID,
                        dat.RPT_PERIOD_ID,
                        dat.MON_SYS_ID,
                        dat.BEGIN_DATE,
                        dat.BEGIN_HOUR,
                        dat.END_DATE,
                        dat.END_HOUR,
                        dat.COMPONENT_ID
                having  ( count( 1 ) > 1 )
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


