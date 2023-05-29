USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[PgSamplingTrainDeletes]    Script Date: 2/11/2023 6:40:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION SqlGenEm.PgSamplingTrainDeletes
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
                    'delete from camdecmpswks.SAMPLING_TRAIN tar',
                    ' where  exists', 
                    ' (', 
                        ' select 1 from camdecmpswks.SORBENT_TRAP trp', 
                        ' join camdecmpswks.SAMPLING_TRAIN trn on trn.TRAP_ID = trp.TRAP_ID',
                        ' where trp.MON_LOC_ID = ''', sel.MON_LOC_ID, '''',
                        ' and trp.RPT_PERIOD_ID = ', sel.RPT_PERIOD_ID,
                        ' and trp.MON_SYS_ID = ''', sel.MON_SYS_ID, '''',
                        ' and trp.BEGIN_DATE = ''', format( sel.BEGIN_DATE, 'yyyy-MM-dd' ), ''' and BEGIN_HOUR = ', sel.BEGIN_HOUR,
                        ' and trp.END_DATE = ''', format( sel.END_DATE, 'yyyy-MM-dd' ), ''' and END_HOUR = ', sel.END_HOUR,
                        ' and trn.COMPONENT_ID = ''', sel.COMPONENT_ID, '''',
                        ' and trp.TRAP_ID = tar.TRAP_ID',
                        ' and trn.COMPONENT_ID = tar.COMPONENT_ID',
                    ' )',
                    ';'
                )
            ) as SQL_STATEMENT
      from  (
                select  -- ECMPSP
                        lst.ORIS_CODE, 
                        lst.FACILITY_NAME, 
                        lst.LOCATIONS, 
                        lst.QUARTER, 
                        lst.LOCATION_NAME,
                        tar.MON_LOC_ID,
                        tar.RPT_PERIOD_ID,
                        trp.MON_SYS_ID,
                        trp.BEGIN_DATE,
                        trp.BEGIN_HOUR,
                        trp.END_DATE,
                        trp.END_HOUR,
                        tar.COMPONENT_ID
                    from  @TestInformationTable lst
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.SORBENT_TRAP trp 
                            on trp.MON_LOC_ID = lst.MON_LOC_ID
                            and trp.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                        join [CHV-DWHITTEN2\ECMPSP].ECMPS.dbo.SAMPLING_TRAIN tar 
                            on tar.TRAP_ID = trp.TRAP_ID
                except
                select  -- ECMPS_WORKING
                        lst.ORIS_CODE, 
                        lst.FACILITY_NAME, 
                        lst.LOCATIONS, 
                        lst.QUARTER, 
                        lst.LOCATION_NAME,
                        tar.MON_LOC_ID,
                        tar.RPT_PERIOD_ID,
                        trp.MON_SYS_ID,
                        trp.BEGIN_DATE,
                        trp.BEGIN_HOUR,
                        trp.END_DATE,
                        trp.END_HOUR,
                        tar.COMPONENT_ID
                    from  @TestInformationTable lst
                        join ECMPS.dbo.SORBENT_TRAP trp 
                            on trp.MON_LOC_ID = lst.MON_LOC_ID
                            and trp.RPT_PERIOD_ID = lst.RPT_PERIOD_ID
                        join ECMPS.dbo.SAMPLING_TRAIN tar 
                            on tar.TRAP_ID = trp.TRAP_ID
            ) sel
)
GO


