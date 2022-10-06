USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgTestSummaryInserts]    Script Date: 8/4/2022 7:55:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE or ALTER FUNCTION [SqlGenQa].[PgTestSummaryInserts] 
(	
	@TestInformationTable SqlGenQa.Test_Information_Table readonly,
    @TestOrder  integer
)
RETURNS TABLE 
AS
RETURN 
(
    select  SqlGenQa.FormatSql
            ( 
                lst.ORIS_CODE, lst.FACILITY_NAME, lst.LOCATION_NAME, lst.TEST_TYPE_CD, lst.TEST_NUM,  @TestOrder, 
                concat
                (
                    'insert into ', 
                    'camdecmpswks.TEST_SUMMARY', 
                    ' ( ', 
                        'TEST_SUM_ID, MON_LOC_ID, TEST_TYPE_CD, TEST_NUM, MON_SYS_ID, COMPONENT_ID, GP_IND, TEST_REASON_CD, TEST_RESULT_CD, ',
                        'RPT_PERIOD_ID, BEGIN_DATE, BEGIN_HOUR, BEGIN_MIN, END_DATE, END_HOUR, END_MIN, SPAN_SCALE_CD, INJECTION_PROTOCOL_CD, TEST_COMMENT, TEST_DESCRIPTION, ',
                        'CALC_GP_IND, CALC_TEST_RESULT_CD, CALC_SPAN_VALUE, LAST_UPDATED, UPDATED_STATUS_FLG, NEEDS_EVAL_FLG, CHK_SESSION_ID, ',
                        'USERID, ADD_DATE, UPDATE_DATE',
                    ' ) values ( ',
                    case when dat.TEST_SUM_ID is not null then '''' + dat.TEST_SUM_ID + '''' else 'NULL' end, ', ',
                    case when dat.MON_LOC_ID is not null then '''' + dat.MON_LOC_ID + '''' else 'NULL' end, ', ',
                    case when dat.TEST_TYPE_CD is not null then '''' + dat.TEST_TYPE_CD + '''' else 'NULL' end, ', ',
                    case when dat.TEST_NUM is not null then '''' + dat.TEST_NUM + '''' else 'NULL' end, ', ',
                    case when dat.MON_SYS_ID is not null then '''' + dat.MON_SYS_ID + '''' else 'NULL' end, ', ',
                    case when dat.COMPONENT_ID is not null then '''' + dat.COMPONENT_ID + '''' else 'NULL' end, ', ',
                    case when dat.GP_IND is not null then cast(dat.GP_IND as varchar) else 'NULL' end, ', ', 
                    case when dat.TEST_REASON_CD is not null then '''' + dat.TEST_REASON_CD + '''' else 'NULL' end, ', ',
                    case when dat.TEST_RESULT_CD is not null then '''' + dat.TEST_RESULT_CD + '''' else 'NULL' end, ', ',
                    case when dat.RPT_PERIOD_ID is not null then cast(dat.RPT_PERIOD_ID as varchar) else 'NULL' end, ', ', 
                    case when dat.BEGIN_DATE is not null then '''' + convert(varchar(10), dat.BEGIN_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.BEGIN_HOUR is not null then cast(dat.BEGIN_HOUR as varchar) else 'NULL' end, ', ', 
                    case when dat.BEGIN_MIN is not null then cast(dat.BEGIN_MIN as varchar) else 'NULL' end, ', ', 
                    case when dat.END_DATE is not null then '''' + convert(varchar(10), dat.END_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.END_HOUR is not null then cast(dat.END_HOUR as varchar) else 'NULL' end, ', ', 
                    case when dat.END_MIN is not null then cast(dat.END_MIN as varchar) else 'NULL' end, ', ', 
                    case when dat.SPAN_SCALE_CD is not null then '''' + dat.SPAN_SCALE_CD + '''' else 'NULL' end, ', ',
                    case when dat.INJECTION_PROTOCOL_CD is not null then '''' + dat.INJECTION_PROTOCOL_CD + '''' else 'NULL' end, ', ',
                    case when dat.TEST_COMMENT is not null then '''' + dat.TEST_COMMENT + '''' else 'NULL' end, ', ',
                    case when dat.TEST_DESCRIPTION is not null then '''' + dat.TEST_DESCRIPTION + '''' else 'NULL' end, ', ',
                    case when dat.CALC_GP_IND is not null then cast(dat.CALC_GP_IND as varchar) else 'NULL' end, ', ', 
                    case when dat.CALC_TEST_RESULT_CD is not null then '''' + dat.CALC_TEST_RESULT_CD + '''' else 'NULL' end, ', ',
                    case when dat.CALC_SPAN_VALUE is not null then cast(dat.CALC_SPAN_VALUE as varchar) else 'NULL' end, ', ', 
                    case when dat.LAST_UPDATED is not null then '''' + convert(varchar, dat.LAST_UPDATED, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATED_STATUS_FLG is not null then '''' + dat.UPDATED_STATUS_FLG + '''' else 'NULL' end, ', ',
                    case when dat.NEEDS_EVAL_FLG is not null then '''' + dat.NEEDS_EVAL_FLG + '''' else 'NULL' end, ', ',
                    case when dat.CHK_SESSION_ID is not null then '''' + dat.CHK_SESSION_ID + '''' else 'NULL' end, ', ',
                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end,
                    ' ) on conflict (', 
                    'TEST_SUM_ID', 
                    ') do update set ',
                    'MON_LOC_ID', ' = EXCLUDED.', 'MON_LOC_ID', ', ',
                    'TEST_TYPE_CD', ' = EXCLUDED.', 'TEST_TYPE_CD', ', ',
                    'TEST_NUM', ' = EXCLUDED.', 'TEST_NUM', ', ',
                    'MON_SYS_ID', ' = EXCLUDED.', 'MON_SYS_ID', ', ',
                    'COMPONENT_ID', ' = EXCLUDED.', 'COMPONENT_ID', ', ',
                    'GP_IND', ' = EXCLUDED.', 'GP_IND', ', ',
                    'TEST_REASON_CD', ' = EXCLUDED.', 'TEST_REASON_CD', ', ',
                    'TEST_RESULT_CD', ' = EXCLUDED.', 'TEST_RESULT_CD', ', ',
                    'RPT_PERIOD_ID', ' = EXCLUDED.', 'RPT_PERIOD_ID', ', ',
                    'BEGIN_DATE', ' = EXCLUDED.', 'BEGIN_DATE', ', ',
                    'BEGIN_HOUR', ' = EXCLUDED.', 'BEGIN_HOUR', ', ',
                    'BEGIN_MIN', ' = EXCLUDED.', 'BEGIN_MIN', ', ',
                    'END_DATE', ' = EXCLUDED.', 'END_DATE', ', ',
                    'END_HOUR', ' = EXCLUDED.', 'END_HOUR', ', ',
                    'END_MIN', ' = EXCLUDED.', 'END_MIN', ', ',
                    'SPAN_SCALE_CD', ' = EXCLUDED.', 'SPAN_SCALE_CD', ', ',
                    'INJECTION_PROTOCOL_CD', ' = EXCLUDED.', 'INJECTION_PROTOCOL_CD', ', ',
                    'TEST_COMMENT', ' = EXCLUDED.', 'TEST_COMMENT', ', ',
                    'TEST_DESCRIPTION', ' = EXCLUDED.', 'TEST_DESCRIPTION', ', ',
                    'CALC_GP_IND', ' = EXCLUDED.', 'CALC_GP_IND', ', ',
                    'CALC_TEST_RESULT_CD', ' = EXCLUDED.', 'CALC_TEST_RESULT_CD', ', ',
                    'CALC_SPAN_VALUE', ' = EXCLUDED.', 'CALC_SPAN_VALUE', ', ',
                    'LAST_UPDATED', ' = EXCLUDED.', 'LAST_UPDATED', ', ',
                    'UPDATED_STATUS_FLG', ' = EXCLUDED.', 'UPDATED_STATUS_FLG', ', ',
                    'NEEDS_EVAL_FLG', ' = EXCLUDED.', 'NEEDS_EVAL_FLG', ', ',
                    'CHK_SESSION_ID', ' = EXCLUDED.', 'CHK_SESSION_ID', ', ',
                    'USERID', ' = EXCLUDED.', 'USERID', ', ',
                    'ADD_DATE', ' = EXCLUDED.', 'ADD_DATE', ', ',
                    'UPDATE_DATE', ' = EXCLUDED.', 'UPDATE_DATE', ';'
                )
            ) as SQL_STATEMENT
      from  @TestInformationTable lst
            join ECMPS.dbo.TEST_SUMMARY dat
              on dat.TEST_SUM_ID = lst.TEST_SUM_ID
)
GO


