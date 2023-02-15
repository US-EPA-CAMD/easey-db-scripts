USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgDailyEmissionInserts]    Script Date: 2/8/2023 2:37:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER   FUNCTION SqlGenEm.PgDailyEmissionInserts
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
                    'insert into camdecmpswks.DAILY_EMISSION',
                    ' (',
                        ' DAILY_EMISSION_ID', ',',

                        ' RPT_PERIOD_ID', ',',
                        ' MON_LOC_ID', ',',
                        ' PARAMETER_CD', ',',
                        ' BEGIN_DATE', ',',
                        ' TOTAL_DAILY_EMISSION', ',',
                        ' ADJUSTED_DAILY_EMISSION', ',',
                        ' UNADJUSTED_DAILY_EMISSION', ',',
                        ' SORBENT_MASS_EMISSION', ',',
                        ' TOTAL_CARBON_BURNED', ',',

                        ' USERID', ',',
                        ' ADD_DATE', ',',
                        ' UPDATE_DATE',
                    ' )',
                    ' values',
                    ' (',
                        '''UNITTEST-'' || uuid_generate_v4()', ', ',
                        
                        case when  tar.RPT_PERIOD_ID                  is not null  then  cast( tar.RPT_PERIOD_ID as varchar ) else 'NULL' end, ', ',
                        case when  tar.MON_LOC_ID                     is not null  then  concat( '''', tar.MON_LOC_ID, '''' ) else 'NULL' end, ', ',
                        case when  tar.PARAMETER_CD                   is not null  then  concat( '''', tar.PARAMETER_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.BEGIN_DATE                     is not null  then  concat( '''', format( tar.BEGIN_DATE, 'yyyy-MM-dd'), '''' ) else 'NULL' end, ', ',
                        case when  tar.TOTAL_DAILY_EMISSION           is not null  then  cast( tar.TOTAL_DAILY_EMISSION as varchar ) else 'NULL' end, ', ',
                        case when  tar.ADJUSTED_DAILY_EMISSION        is not null  then  cast( tar.ADJUSTED_DAILY_EMISSION as varchar ) else 'NULL' end, ', ',
                        case when  tar.UNADJUSTED_DAILY_EMISSION      is not null  then  cast( tar.UNADJUSTED_DAILY_EMISSION as varchar ) else 'NULL' end, ', ',
                        case when  tar.SORBENT_MASS_EMISSION          is not null  then  cast( tar.SORBENT_MASS_EMISSION as varchar ) else 'NULL' end, ', ',
                        case when  tar.TOTAL_CARBON_BURNED            is not null  then  cast( tar.TOTAL_CARBON_BURNED as varchar ) else 'NULL' end, ', ',

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
                        tar.BEGIN_DATE,
                        tar.MON_LOC_ID,
                        tar.RPT_PERIOD_ID
                    from  @TestInformationTable lst
                        join ECMPS.dbo.DAILY_EMISSION tar 
                            on tar.MON_LOC_ID = lst.MON_LOC_ID
                            and tar.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                except
                select  -- ECMPSP
                        lst.ORIS_CODE, 
                        lst.FACILITY_NAME, 
                        lst.LOCATIONS, 
                        lst.QUARTER, 
                        lst.LOCATION_NAME,
                        tar.BEGIN_DATE,
                        tar.MON_LOC_ID,
                        tar.RPT_PERIOD_ID
                    from  @TestInformationTable lst
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.DAILY_EMISSION tar 
                            on tar.MON_LOC_ID = lst.MON_LOC_ID
                            and tar.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
            ) sel
        join ECMPS.dbo.DAILY_EMISSION tar
            on tar.MON_LOC_ID = sel.MON_LOC_ID
            and tar.BEGIN_DATE = sel.BEGIN_DATE
)
GO


