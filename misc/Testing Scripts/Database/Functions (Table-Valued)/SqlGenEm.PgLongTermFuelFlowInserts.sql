USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgLongTermFuelFlowInserts]    Script Date: 2/8/2023 2:37:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER   FUNCTION SqlGenEm.PgLongTermFuelFlowInserts
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
                    'insert into camdecmpswks.LONG_TERM_FUEL_FLOW',
                    ' (',
                        ' LTFF_ID', ',',

                        ' RPT_PERIOD_ID', ',',
                        ' MON_LOC_ID', ',',
                        ' MON_SYS_ID', ',',
                        ' FUEL_FLOW_PERIOD_CD', ',',
                        ' LONG_TERM_FUEL_FLOW_VALUE', ',',
                        ' LTFF_UOM_CD', ',',
                        ' GROSS_CALORIFIC_VALUE', ',',
                        ' GCV_UOM_CD', ',',
                        ' TOTAL_HEAT_INPUT', ',',

                        ' USERID', ',',
                        ' ADD_DATE', ',',
                        ' UPDATE_DATE',
                    ' )',
                    ' values',
                    ' (',
                        '''UNITTEST-'' || uuid_generate_v4()', ', ',
                        
                        case when  tar.RPT_PERIOD_ID                  is not null  then  cast( tar.RPT_PERIOD_ID as varchar ) else 'NULL' end, ', ',
                        case when  tar.MON_LOC_ID                     is not null  then  concat( '''', tar.MON_LOC_ID, '''' ) else 'NULL' end, ', ',
                        case when  tar.MON_SYS_ID                     is not null  then  concat( '''', tar.MON_SYS_ID, '''' ) else 'NULL' end, ', ',
                        case when  tar.FUEL_FLOW_PERIOD_CD            is not null  then  concat( '''', tar.FUEL_FLOW_PERIOD_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.LONG_TERM_FUEL_FLOW_VALUE      is not null  then  cast( tar.LONG_TERM_FUEL_FLOW_VALUE as varchar ) else 'NULL' end, ', ',
                        case when  tar.LTFF_UOM_CD                    is not null  then  concat( '''', tar.LTFF_UOM_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.GROSS_CALORIFIC_VALUE          is not null  then  cast( tar.GROSS_CALORIFIC_VALUE as varchar ) else 'NULL' end, ', ',
                        case when  tar.GCV_UOM_CD                     is not null  then  concat( '''', tar.GCV_UOM_CD, '''' ) else 'NULL' end, ', ',
                        case when  tar.TOTAL_HEAT_INPUT               is not null  then  cast( tar.TOTAL_HEAT_INPUT as varchar ) else 'NULL' end, ', ',

                        '''UNITTEST''', ', ',
                        concat( '''', format( getdate(), 'yyyy-MM-dd'), '''' ), ', ',
                        'NULL',
                    ' );'
                )
            ) as SQL_STATEMENT
      from  (
                select  -- ECMPS_WORKING
                        lst.ORIS_CODE, 
                        lst.FACILITY_NAME, 
                        lst.LOCATIONS, 
                        lst.QUARTER, 
                        lst.LOCATION_NAME,
                        tar.MON_LOC_ID,
                        tar.RPT_PERIOD_ID,
                        tar.MON_SYS_ID,
                        tar.FUEL_FLOW_PERIOD_CD
                    from  @TestInformationTable lst
                        join ECMPS.dbo.LONG_TERM_FUEL_FLOW tar 
                            on tar.MON_LOC_ID = lst.MON_LOC_ID
                            and tar.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                except
                select  -- ECMPSP
                        lst.ORIS_CODE, 
                        lst.FACILITY_NAME, 
                        lst.LOCATIONS, 
                        lst.QUARTER, 
                        lst.LOCATION_NAME,
                        tar.MON_LOC_ID,
                        tar.RPT_PERIOD_ID,
                        tar.MON_SYS_ID,
                        tar.FUEL_FLOW_PERIOD_CD
                    from  @TestInformationTable lst
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.LONG_TERM_FUEL_FLOW tar 
                            on tar.MON_LOC_ID = lst.MON_LOC_ID
                            and tar.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
            ) sel
        join ECMPS.dbo.LONG_TERM_FUEL_FLOW tar
            on tar.MON_LOC_ID = sel.MON_LOC_ID
            and tar.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
            and tar.MON_SYS_ID = sel.MON_SYS_ID
            and isnull( tar.FUEL_FLOW_PERIOD_CD, 'NULL' ) = isnull( sel.FUEL_FLOW_PERIOD_CD, 'NULL' )
)
GO


