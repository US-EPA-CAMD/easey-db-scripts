/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  fac.ORIS_CODE,
        fac.FACILITY_NAME,
        concat( chk.CHECK_TYPE_CD, '-', chk.CHECK_NUMBER, '-', ccr.CHECK_RESULT ) as RESULT_CD,
        ess.*
  FROM  [ECMPS_AUX].[ErrorSuppression].[ES_SPEC] ess
        join FACILITY fac on fac.FAC_ID = ess.FAC_ID
        join [ECMPS_AUX].dbo.CHECK_CATALOG_RESULT ccr on ccr.CHECK_CATALOG_RESULT_ID = ess.CHECK_CATALOG_RESULT_ID
        join [ECMPS_AUX].dbo.CHECK_CATALOG chk on chk.CHECK_CATALOG_ID = ccr.CHECK_CATALOG_ID
 ORDER
    BY  fac.ORIS_CODE,
        RESULT_CD,
        ess.[ES_SPEC_ID] desc
