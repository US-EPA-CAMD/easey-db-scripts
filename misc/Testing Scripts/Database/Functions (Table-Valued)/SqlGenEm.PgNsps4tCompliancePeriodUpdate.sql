USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgNsps4tCompliancePeriodUpdates]    Script Date: 2/7/2023 1:29:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE or ALTER FUNCTION SqlGenEm.PgNsps4tCompliancePeriodUpdates
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
                    'update camdecmpswks.NSPS4T_COMPLIANCE_PERIOD set',

                    ' BEGIN_YEAR                     = ',  case when  tar.BEGIN_YEAR                     is not null  then  cast( tar.BEGIN_YEAR as varchar ) else 'NULL' end, ', ',
                    ' BEGIN_MONTH                    = ',  case when  tar.BEGIN_MONTH                    is not null  then  cast( tar.BEGIN_MONTH as varchar ) else 'NULL' end, ', ',
                    ' END_YEAR                       = ',  case when  tar.END_YEAR                       is not null  then  cast( tar.END_YEAR as varchar ) else 'NULL' end, ', ',
                    ' END_MONTH                      = ',  case when  tar.END_MONTH                      is not null  then  cast( tar.END_MONTH as varchar ) else 'NULL' end, ', ',
                    ' AVG_CO2_EMISSION_RATE          = ',  case when  tar.AVG_CO2_EMISSION_RATE          is not null  then  cast( tar.AVG_CO2_EMISSION_RATE as varchar ) else 'NULL' end, ', ',
                    ' CO2_EMISSION_RATE_UOM_CD       = ',  case when  tar.CO2_EMISSION_RATE_UOM_CD       is not null  then  concat( '''', tar.CO2_EMISSION_RATE_UOM_CD, '''' ) else 'NULL' end, ', ',
                    ' PCT_VALID_OP_HOURS             = ',  case when  tar.PCT_VALID_OP_HOURS             is not null  then  cast( tar.PCT_VALID_OP_HOURS as varchar ) else 'NULL' end, ', ',
                    ' CO2_VIOLATION_IND              = ',  case when  tar.CO2_VIOLATION_IND              is not null  then  cast( tar.CO2_VIOLATION_IND as varchar ) else 'NULL' end, ', ',
                    ' CO2_VIOLATION_COMMENT          = ',  case when  tar.CO2_VIOLATION_COMMENT          is not null  then  concat( '''', tar.CO2_VIOLATION_COMMENT, '''' ) else 'NULL' end, ', ',
                    ' MON_LOC_ID                     = ',  case when  tar.MON_LOC_ID                     is not null  then  concat( '''', tar.MON_LOC_ID, '''' ) else 'NULL' end, ', ',
                    ' RPT_PERIOD_ID                  = ',  case when  tar.RPT_PERIOD_ID                  is not null  then  cast( tar.RPT_PERIOD_ID as varchar ) else 'NULL' end, ', ',

                    ' USERID                          = ', '''UNITTEST''', ', ',
                    ' UPDATE_DATE                     = ', concat( '''', format( getdate(), 'yyyy-MM-dd'), '''' ),

                    ' where MON_LOC_ID = ''', sel.MON_LOC_ID, ''' and RPT_PERIOD_ID = ', sel.RPT_PERIOD_ID,
                    ' and BEGIN_YEAR = ', sel.BEGIN_YEAR, ' and BEGIN_MONTH = ', sel.BEGIN_MONTH,
                    ' and END_YEAR = ', sel.END_YEAR, ' and END_MONTH = ', sel.END_MONTH,
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
                        dat.BEGIN_YEAR,
                        dat.BEGIN_MONTH,
                        dat.END_YEAR,
                        dat.END_MONTH,
                        count( 1 ) as ROW_COUNT
                  from  (
                            select  -- ECMPSP
                                    lst.ORIS_CODE, 
                                    lst.FACILITY_NAME, 
                                    lst.LOCATIONS, 
                                    lst.QUARTER, 
                                    lst.LOCATION_NAME,
                                    tar.BEGIN_YEAR,
                                    tar.BEGIN_MONTH,
                                    tar.END_YEAR,
                                    tar.END_MONTH,
                                    tar.AVG_CO2_EMISSION_RATE,
                                    tar.CO2_EMISSION_RATE_UOM_CD,
                                    tar.PCT_VALID_OP_HOURS,
                                    tar.CO2_VIOLATION_IND,
                                    tar.CO2_VIOLATION_COMMENT,
                                    tar.MON_LOC_ID,
                                    tar.RPT_PERIOD_ID
                              from  @TestInformationTable lst
                                    join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.NSPS4T_COMPLIANCE_PERIOD tar 
                                      on tar.MON_LOC_ID = lst.MON_LOC_ID
                                     and tar.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                            union
                            select  -- ECMPS_WORKING
                                    lst.ORIS_CODE, 
                                    lst.FACILITY_NAME, 
                                    lst.LOCATIONS, 
                                    lst.QUARTER, 
                                    lst.LOCATION_NAME,
                                    tar.BEGIN_YEAR,
                                    tar.BEGIN_MONTH,
                                    tar.END_YEAR,
                                    tar.END_MONTH,
                                    tar.AVG_CO2_EMISSION_RATE,
                                    tar.CO2_EMISSION_RATE_UOM_CD,
                                    tar.PCT_VALID_OP_HOURS,
                                    tar.CO2_VIOLATION_IND,
                                    tar.CO2_VIOLATION_COMMENT,
                                    tar.MON_LOC_ID,
                                    tar.RPT_PERIOD_ID
                              from  @TestInformationTable lst
                                    join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.NSPS4T_COMPLIANCE_PERIOD tar 
                                      on tar.MON_LOC_ID = lst.MON_LOC_ID
                                     and tar.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                        ) dat
                 group
                    by  dat.ORIS_CODE, 
                        dat.FACILITY_NAME, 
                        dat.LOCATIONS, 
                        dat.QUARTER, 
                        dat.LOCATION_NAME,
                        dat.MON_LOC_ID,
                        dat.RPT_PERIOD_ID,
                        dat.BEGIN_YEAR,
                        dat.BEGIN_MONTH,
                        dat.END_YEAR,
                        dat.END_MONTH
                having  ( count( 1 ) > 1 )
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


