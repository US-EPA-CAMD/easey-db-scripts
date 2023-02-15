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

    declare @LoadOrder integer = 1;
    
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
    
    
    -----------------------------------
    -- Genereate Delete Existing SQL --
    -----------------------------------

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgHrlyOpDataDeletes(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgDerivedHrlyValueDeletes(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgMonitorHrlyValueDeletes(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgMatsDerivedHrlyValueDeletes(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgMatsMonitorHrlyValueDeletes(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgHrlyFuelFlowDeletes(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgHrlyParamFuelFlowDeletes(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgHrlyGasFlowMeterDeletes(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgDailyEmissionDeletes(@vEmInformationTable, @LoadOrder)

    set @LoadOrder = @LoadOrder + 1
    
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


    return;

end;
GO


