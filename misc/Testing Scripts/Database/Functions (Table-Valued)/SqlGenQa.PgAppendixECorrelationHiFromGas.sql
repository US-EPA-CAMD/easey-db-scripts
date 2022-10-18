USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgAppendixECorrelationHiFromGas]    Script Date: 10/12/2022 5:00:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION [SqlGenQa].[PgAppendixECorrelationHiFromGas] 
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
                    'camdecmpswks.AE_HI_GAS', 
                    ' ( ', 
                        'AE_HI_GAS_ID', ', ',
                        'AE_CORR_TEST_RUN_ID', ', ',
                        'GAS_VOLUME', ', ',
                        'GAS_GCV', ', ',
                        'GAS_HI', ', ',
                        'CALC_GAS_HI', ', ',
                        'USERID', ', ',
                        'ADD_DATE', ', ',
                        'UPDATE_DATE', ', ',
                        'MON_SYS_ID',
                    ' ) values ( ',
                    case when dat.AE_HI_GAS_ID is not null then '''' + dat.AE_HI_GAS_ID + '''' else 'NULL' end, ', ',
                    case when dat.AE_CORR_TEST_RUN_ID is not null then '''' + dat.AE_CORR_TEST_RUN_ID + '''' else 'NULL' end, ', ',
                    case when dat.GAS_VOLUME is not null then cast(dat.GAS_VOLUME as varchar) else 'NULL' end, ', ',
                    case when dat.GAS_GCV is not null then cast(dat.GAS_GCV as varchar) else 'NULL' end, ', ',
                    case when dat.GAS_HI is not null then cast(dat.GAS_HI as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_GAS_HI is not null then cast(dat.CALC_GAS_HI as varchar) else 'NULL' end, ', ',
                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.MON_SYS_ID is not null then '''' + dat.MON_SYS_ID + '''' else 'NULL' end,
                    ' ) on conflict (', 
                    'AE_HI_GAS_ID', 
                    ') do update set ',
                        'AE_CORR_TEST_RUN_ID = EXCLUDED.AE_CORR_TEST_RUN_ID, ',
                        'GAS_VOLUME = EXCLUDED.GAS_VOLUME, ',
                        'GAS_GCV = EXCLUDED.GAS_GCV, ',
                        'GAS_HI = EXCLUDED.GAS_HI, ',
                        'CALC_GAS_HI = EXCLUDED.CALC_GAS_HI, ',
                        'MON_SYS_ID = EXCLUDED.MON_SYS_ID, '
                        ,
                        'USERID = EXCLUDED.USERID, ',
                        'ADD_DATE = EXCLUDED.ADD_DATE, ',
                        'UPDATE_DATE = EXCLUDED.UPDATE_DATE;'
                )
            ) as SQL_STATEMENT
      from  @TestInformationTable lst
            join ECMPS.dbo.AE_CORRELATION_TEST_SUM lk1
              on lk1.TEST_SUM_ID = lst.TEST_SUM_ID
            join ECMPS.dbo.AE_CORRELATION_TEST_RUN lk2
              on lk2.AE_CORR_TEST_SUM_ID = lk1.AE_CORR_TEST_SUM_ID
            join ECMPS.dbo.AE_HI_GAS dat
              on dat.AE_CORR_TEST_RUN_ID = lk2.AE_CORR_TEST_RUN_ID
)
GO


