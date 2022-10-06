USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgRataRunInserts]    Script Date: 9/20/2022 4:49:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION [SqlGenQa].[PgRataRunInserts] 
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
                    'camdecmpswks.RATA_RUN', 
                    ' ( ', 
                        'RATA_RUN_ID', ', ',
                        'RATA_SUM_ID', ', ',
                        'GROSS_UNIT_LOAD', ', ',
                        'RUN_NUM', ', ',
                        'CEM_VALUE', ', ',
                        'RATA_REF_VALUE', ', ',
                        'CALC_RATA_REF_VALUE', ', ',
                        'RUN_STATUS_CD', ', ',
                        'BEGIN_DATE', ', ',
                        'BEGIN_HOUR', ', ',
                        'BEGIN_MIN', ', ',
                        'END_DATE', ', ',
                        'END_HOUR', ', ',
                        'END_MIN', ', ',
                        'USERID', ', ',
                        'ADD_DATE', ', ',
                        'UPDATE_DATE',
                    ' ) values ( ',
                    case when dat.RATA_RUN_ID is not null then '''' + dat.RATA_RUN_ID + '''' else 'NULL' end, ', ',
                    case when dat.RATA_SUM_ID is not null then '''' + dat.RATA_SUM_ID + '''' else 'NULL' end, ', ',
                    case when dat.GROSS_UNIT_LOAD is not null then cast(dat.GROSS_UNIT_LOAD as varchar) else 'NULL' end, ', ',
                    case when dat.RUN_NUM is not null then cast(dat.RUN_NUM as varchar) else 'NULL' end, ', ',
                    case when dat.CEM_VALUE is not null then cast(dat.CEM_VALUE as varchar) else 'NULL' end, ', ',
                    case when dat.RATA_REF_VALUE is not null then cast(dat.RATA_REF_VALUE as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_RATA_REF_VALUE is not null then cast(dat.CALC_RATA_REF_VALUE as varchar) else 'NULL' end, ', ',
                    case when dat.RUN_STATUS_CD is not null then '''' + dat.RUN_STATUS_CD + '''' else 'NULL' end, ', ',
                    case when dat.BEGIN_DATE is not null then '''' + convert(varchar(10), dat.BEGIN_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.BEGIN_HOUR is not null then cast(dat.BEGIN_HOUR as varchar) else 'NULL' end, ', ',
                    case when dat.BEGIN_MIN is not null then cast(dat.BEGIN_MIN as varchar) else 'NULL' end, ', ',
                    case when dat.END_DATE is not null then '''' + convert(varchar(10), dat.END_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.END_HOUR is not null then cast(dat.END_HOUR as varchar) else 'NULL' end, ', ',
                    case when dat.END_MIN is not null then cast(dat.END_MIN as varchar) else 'NULL' end, ', ',
                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end,
                    ' ) on conflict (', 
                    'RATA_RUN_ID', 
                    ') do update set ',
                        'RATA_SUM_ID = EXCLUDED.RATA_SUM_ID, ',
                        'GROSS_UNIT_LOAD = EXCLUDED.GROSS_UNIT_LOAD, ',
                        'RUN_NUM = EXCLUDED.RUN_NUM, ',
                        'CEM_VALUE = EXCLUDED.CEM_VALUE, ',
                        'RATA_REF_VALUE = EXCLUDED.RATA_REF_VALUE, ',
                        'CALC_RATA_REF_VALUE = EXCLUDED.CALC_RATA_REF_VALUE, ',
                        'RUN_STATUS_CD = EXCLUDED.RUN_STATUS_CD, ',
                        'BEGIN_DATE = EXCLUDED.BEGIN_DATE, ',
                        'BEGIN_HOUR = EXCLUDED.BEGIN_HOUR, ',
                        'BEGIN_MIN = EXCLUDED.BEGIN_MIN, ',
                        'END_DATE = EXCLUDED.END_DATE, ',
                        'END_HOUR = EXCLUDED.END_HOUR, ',
                        'END_MIN = EXCLUDED.END_MIN, ',
                        'USERID = EXCLUDED.USERID, ',
                        'ADD_DATE = EXCLUDED.ADD_DATE, ',
                        'UPDATE_DATE = EXCLUDED.UPDATE_DATE;'
                )
            ) as SQL_STATEMENT
      from  @TestInformationTable lst
            join ECMPS.dbo.RATA lk1
              on lk1.TEST_SUM_ID = lst.TEST_SUM_ID
            join ECMPS.dbo.RATA_SUMMARY lk2
              on lk2.RATA_ID = lk1.RATA_ID
            join ECMPS.dbo.RATA_RUN dat
              on dat.RATA_SUM_ID = lk2.RATA_SUM_ID
)
GO


