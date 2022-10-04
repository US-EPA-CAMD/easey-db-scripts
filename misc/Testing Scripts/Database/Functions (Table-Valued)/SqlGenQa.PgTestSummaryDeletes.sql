USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgTestSummaryDeletes]    Script Date: 9/6/2022 5:42:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE or ALTER  FUNCTION [SqlGenQa].[PgTestSummaryDeletes] 
(	
	@TestInformationTable SqlGenQa.Test_Information_Table readonly,
    @TestOrder  integer
)
RETURNS TABLE 
AS
RETURN 
(
    select  SqlGenQa.FormatSql( lst.ORIS_CODE, lst.FACILITY_NAME, lst.LOCATION_NAME, lst.TEST_TYPE_CD, lst.TEST_NUM,  @TestOrder, 
                                concat( 'delete from camdecmpswks.TEST_SUMMARY where TEST_SUM_ID = ', '''', lst.TEST_SUM_ID, '''', ';' ) ) as SQL_STATEMENT
      from  @TestInformationTable lst
)
GO


