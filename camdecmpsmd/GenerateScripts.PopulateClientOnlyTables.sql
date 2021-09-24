-- CONFIGURATION_TYPE_CODE
select  concat( 'insert into CONFIGURATION_TYPE_CODE ( CONFIG_TYPE_CD, CONFIG_TYPE_CD_DESCRIPTION ) values ( ', 
                case when CONFIG_TYPE_CD is not null then '''' + CONFIG_TYPE_CD + '''' else 'NULL' end, ', ', 
                case when CONFIG_TYPE_CD_DESCRIPTION is not null then '''' + CONFIG_TYPE_CD_DESCRIPTION + '''' else 'NULL' end,
                ' );' )
  from  ECMPS.dbo.CONFIGURATION_TYPE_CODE 


-- EVAL_SCORE_CODE
select  concat( 'insert into EVAL_SCORE_CODE ( EVAL_SCORE_CD, EVAL_SCORE_DESCRIPTION ) values ( ', 
                case when EVAL_SCORE_CD is not null then '''' + EVAL_SCORE_CD + '''' else 'NULL' end, ', ', 
                case when EVAL_SCORE_DESCRIPTION is not null then '''' + EVAL_SCORE_DESCRIPTION + '''' else 'NULL' end,
                ' );' )
  from  ECMPS_AUX.dbo.EVAL_SCORE_CODE 


-- SYSTEM_PARAMETER_NAME
select  concat( 'insert into SYSTEM_PARAMETER_NAME ( SYS_PARAM_NAME, SYS_PARAM_DESCRIPTION ) values ( ', 
                case when SYS_PARAM_NAME is not null then '''' + SYS_PARAM_NAME + '''' else 'NULL' end, ', ', 
                case when SYS_PARAM_DESCRIPTION is not null then '''' + replace(SYS_PARAM_DESCRIPTION, '''', '''''') + '''' else 'NULL' end,
                ' );' )
  from  ECMPS_AUX.dbo.SYSTEM_PARAMETER_NAME 


-- SYSTEM_PARAMETER
select  concat( 'insert into SYSTEM_PARAMETER ( SYS_PARAM_ID, SYS_PARAM_NAME, PARAM_NAME1, PARAM_VALUE1, PARAM_NAME2, PARAM_VALUE2, PARAM_NAME3, PARAM_VALUE3, PARAM_NAME4, PARAM_VALUE4, PARAM_NAME5, PARAM_VALUE5, NOTES ) overriding system value values ( ', 
                case when SYS_PARAM_ID is not null then cast(SYS_PARAM_ID as varchar) else 'NULL' end, ', ', 
                case when SYS_PARAM_NAME is not null then '''' + replace(SYS_PARAM_NAME, '''', '''''') + '''' else 'NULL' end, ', ', 
                case when PARAM_NAME1 is not null then '''' + replace(PARAM_NAME1, '''', '''''') + '''' else 'NULL' end, ', ', 
                case when PARAM_VALUE1 is not null then '''' + replace(PARAM_VALUE1, '''', '''''') + '''' else 'NULL' end, ', ', 
                case when PARAM_NAME2 is not null then '''' + replace(PARAM_NAME2, '''', '''''') + '''' else 'NULL' end, ', ', 
                case when PARAM_VALUE2 is not null then '''' + replace(PARAM_VALUE2, '''', '''''') + '''' else 'NULL' end, ', ', 
                case when PARAM_NAME3 is not null then '''' + replace(PARAM_NAME3, '''', '''''') + '''' else 'NULL' end, ', ', 
                case when PARAM_VALUE3 is not null then '''' + replace(PARAM_VALUE3, '''', '''''') + '''' else 'NULL' end, ', ', 
                case when PARAM_NAME4 is not null then '''' + replace(PARAM_NAME4, '''', '''''') + '''' else 'NULL' end, ', ', 
                case when PARAM_VALUE4 is not null then '''' + replace(PARAM_VALUE4, '''', '''''') + '''' else 'NULL' end, ', ', 
                case when PARAM_NAME5 is not null then '''' + replace(PARAM_NAME5, '''', '''''') + '''' else 'NULL' end, ', ', 
                case when PARAM_VALUE5 is not null then '''' + replace(PARAM_VALUE5, '''', '''''') + '''' else 'NULL' end, ', ', 
                case when NOTES is not null then '''' + replace(NOTES, '''', '''''') + '''' else 'NULL' end,
                ' );' )
  from  ECMPS_AUX.dbo.SYSTEM_PARAMETER

-- PARAMETER_METHOD_TO_FORMULA
select  concat( 'insert into PARAMETER_METHOD_TO_FORMULA ( PARAMETER_CD, METHOD_CD, SYSTEM_TYPE_LIST, ECMPS_ONLY, LOCATION_TYPE_LIST, FORMULA_LIST, NOT_FOUND_RESULT ) values ( ', 
                case when PARAMETER_CD is not null then '''' + PARAMETER_CD + '''' else 'NULL' end, ', ',                 
                case when METHOD_CD is not null then '''' + METHOD_CD + '''' else 'NULL' end, ', ', 
                case when SYSTEM_TYPE_LIST is not null then '''' + SYSTEM_TYPE_LIST + '''' else 'NULL' end, ', ',                 
                case when ECMPS_ONLY is not null then '''' + ECMPS_ONLY + '''' else 'NULL' end, ', ', 
                case when LOCATION_TYPE_LIST is not null then '''' + LOCATION_TYPE_LIST + '''' else 'NULL' end, ', ', 
                case when FORMULA_LIST is not null then '''' + FORMULA_LIST + '''' else 'NULL' end, ', ', 
                case when NOT_FOUND_RESULT is not null then '''' + NOT_FOUND_RESULT + '''' else 'NULL' end,
                ' );' )
  from  ECMPS.CrossCheck.PARAMETER_METHOD_TO_FORMULA 