USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[Pg7DayCalibrationInserts]    Script Date: 109/14/2022 06:12:13 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION [SqlGenQa].[Pg7DayCalibrationInserts] 
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
                    'camdecmpswks.CALIBRATION_INJECTION', 
                    ' ( ', 
                        'CAL_INJ_ID', ', ',
                        'TEST_SUM_ID', ', ',
                        'ONLINE_OFFLINE_IND', ', ',
                        'ZERO_REF_VALUE', ', ',
                        'ZERO_CAL_ERROR', ', ',
                        'CALC_ZERO_CAL_ERROR', ', ',
                        'ZERO_APS_IND', ', ',
                        'CALC_ZERO_APS_IND', ', ',
                        'ZERO_INJECTION_DATE', ', ',
                        'ZERO_INJECTION_HOUR', ', ',
                        'ZERO_INJECTION_MIN', ', ',
                        'UPSCALE_REF_VALUE', ', ',
                        'ZERO_MEASURED_VALUE', ', ',
                        'UPSCALE_GAS_LEVEL_CD', ', ',
                        'UPSCALE_MEASURED_VALUE', ', ',
                        'UPSCALE_CAL_ERROR', ', ',
                        'CALC_UPSCALE_CAL_ERROR', ', ',
                        'UPSCALE_APS_IND', ', ',
                        'CALC_UPSCALE_APS_IND', ', ',
                        'UPSCALE_INJECTION_DATE', ', ',
                        'UPSCALE_INJECTION_HOUR', ', ',
                        'UPSCALE_INJECTION_MIN', ', ',
                        'USERID', ', ',
                        'ADD_DATE', ', ',
                        'UPDATE_DATE',
                    ' ) values ( ',
                    case when dat.CAL_INJ_ID is not null then '''' + dat.CAL_INJ_ID + '''' else 'NULL' end, ', ',
                    case when dat.TEST_SUM_ID is not null then '''' + dat.TEST_SUM_ID + '''' else 'NULL' end, ', ',
                    case when dat.ONLINE_OFFLINE_IND is not null then cast(dat.ONLINE_OFFLINE_IND as varchar) else 'NULL' end, ', ',
                    case when dat.ZERO_REF_VALUE is not null then cast(dat.ZERO_REF_VALUE as varchar) else 'NULL' end, ', ',
                    case when dat.ZERO_CAL_ERROR is not null then cast(dat.ZERO_CAL_ERROR as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_ZERO_CAL_ERROR is not null then cast(dat.CALC_ZERO_CAL_ERROR as varchar) else 'NULL' end, ', ',
                    case when dat.ZERO_APS_IND is not null then cast(dat.ZERO_APS_IND as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_ZERO_APS_IND is not null then cast(dat.CALC_ZERO_APS_IND as varchar) else 'NULL' end, ', ',
                    case when dat.ZERO_INJECTION_DATE is not null then '''' + convert(varchar(10), dat.ZERO_INJECTION_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.ZERO_INJECTION_HOUR is not null then cast(dat.ZERO_INJECTION_HOUR as varchar) else 'NULL' end, ', ',
                    case when dat.ZERO_INJECTION_MIN is not null then cast(dat.ZERO_INJECTION_MIN as varchar) else 'NULL' end, ', ',
                    case when dat.UPSCALE_REF_VALUE is not null then cast(dat.UPSCALE_REF_VALUE as varchar) else 'NULL' end, ', ',
                    case when dat.ZERO_MEASURED_VALUE is not null then cast(dat.ZERO_MEASURED_VALUE as varchar) else 'NULL' end, ', ',
                    case when dat.UPSCALE_GAS_LEVEL_CD is not null then '''' + dat.UPSCALE_GAS_LEVEL_CD + '''' else 'NULL' end, ', ',
                    case when dat.UPSCALE_MEASURED_VALUE is not null then cast(dat.UPSCALE_MEASURED_VALUE as varchar) else 'NULL' end, ', ',
                    case when dat.UPSCALE_CAL_ERROR is not null then cast(dat.UPSCALE_CAL_ERROR as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_UPSCALE_CAL_ERROR is not null then cast(dat.CALC_UPSCALE_CAL_ERROR as varchar) else 'NULL' end, ', ',
                    case when dat.UPSCALE_APS_IND is not null then cast(dat.UPSCALE_APS_IND as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_UPSCALE_APS_IND is not null then cast(dat.CALC_UPSCALE_APS_IND as varchar) else 'NULL' end, ', ',
                    case when dat.UPSCALE_INJECTION_DATE is not null then '''' + convert(varchar(10), dat.UPSCALE_INJECTION_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPSCALE_INJECTION_HOUR is not null then cast(dat.UPSCALE_INJECTION_HOUR as varchar) else 'NULL' end, ', ',
                    case when dat.UPSCALE_INJECTION_MIN is not null then cast(dat.UPSCALE_INJECTION_MIN as varchar) else 'NULL' end, ', ',
                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end,
                    ' ) on conflict (', 
                    'CAL_INJ_ID', 
                    ') do update set ',
                        'TEST_SUM_ID = EXCLUDED.TEST_SUM_ID, ',
                        'ONLINE_OFFLINE_IND = EXCLUDED.ONLINE_OFFLINE_IND, ',
                        'ZERO_REF_VALUE = EXCLUDED.ZERO_REF_VALUE, ',
                        'ZERO_CAL_ERROR = EXCLUDED.ZERO_CAL_ERROR, ',
                        'CALC_ZERO_CAL_ERROR = EXCLUDED.CALC_ZERO_CAL_ERROR, ',
                        'ZERO_APS_IND = EXCLUDED.ZERO_APS_IND, ',
                        'CALC_ZERO_APS_IND = EXCLUDED.CALC_ZERO_APS_IND, ',
                        'ZERO_INJECTION_DATE = EXCLUDED.ZERO_INJECTION_DATE, ',
                        'ZERO_INJECTION_HOUR = EXCLUDED.ZERO_INJECTION_HOUR, ',
                        'ZERO_INJECTION_MIN = EXCLUDED.ZERO_INJECTION_MIN, ',
                        'UPSCALE_REF_VALUE = EXCLUDED.UPSCALE_REF_VALUE, ',
                        'ZERO_MEASURED_VALUE = EXCLUDED.ZERO_MEASURED_VALUE, ',
                        'UPSCALE_GAS_LEVEL_CD = EXCLUDED.UPSCALE_GAS_LEVEL_CD, ',
                        'UPSCALE_MEASURED_VALUE = EXCLUDED.UPSCALE_MEASURED_VALUE, ',
                        'UPSCALE_CAL_ERROR = EXCLUDED.UPSCALE_CAL_ERROR, ',
                        'CALC_UPSCALE_CAL_ERROR = EXCLUDED.CALC_UPSCALE_CAL_ERROR, ',
                        'UPSCALE_APS_IND = EXCLUDED.UPSCALE_APS_IND, ',
                        'CALC_UPSCALE_APS_IND = EXCLUDED.CALC_UPSCALE_APS_IND, ',
                        'UPSCALE_INJECTION_DATE = EXCLUDED.UPSCALE_INJECTION_DATE, ',
                        'UPSCALE_INJECTION_HOUR = EXCLUDED.UPSCALE_INJECTION_HOUR, ',
                        'UPSCALE_INJECTION_MIN = EXCLUDED.UPSCALE_INJECTION_MIN, ',

                        'USERID', ' = EXCLUDED.', 'USERID', ', ',
                        'ADD_DATE', ' = EXCLUDED.', 'ADD_DATE', ', ',
                        'UPDATE_DATE', ' = EXCLUDED.', 'UPDATE_DATE', ';'
                )
            ) as SQL_STATEMENT
      from  @TestInformationTable lst
            join ECMPS.dbo.CALIBRATION_INJECTION dat
              on dat.TEST_SUM_ID = lst.TEST_SUM_ID
)
GO
