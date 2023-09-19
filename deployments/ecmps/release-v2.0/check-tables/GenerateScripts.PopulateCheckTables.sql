
--------------------------
-- Lookup Table Inserts --
--------------------------
select  ''
union all 
select  '--------------------------'
union all
select  '-- Lookup Table Inserts --'
union all
select  '--------------------------'
union all
select  ''
union all 


-- CHECK_APPLICABILITY_CODE
select  '-- CHECK_APPLICABILITY_CODE'
union all
select  concat( 'insert into CHECK_APPLICABILITY_CODE ( CHECK_APPLICABILITY_CD, CHECK_APPLICABILITY_CD_NAME ) values ( ', 
                case when CHECK_APPLICABILITY_CD is not null then '''' + CHECK_APPLICABILITY_CD + '''' else 'NULL' end, ', ', 
                case when CHECK_APPLICABILITY_CD_NAME is not null then '''' + CHECK_APPLICABILITY_CD_NAME + '''' else 'NULL' end,
                ' );' ) as SQL_STATEMENT
  from  ECMPS_AUX.dbo.CHECK_APPLICABILITY_CODE 

union all 
select  '' 
union all 
select  ''
union all 

-- CHECK_DATA_TYPE_CODE
select  '-- CHECK_DATA_TYPE_CODE'
union all
select  concat( 'insert into CHECK_DATA_TYPE_CODE ( CHECK_DATA_TYPE_CD, CHECK_DATA_TYPE_CD_NAME ) values ( ', 
                case when CHECK_DATA_TYPE_CD is not null then '''' + CHECK_DATA_TYPE_CD + '''' else 'NULL' end, ', ', 
                case when CHECK_DATA_TYPE_CD_NAME is not null then '''' + CHECK_DATA_TYPE_CD_NAME + '''' else 'NULL' end,
                ' );' ) as SQL_STATEMENT
  from  ECMPS_AUX.dbo.CHECK_DATA_TYPE_CODE 

union all 
select  '' 
union all 
select  ''
union all 

-- CHECK_OPERATOR_CODE
select  '-- CHECK_OPERATOR_CODE'
union all
select  concat( 'insert into CHECK_OPERATOR_CODE ( CHECK_OPERATOR_CD, CHECK_OPERATOR_CD_NAME ) values ( ', 
                case when CHECK_OPERATOR_CD is not null then '''' + CHECK_OPERATOR_CD + '''' else 'NULL' end, ', ', 
                case when CHECK_OPERATOR_CD_NAME is not null then '''' + CHECK_OPERATOR_CD_NAME + '''' else 'NULL' end,
                ' );' ) as SQL_STATEMENT
  from  ECMPS_AUX.dbo.CHECK_OPERATOR_CODE 

union all 
select  '' 
union all 
select  ''
union all 

-- CHECK_PARAMETER_TYPE_CODE
select  '-- CHECK_PARAMETER_TYPE_CODE'
union all
select  concat( 'insert into CHECK_PARAMETER_TYPE_CODE ( CHK_PARAM_TYPE_CD, CHK_PARAM_TYPE_CD_DESCRIPTION ) values ( ', 
                case when CHK_PARAM_TYPE_CD is not null then '''' + CHK_PARAM_TYPE_CD + '''' else 'NULL' end, ', ', 
                case when CHK_PARAM_TYPE_CD_DESCRIPTION is not null then '''' + CHK_PARAM_TYPE_CD_DESCRIPTION + '''' else 'NULL' end,
                ' );' ) as SQL_STATEMENT
  from  ECMPS_AUX.dbo.CHECK_PARAMETER_TYPE_CODE 

union all 
select  '' 
union all 
select  ''
union all 

-- CHECK_PARAMETER_USAGE_CODE
select  '-- CHECK_PARAMETER_USAGE_CODE'
union all
select  concat( 'insert into CHECK_PARAMETER_USAGE_CODE ( CHECK_PARAM_USAGE_CD, CHECK_PARAM_USAGE_CD_NAME ) values ( ', 
                case when CHECK_PARAM_USAGE_CD is not null then '''' + CHECK_PARAM_USAGE_CD + '''' else 'NULL' end, ', ', 
                case when CHECK_PARAM_USAGE_CD_NAME is not null then '''' + CHECK_PARAM_USAGE_CD_NAME + '''' else 'NULL' end,
                ' );' ) as SQL_STATEMENT
  from  ECMPS_AUX.dbo.CHECK_PARAMETER_USAGE_CODE 

union all 
select  '' 
union all 
select  ''
union all 

-- CHECK_STATUS_CODE
select  '-- CHECK_STATUS_CODE'
union all
select  concat( 'insert into CHECK_STATUS_CODE ( CHECK_STATUS_CD, CHECK_STATUS_CD_DESCRIPTION, CHECK_USES_FLG, CODE_USES_FLG, TEST_USES_FLG ) values ( ', 
                case when CHECK_STATUS_CD is not null then '''' + CHECK_STATUS_CD + '''' else 'NULL' end, ', ', 
                case when CHECK_STATUS_CD_DESCRIPTION is not null then '''' + CHECK_STATUS_CD_DESCRIPTION + '''' else 'NULL' end, ', ', 
                case when CHECK_USES_FLG is not null then '''' + CHECK_USES_FLG + '''' else 'NULL' end, ', ', 
                case when CODE_USES_FLG is not null then '''' + CODE_USES_FLG + '''' else 'NULL' end, ', ', 
                case when TEST_USES_FLG is not null then '''' + TEST_USES_FLG + '''' else 'NULL' end,
                ' );' ) as SQL_STATEMENT
  from  ECMPS_AUX.dbo.CHECK_STATUS_CODE 

union all 
select  '' 
union all 
select  ''
union all 

-- CHECK_TYPE_CODE
select  '-- CHECK_TYPE_CODE'
union all
select  concat( 'insert into CHECK_TYPE_CODE ( CHECK_TYPE_CD, CHECK_TYPE_CD_DESCRIPTION ) values ( ', 
                case when CHECK_TYPE_CD is not null then '''' + CHECK_TYPE_CD + '''' else 'NULL' end, ', ', 
                case when CHECK_TYPE_CD_DESCRIPTION is not null then '''' + CHECK_TYPE_CD_DESCRIPTION + '''' else 'NULL' end,
                ' );' ) as SQL_STATEMENT
  from  ECMPS_AUX.dbo.CHECK_TYPE_CODE 

union all 
select  '' 
union all 
select  ''
union all 

-- CROSS_CHECK_CATALOG
select  '-- CROSS_CHECK_CATALOG'
union all
select  concat( 'insert into CROSS_CHECK_CATALOG ( CROSS_CHK_CATALOG_ID, CROSS_CHK_CATALOG_NAME, CROSS_CHK_CATALOG_DESCRIPTION, TABLE_NAME1, COLUMN_NAME1, DESCRIPTION1, FIELD_TYPE_CD1, TABLE_NAME2, COLUMN_NAME2, DESCRIPTION2, FIELD_TYPE_CD2, TABLE_NAME3, COLUMN_NAME3, DESCRIPTION3, FIELD_TYPE_CD3 ) overriding system value values ( ', 
                case when CROSS_CHK_CATALOG_ID is not null then cast(CROSS_CHK_CATALOG_ID as varchar) else 'NULL' end, ', ', 
                case when CROSS_CHK_CATALOG_NAME is not null then '''' + CROSS_CHK_CATALOG_NAME + '''' else 'NULL' end, ', ', 
                case when CROSS_CHK_CATALOG_DESCRIPTION is not null then '''' + CROSS_CHK_CATALOG_DESCRIPTION + '''' else 'NULL' end, ', ', 
                case when TABLE_NAME1 is not null then '''' + TABLE_NAME1 + '''' else 'NULL' end, ', ', 
                case when COLUMN_NAME1 is not null then '''' + COLUMN_NAME1 + '''' else 'NULL' end, ', ', 
                case when DESCRIPTION1 is not null then '''' + DESCRIPTION1 + '''' else 'NULL' end, ', ', 
                case when FIELD_TYPE_CD1 is not null then '''' + FIELD_TYPE_CD1 + '''' else 'NULL' end, ', ', 
                case when TABLE_NAME2 is not null then '''' + TABLE_NAME2 + '''' else 'NULL' end, ', ', 
                case when COLUMN_NAME2 is not null then '''' + COLUMN_NAME2 + '''' else 'NULL' end, ', ', 
                case when DESCRIPTION2 is not null then '''' + DESCRIPTION2 + '''' else 'NULL' end, ', ', 
                case when FIELD_TYPE_CD2 is not null then '''' + FIELD_TYPE_CD2 + '''' else 'NULL' end, ', ', 
                case when TABLE_NAME3 is not null then '''' + TABLE_NAME3 + '''' else 'NULL' end, ', ', 
                case when COLUMN_NAME3 is not null then '''' + COLUMN_NAME3 + '''' else 'NULL' end, ', ', 
                case when DESCRIPTION3 is not null then '''' + DESCRIPTION3 + '''' else 'NULL' end, ', ', 
                case when FIELD_TYPE_CD3 is not null then '''' + FIELD_TYPE_CD3 + '''' else 'NULL' end,
                ' );' ) as SQL_STATEMENT
  from  ECMPS_AUX.dbo.CROSS_CHECK_CATALOG 

union all 
select  '' 
union all 
select  ''
union all 

-- CROSS_CHECK_CATALOG_VALUE
select  '-- CROSS_CHECK_CATALOG_VALUE'
union all
select  concat( 'insert into CROSS_CHECK_CATALOG_VALUE ( CROSS_CHK_CATALOG_VALUE_ID, CROSS_CHK_CATALOG_ID, VALUE1, VALUE2, VALUE3 ) overriding system value values ( ', 
                case when CROSS_CHK_CATALOG_VALUE_ID is not null then cast(CROSS_CHK_CATALOG_VALUE_ID as varchar) else 'NULL' end, ', ', 
                case when CROSS_CHK_CATALOG_ID is not null then cast(CROSS_CHK_CATALOG_ID as varchar) else 'NULL' end, ', ', 
                case when VALUE1 is not null then '''' + VALUE1 + '''' else 'NULL' end, ', ', 
                case when VALUE2 is not null then '''' + VALUE2 + '''' else 'NULL' end, ', ', 
                case when VALUE3 is not null then '''' + VALUE3 + '''' else 'NULL' end,
                ' );' ) as SQL_STATEMENT
  from  ECMPS_AUX.dbo.CROSS_CHECK_CATALOG_VALUE 

union all 
select  '' 
union all 
select  ''
union all 

-- PARAMETER_GROUP_OVERRIDE_CODE
select  '-- PARAMETER_GROUP_OVERRIDE_CODE'
union all
select  concat( 'insert into PARAMETER_GROUP_OVERRIDE_CODE ( PARAMETER_GROUP_OVERRIDE_CD, PARAMETER_GROUP_OVERRIDE_DESCRIPTION ) values ( ', 
                case when PARAMETER_GROUP_OVERRIDE_CD is not null then '''' + PARAMETER_GROUP_OVERRIDE_CD + '''' else 'NULL' end, ', ', 
                case when PARAMETER_GROUP_OVERRIDE_DESCRIPTION is not null then '''' + PARAMETER_GROUP_OVERRIDE_DESCRIPTION + '''' else 'NULL' end,
                ' );' ) as SQL_STATEMENT
  from  ECMPS_AUX.chet.PARAMETER_GROUP_OVERRIDE_CODE 

union all 
select  '' 
union all 
select  ''
union all 

-- PLUGIN_TYPE_CODE
select  '-- PLUGIN_TYPE_CODE'
union all
select  concat( 'insert into PLUGIN_TYPE_CODE ( PLUGIN_TYPE_CD, PLUGIN_TYPE_CD_DESCRIPTION ) values ( ', 
                case when PLUGIN_TYPE_CD is not null then '''' + PLUGIN_TYPE_CD + '''' else 'NULL' end, ', ', 
                case when PLUGIN_TYPE_CD_DESCRIPTION is not null then '''' + PLUGIN_TYPE_CD_DESCRIPTION + '''' else 'NULL' end,
                ' );' ) as SQL_STATEMENT
  from  ECMPS_AUX.dbo.PLUGIN_TYPE_CODE 

union all 
select  '' 
union all 
select  ''
union all 

-- PROCESS_GROUP_CODE
select  '-- PROCESS_GROUP_CODE'
union all
select  concat( 'insert into PROCESS_GROUP_CODE ( PROCESS_GROUP_CD, PROCESS_GROUP_DESCRIPTION ) values ( ', 
                case when PROCESS_GROUP_CD is not null then '''' + PROCESS_GROUP_CD + '''' else 'NULL' end, ', ', 
                case when PROCESS_GROUP_DESCRIPTION is not null then '''' + PROCESS_GROUP_DESCRIPTION + '''' else 'NULL' end,
                ' );' ) as SQL_STATEMENT
  from  ECMPS_AUX.Lookup.PROCESS_GROUP_CODE 

union all 
select  '' 
union all 
select  ''
union all 

-- RESPONSE_TYPE_CODE
select  '-- RESPONSE_TYPE_CODE'
union all
select  concat( 'insert into RESPONSE_TYPE_CODE ( RESPONSE_TYPE_CD, RESPONSE_TYPE_CD_DESCRIPTION ) values ( ', 
                case when RESPONSE_TYPE_CD is not null then '''' + RESPONSE_TYPE_CD + '''' else 'NULL' end, ', ', 
                case when RESPONSE_TYPE_CD_DESCRIPTION is not null then '''' + RESPONSE_TYPE_CD_DESCRIPTION + '''' else 'NULL' end,
                ' );' ) as SQL_STATEMENT
  from  ECMPS_AUX.dbo.RESPONSE_TYPE_CODE 

------------------------------------
-- Lookup Table Secondary Inserts --
------------------------------------
union all 
select  ''
union all 
select  '------------------------------------'
union all
select  '-- Lookup Table Secondary Inserts --'
union all
select  '------------------------------------'
union all
select  ''
union all 


-- CHECK_PARAMETER_CODE
select  '-- CHECK_PARAMETER_CODE'
union all
select  concat( 'insert into CHECK_PARAMETER_CODE ( CHECK_PARAM_ID, CHECK_PARAM_ID_NAME, CHECK_PARAM_ID_DESCRIPTION, DISPLAY_NAME, SOURCE_TABLE, CHECK_DATA_TYPE_CD, CHK_PARAM_TYPE_CD, OBJECT_TYPE ) overriding system value values ( ', 
                case when CHECK_PARAM_ID is not null then cast(CHECK_PARAM_ID as varchar) else 'NULL' end, ', ', 
                case when CHECK_PARAM_ID_NAME is not null then '''' + CHECK_PARAM_ID_NAME + '''' else 'NULL' end, ', ', 
                case when CHECK_PARAM_ID_DESCRIPTION is not null then '''' + replace(CHECK_PARAM_ID_DESCRIPTION, '''', '''''') + '''' else 'NULL' end, ', ', 
                case when DISPLAY_NAME is not null then '''' + DISPLAY_NAME + '''' else 'NULL' end, ', ', 
                case when SOURCE_TABLE is not null then '''' + SOURCE_TABLE + '''' else 'NULL' end, ', ', 
                case when CHECK_DATA_TYPE_CD is not null then '''' + CHECK_DATA_TYPE_CD + '''' else 'NULL' end, ', ', 
                case when CHK_PARAM_TYPE_CD is not null then '''' + CHK_PARAM_TYPE_CD + '''' else 'NULL' end, ', ', 
                case when OBJECT_TYPE is not null then '''' + OBJECT_TYPE + '''' else 'NULL' end,
                ' );' ) as SQL_STATEMENT
  from  ECMPS_AUX.dbo.CHECK_PARAMETER_CODE 

union all 
select  '' 
union all 
select  ''
union all 

-- CHECK_OPERATOR_DATA_TYPE
select  '-- CHECK_OPERATOR_DATA_TYPE'
union all
select  concat( 'insert into CHECK_OPERATOR_DATA_TYPE ( CHECK_OPERATOR_CD, CHECK_DATA_TYPE_CD ) values ( ', 
                case when CHECK_OPERATOR_CD is not null then '''' + CHECK_OPERATOR_CD + '''' else 'NULL' end, ', ', 
                case when CHECK_DATA_TYPE_CD is not null then '''' + CHECK_DATA_TYPE_CD + '''' else 'NULL' end,
                ' );' ) as SQL_STATEMENT
  from  ECMPS_AUX.dbo.CHECK_OPERATOR_DATA_TYPE 

----------------------------
-- Metadata Table Inserts --
----------------------------
union all 
select  ''
union all 
select  '----------------------------'
union all
select  '-- Metadata Table Inserts --'
union all
select  '----------------------------'
union all
select  ''
union all 


-- CHECK_CATALOG
select  '-- CHECK_CATALOG'
union all
select  concat( 'insert into CHECK_CATALOG ( CHECK_CATALOG_ID, CHECK_TYPE_CD, CHECK_NUMBER, CHECK_NAME, CHECK_DESCRIPTION, CHECK_PROCEDURE, OLD_CHECK_NAME, TECH_NOTE, TODO_NOTE, CHECK_APPLICABILITY_CD, CHECK_STATUS_CD, TEST_STATUS_CD, CODE_STATUS_CD, RUN_CHECK_FLG ) values ( ', 
                case when CHECK_CATALOG_ID is not null then cast(CHECK_CATALOG_ID as varchar) else 'NULL' end, ', ', 
                case when CHECK_TYPE_CD is not null then '''' + CHECK_TYPE_CD + '''' else 'NULL' end, ', ', 
                case when CHECK_NUMBER is not null then cast(CHECK_NUMBER as varchar) else 'NULL' end, ', ', 
                case when CHECK_NAME is not null then '''' + replace(CHECK_NAME, '''', '''''') + '''' else 'NULL' end, ', ', 
                case when CHECK_DESCRIPTION is not null then '''' + replace(CHECK_DESCRIPTION, '''', '''''') + '''' else 'NULL' end, ', ', 
                case when CHECK_PROCEDURE is not null then '''' + CHECK_PROCEDURE + '''' else 'NULL' end, ', ', 
                case when OLD_CHECK_NAME is not null then '''' + OLD_CHECK_NAME + '''' else 'NULL' end, ', ', 
                'NULL, ', --case when TECH_NOTE is not null then '''' + TECH_NOTE + '''' else 'NULL' end, ', ',                 
                case when TODO_NOTE is not null then '''' + replace(TODO_NOTE, '''', '''''') + '''' else 'NULL' end, ', ', 
                case when CHECK_APPLICABILITY_CD is not null then '''' + CHECK_APPLICABILITY_CD + '''' else 'NULL' end, ', ', 
                case when CHECK_STATUS_CD is not null then '''' + CHECK_STATUS_CD + '''' else 'NULL' end, ', ', 
                case when TEST_STATUS_CD is not null then '''' + TEST_STATUS_CD + '''' else 'NULL' end, ', ', 
                case when CODE_STATUS_CD is not null then '''' + CODE_STATUS_CD + '''' else 'NULL' end, ', ', 
                case when RUN_CHECK_FLG is not null then '''' + RUN_CHECK_FLG + '''' else 'NULL' end,
                ' );' ) as SQL_STATEMENT
  from  ECMPS_AUX.dbo.CHECK_CATALOG 

union all 
select  '' 
union all 
select  ''
union all 

-- CHECK_CATALOG_PARAMETER
select  '-- CHECK_CATALOG_PARAMETER'
union all
select  concat( 'insert into CHECK_CATALOG_PARAMETER ( CHECK_CATALOG_PARAM_ID, CHECK_CATALOG_ID, CHECK_PARAM_ID, CHECK_PARAM_USAGE_CD ) overriding system value values ( ', 
                case when CHECK_CATALOG_PARAM_ID is not null then cast(CHECK_CATALOG_PARAM_ID as varchar) else 'NULL' end, ', ', 
                case when CHECK_CATALOG_ID is not null then cast(CHECK_CATALOG_ID as varchar) else 'NULL' end, ', ', 
                case when CHECK_PARAM_ID is not null then cast(CHECK_PARAM_ID as varchar) else 'NULL' end, ', ', 
                case when CHECK_PARAM_USAGE_CD is not null then '''' + CHECK_PARAM_USAGE_CD + '''' else 'NULL' end,
                ' );' ) as SQL_STATEMENT
  from  ECMPS_AUX.dbo.CHECK_CATALOG_PARAMETER 

union all 
select  '' 
union all 
select  ''
union all 

-- CHECK_CATALOG_PLUGIN
select  '-- CHECK_CATALOG_PLUGIN'
union all
select  concat( 'insert into CHECK_CATALOG_PLUGIN ( CHECK_CATALOG_PLUGIN_ID, CHECK_CATALOG_ID, PLUGIN_NAME, PLUGIN_TYPE_CD, CHECK_PARAM_ID, FIELD_NAME ) overriding system value values ( ', 
                case when CHECK_CATALOG_PLUGIN_ID is not null then cast(CHECK_CATALOG_PLUGIN_ID as varchar) else 'NULL' end, ', ', 
                case when CHECK_CATALOG_ID is not null then cast(CHECK_CATALOG_ID as varchar) else 'NULL' end, ', ', 
                case when PLUGIN_NAME is not null then '''' + PLUGIN_NAME + '''' else 'NULL' end, ', ', 
                case when PLUGIN_TYPE_CD is not null then '''' + PLUGIN_TYPE_CD + '''' else 'NULL' end, ', ', 
                case when CHECK_PARAM_ID is not null then cast(CHECK_PARAM_ID as varchar) else 'NULL' end, ', ', 
                case when FIELD_NAME is not null then '''' + FIELD_NAME + '''' else 'NULL' end,
                ' );' ) as SQL_STATEMENT
  from  ECMPS_AUX.dbo.CHECK_CATALOG_PLUGIN 

union all 
select  '' 
union all 
select  ''
union all 

-- RESPONSE_CATALOG
select  '-- RESPONSE_CATALOG'
union all
select  concat( 'insert into RESPONSE_CATALOG ( RESPONSE_CATALOG_ID, RESPONSE_CATALOG_DESCRIPTION, RESPONSE_TYPE_CD, RESPONSE_CATALOG_HEADER, SEVERITY_CD ) overriding system value values ( ', 
                case when RESPONSE_CATALOG_ID is not null then cast(RESPONSE_CATALOG_ID as varchar) else 'NULL' end, ', ', 
                case when RESPONSE_CATALOG_DESCRIPTION is not null then '''' + replace(RESPONSE_CATALOG_DESCRIPTION, '''', '''''') + '''' else 'NULL' end, ', ', 
                case when RESPONSE_TYPE_CD is not null then '''' + RESPONSE_TYPE_CD + '''' else 'NULL' end, ', ', 
                case when RESPONSE_CATALOG_HEADER is not null then '''' + replace(RESPONSE_CATALOG_HEADER, '''', '''''') + '''' else 'NULL' end, ', ', 
                case when SEVERITY_CD is not null then '''' + SEVERITY_CD + '''' else 'NULL' end,
                ' );' ) as SQL_STATEMENT
  from  ECMPS_AUX.dbo.RESPONSE_CATALOG

union all 
select  '' 
union all 
select  ''
union all 

-- CHECK_CATALOG_RESULT
select  '-- CHECK_CATALOG_RESULT'
union all
select  concat( 'insert into CHECK_CATALOG_RESULT ( CHECK_CATALOG_RESULT_ID, CHECK_CATALOG_ID, CHECK_RESULT, SEVERITY_CD, RESPONSE_CATALOG_ID, ES_ALLOWED_IND ) overriding system value values ( ', 
                case when CHECK_CATALOG_RESULT_ID is not null then cast(CHECK_CATALOG_RESULT_ID as varchar) else 'NULL' end, ', ', 
                case when CHECK_CATALOG_ID is not null then cast(CHECK_CATALOG_ID as varchar) else 'NULL' end, ', ', 
                case when CHECK_RESULT is not null then '''' + CHECK_RESULT + '''' else 'NULL' end, ', ', 
                case when SEVERITY_CD is not null then '''' + SEVERITY_CD + '''' else 'NULL' end, ', ', 
                case when RESPONSE_CATALOG_ID is not null then cast(RESPONSE_CATALOG_ID as varchar) else 'NULL' end, ', ', 
                case when ES_ALLOWED_IND is not null then '''' + cast(ES_ALLOWED_IND as varchar) + '''' else 'NULL' end,
                ' );' ) as SQL_STATEMENT
  from  ECMPS_AUX.dbo.CHECK_CATALOG_RESULT 

union all 
select  '' 
union all 
select  ''
union all 

-- CHECK_CATALOG_RESULT
select  '-- CHECK_CATALOG_RESULT'
union all
select  concat( 'insert into CHECK_CATALOG_RESULT ( CHECK_CATALOG_RESULT_ID, CHECK_CATALOG_ID, CHECK_RESULT, SEVERITY_CD, RESPONSE_CATALOG_ID, ES_ALLOWED_IND ) overriding system value values ( ', 
                case when CHECK_CATALOG_RESULT_ID is not null then cast(CHECK_CATALOG_RESULT_ID as varchar) else 'NULL' end, ', ', 
                case when CHECK_CATALOG_ID is not null then cast(CHECK_CATALOG_ID as varchar) else 'NULL' end, ', ', 
                case when CHECK_RESULT is not null then '''' + CHECK_RESULT + '''' else 'NULL' end, ', ', 
                case when SEVERITY_CD is not null then '''' + SEVERITY_CD + '''' else 'NULL' end, ', ', 
                case when RESPONSE_CATALOG_ID is not null then cast(RESPONSE_CATALOG_ID as varchar) else 'NULL' end, ', ', 
                case when ES_ALLOWED_IND is not null then '''' + cast(ES_ALLOWED_IND as varchar) + '''' else 'NULL' end,
                ' );' ) as SQL_STATEMENT
  from  ECMPS_AUX.dbo.CHECK_CATALOG_RESULT 

union all 
select  '' 
union all 
select  ''
union all 

-- RULE_CHECK
select  '-- RULE_CHECK'
union all
select  concat( 'insert into RULE_CHECK ( RULE_CHECK_ID, CATEGORY_CD, CHECK_CATALOG_ID ) overriding system value values ( ', 
                case when RULE_CHECK_ID is not null then cast(RULE_CHECK_ID as varchar) else 'NULL' end, ', ',
                case when CATEGORY_CD is not null then '''' + CATEGORY_CD + '''' else 'NULL' end, ', ', 
                case when CHECK_CATALOG_ID is not null then '''' + cast(CHECK_CATALOG_ID as varchar) + '''' else 'NULL' end,
                ' );' ) as SQL_STATEMENT
  from  ECMPS_AUX.dbo.RULE_CHECK 

union all 
select  '' 
union all 
select  ''
union all 

-- RULE_CHECK_CONDITION
select  '-- RULE_CHECK_CONDITION'
union all
select  concat( 'insert into RULE_CHECK_CONDITION ( RULE_CHECK_CONDITION_ID, RULE_CHECK_ID, AND_GROUP_NO, CHECK_PARAM_ID, CHECK_OPERATOR_CD, CHECK_CONDITION, NEGATION_IND ) overriding system value values ( ', 
                case when RULE_CHECK_CONDITION_ID is not null then cast(RULE_CHECK_CONDITION_ID as varchar) else 'NULL' end, ', ', 
                case when RULE_CHECK_ID is not null then cast(RULE_CHECK_ID as varchar) else 'NULL' end, ', ', 
                case when AND_GROUP_NO is not null then cast(AND_GROUP_NO as varchar) else 'NULL' end, ', ', 
                case when CHECK_PARAM_ID is not null then cast(CHECK_PARAM_ID as varchar) else 'NULL' end, ', ', 
                case when CHECK_OPERATOR_CD is not null then '''' + CHECK_OPERATOR_CD + '''' else 'NULL' end, ', ', 
                case when CHECK_CONDITION is not null then '''' + CHECK_CONDITION + '''' else 'NULL' end, ', ', 
                case when NEGATION_IND is not null then cast(NEGATION_IND as varchar) else 'NULL' end,
                ' );' ) as SQL_STATEMENT
  from  ECMPS_AUX.dbo.RULE_CHECK_CONDITION

union all 
select  '' 
union all 
select  ''
union all 

-- Commit Changes
select  '-- Commit Change' 
union all 
select  'commit;'
