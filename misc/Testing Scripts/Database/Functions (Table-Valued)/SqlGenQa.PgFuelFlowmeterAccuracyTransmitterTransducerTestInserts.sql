USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgFuelFlowmeterAccuracyTransmitterTransducerTestInserts]    Script Date: 11/19/2022 17:02:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION SqlGenQa.PgFuelFlowmeterAccuracyTransmitterTransducerTestInserts 
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
                    'camdecmpswks.TRANS_ACCURACY', 
                    ' ( ', 
                        'TRANS_AC_ID', ', ',
                        'TEST_SUM_ID', ', ',
                        'LOW_LEVEL_ACCURACY', ', ',
                        'MID_LEVEL_ACCURACY', ', ',
                        'HIGH_LEVEL_ACCURACY', ', ',
                        'LOW_LEVEL_ACCURACY_SPEC_CD', ', ',
                        'MID_LEVEL_ACCURACY_SPEC_CD', ', ',
                        'HIGH_LEVEL_ACCURACY_SPEC_CD', ', ',

                        'USERID', ', ',
                        'ADD_DATE', ', ',
                        'UPDATE_DATE',
                    ' ) values ( ',
                    case when dat.TRANS_AC_ID is not null then '''' + dat.TRANS_AC_ID + '''' else 'NULL' end, ', ',
                    case when dat.TEST_SUM_ID is not null then '''' + dat.TEST_SUM_ID + '''' else 'NULL' end, ', ',
                    case when dat.LOW_LEVEL_ACCURACY is not null then cast(dat.LOW_LEVEL_ACCURACY as varchar) else 'NULL' end, ', ',
                    case when dat.MID_LEVEL_ACCURACY is not null then cast(dat.MID_LEVEL_ACCURACY as varchar) else 'NULL' end, ', ',
                    case when dat.HIGH_LEVEL_ACCURACY is not null then cast(dat.HIGH_LEVEL_ACCURACY as varchar) else 'NULL' end, ', ',
                    case when dat.LOW_LEVEL_ACCURACY_SPEC_CD is not null then '''' + dat.LOW_LEVEL_ACCURACY_SPEC_CD + '''' else 'NULL' end, ', ',
                    case when dat.MID_LEVEL_ACCURACY_SPEC_CD is not null then '''' + dat.MID_LEVEL_ACCURACY_SPEC_CD + '''' else 'NULL' end, ', ',
                    case when dat.HIGH_LEVEL_ACCURACY_SPEC_CD is not null then '''' + dat.HIGH_LEVEL_ACCURACY_SPEC_CD + '''' else 'NULL' end, ', ',

                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end,
                    ' ) on conflict (', 
                    'TRANS_AC_ID', 
                    ') do update set ',
                        'TEST_SUM_ID = EXCLUDED.TEST_SUM_ID, ',
                        'LOW_LEVEL_ACCURACY = EXCLUDED.LOW_LEVEL_ACCURACY, ',
                        'MID_LEVEL_ACCURACY = EXCLUDED.MID_LEVEL_ACCURACY, ',
                        'HIGH_LEVEL_ACCURACY = EXCLUDED.HIGH_LEVEL_ACCURACY, ',
                        'LOW_LEVEL_ACCURACY_SPEC_CD = EXCLUDED.LOW_LEVEL_ACCURACY_SPEC_CD, ',
                        'MID_LEVEL_ACCURACY_SPEC_CD = EXCLUDED.MID_LEVEL_ACCURACY_SPEC_CD, ',
                        'HIGH_LEVEL_ACCURACY_SPEC_CD = EXCLUDED.HIGH_LEVEL_ACCURACY_SPEC_CD, ',

                        'USERID', ' = EXCLUDED.', 'USERID', ', ',
                        'ADD_DATE', ' = EXCLUDED.', 'ADD_DATE', ', ',
                        'UPDATE_DATE', ' = EXCLUDED.', 'UPDATE_DATE', ';'
                )
            ) as SQL_STATEMENT
      from  @TestInformationTable lst
            join ECMPS.dbo.TRANS_ACCURACY dat
              on dat.TEST_SUM_ID = lst.TEST_SUM_ID
)
GO


