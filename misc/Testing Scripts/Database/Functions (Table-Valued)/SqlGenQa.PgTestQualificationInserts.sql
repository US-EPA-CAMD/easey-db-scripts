USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgTestQualificationInserts]    Script Date: 10/4/2022 10:42:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION [SqlGenQa].[PgTestQualificationInserts] 
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
                    'camdecmpswks.TEST_QUALIFICATION', 
                    ' ( ', 
                        'TEST_QUALIFICATION_ID', ', ',
                        'TEST_SUM_ID', ', ',
                        'TEST_CLAIM_CD', ', ',
                        'HI_LOAD_PCT', ', ',
                        'MID_LOAD_PCT', ', ',
                        'LOW_LOAD_PCT', ', ',
                        'BEGIN_DATE', ', ',
                        'END_DATE', ', ',
                        'USERID', ', ',
                        'ADD_DATE', ', ',
                        'UPDATE_DATE',
                    ' ) values ( ',
                    case when dat.TEST_QUALIFICATION_ID is not null then '''' + dat.TEST_QUALIFICATION_ID + '''' else 'NULL' end, ', ',
                    case when dat.TEST_SUM_ID is not null then '''' + dat.TEST_SUM_ID + '''' else 'NULL' end, ', ',
                    case when dat.TEST_CLAIM_CD is not null then '''' + dat.TEST_CLAIM_CD + '''' else 'NULL' end, ', ',
                    case when dat.HI_LOAD_PCT is not null then cast(dat.HI_LOAD_PCT as varchar) else 'NULL' end, ', ',
                    case when dat.MID_LOAD_PCT is not null then cast(dat.MID_LOAD_PCT as varchar) else 'NULL' end, ', ',
                    case when dat.LOW_LOAD_PCT is not null then cast(dat.LOW_LOAD_PCT as varchar) else 'NULL' end, ', ',
                    case when dat.BEGIN_DATE is not null then '''' + convert(varchar(10), dat.BEGIN_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.END_DATE is not null then '''' + convert(varchar(10), dat.END_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end,
                    ' ) on conflict (', 
                    'TEST_QUALIFICATION_ID', 
                    ') do update set ',
                        'TEST_SUM_ID = EXCLUDED.TEST_SUM_ID, ',
                        'TEST_CLAIM_CD = EXCLUDED.TEST_CLAIM_CD, ',
                        'HI_LOAD_PCT = EXCLUDED.HI_LOAD_PCT, ',
                        'MID_LOAD_PCT = EXCLUDED.MID_LOAD_PCT, ',
                        'LOW_LOAD_PCT = EXCLUDED.LOW_LOAD_PCT, ',
                        'BEGIN_DATE = EXCLUDED.BEGIN_DATE, ',
                        'END_DATE = EXCLUDED.END_DATE, ',

                        'USERID', ' = EXCLUDED.', 'USERID', ', ',
                        'ADD_DATE', ' = EXCLUDED.', 'ADD_DATE', ', ',
                        'UPDATE_DATE', ' = EXCLUDED.', 'UPDATE_DATE', ';'
                )
            ) as SQL_STATEMENT
      from  @TestInformationTable lst
            join ECMPS.dbo.TEST_QUALIFICATION dat
              on dat.TEST_SUM_ID = lst.TEST_SUM_ID
)
GO


