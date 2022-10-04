USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgQatInserts]    Script Date: 9/6/2022 3:26:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE or ALTER FUNCTION [SqlGenQa].[PgQatInserts] 
(	
	@OrisCode           integer,
    @LocationNameFilter varchar(6),
    @TestTypeCdFilter   varchar(7)
)
RETURNS @SqlTable TABLE ( SQL_STATEMENT varchar(max) )
AS
BEGIN

    ---------------------
    -- Get Information --
    ---------------------

    declare @vTestInformationTable SqlGenQa.Test_Information_Table;

    insert
      into  @vTestInformationTable
            (
                TEST_SUM_ID,
                ORIS_CODE,
                FACILITY_NAME,
                LOCATION_NAME,
                TEST_TYPE_CD,
                TEST_NUM
            )
    select  lst.TEST_SUM_ID,
            lst.ORIS_CODE,
            lst.FACILITY_NAME,
            lst.LOCATION_NAME,
            lst.TEST_TYPE_CD,
            lst.TEST_NUM
      from  SqlGenQa.PgQatInformation( @OrisCode, @LocationNameFilter, @TestTypeCdFilter ) lst;
    
    
    -----------------------------------
    -- Genereate Delete Existing SQL --
    -----------------------------------

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgTestSummaryDeletes(@vTestInformationTable, 1)

    
    ---------------------------------------
    -- Genereate Test Summary Insert SQL --
    ---------------------------------------

    -- Test Summary
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgTestSummaryInserts(@vTestInformationTable, 2)

    
    -------------------------------------------------------------
    -- Genereate Protocol Gas and Air Emission Test Insert SQL --
    -------------------------------------------------------------

    -- Protocol Gas
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgProtocolGasInserts( @vTestInformationTable,  3 )

    -- Air Emission Test
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgAirEmissionTestingInserts( @vTestInformationTable,  4 )

    
    -----------------------
    -- Initialize Offset --
    -----------------------

    declare @OrderOffset integer = 4
    
    
    ---------------------------------------
    -- Genereate Hg Test Insert SQL --
    ---------------------------------------

    -- Linearity Summary
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgHgTestSummaryInserts( @vTestInformationTable, @OrderOffset + 1 )

    -- Linearity Injection
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgHgTestInjectionInserts( @vTestInformationTable,  @OrderOffset + 2 )
    
    
    ---------------------------------------
    -- Genereate Linearity Insert SQL --
    ---------------------------------------

    -- Linearity Summary
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgLinearitySummaryInserts( @vTestInformationTable, @OrderOffset + 1 )

    -- Linearity Injection
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgLinearityInjectionInserts( @vTestInformationTable,  @OrderOffset + 2 )
    
    
    ---------------------------------------
    -- Genereate RATA Insert SQL --
    ---------------------------------------

    -- RATA
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgRataInserts( @vTestInformationTable, @OrderOffset + 1 )

    -- RATA_SUMMARY
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgRataSummaryInserts( @vTestInformationTable, @OrderOffset + 2 )

    -- RATA_RUN
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgRataRunInserts( @vTestInformationTable, @OrderOffset + 3 )

    -- FLOW_RATA_RUN
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgFlowRataRunInserts( @vTestInformationTable, @OrderOffset + 4 )

    -- RATA_TRAVERSE
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgRataTraverseInserts( @vTestInformationTable, @OrderOffset + 5 )


    return;

end;
GO


