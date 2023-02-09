USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgHrlyOpDataDeletes]    Script Date: 2/8/2023 4:25:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION SqlGenEm.PgHrlyOpDataDeletes
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
                    'delete from camdecmpswks.HRLY_OP_DATA',
                    ' where MON_LOC_ID = ''', sel.MON_LOC_ID, ''' and BEGIN_DATE = ''', format( sel.BEGIN_DATE, 'yyyy-MM-dd' ), ''' and BEGIN_HOUR = ', sel.BEGIN_HOUR, ';' 
                )
            ) as SQL_STATEMENT
      from  (
                select  -- ECMPSP
                        lst.ORIS_CODE, 
                        lst.FACILITY_NAME, 
                        lst.LOCATIONS, 
                        lst.QUARTER, 
                        lst.LOCATION_NAME,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.MON_LOC_ID,
                        hod.RPT_PERIOD_ID
                    from  @TestInformationTable lst
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.HRLY_OP_DATA hod 
                            on hod.MON_LOC_ID = lst.MON_LOC_ID
                            and hod.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                except
                select  -- ECMPS_WORKING
                        lst.ORIS_CODE, 
                        lst.FACILITY_NAME, 
                        lst.LOCATIONS, 
                        lst.QUARTER, 
                        lst.LOCATION_NAME,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.MON_LOC_ID,
                        hod.RPT_PERIOD_ID
                    from  @TestInformationTable lst
                        join ECMPS.dbo.HRLY_OP_DATA hod 
                            on hod.MON_LOC_ID = lst.MON_LOC_ID
                            and hod.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
            ) sel
)
GO


