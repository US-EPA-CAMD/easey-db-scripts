USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgNsps4tAnnualInserts]    Script Date: 2/8/2023 2:37:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER   FUNCTION SqlGenEm.PgNsps4tAnnualInserts
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
                    'insert into camdecmpswks.NSPS4T_ANNUAL',
                    ' (',
                        ' NSPS4T_ANN_ID', ',',
                        ' NSPS4T_SUM_ID', ',',

                        ' ANNUAL_ENERGY_SOLD', ',',
                        ' ANNUAL_ENERGY_SOLD_TYPE_CD', ',',
                        ' ANNUAL_POTENTIAL_OUTPUT', ',',
                        ' MON_LOC_ID', ',',
                        ' RPT_PERIOD_ID', ',',

                        ' USERID', ',',
                        ' ADD_DATE', ',',
                        ' UPDATE_DATE',
                    ' )',
                    ' values',
                    ' (',
                        '''UNITTEST-'' || uuid_generate_v4()', ', ',
                        ' ( ', 
                        ' select trp.NSPS4T_SUM_ID from camdecmpswks.NSPS4T_SUMMARY trp',
                        ' where MON_LOC_ID = ''', sel.MON_LOC_ID, '''',
                        ' and RPT_PERIOD_ID = ', sel.RPT_PERIOD_ID,
                        ' )', ', ',
                        
                        case when  tar.ANNUAL_ENERGY_SOLD             is not null  then  cast( tar.ANNUAL_ENERGY_SOLD as varchar ) else 'NULL' end, ', ',
                        case when  tar.ANNUAL_ENERGY_SOLD_TYPE_CD     is not null  then  concat( '''', tar.ANNUAL_ENERGY_SOLD_TYPE_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.ANNUAL_POTENTIAL_OUTPUT        is not null  then  cast( tar.ANNUAL_POTENTIAL_OUTPUT as varchar ) else 'NULL' end, ', ',
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
                        join ECMPS.dbo.NSPS4T_ANNUAL tar 
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
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.NSPS4T_ANNUAL tar 
                          on tar.MON_LOC_ID = lst.MON_LOC_ID
                         and tar.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
            ) sel
            join ECMPS.dbo.NSPS4T_ANNUAL tar 
              on tar.MON_LOC_ID = sel.MON_LOC_ID
             and tar.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
)
GO


