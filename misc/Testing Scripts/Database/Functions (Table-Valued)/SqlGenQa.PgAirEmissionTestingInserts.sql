USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgAirEmissionTestingInserts]    Script Date: 9/30/2022 5:19:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION [SqlGenQa].[PgAirEmissionTestingInserts] 
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
                    'camdecmpswks.AIR_EMISSION_TESTING', 
                    ' ( ', 
                        'AIR_EMISSION_TEST_ID', ', ',
                        'TEST_SUM_ID', ', ',
                        'QI_LAST_NAME', ', ',
                        'QI_FIRST_NAME', ', ',
                        'QI_MIDDLE_INITIAL', ', ',
                        'AETB_NAME', ', ',
                        'AETB_PHONE_NUMBER', ', ',
                        'AETB_EMAIL', ', ',
                        'EXAM_DATE', ', ',
                        'PROVIDER_NAME', ', ',
                        'PROVIDER_EMAIL', ', ',
                        'ADD_DATE', ', ',
                        'UPDATE_DATE', ', ',
                        'USERID',
                    ' ) values ( ',
                    case when dat.AIR_EMISSION_TEST_ID is not null then '''' + dat.AIR_EMISSION_TEST_ID + '''' else 'NULL' end, ', ',
                    case when dat.TEST_SUM_ID is not null then '''' + dat.TEST_SUM_ID + '''' else 'NULL' end, ', ',
                    case when dat.QI_LAST_NAME is not null then '''' + dat.QI_LAST_NAME + '''' else 'NULL' end, ', ',
                    case when dat.QI_FIRST_NAME is not null then '''' + dat.QI_FIRST_NAME + '''' else 'NULL' end, ', ',
                    case when dat.QI_MIDDLE_INITIAL is not null then '''' + dat.QI_MIDDLE_INITIAL + '''' else 'NULL' end, ', ',
                    case when dat.AETB_NAME is not null then '''' + dat.AETB_NAME + '''' else 'NULL' end, ', ',
                    case when dat.AETB_PHONE_NUMBER is not null then '''' + dat.AETB_PHONE_NUMBER + '''' else 'NULL' end, ', ',
                    case when dat.AETB_EMAIL is not null then '''' + dat.AETB_EMAIL + '''' else 'NULL' end, ', ',
                    case when dat.EXAM_DATE is not null then '''' + convert(varchar(10), dat.EXAM_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.PROVIDER_NAME is not null then '''' + dat.PROVIDER_NAME + '''' else 'NULL' end, ', ',
                    case when dat.PROVIDER_EMAIL is not null then '''' + dat.PROVIDER_EMAIL + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end,
                    ' ) on conflict (', 
                    'AIR_EMISSION_TEST_ID', 
                    ') do update set ',
                        'TEST_SUM_ID = EXCLUDED.TEST_SUM_ID, ',
                        'QI_LAST_NAME = EXCLUDED.QI_LAST_NAME, ',
                        'QI_FIRST_NAME = EXCLUDED.QI_FIRST_NAME, ',
                        'QI_MIDDLE_INITIAL = EXCLUDED.QI_MIDDLE_INITIAL, ',
                        'AETB_NAME = EXCLUDED.AETB_NAME, ',
                        'AETB_PHONE_NUMBER = EXCLUDED.AETB_PHONE_NUMBER, ',
                        'AETB_EMAIL = EXCLUDED.AETB_EMAIL, ',
                        'EXAM_DATE = EXCLUDED.EXAM_DATE, ',
                        'PROVIDER_NAME = EXCLUDED.PROVIDER_NAME, ',
                        'PROVIDER_EMAIL = EXCLUDED.PROVIDER_EMAIL, ',
                        'ADD_DATE = EXCLUDED.ADD_DATE, ',
                        'UPDATE_DATE = EXCLUDED.UPDATE_DATE, ',
                        'USERID = EXCLUDED.USERID;'
                )
            ) as SQL_STATEMENT
      from  @TestInformationTable lst
            join ECMPS.dbo.AIR_EMISSION_TESTING dat
              on dat.TEST_SUM_ID = lst.TEST_SUM_ID
)
GO


