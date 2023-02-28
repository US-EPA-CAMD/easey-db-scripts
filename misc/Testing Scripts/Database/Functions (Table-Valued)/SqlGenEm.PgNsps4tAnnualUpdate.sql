USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgNsps4tAnnualUpdates]    Script Date: 2/7/2023 1:29:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE or ALTER FUNCTION SqlGenEm.PgNsps4tAnnualUpdates
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
                    'update camdecmpswks.NSPS4T_ANNUAL set',

                    ' ANNUAL_ENERGY_SOLD             = ',  case when  tar.ANNUAL_ENERGY_SOLD             is not null  then  cast( tar.ANNUAL_ENERGY_SOLD as varchar ) else 'NULL' end, ', ',
                    ' ANNUAL_ENERGY_SOLD_TYPE_CD     = ',  case when  tar.ANNUAL_ENERGY_SOLD_TYPE_CD     is not null  then  concat( '''', tar.ANNUAL_ENERGY_SOLD_TYPE_CD, '''' ) else 'NULL' end, ', ',
                    ' ANNUAL_POTENTIAL_OUTPUT        = ',  case when  tar.ANNUAL_POTENTIAL_OUTPUT        is not null  then  cast( tar.ANNUAL_POTENTIAL_OUTPUT as varchar ) else 'NULL' end, ', ',
                    ' MON_LOC_ID                     = ',  case when  tar.MON_LOC_ID                     is not null  then  concat( '''', tar.MON_LOC_ID, '''' ) else 'NULL' end, ', ',
                    ' RPT_PERIOD_ID                  = ',  case when  tar.RPT_PERIOD_ID                  is not null  then  cast( tar.RPT_PERIOD_ID as varchar ) else 'NULL' end, ', ',

                    ' USERID                          = ', '''UNITTEST''', ', ',
                    ' UPDATE_DATE                     = ', concat( '''', format( getdate(), 'yyyy-MM-dd'), '''' ),

                    ' where MON_LOC_ID = ''', sel.MON_LOC_ID, ''' and RPT_PERIOD_ID = ', sel.RPT_PERIOD_ID,
                    ';' 
                )
            ) as SQL_STATEMENT
      from  (
                select  dat.ORIS_CODE, 
                        dat.FACILITY_NAME, 
                        dat.LOCATIONS, 
                        dat.QUARTER, 
                        dat.LOCATION_NAME,
                        dat.MON_LOC_ID,
                        dat.RPT_PERIOD_ID,
                        count( 1 ) as ROW_COUNT
                  from  (
                            select  -- ECMPSP
                                    lst.ORIS_CODE, 
                                    lst.FACILITY_NAME, 
                                    lst.LOCATIONS, 
                                    lst.QUARTER, 
                                    lst.LOCATION_NAME,
                                    tar.ANNUAL_ENERGY_SOLD,
                                    tar.ANNUAL_ENERGY_SOLD_TYPE_CD,
                                    tar.ANNUAL_POTENTIAL_OUTPUT,
                                    tar.MON_LOC_ID,
                                    tar.RPT_PERIOD_ID
                              from  @TestInformationTable lst
                                    join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.NSPS4T_ANNUAL tar 
                                      on tar.MON_LOC_ID = lst.MON_LOC_ID
                                     and tar.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                            union
                            select  -- ECMPS_WORKING
                                    lst.ORIS_CODE, 
                                    lst.FACILITY_NAME, 
                                    lst.LOCATIONS, 
                                    lst.QUARTER, 
                                    lst.LOCATION_NAME,
                                    tar.ANNUAL_ENERGY_SOLD,
                                    tar.ANNUAL_ENERGY_SOLD_TYPE_CD,
                                    tar.ANNUAL_POTENTIAL_OUTPUT,
                                    tar.MON_LOC_ID,
                                    tar.RPT_PERIOD_ID
                              from  @TestInformationTable lst
                                    join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.NSPS4T_ANNUAL tar 
                                      on tar.MON_LOC_ID = lst.MON_LOC_ID
                                     and tar.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                        ) dat
                 group
                    by  dat.ORIS_CODE, 
                        dat.FACILITY_NAME, 
                        dat.LOCATIONS, 
                        dat.QUARTER, 
                        dat.LOCATION_NAME,
                        dat.MON_LOC_ID,
                        dat.RPT_PERIOD_ID
                having  ( count( 1 ) > 1 )
            ) sel
            join ECMPS.dbo.NSPS4T_ANNUAL tar 
              on tar.MON_LOC_ID = sel.MON_LOC_ID
             and tar.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
)
GO


