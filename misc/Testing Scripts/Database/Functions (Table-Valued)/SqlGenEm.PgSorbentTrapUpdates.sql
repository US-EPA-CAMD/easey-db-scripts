USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgSorbentTrapUpdates]    Script Date: 2/7/2023 1:29:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE or ALTER FUNCTION SqlGenEm.PgSorbentTrapUpdates
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
                    'update camdecmpswks.SORBENT_TRAP set',

                    ' MON_LOC_ID                     = ',  case when  tar.MON_LOC_ID                     is not null  then  concat( '''', tar.MON_LOC_ID, '''' ) else 'NULL' end, ', ',
                    ' RPT_PERIOD_ID                  = ',  case when  tar.RPT_PERIOD_ID                  is not null  then  cast( tar.RPT_PERIOD_ID as varchar ) else 'NULL' end, ', ',
                    ' BEGIN_DATE                     = ',  case when  tar.BEGIN_DATE                     is not null  then  concat( '''', format( tar.BEGIN_DATE, 'yyyy-MM-dd'), '''' ) else 'NULL' end, ', ',
                    ' BEGIN_HOUR                     = ',  case when  tar.BEGIN_HOUR                     is not null  then  cast( tar.BEGIN_HOUR as varchar ) else 'NULL' end, ', ',
                    ' END_DATE                       = ',  case when  tar.END_DATE                       is not null  then  concat( '''', format( tar.END_DATE, 'yyyy-MM-dd'), '''' ) else 'NULL' end, ', ',
                    ' END_HOUR                       = ',  case when  tar.END_HOUR                       is not null  then  cast( tar.END_HOUR as varchar ) else 'NULL' end, ', ',
                    ' MON_SYS_ID                     = ',  case when  tar.MON_SYS_ID                     is not null  then  concat( '''', tar.MON_SYS_ID, '''' ) else 'NULL' end, ', ',
                    ' PAIRED_TRAP_AGREEMENT          = ',  case when  tar.PAIRED_TRAP_AGREEMENT          is not null  then  cast( tar.PAIRED_TRAP_AGREEMENT as varchar ) else 'NULL' end, ', ',
                    ' ABSOLUTE_DIFFERENCE_IND        = ',  case when  tar.ABSOLUTE_DIFFERENCE_IND        is not null  then  cast( tar.ABSOLUTE_DIFFERENCE_IND as varchar ) else 'NULL' end, ', ',
                    ' MODC_CD                        = ',  case when  tar.MODC_CD                        is not null  then  concat( '''', tar.MODC_CD, '''' ) else 'NULL' end, ', ',
                    ' HG_CONCENTRATION               = ',  case when  tar.HG_CONCENTRATION               is not null  then  concat( '''', tar.HG_CONCENTRATION, '''' ) else 'NULL' end, ', ',
                    ' SORBENT_TRAP_APS_CD            = ',  case when  tar.SORBENT_TRAP_APS_CD            is not null  then  concat( '''', tar.SORBENT_TRAP_APS_CD, '''' ) else 'NULL' end, ', ',
                    ' RATA_IND                       = ',  case when  tar.RATA_IND                       is not null  then  cast( tar.RATA_IND as varchar ) else 'NULL' end, ', ',

                    ' USERID                          = ', '''UNITTEST''', ', ',
                    ' UPDATE_DATE                     = ', concat( '''', format( getdate(), 'yyyy-MM-dd'), '''' ),

                    ' where MON_LOC_ID = ''', sel.MON_LOC_ID, ''' and RPT_PERIOD_ID = ', sel.RPT_PERIOD_ID,
                    ' and coalesce( MON_SYS_ID, ''nothing'' ) = ''', isnull( sel.MON_SYS_ID, 'nothing' ), '''',
                    ' and BEGIN_DATE = ''', format( sel.BEGIN_DATE, 'yyyy-MM-dd' ), ''' and BEGIN_HOUR = ', sel.BEGIN_HOUR,
                    ' and END_DATE = ''', format( sel.END_DATE, 'yyyy-MM-dd' ), ''' and END_HOUR = ', sel.END_HOUR,
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
                        dat.MON_SYS_ID,
                        dat.BEGIN_DATE,
                        dat.BEGIN_HOUR,
                        dat.END_DATE,
                        dat.END_HOUR,
                        count( 1 ) as ROW_COUNT
                  from  (
                            select  -- ECMPSP
                                    lst.ORIS_CODE, 
                                    lst.FACILITY_NAME, 
                                    lst.LOCATIONS, 
                                    lst.QUARTER, 
                                    lst.LOCATION_NAME,
                                    tar.MON_LOC_ID,
                                    tar.RPT_PERIOD_ID,
                                    tar.BEGIN_DATE,
                                    tar.BEGIN_HOUR,
                                    tar.END_DATE,
                                    tar.END_HOUR,
                                    tar.MON_SYS_ID,
                                    tar.PAIRED_TRAP_AGREEMENT,
                                    tar.ABSOLUTE_DIFFERENCE_IND,
                                    tar.MODC_CD,
                                    tar.HG_CONCENTRATION,
                                    tar.SORBENT_TRAP_APS_CD,
                                    tar.RATA_IND
                              from  @TestInformationTable lst
                                    join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.SORBENT_TRAP tar 
                                      on tar.MON_LOC_ID = lst.MON_LOC_ID
                                     and tar.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                            union
                            select  -- ECMPS_WORKING
                                    lst.ORIS_CODE, 
                                    lst.FACILITY_NAME, 
                                    lst.LOCATIONS, 
                                    lst.QUARTER, 
                                    lst.LOCATION_NAME,
                                    tar.MON_LOC_ID,
                                    tar.RPT_PERIOD_ID,
                                    tar.BEGIN_DATE,
                                    tar.BEGIN_HOUR,
                                    tar.END_DATE,
                                    tar.END_HOUR,
                                    tar.MON_SYS_ID,
                                    tar.PAIRED_TRAP_AGREEMENT,
                                    tar.ABSOLUTE_DIFFERENCE_IND,
                                    tar.MODC_CD,
                                    tar.HG_CONCENTRATION,
                                    tar.SORBENT_TRAP_APS_CD,
                                    tar.RATA_IND
                              from  @TestInformationTable lst
                                    join ECMPS.dbo.SORBENT_TRAP tar 
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
                        dat.BEGIN_DATE,
                        dat.BEGIN_HOUR,
                        dat.END_DATE,
                        dat.END_HOUR
                having  ( count( 1 ) > 1 )
            ) sel
        join ECMPS.dbo.SORBENT_TRAP tar
            on tar.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
            and tar.MON_LOC_ID = sel.MON_LOC_ID
            and tar.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
            and tar.MON_SYS_ID = sel.MON_SYS_ID
            and tar.BEGIN_DATE = sel.BEGIN_DATE
            and tar.BEGIN_HOUR = sel.BEGIN_HOUR
            and tar.END_DATE = sel.END_DATE
            and tar.END_HOUR = sel.END_HOUR
)
GO


