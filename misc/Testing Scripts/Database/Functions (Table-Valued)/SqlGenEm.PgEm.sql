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
      from  SqlGenEm.PgHrlyOpDataDeletes(@vEmInformationTable, 1)

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgHrlyOpDataUpdates(@vEmInformationTable, 2)

    insert
      into  @SqlTable
    select  SQL_STATEMENT
      from  SqlGenEm.PgHrlyOpDataInserts(@vEmInformationTable, 3)


    return;

end;
GO


