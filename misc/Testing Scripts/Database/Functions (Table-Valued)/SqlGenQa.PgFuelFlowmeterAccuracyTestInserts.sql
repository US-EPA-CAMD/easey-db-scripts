USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgFuelFlowmeterAccuracyTransmitterTransducerTestInserts]    Script Date: 11/19/2022 17:02:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION SqlGenQa.PgFuelFlowmeterAccuracyTestInserts 
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
                    'camdecmpswks.FUEL_FLOWMETER_ACCURACY', 
                    ' ( ', 
                        'FUEL_FLOW_ACC_ID', ', ',
                        'TEST_SUM_ID', ', ',
                        'ACC_TEST_METHOD_CD', ', ',
                        'REINSTALL_DATE', ', ',
                        'REINSTALL_HOUR', ', ',
                        'LOW_FUEL_ACCURACY', ', ',
                        'MID_FUEL_ACCURACY', ', ',
                        'HIGH_FUEL_ACCURACY', ', ',

                        'USERID', ', ',
                        'ADD_DATE', ', ',
                        'UPDATE_DATE',
                    ' ) values ( ',
                    case when dat.FUEL_FLOW_ACC_ID is not null then '''' + dat.FUEL_FLOW_ACC_ID + '''' else 'NULL' end, ', ',
                    case when dat.TEST_SUM_ID is not null then '''' + dat.TEST_SUM_ID + '''' else 'NULL' end, ', ',
                    case when dat.ACC_TEST_METHOD_CD is not null then '''' + dat.ACC_TEST_METHOD_CD + '''' else 'NULL' end, ', ',
                    case when dat.REINSTALL_DATE is not null then '''' + convert(varchar(10), dat.REINSTALL_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.REINSTALL_HOUR is not null then cast(dat.REINSTALL_HOUR as varchar) else 'NULL' end, ', ',
                    case when dat.LOW_FUEL_ACCURACY is not null then cast(dat.LOW_FUEL_ACCURACY as varchar) else 'NULL' end, ', ',
                    case when dat.MID_FUEL_ACCURACY is not null then cast(dat.MID_FUEL_ACCURACY as varchar) else 'NULL' end, ', ',
                    case when dat.HIGH_FUEL_ACCURACY is not null then cast(dat.HIGH_FUEL_ACCURACY as varchar) else 'NULL' end, ', ',

                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end,
                    ' ) on conflict (', 
                    'FUEL_FLOW_ACC_ID', 
                    ') do update set ',
                        'TEST_SUM_ID = EXCLUDED.TEST_SUM_ID, ',
                        'ACC_TEST_METHOD_CD = EXCLUDED.ACC_TEST_METHOD_CD, ',
                        'REINSTALL_DATE = EXCLUDED.REINSTALL_DATE, ',
                        'REINSTALL_HOUR = EXCLUDED.REINSTALL_HOUR, ',
                        'LOW_FUEL_ACCURACY = EXCLUDED.LOW_FUEL_ACCURACY, ',
                        'MID_FUEL_ACCURACY = EXCLUDED.MID_FUEL_ACCURACY, ',
                        'HIGH_FUEL_ACCURACY = EXCLUDED.HIGH_FUEL_ACCURACY, ',

                        'USERID', ' = EXCLUDED.', 'USERID', ', ',
                        'ADD_DATE', ' = EXCLUDED.', 'ADD_DATE', ', ',
                        'UPDATE_DATE', ' = EXCLUDED.', 'UPDATE_DATE', ';'
                )
            ) as SQL_STATEMENT
      from  @TestInformationTable lst
            join ECMPS.dbo.FUEL_FLOWMETER_ACCURACY dat
              on dat.TEST_SUM_ID = lst.TEST_SUM_ID
)
GO


