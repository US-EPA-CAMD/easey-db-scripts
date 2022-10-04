USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgProtocolGasInserts]    Script Date: 9/16/2022 7:15:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION [SqlGenQa].[PgProtocolGasInserts] 
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
                    'camdecmpswks.PROTOCOL_GAS', 
                    ' ( ', 
                        'PROTOCOL_GAS_ID, TEST_SUM_ID, ',
                        'GAS_LEVEL_CD, GAS_TYPE_CD, VENDOR_ID, CYLINDER_ID, EXPIRATION_DATE, ',
                        'USERID, ADD_DATE, UPDATE_DATE',
                    ' ) values ( ',
                    case when dat.PROTOCOL_GAS_ID is not null then '''' + dat.PROTOCOL_GAS_ID + '''' else 'NULL' end, ', ',
                    case when dat.TEST_SUM_ID is not null then '''' + dat.TEST_SUM_ID + '''' else 'NULL' end, ', ',
                    
                    case when dat.GAS_LEVEL_CD is not null then '''' + dat.GAS_LEVEL_CD + '''' else 'NULL' end, ', ',
                    case when dat.GAS_TYPE_CD is not null then '''' + dat.GAS_TYPE_CD + '''' else 'NULL' end, ', ',
                    case when dat.VENDOR_ID is not null then '''' + dat.VENDOR_ID + '''' else 'NULL' end, ', ',
                    case when dat.CYLINDER_ID is not null then '''' + dat.CYLINDER_ID + '''' else 'NULL' end, ', ',
                    case when dat.EXPIRATION_DATE is not null then '''' + convert(varchar(10), dat.EXPIRATION_DATE, 120) + '''' else 'NULL' end, ', ',

                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end,
                    ' ) on conflict (', 
                    'PROTOCOL_GAS_ID', 
                    ') do update set ',
                        'TEST_SUM_ID', ' = EXCLUDED.', 'TEST_SUM_ID', ', ',

                        'GAS_LEVEL_CD', ' = EXCLUDED.', 'GAS_LEVEL_CD', ', ',
                        'GAS_TYPE_CD', ' = EXCLUDED.', 'GAS_TYPE_CD', ', ',
                        'VENDOR_ID', ' = EXCLUDED.', 'VENDOR_ID', ', ',
                        'CYLINDER_ID', ' = EXCLUDED.', 'CYLINDER_ID', ', ',
                        'EXPIRATION_DATE', ' = EXCLUDED.', 'EXPIRATION_DATE', ', ',

                        'USERID', ' = EXCLUDED.', 'USERID', ', ',
                        'ADD_DATE', ' = EXCLUDED.', 'ADD_DATE', ', ',
                        'UPDATE_DATE', ' = EXCLUDED.', 'UPDATE_DATE', ';'
                )
            ) as SQL_STATEMENT
      from  @TestInformationTable lst
            join ECMPS.dbo.PROTOCOL_GAS dat
              on dat.TEST_SUM_ID = lst.TEST_SUM_ID
)
GO


