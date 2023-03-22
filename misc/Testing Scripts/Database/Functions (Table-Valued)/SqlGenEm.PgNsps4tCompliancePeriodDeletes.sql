USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgNsps4tCompliancePeriodDeletes]    Script Date: 2/8/2023 4:25:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION SqlGenEm.PgNsps4tCompliancePeriodDeletes
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
                    'delete from camdecmpswks.NSPS4T_COMPLIANCE_PERIOD',
                    ' where MON_LOC_ID = ''', sel.MON_LOC_ID, ''' and RPT_PERIOD_ID = ', sel.RPT_PERIOD_ID,
                    ' and BEGIN_YEAR = ', sel.BEGIN_YEAR, ' and BEGIN_MONTH = ', sel.BEGIN_MONTH,
                    ' and END_YEAR = ', sel.END_YEAR, ' and END_MONTH = ', sel.END_MONTH,
                    ';' 
                )
            ) as SQL_STATEMENT
      from  (
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
                except
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
            ) sel
)
GO


