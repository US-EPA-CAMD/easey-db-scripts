USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgEmLoad]    Script Date: 2/15/2023 11:11:11 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION SqlGenEm.PgEmLoad
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
                lst.ORIS_CODE, lst.FACILITY_NAME, lst.LOCATIONS, lst.QUARTER, null,  @TestOrder,
                concat( 'call camdecmpswks.load_emissions_workspace( ''',  lst.MON_PLAN_ID, ''', ', prd.CALENDAR_YEAR, ', ', prd.QUARTER, ' );' )
            ) as SQL_STATEMENT
      from  @TestInformationTable lst
            join ECMPS.dbo.REPORTING_PERIOD prd
              on prd.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
     group
        by  lst.ORIS_CODE, 
            lst.FACILITY_NAME, 
            lst.LOCATIONS, 
            lst.QUARTER, 
            lst.MON_PLAN_ID,
            lst.RPT_PERIOD_ID,
            prd.CALENDAR_YEAR,
            prd.QUARTER
)
GO


