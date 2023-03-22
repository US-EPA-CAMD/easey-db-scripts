USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgSorbentTrapInserts]    Script Date: 2/8/2023 2:37:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER   FUNCTION SqlGenEm.PgSorbentTrapInserts
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
                    'insert into camdecmpswks.SORBENT_TRAP',
                    ' (',
                        ' TRAP_ID', ',',

                        ' MON_LOC_ID', ',',
                        ' RPT_PERIOD_ID', ',',
                        ' BEGIN_DATE', ',',
                        ' BEGIN_HOUR', ',',
                        ' END_DATE', ',',
                        ' END_HOUR', ',',
                        ' MON_SYS_ID', ',',
                        ' PAIRED_TRAP_AGREEMENT', ',',
                        ' ABSOLUTE_DIFFERENCE_IND', ',',
                        ' MODC_CD', ',',
                        ' HG_CONCENTRATION', ',',
                        ' SORBENT_TRAP_APS_CD', ',',
                        ' RATA_IND', ',',

                        ' USERID', ',',
                        ' ADD_DATE', ',',
                        ' UPDATE_DATE',
                    ' )',
                    ' values',
                    ' (',
                        '''UNITTEST-'' || uuid_generate_v4()', ', ',
                        
                        case when  tar.MON_LOC_ID                     is not null  then  concat( '''', tar.MON_LOC_ID, '''' ) else 'NULL' end, ', ',
                        case when  tar.RPT_PERIOD_ID                  is not null  then  cast( tar.RPT_PERIOD_ID as varchar ) else 'NULL' end, ', ',
                        case when  tar.BEGIN_DATE                     is not null  then  concat( '''', format( tar.BEGIN_DATE, 'yyyy-MM-dd'), '''' ) else 'NULL' end, ', ',
                        case when  tar.BEGIN_HOUR                     is not null  then  cast( tar.BEGIN_HOUR as varchar ) else 'NULL' end, ', ',
                        case when  tar.END_DATE                       is not null  then  concat( '''', format( tar.END_DATE, 'yyyy-MM-dd'), '''' ) else 'NULL' end, ', ',
                        case when  tar.END_HOUR                       is not null  then  cast( tar.END_HOUR as varchar ) else 'NULL' end, ', ',
                        case when  tar.MON_SYS_ID                     is not null  then  concat( '''', tar.MON_SYS_ID, '''' ) else 'NULL' end, ', ',
                        case when  tar.PAIRED_TRAP_AGREEMENT          is not null  then  cast( tar.PAIRED_TRAP_AGREEMENT as varchar ) else 'NULL' end, ', ',
                        case when  tar.ABSOLUTE_DIFFERENCE_IND        is not null  then  cast( tar.ABSOLUTE_DIFFERENCE_IND as varchar ) else 'NULL' end, ', ',
                        case when  tar.MODC_CD                        is not null  then  concat( '''', tar.MODC_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.HG_CONCENTRATION               is not null  then  concat( '''', tar.HG_CONCENTRATION, '''' ) else 'NULL' end, ', ',
                        case when  tar.SORBENT_TRAP_APS_CD            is not null  then  concat( '''', tar.SORBENT_TRAP_APS_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.RATA_IND                       is not null  then  cast( tar.RATA_IND as varchar ) else 'NULL' end, ', ',

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
                        tar.MON_LOC_ID,
                        tar.RPT_PERIOD_ID,
                        tar.MON_SYS_ID,
                        tar.BEGIN_DATE,
                        tar.BEGIN_HOUR,
                        tar.END_DATE,
                        tar.END_HOUR
                    from  @TestInformationTable lst
                        join ECMPS.dbo.SORBENT_TRAP tar 
                            on tar.MON_LOC_ID = lst.MON_LOC_ID
                            and tar.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                except
                select  -- ECMPSP
                        lst.ORIS_CODE, 
                        lst.FACILITY_NAME, 
                        lst.LOCATIONS, 
                        lst.QUARTER, 
                        lst.LOCATION_NAME,
                        tar.MON_LOC_ID,
                        tar.RPT_PERIOD_ID,
                        tar.MON_SYS_ID,
                        tar.BEGIN_DATE,
                        tar.BEGIN_HOUR,
                        tar.END_DATE,
                        tar.END_HOUR
                    from  @TestInformationTable lst
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.SORBENT_TRAP tar 
                            on tar.MON_LOC_ID = lst.MON_LOC_ID
                            and tar.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
            ) sel
        join ECMPS.dbo.SORBENT_TRAP tar
            on tar.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
            and tar.MON_LOC_ID = sel.MON_LOC_ID
            and tar.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
            and tar.MON_SYS_ID = sel.MON_SYS_ID
            and tar.BEGIN_DATE = sel.BEGIN_DATE
            and tar.BEGIN_HOUR = sel.BEGIN_HOUR
            and tar.END_DATE = sel.END_DATE
            and tar.END_HOUR = sel.END_HOUR
)
GO


