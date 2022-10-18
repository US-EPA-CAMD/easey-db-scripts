USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[PgAppendixECorrelationHiFromOil]    Script Date: 10/12/2022 5:12:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION [SqlGenQa].[PgAppendixECorrelationHiFromOil] 
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
                    'camdecmpswks.AE_HI_OIL', 
                    ' ( ', 
                        'AE_HI_OIL_ID', ', ',
                        'AE_CORR_TEST_RUN_ID', ', ',
                        'OIL_MASS', ', ',
                        'OIL_HI', ', ',
                        'CALC_OIL_HI', ', ',
                        'OIL_GCV', ', ',
                        'OIL_VOLUME', ', ',
                        'OIL_DENSITY', ', ',
                        'USERID', ', ',
                        'ADD_DATE', ', ',
                        'UPDATE_DATE', ', ',
                        'OIL_GCV_UOM_CD', ', ',
                        'OIL_VOLUME_UOM_CD', ', ',
                        'OIL_DENSITY_UOM_CD', ', ',
                        'MON_SYS_ID', ', ',
                        'CALC_OIL_MASS',
                    ' ) values ( ',
                    case when dat.AE_HI_OIL_ID is not null then '''' + dat.AE_HI_OIL_ID + '''' else 'NULL' end, ', ',
                    case when dat.AE_CORR_TEST_RUN_ID is not null then '''' + dat.AE_CORR_TEST_RUN_ID + '''' else 'NULL' end, ', ',
                    case when dat.OIL_MASS is not null then cast(dat.OIL_MASS as varchar) else 'NULL' end, ', ',
                    case when dat.OIL_HI is not null then cast(dat.OIL_HI as varchar) else 'NULL' end, ', ',
                    case when dat.CALC_OIL_HI is not null then cast(dat.CALC_OIL_HI as varchar) else 'NULL' end, ', ',
                    case when dat.OIL_GCV is not null then cast(dat.OIL_GCV as varchar) else 'NULL' end, ', ',
                    case when dat.OIL_VOLUME is not null then cast(dat.OIL_VOLUME as varchar) else 'NULL' end, ', ',
                    case when dat.OIL_DENSITY is not null then cast(dat.OIL_DENSITY as varchar) else 'NULL' end, ', ',
                    case when dat.USERID is not null then '''' + dat.USERID + '''' else 'NULL' end, ', ',
                    case when dat.ADD_DATE is not null then '''' + convert(varchar, dat.ADD_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.UPDATE_DATE is not null then '''' + convert(varchar, dat.UPDATE_DATE, 120) + '''' else 'NULL' end, ', ',
                    case when dat.OIL_GCV_UOM_CD is not null then '''' + dat.OIL_GCV_UOM_CD + '''' else 'NULL' end, ', ',
                    case when dat.OIL_VOLUME_UOM_CD is not null then '''' + dat.OIL_VOLUME_UOM_CD + '''' else 'NULL' end, ', ',
                    case when dat.OIL_DENSITY_UOM_CD is not null then '''' + dat.OIL_DENSITY_UOM_CD + '''' else 'NULL' end, ', ',
                    case when dat.MON_SYS_ID is not null then '''' + dat.MON_SYS_ID + '''' else 'NULL' end, ', ',
                    case when dat.CALC_OIL_MASS is not null then cast(dat.CALC_OIL_MASS as varchar) else 'NULL' end,
                    ' ) on conflict (', 
                    'AE_HI_OIL_ID', 
                    ') do update set ',
                        'AE_CORR_TEST_RUN_ID = EXCLUDED.AE_CORR_TEST_RUN_ID, ',
                        'OIL_MASS = EXCLUDED.OIL_MASS, ',
                        'OIL_HI = EXCLUDED.OIL_HI, ',
                        'CALC_OIL_HI = EXCLUDED.CALC_OIL_HI, ',
                        'OIL_GCV = EXCLUDED.OIL_GCV, ',
                        'OIL_VOLUME = EXCLUDED.OIL_VOLUME, ',
                        'OIL_DENSITY = EXCLUDED.OIL_DENSITY, ',
                        'OIL_GCV_UOM_CD = EXCLUDED.OIL_GCV_UOM_CD, ',
                        'OIL_VOLUME_UOM_CD = EXCLUDED.OIL_VOLUME_UOM_CD, ',
                        'OIL_DENSITY_UOM_CD = EXCLUDED.OIL_DENSITY_UOM_CD, ',
                        'MON_SYS_ID = EXCLUDED.MON_SYS_ID, ',
                        'CALC_OIL_MASS = EXCLUDED.CALC_OIL_MASS, ',
                        
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
            join ECMPS.dbo.AE_HI_OIL dat
              on dat.AE_CORR_TEST_RUN_ID = lk2.AE_CORR_TEST_RUN_ID
)
GO


