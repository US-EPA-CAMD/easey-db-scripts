USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgQceStatements]    Script Date: 11/28/2022 10:49:13 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE or ALTER FUNCTION SqlGenQa.PgTeeStatements 
(	
	@OrisCode           integer,
    @LocationNameFilter varchar(6)
)
RETURNS @SqlTable TABLE ( SQL_STATEMENT varchar(max) )
AS
BEGIN

    ---------------------
    -- Get Information --
    ---------------------

    declare @vInformationTable SqlGenQa.Tee_Information_Table;

    insert
      into  @vInformationTable
            (
                TEST_EXTENSION_EXEMPTION_ID,
                ORIS_CODE,
                FACILITY_NAME,
                LOCATION_NAME,
                QUARTER,
                EXTENS_EXEMPT_CD,
                SYSTEM_IDENTIFIER,
                SYS_TYPE_CD,
                COMPONENT_IDENTIFIER,
                COMPONENT_TYPE_CD
            )
    select  lst.TEST_EXTENSION_EXEMPTION_ID,
            lst.ORIS_CODE,
            lst.FACILITY_NAME,
            lst.LOCATION_NAME,
            lst.QUARTER,
            lst.EXTENS_EXEMPT_CD,
            lst.SYSTEM_IDENTIFIER,
            lst.SYS_TYPE_CD,
            lst.COMPONENT_IDENTIFIER,
            lst.COMPONENT_TYPE_CD
      from  SqlGenQa.PgTeeInformation( @OrisCode, @LocationNameFilter ) lst;
    
    
    -----------------------------------
    -- Genereate Delete Existing SQL --
    -----------------------------------

    insert
      into  @SqlTable
    select  SqlGenQa.FormatTeeSql
            ( 
                lst.ORIS_CODE, lst.FACILITY_NAME, lst.LOCATION_NAME, lst.QUARTER, lst.EXTENS_EXEMPT_CD, lst.SYSTEM_IDENTIFIER, lst.SYS_TYPE_CD, lst.COMPONENT_IDENTIFIER, lst.COMPONENT_TYPE_CD, 1,
                concat( 'delete from camdecmpswks.TEST_EXTENSION_EXEMPTION where TEST_EXTENSION_EXEMPTION_ID = ', '''', lst.TEST_EXTENSION_EXEMPTION_ID, '''', ';' )
            ) as SQL_STATEMENT
      from  @vInformationTable lst

    
    --------------------------
    -- Genereate Insert SQL --
    --------------------------

    -- Test Summary
    insert
      into  @SqlTable
    select  SqlGenQa.FormatTeeSql
            ( 
                lst.ORIS_CODE, lst.FACILITY_NAME, lst.LOCATION_NAME, lst.QUARTER, lst.EXTENS_EXEMPT_CD, lst.SYSTEM_IDENTIFIER, lst.SYS_TYPE_CD, lst.COMPONENT_IDENTIFIER, lst.COMPONENT_TYPE_CD, 2,
                concat
                (
                    'insert into ', 
                    'camdecmpswks.TEST_EXTENSION_EXEMPTION', 
                    ' ( ', 
                        'TEST_EXTENSION_EXEMPTION_ID', ', ',
                        'MON_LOC_ID', ', ',
                        'RPT_PERIOD_ID', ', ',
                        'MON_SYS_ID', ', ',
                        'COMPONENT_ID', ', ',
                        'FUEL_CD', ', ',
                        'EXTENS_EXEMPT_CD', ', ',
                        'LAST_UPDATED', ', ',
                        'UPDATED_STATUS_FLG', ', ',
                        'NEEDS_EVAL_FLG', ', ',
                        'CHK_SESSION_ID', ', ',
                        'HOURS_USED', ', ',
                        'SPAN_SCALE_CD', ', ',
                        'SUBMISSION_ID', ', ',
                        'SUBMISSION_AVAILABILITY_CD', ', ',

                        'USERID', ', ',
                        'ADD_DATE', ', ',
                        'UPDATE_DATE',
                    ' ) values ( ',
                    case when dat.TEST_EXTENSION_EXEMPTION_ID is not null then '''' + dat.TEST_EXTENSION_EXEMPTION_ID + '''' else 'NULL' end, ', ',
                    case when dat.MON_LOC_ID is not null then '''' + dat.MON_LOC_ID + '''' else 'NULL' end, ', ',
                    case when dat.RPT_PERIOD_ID is not null then cast(dat.RPT_PERIOD_ID as varchar) else 'NULL' end, ', ',
                    case when dat.MON_SYS_ID is not null then '''' + dat.MON_SYS_ID + '''' else 'NULL' end, ', ',
                    case when dat.COMPONENT_ID is not null then '''' + dat.COMPONENT_ID + '''' else 'NULL' end, ', ',
                    case when dat.FUEL_CD is not null then '''' + dat.FUEL_CD + '''' else 'NULL' end, ', ',
                    case when dat.EXTENS_EXEMPT_CD is not null then '''' + dat.EXTENS_EXEMPT_CD + '''' else 'NULL' end, ', ',
                    case when dat.LAST_UPDATED is not null then '''' + convert(varchar(10), dat.LAST_UPDATED, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATED_STATUS_FLG is not null then '''' + dat.UPDATED_STATUS_FLG + '''' else 'NULL' end, ', ',
                    case when dat.NEEDS_EVAL_FLG is not null then '''' + dat.NEEDS_EVAL_FLG + '''' else 'NULL' end, ', ',
                    case when dat.CHK_SESSION_ID is not null then '''' + dat.CHK_SESSION_ID + '''' else 'NULL' end, ', ',
                    case when dat.HOURS_USED is not null then cast(dat.HOURS_USED as varchar) else 'NULL' end, ', ',
                    case when dat.SPAN_SCALE_CD is not null then '''' + dat.SPAN_SCALE_CD + '''' else 'NULL' end, ', ',
                    case when dat.SUBMISSION_ID is not null then cast(dat.SUBMISSION_ID as varchar) else 'NULL' end, ', ',
                    case when dat.SUBMISSION_AVAILABILITY_CD is not null then '''' + dat.SUBMISSION_AVAILABILITY_CD + '''' else 'NULL' end, ', ',

                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end,
                    ' ) on conflict (', 
                    'TEST_EXTENSION_EXEMPTION_ID', 
                    ') do update set ',
                        'MON_LOC_ID = EXCLUDED.MON_LOC_ID, ',
                        'RPT_PERIOD_ID = EXCLUDED.RPT_PERIOD_ID, ',
                        'MON_SYS_ID = EXCLUDED.MON_SYS_ID, ',
                        'COMPONENT_ID = EXCLUDED.COMPONENT_ID, ',
                        'FUEL_CD = EXCLUDED.FUEL_CD, ',
                        'EXTENS_EXEMPT_CD = EXCLUDED.EXTENS_EXEMPT_CD, ',
                        'LAST_UPDATED = EXCLUDED.LAST_UPDATED, ',
                        'UPDATED_STATUS_FLG = EXCLUDED.UPDATED_STATUS_FLG, ',
                        'NEEDS_EVAL_FLG = EXCLUDED.NEEDS_EVAL_FLG, ',
                        'CHK_SESSION_ID = EXCLUDED.CHK_SESSION_ID, ',
                        'HOURS_USED = EXCLUDED.HOURS_USED, ',
                        'SPAN_SCALE_CD = EXCLUDED.SPAN_SCALE_CD, ',
                        'SUBMISSION_ID = EXCLUDED.SUBMISSION_ID, ',
                        'SUBMISSION_AVAILABILITY_CD = EXCLUDED.SUBMISSION_AVAILABILITY_CD, ',

                        'USERID', ' = EXCLUDED.', 'USERID', ', ',
                        'ADD_DATE', ' = EXCLUDED.', 'ADD_DATE', ', ',
                        'UPDATE_DATE', ' = EXCLUDED.', 'UPDATE_DATE', ';'
                )
            ) as SQL_STATEMENT
      from  @vInformationTable lst
            join ECMPS.dbo.TEST_EXTENSION_EXEMPTION dat
              on dat.TEST_EXTENSION_EXEMPTION_ID = lst.TEST_EXTENSION_EXEMPTION_ID


    return;

end;
GO


