USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgEm]    Script Date: 2/7/2023 2:34:26 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE or ALTER FUNCTION SqlGenEm.PgEm 
(	
	@OrisCode           integer,
    @Year               integer,
    @Quarter            integer,
    @LocationNameFilter varchar(6)
)
RETURNS @SqlTable TABLE ( SQL_STATEMENT varchar(max) )
AS
BEGIN

    declare @LoadOrder integer = 0;
    
    ---------------------
    -- Get Information --
    ---------------------

    declare @vEmInformationTable SqlGenEm.Em_Information_Table;

    insert
      into  @vEmInformationTable
            (
                ORIS_CODE,
                FACILITY_NAME,
                LOCATIONS,
                QUARTER,
                LOCATION_NAME,
                MON_PLAN_ID,
                RPT_PERIOD_ID,
                MON_LOC_ID
            )
    select  lst.ORIS_CODE,
            lst.FACILITY_NAME,
            lst.LOCATIONS,
            lst.QUARTER,
            lst.LOCATION_NAME,
            lst.MON_PLAN_ID,
            lst.RPT_PERIOD_ID,
            lst.MON_LOC_ID
      from  SqlGenEm.PgEmInformation( @OrisCode, @Year, @Quarter, @LocationNameFilter ) lst;
    
    
    ----------------------------------
    -- Genereate Load Workspace SQL --
    ----------------------------------

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgEmLoad(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1   
    

    -----------------------------------
    -- Genereate Delete Existing SQL --
    -----------------------------------

    -- HRLY_OP_DATA
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgHrlyOpDataDeletes(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    -- DERIVED_HRLY_VALUE
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgDerivedHrlyValueDeletes(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    -- MONITOR_HRLY_VALUE
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgMonitorHrlyValueDeletes(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    -- MATS_DERIVED_HRLY_VALUE
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgMatsDerivedHrlyValueDeletes(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    -- MATS_MONITOR_HRLY_VALUE
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgMatsMonitorHrlyValueDeletes(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    -- HRLY_FUEL_FLOW
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgHrlyFuelFlowDeletes(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    -- HRLY_PARAM_FUEL_FLOW
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgHrlyParamFuelFlowDeletes(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    -- HRLY_GAS_FLOW_METER
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgHrlyGasFlowMeterDeletes(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    -- DAILY_EMISSION
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgDailyEmissionDeletes(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    -- DAILY_FUEL
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgDailyFuelDeletes(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    -- LONG_TERM_FUEL_FLOW
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgLongTermFuelFlowDeletes(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    -- SUMMARY_VALUE
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgSummaryValueDeletes(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    -- SORBENT_TRA{
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgSorbentTrapDeletes(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    -- SAMPLING_TRAIN
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgSamplingTrainDeletes(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    -- DAILY_TEST_SUMMARY
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgDailyTestSummaryDeletes(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    -- DAILY_CALIBRATION
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgDailyCalibrationDeletes(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    -- WEEKLY_TEST_SUMMARY
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgWeeklyTestSummaryDeletes(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    -- WEEKLY_SYSTEM_INTEGRITY
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgWeeklySystemIntegrityDeletes(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    -- NSPS4T_SUMMARY
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgNsps4tSummaryDeletes(@vEmInformationTable, @LoadOrder)

    -- NSPS4T_ANNUAL
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgNsps4tAnnualDeletes(@vEmInformationTable, @LoadOrder)

    -- NSPS4T_COMPLIANCE_PERIOD
    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgNsps4tCompliancePeriodDeletes(@vEmInformationTable, @LoadOrder)
    

    --------------------------------------------------
    -- Genereate HRLY_OP_DATA Update and Insert SQL --
    --------------------------------------------------

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgHrlyOpDataUpdates(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgHrlyOpDataInserts(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1
    

    --------------------------------------------------------
    -- Genereate DERIVED_HRLY_VALUE Update and Insert SQL --
    --------------------------------------------------------

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgDerivedHrlyValueUpdates(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgDerivedHrlyValueInserts(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1
    

    --------------------------------------------------------
    -- Genereate MONITOR_HRLY_VALUE Update and Insert SQL --
    --------------------------------------------------------

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgMonitorHrlyValueUpdates(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgMonitorHrlyValueInserts(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1
    

    -------------------------------------------------------------
    -- Genereate MATS_DERIVED_HRLY_VALUE Update and Insert SQL --
    -------------------------------------------------------------

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgMatsDerivedHrlyValueUpdates(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgMatsDerivedHrlyValueInserts(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1
    

    -------------------------------------------------------------
    -- Genereate MATS_MONITOR_HRLY_VALUE Update and Insert SQL --
    -------------------------------------------------------------

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgMatsMonitorHrlyValueUpdates(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgMatsMonitorHrlyValueInserts(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1
    

    ----------------------------------------------------
    -- Genereate HRLY_FUEL_FLOW Update and Insert SQL --
    ----------------------------------------------------

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgHrlyFuelFlowUpdates(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgHrlyFuelFlowInserts(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1
    

    ----------------------------------------------------------
    -- Genereate HRLY_PARAM_FUEL_FLOW Update and Insert SQL --
    ----------------------------------------------------------

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgHrlyParamFuelFlowUpdates(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgHrlyParamFuelFlowInserts(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1
    

    ---------------------------------------------------------
    -- Genereate HRLY_GAS_FLOW_METER Update and Insert SQL --
    ---------------------------------------------------------

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgHrlyGasFlowMeterUpdates(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgHrlyGasFlowMeterInserts(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1
    

    ----------------------------------------------------
    -- Genereate DAILY_EMISSION Update and Insert SQL --
    ----------------------------------------------------

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgDailyEmissionUpdates(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgDailyEmissionInserts(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1
    

    ------------------------------------------------
    -- Genereate DAILY_FUEL Update and Insert SQL --
    ------------------------------------------------

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgDailyFuelUpdates(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgDailyFuelInserts(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1
    

    ---------------------------------------------------------
    -- Genereate LONG_TERM_FUEL_FLOW Update and Insert SQL --
    ---------------------------------------------------------

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgLongTermFuelFlowUpdates(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgLongTermFuelFlowInserts(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1
    

    ---------------------------------------------------
    -- Genereate SUMMARY_VALUE Update and Insert SQL --
    ---------------------------------------------------

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgSummaryValueUpdates(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgSummaryValueInserts(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1


    --------------------------------------------------
    -- Genereate SORBENT_TRAP Update and Insert SQL --
    --------------------------------------------------

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgSorbentTrapUpdates(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgSorbentTrapInserts(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1


    ----------------------------------------------------
    -- Genereate SAMPLING_TRAIN Update and Insert SQL --
    ----------------------------------------------------

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgSamplingTrainUpdates(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgSamplingTrainInserts(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1


    --------------------------------------------------------
    -- Genereate DAILY_TEST_SUMMARY Update and Insert SQL --
    --------------------------------------------------------

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgDailyTestSummaryUpdates(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgDailyTestSummaryInserts(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1


    -------------------------------------------------------
    -- Genereate DAILY_CALIBRATION Update and Insert SQL --
    -------------------------------------------------------

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgDailyCalibrationUpdates(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgDailyCalibrationInserts(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1


    ---------------------------------------------------------
    -- Genereate WEEKLY_TEST_SUMMARY Update and Insert SQL --
    ---------------------------------------------------------

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgWeeklyTestSummaryUpdates(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgWeeklyTestSummaryInserts(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1


    -------------------------------------------------------------
    -- Genereate WEEKLY_SYSTEM_INTEGRITY Update and Insert SQL --
    -------------------------------------------------------------

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgWeeklySystemIntegrityUpdates(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgWeeklySystemIntegrityInserts(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1


    ----------------------------------------------------
    -- Genereate NSPS4T_SUMMARY Update and Insert SQL --
    ----------------------------------------------------

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgNsps4tSummaryUpdates(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgNsps4tSummaryInserts(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1


    ---------------------------------------------------
    -- Genereate NSPS4T_ANNUAL Update and Insert SQL --
    ---------------------------------------------------

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgNsps4tAnnualUpdates(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgNsps4tAnnualInserts(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1


    --------------------------------------------------------------
    -- Genereate NSPS4T_COMPLIANCE_PERIOD Update and Insert SQL --
    --------------------------------------------------------------

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgNsps4tCompliancePeriodUpdates(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgNsps4tCompliancePeriodInserts(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1


    return;

end;
GO


