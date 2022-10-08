USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgQatInserts]    Script Date: 10/4/2022 10:53:56 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




BEGIN

    DECLARE @OrisCode           integer;
    DECLARE @LocationNameFilter varchar(6);
    DECLARE @TestTypeCdFilter   varchar(7);

    
    SELECT  @OrisCode = 6030,
            @LocationNameFilter = null,
            @TestTypeCdFilter = null;

    
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
    
    
    ------------------
    -- Generate SQL --
    ------------------

    select  SQL_STATEMENT
      from  SqlGenQa.PgTestQualificationInserts(@vTestInformationTable, 1)

end;
GO


