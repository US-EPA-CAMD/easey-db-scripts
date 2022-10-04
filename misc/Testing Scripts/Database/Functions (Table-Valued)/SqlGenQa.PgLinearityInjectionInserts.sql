USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgLinearityInjectionInserts]    Script Date: 9/6/2022 1:23:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION [SqlGenQa].[PgLinearityInjectionInserts] 
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
                    'camdecmpswks.LINEARITY_INJECTION', 
                    ' ( ', 
                        'LIN_INJ_ID, LIN_SUM_ID, ',
                        'INJECTION_DATE, INJECTION_HOUR, INJECTION_MIN, MEASURED_VALUE, REF_VALUE, ',
                        'USERID, ADD_DATE, UPDATE_DATE',
                    ' ) values ( ',
                    case when dat.LIN_INJ_ID is not null then '''' + dat.LIN_INJ_ID + '''' else 'NULL' end, ', ',
                    case when dat.LIN_SUM_ID is not null then '''' + dat.LIN_SUM_ID + '''' else 'NULL' end, ', ',
                
                    case when dat.INJECTION_DATE is not null then '''' + convert(varchar(10), dat.INJECTION_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.INJECTION_HOUR is not null then cast(dat.INJECTION_HOUR as varchar) else 'NULL' end, ', ', 
                    case when dat.INJECTION_MIN is not null then cast(dat.INJECTION_MIN as varchar) else 'NULL' end, ', ', 
                    case when dat.MEASURED_VALUE is not null then cast(dat.MEASURED_VALUE as varchar) else 'NULL' end, ', ', 
                    case when dat.REF_VALUE is not null then cast(dat.REF_VALUE as varchar) else 'NULL' end, ', ', 

                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end,
                    ' ) on conflict (', 
                    'LIN_INJ_ID', 
                    ') do update set ',
                        'LIN_SUM_ID', ' = EXCLUDED.', 'LIN_SUM_ID', ', ',

                        'INJECTION_DATE', ' = EXCLUDED.', 'INJECTION_DATE', ', ',
                        'INJECTION_HOUR', ' = EXCLUDED.', 'INJECTION_HOUR', ', ',
                        'INJECTION_MIN', ' = EXCLUDED.', 'INJECTION_MIN', ', ',
                        'MEASURED_VALUE', ' = EXCLUDED.', 'MEASURED_VALUE', ', ',
                        'REF_VALUE', ' = EXCLUDED.', 'REF_VALUE', ', ',

                        'USERID', ' = EXCLUDED.', 'USERID', ', ',
                        'ADD_DATE', ' = EXCLUDED.', 'ADD_DATE', ', ',
                        'UPDATE_DATE', ' = EXCLUDED.', 'UPDATE_DATE', ';'
                )
            ) as SQL_STATEMENT
      from  @TestInformationTable lst
            join ECMPS.dbo.LINEARITY_SUMMARY lns
              on lns.TEST_SUM_ID = lst.TEST_SUM_ID
            join ECMPS.dbo.LINEARITY_INJECTION dat
              on dat.LIN_SUM_ID = lns.LIN_SUM_ID
)
GO


