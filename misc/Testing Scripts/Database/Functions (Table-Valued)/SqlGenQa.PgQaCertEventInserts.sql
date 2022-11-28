USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgQaCertEventInserts]    Script Date: 11/23/2022 11:51:13 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE or ALTER FUNCTION SqlGenQa.PgQaCertEventInserts 
(	
	@TestInformationTable SqlGenQa.Qce_Information_Table readonly
)
RETURNS TABLE 
AS
RETURN 
(
    select  SqlGenQa.FormatQceSql
            ( 
                lst.ORIS_CODE, lst.FACILITY_NAME, lst.LOCATION_NAME, lst.QA_CERT_EVENT_CD, lst.QA_CERT_EVENT_DATE, lst.QA_CERT_EVENT_HOUR, lst.SYSTEM_IDENTIFIER, lst.SYS_TYPE_CD, lst.COMPONENT_IDENTIFIER, lst.COMPONENT_TYPE_CD, 
                concat
                (
                    'insert into ', 
                    'camdecmpswks.QA_CERT_EVENT', 
                    ' ( ', 
                        'QA_CERT_EVENT_ID', ', ',
                        'MON_LOC_ID', ', ',
                        'MON_SYS_ID', ', ',
                        'COMPONENT_ID', ', ',
                        'QA_CERT_EVENT_CD', ', ',
                        'QA_CERT_EVENT_DATE', ', ',
                        'QA_CERT_EVENT_HOUR', ', ',
                        'REQUIRED_TEST_CD', ', ',
                        'CONDITIONAL_DATA_BEGIN_DATE', ', ',
                        'CONDITIONAL_DATA_BEGIN_HOUR', ', ',
                        'LAST_TEST_COMPLETED_DATE', ', ',
                        'LAST_TEST_COMPLETED_HOUR', ', ',
                        'LAST_UPDATED', ', ',
                        'UPDATED_STATUS_FLG', ', ',
                        'NEEDS_EVAL_FLG', ', ',
                        'CHK_SESSION_ID', ', ',
                        'SUBMISSION_ID', ', ',
                        'SUBMISSION_AVAILABILITY_CD', ', ',

                        'USERID', ', ',
                        'ADD_DATE', ', ',
                        'UPDATE_DATE',
                    ' ) values ( ',
                    case when dat.QA_CERT_EVENT_ID is not null then '''' + dat.QA_CERT_EVENT_ID + '''' else 'NULL' end, ', ',
                    case when dat.MON_LOC_ID is not null then '''' + dat.MON_LOC_ID + '''' else 'NULL' end, ', ',
                    case when dat.MON_SYS_ID is not null then '''' + dat.MON_SYS_ID + '''' else 'NULL' end, ', ',
                    case when dat.COMPONENT_ID is not null then '''' + dat.COMPONENT_ID + '''' else 'NULL' end, ', ',
                    case when dat.QA_CERT_EVENT_CD is not null then '''' + dat.QA_CERT_EVENT_CD + '''' else 'NULL' end, ', ',
                    case when dat.QA_CERT_EVENT_DATE is not null then '''' + convert(varchar(10), dat.QA_CERT_EVENT_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.QA_CERT_EVENT_HOUR is not null then cast(dat.QA_CERT_EVENT_HOUR as varchar) else 'NULL' end, ', ',
                    case when dat.REQUIRED_TEST_CD is not null then '''' + dat.REQUIRED_TEST_CD + '''' else 'NULL' end, ', ',
                    case when dat.CONDITIONAL_DATA_BEGIN_DATE is not null then '''' + convert(varchar(10), dat.CONDITIONAL_DATA_BEGIN_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.CONDITIONAL_DATA_BEGIN_HOUR is not null then cast(dat.CONDITIONAL_DATA_BEGIN_HOUR as varchar) else 'NULL' end, ', ',
                    case when dat.LAST_TEST_COMPLETED_DATE is not null then '''' + convert(varchar(10), dat.LAST_TEST_COMPLETED_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.LAST_TEST_COMPLETED_HOUR is not null then cast(dat.LAST_TEST_COMPLETED_HOUR as varchar) else 'NULL' end, ', ',
                    case when dat.LAST_UPDATED is not null then '''' + convert(varchar(10), dat.LAST_UPDATED, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATED_STATUS_FLG is not null then '''' + dat.UPDATED_STATUS_FLG + '''' else 'NULL' end, ', ',
                    case when dat.NEEDS_EVAL_FLG is not null then '''' + dat.NEEDS_EVAL_FLG + '''' else 'NULL' end, ', ',
                    case when dat.CHK_SESSION_ID is not null then '''' + dat.CHK_SESSION_ID + '''' else 'NULL' end, ', ',
                    case when dat.SUBMISSION_ID is not null then cast(dat.SUBMISSION_ID as varchar) else 'NULL' end, ', ',
                    case when dat.SUBMISSION_AVAILABILITY_CD is not null then '''' + dat.SUBMISSION_AVAILABILITY_CD + '''' else 'NULL' end, ', ',

                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end,
                    ' ) on conflict (', 
                    'QA_CERT_EVENT_ID', 
                    ') do update set ',
                        'MON_LOC_ID = EXCLUDED.MON_LOC_ID, ',
                        'MON_SYS_ID = EXCLUDED.MON_SYS_ID, ',
                        'COMPONENT_ID = EXCLUDED.COMPONENT_ID, ',
                        'QA_CERT_EVENT_CD = EXCLUDED.QA_CERT_EVENT_CD, ',
                        'QA_CERT_EVENT_DATE = EXCLUDED.QA_CERT_EVENT_DATE, ',
                        'QA_CERT_EVENT_HOUR = EXCLUDED.QA_CERT_EVENT_HOUR, ',
                        'REQUIRED_TEST_CD = EXCLUDED.REQUIRED_TEST_CD, ',
                        'CONDITIONAL_DATA_BEGIN_DATE = EXCLUDED.CONDITIONAL_DATA_BEGIN_DATE, ',
                        'CONDITIONAL_DATA_BEGIN_HOUR = EXCLUDED.CONDITIONAL_DATA_BEGIN_HOUR, ',
                        'LAST_TEST_COMPLETED_DATE = EXCLUDED.LAST_TEST_COMPLETED_DATE, ',
                        'LAST_TEST_COMPLETED_HOUR = EXCLUDED.LAST_TEST_COMPLETED_HOUR, ',
                        'LAST_UPDATED = EXCLUDED.LAST_UPDATED, ',
                        'UPDATED_STATUS_FLG = EXCLUDED.UPDATED_STATUS_FLG, ',
                        'NEEDS_EVAL_FLG = EXCLUDED.NEEDS_EVAL_FLG, ',
                        'CHK_SESSION_ID = EXCLUDED.CHK_SESSION_ID, ',
                        'SUBMISSION_ID = EXCLUDED.SUBMISSION_ID, ',
                        'SUBMISSION_AVAILABILITY_CD = EXCLUDED.SUBMISSION_AVAILABILITY_CD, ',

                        'USERID', ' = EXCLUDED.', 'USERID', ', ',
                        'ADD_DATE', ' = EXCLUDED.', 'ADD_DATE', ', ',
                        'UPDATE_DATE', ' = EXCLUDED.', 'UPDATE_DATE', ';'
                )
            ) as SQL_STATEMENT
      from  @TestInformationTable lst
            join ECMPS.dbo.QA_CERT_EVENT dat
              on dat.QA_CERT_EVENT_ID = lst.QA_CERT_EVENT_ID
)
GO


