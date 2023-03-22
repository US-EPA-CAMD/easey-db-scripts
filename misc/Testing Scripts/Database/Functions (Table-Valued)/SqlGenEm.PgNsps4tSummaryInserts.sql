USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgNsps4tSummaryInserts]    Script Date: 2/8/2023 2:37:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER   FUNCTION SqlGenEm.PgNsps4tSummaryInserts
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
                    'insert into camdecmpswks.NSPS4T_SUMMARY',
                    ' (',
                        ' NSPS4T_SUM_ID', ',',

                        ' EMISSION_STANDARD_CD', ',',
                        ' MODUS_VALUE', ',',
                        ' MODUS_UOM_CD', ',',
                        ' ELECTRICAL_LOAD_CD', ',',
                        ' NO_PERIOD_ENDED_IND', ',',
                        ' NO_PERIOD_ENDED_COMMENT', ',',
                        ' MON_LOC_ID', ',',
                        ' RPT_PERIOD_ID', ',',

                        ' USERID', ',',
                        ' ADD_DATE', ',',
                        ' UPDATE_DATE',
                    ' )',
                    ' values',
                    ' (',
                        '''UNITTEST-'' || uuid_generate_v4()', ', ',
                        
                        case when  tar.EMISSION_STANDARD_CD           is not null  then  concat( '''', tar.EMISSION_STANDARD_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.MODUS_VALUE                    is not null  then  cast( tar.MODUS_VALUE as varchar ) else 'NULL' end, ', ',
                        case when  tar.MODUS_UOM_CD                   is not null  then  concat( '''', tar.MODUS_UOM_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.ELECTRICAL_LOAD_CD             is not null  then  concat( '''', tar.ELECTRICAL_LOAD_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.NO_PERIOD_ENDED_IND            is not null  then  cast( tar.NO_PERIOD_ENDED_IND as varchar ) else 'NULL' end, ', ',
                        case when  tar.NO_PERIOD_ENDED_COMMENT        is not null  then  concat( '''', tar.NO_PERIOD_ENDED_COMMENT, '''' ) else 'NULL' end, ', ',
                        case when  tar.MON_LOC_ID                     is not null  then  concat( '''', tar.MON_LOC_ID, '''' ) else 'NULL' end, ', ',
                        case when  tar.RPT_PERIOD_ID                  is not null  then  cast( tar.RPT_PERIOD_ID as varchar ) else 'NULL' end, ', ',

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
                        tar.RPT_PERIOD_ID
                    from  @TestInformationTable lst
                        join ECMPS.dbo.NSPS4T_SUMMARY tar 
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
                        tar.RPT_PERIOD_ID
                    from  @TestInformationTable lst
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.NSPS4T_SUMMARY tar 
                            on tar.MON_LOC_ID = lst.MON_LOC_ID
                            and tar.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
            ) sel
        join ECMPS.dbo.NSPS4T_SUMMARY tar
            on tar.MON_LOC_ID = sel.MON_LOC_ID
           and tar.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
)
GO


