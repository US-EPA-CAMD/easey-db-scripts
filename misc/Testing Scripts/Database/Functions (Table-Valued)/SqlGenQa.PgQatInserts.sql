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

    -- Test Qualification
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgTestQualificationInserts( @vTestInformationTable,  5 )

    
    -----------------------
    -- Initialize Offset --
    -----------------------

    declare @OrderOffset integer = 5
    
    
    --------------------------------------------
    -- Genereate 7-Day Calibration Insert SQL --
    --------------------------------------------

    -- CALIBRATION_INJECTION
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.Pg7DayCalibrationInserts( @vTestInformationTable, @OrderOffset + 1 )

    
    ------------------------------------------------------
    -- Genereate Appendix E Correlation Test Insert SQL --
    ------------------------------------------------------

    -- AE_CORRELATION_TEST_SUM
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgAppendixECorrelationTestSummaryInserts( @vTestInformationTable, @OrderOffset + 1 )

    -- AE_CORRELATION_TEST_RUN
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgAppendixECorrelationTestRunInserts( @vTestInformationTable, @OrderOffset + 2 )

    -- AE_HI_GAS
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgAppendixECorrelationHiFromGas( @vTestInformationTable, @OrderOffset + 3 )

    -- AE_HI_OIL
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgAppendixECorrelationHiFromOil( @vTestInformationTable, @OrderOffset + 4 )

    
    -------------------------------------
    -- Genereate Cycle Time Insert SQL --
    -------------------------------------

    -- Cycle Time Summary
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgCycleTimeSummaryInserts( @vTestInformationTable, @OrderOffset + 1 )

    -- Cycle Time Injection
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgCycleTimeInjectionInserts( @vTestInformationTable,  @OrderOffset + 2 )
    
    
    ---------------------------------------
    -- Genereate Flow to Load Insert SQL --
    ---------------------------------------

    -- Flow to Load Check
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgFlowToLoadCheckInserts( @vTestInformationTable, @OrderOffset + 1 )

    -- Flow to Load Reference
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgFlowToLoadReferenceInserts( @vTestInformationTable, @OrderOffset + 1 )
    
    
    --------------------------------------------
    -- Genereate Fuel Flow to Load Insert SQL --
    --------------------------------------------

    -- Fuel Flow to Load Baseline
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgFuelFlowToLoadBaselineInserts( @vTestInformationTable, @OrderOffset + 1 )

    -- Fuel Flow to Load Check
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgFuelFlowToLoadCheckInserts( @vTestInformationTable, @OrderOffset + 1 )
    
    
    ------------------------------------------------------------------------------
    -- Genereate Fuel Flowmeter Accuracy Transmitter Transducer Test Insert SQL --
    ------------------------------------------------------------------------------

    -- TRANS_ACCURACY
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgFuelFlowmeterAccuracyTransmitterTransducerTestInserts( @vTestInformationTable, @OrderOffset + 1 )

    
    ---------------------------------------
    -- Genereate Hg Test Insert SQL --
    ---------------------------------------

    -- Hg Test Summary
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgHgTestSummaryInserts( @vTestInformationTable, @OrderOffset + 1 )

    -- Hg Test Injection
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
    
    
    ----------------------------------------------
    -- Genereate Online-Offline Calibration SQL --
    ----------------------------------------------

    -- Online-Offline Summary
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgOnlineOfflineCalibrationInserts( @vTestInformationTable, @OrderOffset + 1 )
    
    
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

    
    --------------------------------------------
    -- Genereate Unit Default Test Insert SQL --
    --------------------------------------------

    -- Unit Default Test
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgUnitDefaultTestInserts( @vTestInformationTable, @OrderOffset + 1 )

    -- Unit Default Test Run
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenQa.PgUnitDefaultTestRunInserts( @vTestInformationTable,  @OrderOffset + 2 )
    

    return;

end;
GO


