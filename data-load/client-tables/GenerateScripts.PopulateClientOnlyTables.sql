-- CONFIGURATION_TYPE_CODE
select  '-- CONFIGURATION_TYPE_CODE'
union all
select  concat( 'insert into camdecmpsmd.CONFIGURATION_TYPE_CODE ( CONFIG_TYPE_CD, CONFIG_TYPE_CD_DESCRIPTION ) values ( ', 
                case when CONFIG_TYPE_CD is not null then '''' + CONFIG_TYPE_CD + '''' else 'NULL' end, ', ', 
                case when CONFIG_TYPE_CD_DESCRIPTION is not null then '''' + CONFIG_TYPE_CD_DESCRIPTION + '''' else 'NULL' end,
                ' );' )
  from  ECMPS.dbo.CONFIGURATION_TYPE_CODE 

union all 
select  '' 
union all 
select  ''
union all 

-- EVAL_SCORE_CODE
select  '-- EVAL_SCORE_CODE'
union all
select  concat( 'insert into camdecmpsmd.EVAL_SCORE_CODE ( EVAL_SCORE_CD, EVAL_SCORE_DESCRIPTION ) values ( ', 
                case when EVAL_SCORE_CD is not null then '''' + EVAL_SCORE_CD + '''' else 'NULL' end, ', ', 
                case when EVAL_SCORE_DESCRIPTION is not null then '''' + EVAL_SCORE_DESCRIPTION + '''' else 'NULL' end,
                ' );' )
  from  ECMPS_AUX.dbo.EVAL_SCORE_CODE 

union all 
select  '' 
union all 
select  ''
union all 

-- SYSTEM_PARAMETER_NAME
select  '-- SYSTEM_PARAMETER_NAME'
union all
select  concat( 'insert into camdecmpsmd.SYSTEM_PARAMETER_NAME ( SYS_PARAM_NAME, SYS_PARAM_DESCRIPTION ) values ( ', 
                case when SYS_PARAM_NAME is not null then '''' + SYS_PARAM_NAME + '''' else 'NULL' end, ', ', 
                case when SYS_PARAM_DESCRIPTION is not null then '''' + replace(SYS_PARAM_DESCRIPTION, '''', '''''') + '''' else 'NULL' end,
                ' );' )
  from  ECMPS_AUX.dbo.SYSTEM_PARAMETER_NAME 

union all 
select  '' 
union all 
select  ''
union all 

-- SYSTEM_PARAMETER
select  '-- SYSTEM_PARAMETER'
union all
select  concat( 'insert into camdecmpsmd.SYSTEM_PARAMETER ( SYS_PARAM_ID, SYS_PARAM_NAME, PARAM_NAME1, PARAM_VALUE1, PARAM_NAME2, PARAM_VALUE2, PARAM_NAME3, PARAM_VALUE3, PARAM_NAME4, PARAM_VALUE4, PARAM_NAME5, PARAM_VALUE5, NOTES ) overriding system value values ( ', 
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

union all 
select  '' 
union all 
select  ''
union all 

-- PARAMETER_METHOD_TO_FORMULA
select  '-- PARAMETER_METHOD_TO_FORMULA'
union all
select  concat( 'insert into camdecmpsmd.PARAMETER_METHOD_TO_FORMULA ( PARAMETER_CD, METHOD_CD, SYSTEM_TYPE_LIST, ECMPS_ONLY, LOCATION_TYPE_LIST, FORMULA_LIST, NOT_FOUND_RESULT ) values ( ', 
                case when PARAMETER_CD is not null then '''' + PARAMETER_CD + '''' else 'NULL' end, ', ',                 
                case when METHOD_CD is not null then '''' + METHOD_CD + '''' else 'NULL' end, ', ', 
                case when SYSTEM_TYPE_LIST is not null then '''' + SYSTEM_TYPE_LIST + '''' else 'NULL' end, ', ',                 
                case when ECMPS_ONLY is not null then '''' + ECMPS_ONLY + '''' else 'NULL' end, ', ', 
                case when LOCATION_TYPE_LIST is not null then '''' + LOCATION_TYPE_LIST + '''' else 'NULL' end, ', ', 
                case when FORMULA_LIST is not null then '''' + FORMULA_LIST + '''' else 'NULL' end, ', ', 
                case when NOT_FOUND_RESULT is not null then '''' + NOT_FOUND_RESULT + '''' else 'NULL' end,
                ' );' )
  from  ECMPS.CrossCheck.PARAMETER_METHOD_TO_FORMULA

union all 
select  '' 
union all 
select  ''
union all 

-- COMMON_STACK_TEST_CODE
select  '-- COMMON_STACK_TEST_CODE'
union all
select  concat( 'insert into camdecmpsmd.COMMON_STACK_TEST_CODE ( COMMON_STACK_TEST_CD, COMMON_STACK_TEST_CD_DESCRIPTION ) values ( ', 
                case when COMMON_STACK_TEST_CD is not null then '''' + COMMON_STACK_TEST_CD + '''' else 'NULL' end, ', ', 
                case when COMMON_STACK_TEST_CD_DESCRIPTION is not null then '''' + COMMON_STACK_TEST_CD_DESCRIPTION + '''' else 'NULL' end,
                ' );' )
  from  ECMPS.dbo.COMMON_STACK_TEST_CODE

union all 
select  '' 
union all 
select  ''
union all 

select  '-- GAS_COMPONENT_CODE'
union all
select  concat( 'insert into camdecmpsmd.GAS_COMPONENT_CODE ( GAS_COMPONENT_CD, GAS_COMPONENT_DESCRIPTION, CAN_COMBINE_IND, BALANCE_COMPONENT_IND) values ( ', 
                case when GAS_COMPONENT_CD is not null then '''' + GAS_COMPONENT_CD + '''' else 'NULL' end, ', ', 
                case when GAS_COMPONENT_DESCRIPTION is not null then '''' + GAS_COMPONENT_DESCRIPTION + '''' else 'NULL' end, ', ', 
                case when CAN_COMBINE_IND is not null then CAN_COMBINE_IND else 'NULL' end, ', ', 
                case when BALANCE_COMPONENT_IND is not null then BALANCE_COMPONENT_IND else 'NULL' end,
				' );' )
  from  ECMPS.Lookup.GAS_COMPONENT_CODE

union all 
select  '' 
union all 
select  ''
union all 

select  '-- OP_DATE_CODE'
union all
select  concat( 'insert into camdecmpsmd.OP_DATE_CODE ( OP_DATE_CD, OP_DATE_CD_DESCRIPTION) values ( ', 
                case when OP_DATE_CD is not null then '''' + OP_DATE_CD + '''' else 'NULL' end, ', ', 
                case when OP_DATE_CD_DESCRIPTION is not null then '''' + OP_DATE_CD_DESCRIPTION + '''' else 'NULL' end,
				' );' )
  from  ECMPS.dbo.OP_DATE_CODE

union all 
select  '' 
union all 
select  ''
union all 

select  '-- TEST_FREQUENCY_CODE'
union all
select  concat( 'insert into camdecmpsmd.TEST_FREQUENCY_CODE ( TEST_FREQUENCY_CD, TEST_FREQUENCY_CD_DESCRIPTION) values ( ', 
                case when TEST_FREQUENCY_CD is not null then '''' + TEST_FREQUENCY_CD + '''' else 'NULL' end, ', ', 
                case when TEST_FREQUENCY_CD_DESCRIPTION is not null then '''' + TEST_FREQUENCY_CD_DESCRIPTION + '''' else 'NULL' end,
				' );' )
  from  ECMPS.dbo.TEST_FREQUENCY_CODE

union all 
select  '' 
union all 
select  ''
union all 

select  '-- BEGIN_END_HOUR_FLAG'
union all
select  concat( 'insert into camdecmpsmd.BEGIN_END_HOUR_FLAG ( BEGIN_END_HOUR_FLG, BEGIN_END_HOUR_DESCRIPTION) values ( ', 
                case when BEGIN_END_HOUR_FLG is not null then '''' + BEGIN_END_HOUR_FLG + '''' else 'NULL' end, ', ', 
                case when BEGIN_END_HOUR_DESCRIPTION is not null then '''' + BEGIN_END_HOUR_DESCRIPTION + '''' else 'NULL' end,
				' );' )
  from  ECMPS.Lookup.BEGIN_END_HOUR_FLAG

union all 
select  '' 
union all 
select  ''
union all 

select  '-- INDICATOR_CODE'
union all
select  concat( 'insert into camdecmpsmd.INDICATOR_CODE ( INDICATOR_CD, INDICATOR_CD_DESCRIPTION) values ( ', 
                case when INDICATOR_CD is not null then '''' + INDICATOR_CD + '''' else 'NULL' end, ', ', 
                case when INDICATOR_CODE_DESCRIPTION is not null then '''' + INDICATOR_CODE_DESCRIPTION + '''' else 'NULL' end,
				' );' )
  from  ECMPS.dbo.INDICATOR_CODE

union all 
select  '' 
union all 
select  ''
union all 

select  '-- EXEMPTION_TYPE_CODE'
union all
select  concat( 'insert into camdecmpsmd.EXEMPTION_TYPE_CODE ( EXEMPT_TYPE_CD, EXEMPT_TYPE_CD_DESCRIPTION) values ( ', 
                case when EXEMPT_TYPE_CD is not null then '''' + EXEMPT_TYPE_CD + '''' else 'NULL' end, ', ', 
                case when EXEMPT_TYPE_CD_DESCRIPTION is not null then '''' + EXEMPT_TYPE_CD_DESCRIPTION + '''' else 'NULL' end,
				' );' )
  from  ECMPS.dbo.EXEMPTION_TYPE_CODE

union all 
select  '' 
union all 
select  ''
union all 

select  '-- OPERATING_STATUS_CODE'
union all
select  concat( 'insert into camdecmpsmd.OPERATING_STATUS_CODE ( OP_STATUS_CD, OP_STATUS_CD_DESCRIPTION) values ( ', 
                case when OP_STATUS_CD is not null then '''' + OP_STATUS_CD + '''' else 'NULL' end, ', ', 
                case when OP_STATUS_CD_DESCRIPTION is not null then '''' + OP_STATUS_CD_DESCRIPTION + '''' else 'NULL' end,
				' );' )
  from  ECMPS.dbo.OPERATING_STATUS_CODE
