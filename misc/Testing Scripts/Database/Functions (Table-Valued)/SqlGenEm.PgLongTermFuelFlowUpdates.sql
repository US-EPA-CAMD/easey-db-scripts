USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgLongTermFuelFlowUpdates]    Script Date: 2/7/2023 1:29:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE or ALTER FUNCTION SqlGenEm.PgLongTermFuelFlowUpdates
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
                    'update camdecmpswks.LONG_TERM_FUEL_FLOW set',

                    ' RPT_PERIOD_ID                  = ',  case when  tar.RPT_PERIOD_ID                  is not null  then  cast( tar.RPT_PERIOD_ID as varchar ) else 'NULL' end, ', ',
                    ' MON_LOC_ID                     = ',  case when  tar.MON_LOC_ID                     is not null  then  concat( '''', tar.MON_LOC_ID, '''' ) else 'NULL' end, ', ',
                    ' MON_SYS_ID                     = ',  case when  tar.MON_SYS_ID                     is not null  then  concat( '''', tar.MON_SYS_ID, '''' ) else 'NULL' end, ', ',
                    ' FUEL_FLOW_PERIOD_CD            = ',  case when  tar.FUEL_FLOW_PERIOD_CD            is not null  then  concat( '''', tar.FUEL_FLOW_PERIOD_CD, '''' ) else 'NULL' end, ', ',
                    ' LONG_TERM_FUEL_FLOW_VALUE      = ',  case when  tar.LONG_TERM_FUEL_FLOW_VALUE      is not null  then  cast( tar.LONG_TERM_FUEL_FLOW_VALUE as varchar ) else 'NULL' end, ', ',
                    ' LTFF_UOM_CD                    = ',  case when  tar.LTFF_UOM_CD                    is not null  then  concat( '''', tar.LTFF_UOM_CD, '''' ) else 'NULL' end, ', ',
                    ' GROSS_CALORIFIC_VALUE          = ',  case when  tar.GROSS_CALORIFIC_VALUE          is not null  then  cast( tar.GROSS_CALORIFIC_VALUE as varchar ) else 'NULL' end, ', ',
                    ' GCV_UOM_CD                     = ',  case when  tar.GCV_UOM_CD                     is not null  then  concat( '''', tar.GCV_UOM_CD, '''' ) else 'NULL' end, ', ',
                    ' TOTAL_HEAT_INPUT               = ',  case when  tar.TOTAL_HEAT_INPUT               is not null  then  cast( tar.TOTAL_HEAT_INPUT as varchar ) else 'NULL' end, ', ',

                    'USERID                          = ', '''UNITTEST''', ', ',
                    'UPDATE_DATE                     = ', concat( '''', format( getdate(), 'yyyy-MM-dd'), '''' ),

                    ' where MON_LOC_ID = ''', sel.MON_LOC_ID, ''' and RPT_PERIOD_ID = ', sel.RPT_PERIOD_ID, ' and MON_SYS_ID = ''', sel.MON_SYS_ID, ''' and FUEL_FLOW_PERIOD_CD = ''', sel.FUEL_FLOW_PERIOD_CD, ''';' 
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
                        dat.MON_SYS_ID,
                        dat.FUEL_FLOW_PERIOD_CD,
                        count( 1 ) as ROW_COUNT
                  from  (
                            select  -- ECMPSP
                                    lst.ORIS_CODE, 
                                    lst.FACILITY_NAME, 
                                    lst.LOCATIONS, 
                                    lst.QUARTER, 
                                    lst.LOCATION_NAME,
                                    tar.RPT_PERIOD_ID,
                                    tar.MON_LOC_ID,
                                    tar.MON_SYS_ID,
                                    tar.FUEL_FLOW_PERIOD_CD,
                                    tar.LONG_TERM_FUEL_FLOW_VALUE,
                                    tar.LTFF_UOM_CD,
                                    tar.GROSS_CALORIFIC_VALUE,
                                    tar.GCV_UOM_CD,
                                    tar.TOTAL_HEAT_INPUT
                              from  @TestInformationTable lst
                                    join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.LONG_TERM_FUEL_FLOW tar 
                                      on tar.MON_LOC_ID = lst.MON_LOC_ID
                                     and tar.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                            union
                            select  -- ECMPS_WORKING
                                    lst.ORIS_CODE, 
                                    lst.FACILITY_NAME, 
                                    lst.LOCATIONS, 
                                    lst.QUARTER, 
                                    lst.LOCATION_NAME,
                                    tar.RPT_PERIOD_ID,
                                    tar.MON_LOC_ID,
                                    tar.MON_SYS_ID,
                                    tar.FUEL_FLOW_PERIOD_CD,
                                    tar.LONG_TERM_FUEL_FLOW_VALUE,
                                    tar.LTFF_UOM_CD,
                                    tar.GROSS_CALORIFIC_VALUE,
                                    tar.GCV_UOM_CD,
                                    tar.TOTAL_HEAT_INPUT
                              from  @TestInformationTable lst
                                    join ECMPS.dbo.LONG_TERM_FUEL_FLOW tar 
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
                        dat.RPT_PERIOD_ID,
                        dat.MON_SYS_ID,
                        dat.FUEL_FLOW_PERIOD_CD
                having  ( count( 1 ) > 1 )
            ) sel
        join ECMPS.dbo.LONG_TERM_FUEL_FLOW tar
            on tar.MON_LOC_ID = sel.MON_LOC_ID
            and tar.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
            and tar.MON_SYS_ID = sel.MON_SYS_ID
            and tar.FUEL_FLOW_PERIOD_CD = sel.FUEL_FLOW_PERIOD_CD
)
GO


