USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgUnitDefaultTestRunInserts]    Script Date: 10/12/2022 10:41:13 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION [SqlGenQa].[PgUnitDefaultTestRunInserts] 
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
                    'camdecmpswks.UNIT_DEFAULT_TEST_RUN', 
                    ' ( ', 
                        'UNIT_DEFAULT_TEST_RUN_ID', ', ',
                        'UNIT_DEFAULT_TEST_SUM_ID', ', ',
                        'OP_LEVEL_NUM', ', ',
                        'RUN_NUM', ', ',
                        'BEGIN_DATE', ', ',
                        'BEGIN_HOUR', ', ',
                        'BEGIN_MIN', ', ',
                        'END_DATE', ', ',
                        'END_HOUR', ', ',
                        'END_MIN', ', ',
                        'RESPONSE_TIME', ', ',
                        'REF_VALUE', ', ',
                        'USERID', ', ',
                        'ADD_DATE', ', ',
                        'UPDATE_DATE', ', ',
                        'RUN_USED_IND',
                    ' ) values ( ',
                    case when dat.UNIT_DEFAULT_TEST_RUN_ID is not null then '''' + dat.UNIT_DEFAULT_TEST_RUN_ID + '''' else 'NULL' end, ', ',
                    case when dat.UNIT_DEFAULT_TEST_SUM_ID is not null then '''' + dat.UNIT_DEFAULT_TEST_SUM_ID + '''' else 'NULL' end, ', ',
                    case when dat.OP_LEVEL_NUM is not null then cast(dat.OP_LEVEL_NUM as varchar) else 'NULL' end, ', ',
                    case when dat.RUN_NUM is not null then cast(dat.RUN_NUM as varchar) else 'NULL' end, ', ',
                    case when dat.BEGIN_DATE is not null then '''' + convert(varchar(10), dat.BEGIN_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.BEGIN_HOUR is not null then cast(dat.BEGIN_HOUR as varchar) else 'NULL' end, ', ',
                    case when dat.BEGIN_MIN is not null then cast(dat.BEGIN_MIN as varchar) else 'NULL' end, ', ',
                    case when dat.END_DATE is not null then '''' + convert(varchar(10), dat.END_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.END_HOUR is not null then cast(dat.END_HOUR as varchar) else 'NULL' end, ', ',
                    case when dat.END_MIN is not null then cast(dat.END_MIN as varchar) else 'NULL' end, ', ',
                    case when dat.RESPONSE_TIME is not null then cast(dat.RESPONSE_TIME as varchar) else 'NULL' end, ', ',
                    case when dat.REF_VALUE is not null then cast(dat.REF_VALUE as varchar) else 'NULL' end, ', ',
                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.RUN_USED_IND is not null then cast(dat.RUN_USED_IND as varchar) else 'NULL' end,
                    ' ) on conflict (', 
                    'UNIT_DEFAULT_TEST_RUN_ID', 
                    ') do update set ',
                        'UNIT_DEFAULT_TEST_SUM_ID = EXCLUDED.UNIT_DEFAULT_TEST_SUM_ID, ',
                        'OP_LEVEL_NUM = EXCLUDED.OP_LEVEL_NUM, ',
                        'RUN_NUM = EXCLUDED.RUN_NUM, ',
                        'BEGIN_DATE = EXCLUDED.BEGIN_DATE, ',
                        'BEGIN_HOUR = EXCLUDED.BEGIN_HOUR, ',
                        'BEGIN_MIN = EXCLUDED.BEGIN_MIN, ',
                        'END_DATE = EXCLUDED.END_DATE, ',
                        'END_HOUR = EXCLUDED.END_HOUR, ',
                        'END_MIN = EXCLUDED.END_MIN, ',
                        'RESPONSE_TIME = EXCLUDED.RESPONSE_TIME, ',
                        'REF_VALUE = EXCLUDED.REF_VALUE, ',
                        'RUN_USED_IND = EXCLUDED.RUN_USED_IND, ',

                        'USERID = EXCLUDED.USERID, ',
                        'ADD_DATE = EXCLUDED.ADD_DATE, ',
                        'UPDATE_DATE = EXCLUDED.UPDATE_DATE;'
                )
            ) as SQL_STATEMENT
      from  @TestInformationTable lst
            join ECMPS.dbo.UNIT_DEFAULT_TEST lk1
              on lk1.TEST_SUM_ID = lst.TEST_SUM_ID
            join ECMPS.dbo.UNIT_DEFAULT_TEST_RUN dat
              on dat.UNIT_DEFAULT_TEST_SUM_ID = lk1.UNIT_DEFAULT_TEST_SUM_ID
)
GO


