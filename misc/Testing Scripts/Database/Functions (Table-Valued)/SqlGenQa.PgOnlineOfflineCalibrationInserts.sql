USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgOnlineOfflineCalibrationInserts]    Script Date: 11/17/2022 03:09:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION [SqlGenQa].[PgOnlineOfflineCalibrationInserts] 
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
                    'camdecmpswks.ON_OFF_CAL', 
                    ' ( ', 
                        'ON_OFF_CAL_ID', ', ',
                        'TEST_SUM_ID', ', ',
                        'ONLINE_ZERO_INJECTION_DATE', ', ',
                        'ONLINE_ZERO_INJECTION_HOUR', ', ',
                        'ONLINE_ZERO_APS_IND', ', ',
                        'CALC_ONLINE_ZERO_APS_IND', ', ',
                        'ONLINE_ZERO_CAL_ERROR', ', ',
                        'CALC_ONLINE_ZERO_CAL_ERROR', ', ',
                        'ONLINE_ZERO_MEASURED_VALUE', ', ',
                        'ONLINE_ZERO_REF_VALUE', ', ',
                        'ONLINE_UPSCALE_APS_IND', ', ',
                        'CALC_ONLINE_UPSCALE_APS_IND', ', ',
                        'ONLINE_UPSCALE_CAL_ERROR', ', ',
                        'CALC_ONLINE_UPSCALE_CAL_ERROR', ', ',
                        'ONLINE_UPSCALE_INJECTION_DATE', ', ',
                        'ONLINE_UPSCALE_INJECTION_HOUR', ', ',
                        'ONLINE_UPSCALE_MEASURED_VALUE', ', ',
                        'ONLINE_UPSCALE_REF_VALUE', ', ',
                        'OFFLINE_ZERO_APS_IND', ', ',
                        'CALC_OFFLINE_ZERO_APS_IND', ', ',
                        'OFFLINE_ZERO_CAL_ERROR', ', ',
                        'CALC_OFFLINE_ZERO_CAL_ERROR', ', ',
                        'OFFLINE_ZERO_INJECTION_DATE', ', ',
                        'OFFLINE_ZERO_INJECTION_HOUR', ', ',
                        'OFFLINE_ZERO_MEASURED_VALUE', ', ',
                        'OFFLINE_ZERO_REF_VALUE', ', ',
                        'OFFLINE_UPSCALE_APS_IND', ', ',
                        'CALC_OFFLINE_UPSCALE_APS_IND', ', ',
                        'OFFLINE_UPSCALE_CAL_ERROR', ', ',
                        'CALC_OFFLINE_UPSCALE_CAL_ERROR', ', ',
                        'OFFLINE_UPSCALE_INJECTION_DATE', ', ',
                        'OFFLINE_UPSCALE_INJECTION_HOUR', ', ',
                        'OFFLINE_UPSCALE_MEASURED_VALUE', ', ',
                        'OFFLINE_UPSCALE_REF_VALUE', ', ',
                        'UPSCALE_GAS_LEVEL_CD', ', ',
                        'USERID', ', ',
                        'ADD_DATE', ', ',
                        'UPDATE_DATE',
                    ' ) values ( ',
                    case when dat.ON_OFF_CAL_ID is not null then '''' + dat.ON_OFF_CAL_ID + '''' else 'NULL' end, ', ',
                    case when dat.TEST_SUM_ID is not null then '''' + dat.TEST_SUM_ID + '''' else 'NULL' end, ', ',
                    case when dat.ONLINE_ZERO_INJECTION_DATE is not null then '''' + convert(varchar(10), dat.ONLINE_ZERO_INJECTION_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.ONLINE_ZERO_INJECTION_HOUR is not null then cast(dat.ONLINE_ZERO_INJECTION_HOUR as varchar) else 'NULL' end, ', ',
                    case when dat.ONLINE_ZERO_APS_IND is not null then cast(dat.ONLINE_ZERO_APS_IND as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_ONLINE_ZERO_APS_IND is not null then cast(dat.CALC_ONLINE_ZERO_APS_IND as varchar) else 'NULL' end, ', ',
                    case when dat.ONLINE_ZERO_CAL_ERROR is not null then cast(dat.ONLINE_ZERO_CAL_ERROR as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_ONLINE_ZERO_CAL_ERROR is not null then cast(dat.CALC_ONLINE_ZERO_CAL_ERROR as varchar) else 'NULL' end, ', ',
                    case when dat.ONLINE_ZERO_MEASURED_VALUE is not null then cast(dat.ONLINE_ZERO_MEASURED_VALUE as varchar) else 'NULL' end, ', ',
                    case when dat.ONLINE_ZERO_REF_VALUE is not null then cast(dat.ONLINE_ZERO_REF_VALUE as varchar) else 'NULL' end, ', ',
                    case when dat.ONLINE_UPSCALE_APS_IND is not null then cast(dat.ONLINE_UPSCALE_APS_IND as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_ONLINE_UPSCALE_APS_IND is not null then cast(dat.CALC_ONLINE_UPSCALE_APS_IND as varchar) else 'NULL' end, ', ',
                    case when dat.ONLINE_UPSCALE_CAL_ERROR is not null then cast(dat.ONLINE_UPSCALE_CAL_ERROR as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_ONLINE_UPSCALE_CAL_ERROR is not null then cast(dat.CALC_ONLINE_UPSCALE_CAL_ERROR as varchar) else 'NULL' end, ', ',
                    case when dat.ONLINE_UPSCALE_INJECTION_DATE is not null then '''' + convert(varchar(10), dat.ONLINE_UPSCALE_INJECTION_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.ONLINE_UPSCALE_INJECTION_HOUR is not null then cast(dat.ONLINE_UPSCALE_INJECTION_HOUR as varchar) else 'NULL' end, ', ',
                    case when dat.ONLINE_UPSCALE_MEASURED_VALUE is not null then cast(dat.ONLINE_UPSCALE_MEASURED_VALUE as varchar) else 'NULL' end, ', ',
                    case when dat.ONLINE_UPSCALE_REF_VALUE is not null then cast(dat.ONLINE_UPSCALE_REF_VALUE as varchar) else 'NULL' end, ', ',
                    case when dat.OFFLINE_ZERO_APS_IND is not null then cast(dat.OFFLINE_ZERO_APS_IND as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_OFFLINE_ZERO_APS_IND is not null then cast(dat.CALC_OFFLINE_ZERO_APS_IND as varchar) else 'NULL' end, ', ',
                    case when dat.OFFLINE_ZERO_CAL_ERROR is not null then cast(dat.OFFLINE_ZERO_CAL_ERROR as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_OFFLINE_ZERO_CAL_ERROR is not null then cast(dat.CALC_OFFLINE_ZERO_CAL_ERROR as varchar) else 'NULL' end, ', ',
                    case when dat.OFFLINE_ZERO_INJECTION_DATE is not null then '''' + convert(varchar(10), dat.OFFLINE_ZERO_INJECTION_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.OFFLINE_ZERO_INJECTION_HOUR is not null then cast(dat.OFFLINE_ZERO_INJECTION_HOUR as varchar) else 'NULL' end, ', ',
                    case when dat.OFFLINE_ZERO_MEASURED_VALUE is not null then cast(dat.OFFLINE_ZERO_MEASURED_VALUE as varchar) else 'NULL' end, ', ',
                    case when dat.OFFLINE_ZERO_REF_VALUE is not null then cast(dat.OFFLINE_ZERO_REF_VALUE as varchar) else 'NULL' end, ', ',
                    case when dat.OFFLINE_UPSCALE_APS_IND is not null then cast(dat.OFFLINE_UPSCALE_APS_IND as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_OFFLINE_UPSCALE_APS_IND is not null then cast(dat.CALC_OFFLINE_UPSCALE_APS_IND as varchar) else 'NULL' end, ', ',
                    case when dat.OFFLINE_UPSCALE_CAL_ERROR is not null then cast(dat.OFFLINE_UPSCALE_CAL_ERROR as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_OFFLINE_UPSCALE_CAL_ERROR is not null then cast(dat.CALC_OFFLINE_UPSCALE_CAL_ERROR as varchar) else 'NULL' end, ', ',
                    case when dat.OFFLINE_UPSCALE_INJECTION_DATE is not null then '''' + convert(varchar(10), dat.OFFLINE_UPSCALE_INJECTION_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.OFFLINE_UPSCALE_INJECTION_HOUR is not null then cast(dat.OFFLINE_UPSCALE_INJECTION_HOUR as varchar) else 'NULL' end, ', ',
                    case when dat.OFFLINE_UPSCALE_MEASURED_VALUE is not null then cast(dat.OFFLINE_UPSCALE_MEASURED_VALUE as varchar) else 'NULL' end, ', ',
                    case when dat.OFFLINE_UPSCALE_REF_VALUE is not null then cast(dat.OFFLINE_UPSCALE_REF_VALUE as varchar) else 'NULL' end, ', ',
                    case when dat.UPSCALE_GAS_LEVEL_CD is not null then '''' + dat.UPSCALE_GAS_LEVEL_CD + '''' else 'NULL' end, ', ',
                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end,
                    ' ) on conflict (', 
                    'ON_OFF_CAL_ID', 
                    ') do update set ',
                        'TEST_SUM_ID = EXCLUDED.TEST_SUM_ID, ',
                        'ONLINE_ZERO_INJECTION_DATE = EXCLUDED.ONLINE_ZERO_INJECTION_DATE, ',
                        'ONLINE_ZERO_INJECTION_HOUR = EXCLUDED.ONLINE_ZERO_INJECTION_HOUR, ',
                        'ONLINE_ZERO_APS_IND = EXCLUDED.ONLINE_ZERO_APS_IND, ',
                        'CALC_ONLINE_ZERO_APS_IND = EXCLUDED.CALC_ONLINE_ZERO_APS_IND, ',
                        'ONLINE_ZERO_CAL_ERROR = EXCLUDED.ONLINE_ZERO_CAL_ERROR, ',
                        'CALC_ONLINE_ZERO_CAL_ERROR = EXCLUDED.CALC_ONLINE_ZERO_CAL_ERROR, ',
                        'ONLINE_ZERO_MEASURED_VALUE = EXCLUDED.ONLINE_ZERO_MEASURED_VALUE, ',
                        'ONLINE_ZERO_REF_VALUE = EXCLUDED.ONLINE_ZERO_REF_VALUE, ',
                        'ONLINE_UPSCALE_APS_IND = EXCLUDED.ONLINE_UPSCALE_APS_IND, ',
                        'CALC_ONLINE_UPSCALE_APS_IND = EXCLUDED.CALC_ONLINE_UPSCALE_APS_IND, ',
                        'ONLINE_UPSCALE_CAL_ERROR = EXCLUDED.ONLINE_UPSCALE_CAL_ERROR, ',
                        'CALC_ONLINE_UPSCALE_CAL_ERROR = EXCLUDED.CALC_ONLINE_UPSCALE_CAL_ERROR, ',
                        'ONLINE_UPSCALE_INJECTION_DATE = EXCLUDED.ONLINE_UPSCALE_INJECTION_DATE, ',
                        'ONLINE_UPSCALE_INJECTION_HOUR = EXCLUDED.ONLINE_UPSCALE_INJECTION_HOUR, ',
                        'ONLINE_UPSCALE_MEASURED_VALUE = EXCLUDED.ONLINE_UPSCALE_MEASURED_VALUE, ',
                        'ONLINE_UPSCALE_REF_VALUE = EXCLUDED.ONLINE_UPSCALE_REF_VALUE, ',
                        'OFFLINE_ZERO_APS_IND = EXCLUDED.OFFLINE_ZERO_APS_IND, ',
                        'CALC_OFFLINE_ZERO_APS_IND = EXCLUDED.CALC_OFFLINE_ZERO_APS_IND, ',
                        'OFFLINE_ZERO_CAL_ERROR = EXCLUDED.OFFLINE_ZERO_CAL_ERROR, ',
                        'CALC_OFFLINE_ZERO_CAL_ERROR = EXCLUDED.CALC_OFFLINE_ZERO_CAL_ERROR, ',
                        'OFFLINE_ZERO_INJECTION_DATE = EXCLUDED.OFFLINE_ZERO_INJECTION_DATE, ',
                        'OFFLINE_ZERO_INJECTION_HOUR = EXCLUDED.OFFLINE_ZERO_INJECTION_HOUR, ',
                        'OFFLINE_ZERO_MEASURED_VALUE = EXCLUDED.OFFLINE_ZERO_MEASURED_VALUE, ',
                        'OFFLINE_ZERO_REF_VALUE = EXCLUDED.OFFLINE_ZERO_REF_VALUE, ',
                        'OFFLINE_UPSCALE_APS_IND = EXCLUDED.OFFLINE_UPSCALE_APS_IND, ',
                        'CALC_OFFLINE_UPSCALE_APS_IND = EXCLUDED.CALC_OFFLINE_UPSCALE_APS_IND, ',
                        'OFFLINE_UPSCALE_CAL_ERROR = EXCLUDED.OFFLINE_UPSCALE_CAL_ERROR, ',
                        'CALC_OFFLINE_UPSCALE_CAL_ERROR = EXCLUDED.CALC_OFFLINE_UPSCALE_CAL_ERROR, ',
                        'OFFLINE_UPSCALE_INJECTION_DATE = EXCLUDED.OFFLINE_UPSCALE_INJECTION_DATE, ',
                        'OFFLINE_UPSCALE_INJECTION_HOUR = EXCLUDED.OFFLINE_UPSCALE_INJECTION_HOUR, ',
                        'OFFLINE_UPSCALE_MEASURED_VALUE = EXCLUDED.OFFLINE_UPSCALE_MEASURED_VALUE, ',
                        'OFFLINE_UPSCALE_REF_VALUE = EXCLUDED.OFFLINE_UPSCALE_REF_VALUE, ',
                        'UPSCALE_GAS_LEVEL_CD = EXCLUDED.UPSCALE_GAS_LEVEL_CD, ',

                        'USERID', ' = EXCLUDED.', 'USERID', ', ',
                        'ADD_DATE', ' = EXCLUDED.', 'ADD_DATE', ', ',
                        'UPDATE_DATE', ' = EXCLUDED.', 'UPDATE_DATE', ';'
                )
            ) as SQL_STATEMENT
      from  @TestInformationTable lst
            join ECMPS.dbo.ON_OFF_CAL dat
              on dat.TEST_SUM_ID = lst.TEST_SUM_ID
)
GO
