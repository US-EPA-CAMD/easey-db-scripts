USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgNsps4tCompliancePeriodInserts]    Script Date: 2/8/2023 2:37:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER   FUNCTION SqlGenEm.PgNsps4tCompliancePeriodInserts
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
                    'insert into camdecmpswks.NSPS4T_COMPLIANCE_PERIOD',
                    ' (',
                        ' NSPS4T_CMP_ID', ',',
                        ' NSPS4T_SUM_ID', ',',

                        ' BEGIN_YEAR', ',',
                        ' BEGIN_MONTH', ',',
                        ' END_YEAR', ',',
                        ' END_MONTH', ',',
                        ' AVG_CO2_EMISSION_RATE', ',',
                        ' CO2_EMISSION_RATE_UOM_CD', ',',
                        ' PCT_VALID_OP_HOURS', ',',
                        ' CO2_VIOLATION_IND', ',',
                        ' CO2_VIOLATION_COMMENT', ',',
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
                        
                        case when  tar.BEGIN_YEAR                     is not null  then  cast( tar.BEGIN_YEAR as varchar ) else 'NULL' end, ', ',
                        case when  tar.BEGIN_MONTH                    is not null  then  cast( tar.BEGIN_MONTH as varchar ) else 'NULL' end, ', ',
                        case when  tar.END_YEAR                       is not null  then  cast( tar.END_YEAR as varchar ) else 'NULL' end, ', ',
                        case when  tar.END_MONTH                      is not null  then  cast( tar.END_MONTH as varchar ) else 'NULL' end, ', ',
                        case when  tar.AVG_CO2_EMISSION_RATE          is not null  then  cast( tar.AVG_CO2_EMISSION_RATE as varchar ) else 'NULL' end, ', ',
                        case when  tar.CO2_EMISSION_RATE_UOM_CD       is not null  then  concat( '''', tar.CO2_EMISSION_RATE_UOM_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.PCT_VALID_OP_HOURS             is not null  then  cast( tar.PCT_VALID_OP_HOURS as varchar ) else 'NULL' end, ', ',
                        case when  tar.CO2_VIOLATION_IND              is not null  then  cast( tar.CO2_VIOLATION_IND as varchar ) else 'NULL' end, ', ',
                        case when  tar.CO2_VIOLATION_COMMENT          is not null  then  concat( '''', tar.CO2_VIOLATION_COMMENT, '''' ) else 'NULL' end, ', ',
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
                        tar.RPT_PERIOD_ID,
                        tar.BEGIN_YEAR,
                        tar.BEGIN_MONTH,
                        tar.END_YEAR,
                        tar.END_MONTH
                  from  @TestInformationTable lst
                        join ECMPS.dbo.NSPS4T_COMPLIANCE_PERIOD tar 
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
                        tar.BEGIN_YEAR,
                        tar.BEGIN_MONTH,
                        tar.END_YEAR,
                        tar.END_MONTH
                  from  @TestInformationTable lst
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.NSPS4T_COMPLIANCE_PERIOD tar 
                          on tar.MON_LOC_ID = lst.MON_LOC_ID
                         and tar.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
            ) sel
        join ECMPS.dbo.NSPS4T_COMPLIANCE_PERIOD tar 
            on tar.MON_LOC_ID = sel.MON_LOC_ID
           and tar.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
           and tar.BEGIN_YEAR = sel.BEGIN_YEAR
           and tar.BEGIN_MONTH = sel.BEGIN_MONTH
           and tar.END_YEAR = sel.END_YEAR
           and tar.END_MONTH = sel.END_MONTH
)
GO


