-- CONFIGURATION_TYPE_CODE
insert into camdecmpsmd.CONFIGURATION_TYPE_CODE ( CONFIG_TYPE_CD, CONFIG_TYPE_CD_DESCRIPTION ) values ( 'COMMON', NULL );
insert into camdecmpsmd.CONFIGURATION_TYPE_CODE ( CONFIG_TYPE_CD, CONFIG_TYPE_CD_DESCRIPTION ) values ( 'COMPLEX', NULL );
insert into camdecmpsmd.CONFIGURATION_TYPE_CODE ( CONFIG_TYPE_CD, CONFIG_TYPE_CD_DESCRIPTION ) values ( 'MULTCOM', NULL );
insert into camdecmpsmd.CONFIGURATION_TYPE_CODE ( CONFIG_TYPE_CD, CONFIG_TYPE_CD_DESCRIPTION ) values ( 'MULTIPL', NULL );
insert into camdecmpsmd.CONFIGURATION_TYPE_CODE ( CONFIG_TYPE_CD, CONFIG_TYPE_CD_DESCRIPTION ) values ( 'SINGLE', NULL );


-- EVAL_SCORE_CODE
insert into camdecmpsmd.EVAL_SCORE_CODE ( EVAL_SCORE_CD, EVAL_SCORE_DESCRIPTION ) values ( '-1', 'Fatal Error' );
insert into camdecmpsmd.EVAL_SCORE_CODE ( EVAL_SCORE_CD, EVAL_SCORE_DESCRIPTION ) values ( '0', 'Critical Error Level 1' );
insert into camdecmpsmd.EVAL_SCORE_CODE ( EVAL_SCORE_CD, EVAL_SCORE_DESCRIPTION ) values ( '1', 'Critical Error Level 2' );
insert into camdecmpsmd.EVAL_SCORE_CODE ( EVAL_SCORE_CD, EVAL_SCORE_DESCRIPTION ) values ( '10', 'No Errors' );
insert into camdecmpsmd.EVAL_SCORE_CODE ( EVAL_SCORE_CD, EVAL_SCORE_DESCRIPTION ) values ( '2', 'Critical Error Level 3' );
insert into camdecmpsmd.EVAL_SCORE_CODE ( EVAL_SCORE_CD, EVAL_SCORE_DESCRIPTION ) values ( '3', 'Pretty bad' );
insert into camdecmpsmd.EVAL_SCORE_CODE ( EVAL_SCORE_CD, EVAL_SCORE_DESCRIPTION ) values ( '4', 'Bad' );
insert into camdecmpsmd.EVAL_SCORE_CODE ( EVAL_SCORE_CD, EVAL_SCORE_DESCRIPTION ) values ( '5', 'OK  I guess' );
insert into camdecmpsmd.EVAL_SCORE_CODE ( EVAL_SCORE_CD, EVAL_SCORE_DESCRIPTION ) values ( '6', 'Not too horrible' );
insert into camdecmpsmd.EVAL_SCORE_CODE ( EVAL_SCORE_CD, EVAL_SCORE_DESCRIPTION ) values ( '7', 'Passing, but still a C' );
insert into camdecmpsmd.EVAL_SCORE_CODE ( EVAL_SCORE_CD, EVAL_SCORE_DESCRIPTION ) values ( '8', 'Non-Critical Error' );
insert into camdecmpsmd.EVAL_SCORE_CODE ( EVAL_SCORE_CD, EVAL_SCORE_DESCRIPTION ) values ( '9', 'Information Message' );
insert into camdecmpsmd.EVAL_SCORE_CODE ( EVAL_SCORE_CD, EVAL_SCORE_DESCRIPTION ) values ( '-2', 'Eval Score Use is Obsolete (Report to DJW2)' );


-- SYSTEM_PARAMETER_NAME
insert into camdecmpsmd.SYSTEM_PARAMETER_NAME ( SYS_PARAM_NAME, SYS_PARAM_DESCRIPTION ) values ( 'ADD_EDIT_MESSAGES', 'Add/Edit Messages' );
insert into camdecmpsmd.SYSTEM_PARAMETER_NAME ( SYS_PARAM_NAME, SYS_PARAM_DESCRIPTION ) values ( 'CLIENT_SETTINGS', 'Client Settings' );
insert into camdecmpsmd.SYSTEM_PARAMETER_NAME ( SYS_PARAM_NAME, SYS_PARAM_DESCRIPTION ) values ( 'DB_PREFIX', 'Database prefix for this ECMPS Client Database' );
insert into camdecmpsmd.SYSTEM_PARAMETER_NAME ( SYS_PARAM_NAME, SYS_PARAM_DESCRIPTION ) values ( 'CAMD_CONTACT_INFO', 'CAMD''s contact information' );
insert into camdecmpsmd.SYSTEM_PARAMETER_NAME ( SYS_PARAM_NAME, SYS_PARAM_DESCRIPTION ) values ( 'HOST_SETTINGS', 'Host Settings' );
insert into camdecmpsmd.SYSTEM_PARAMETER_NAME ( SYS_PARAM_NAME, SYS_PARAM_DESCRIPTION ) values ( 'DB_SETTINGS', 'Database settings' );
insert into camdecmpsmd.SYSTEM_PARAMETER_NAME ( SYS_PARAM_NAME, SYS_PARAM_DESCRIPTION ) values ( 'REPORT_SETTINGS', 'Reports settings' );
insert into camdecmpsmd.SYSTEM_PARAMETER_NAME ( SYS_PARAM_NAME, SYS_PARAM_DESCRIPTION ) values ( 'PGVP_AETB_RULE_DATE', 'PGVP/AETB Rule date' );
insert into camdecmpsmd.SYSTEM_PARAMETER_NAME ( SYS_PARAM_NAME, SYS_PARAM_DESCRIPTION ) values ( 'EXPORT_SETTINGS', 'Export Settings' );
insert into camdecmpsmd.SYSTEM_PARAMETER_NAME ( SYS_PARAM_NAME, SYS_PARAM_DESCRIPTION ) values ( 'MATS_RULE', 'MATS Rule Parameters' );


-- SYSTEM_PARAMETER
insert into camdecmpsmd.SYSTEM_PARAMETER ( SYS_PARAM_ID, SYS_PARAM_NAME, PARAM_NAME1, PARAM_VALUE1, PARAM_NAME2, PARAM_VALUE2, PARAM_NAME3, PARAM_VALUE3, PARAM_NAME4, PARAM_VALUE4, PARAM_NAME5, PARAM_VALUE5, NOTES ) overriding system value values ( 1, 'CLIENT_SETTINGS', 'RequirePasswordFlg', '0', 'HostAutoLoginFlg', '1', NULL, NULL, NULL, NULL, NULL, NULL, 'The system settings for the ECMPS Client Tool' );
insert into camdecmpsmd.SYSTEM_PARAMETER ( SYS_PARAM_ID, SYS_PARAM_NAME, PARAM_NAME1, PARAM_VALUE1, PARAM_NAME2, PARAM_VALUE2, PARAM_NAME3, PARAM_VALUE3, PARAM_NAME4, PARAM_VALUE4, PARAM_NAME5, PARAM_VALUE5, NOTES ) overriding system value values ( 2, 'DB_SETTINGS', 'DatabasePrefix', 'CHV-DWHITTEN2', 'IsSharedDB', '0', 'UTC_Conversion', '1', NULL, NULL, NULL, NULL, 'The database settings for the Client Tool' );
insert into camdecmpsmd.SYSTEM_PARAMETER ( SYS_PARAM_ID, SYS_PARAM_NAME, PARAM_NAME1, PARAM_VALUE1, PARAM_NAME2, PARAM_VALUE2, PARAM_NAME3, PARAM_VALUE3, PARAM_NAME4, PARAM_VALUE4, PARAM_NAME5, PARAM_VALUE5, NOTES ) overriding system value values ( 3, 'ADD_EDIT_MESSAGES', 'AddNewStackPipe', 'Successfully inserted new Stack/Pipe record. You should now assign any associated Units.', 'DeleteSubmittedTest', 'Warning: Removing this test from your Client Tool will not remove the test record from the EPA Host System.', 'DeleteSubmittedTEE', 'This record cannot be deleted because it already has been submitted. Contact EPA for permission to delete this record.', 'DeleteSubmittedEvent', 'This record cannot be deleted because it already has been submitted. Contact EPA for permission to delete this record.', 'CantDeleteThing', 'You cannot remove this <thing> record.', 'Messages used by the Add/Edit procedures' );
insert into camdecmpsmd.SYSTEM_PARAMETER ( SYS_PARAM_ID, SYS_PARAM_NAME, PARAM_NAME1, PARAM_VALUE1, PARAM_NAME2, PARAM_VALUE2, PARAM_NAME3, PARAM_VALUE3, PARAM_NAME4, PARAM_VALUE4, PARAM_NAME5, PARAM_VALUE5, NOTES ) overriding system value values ( 4, 'CAMD_CONTACT_INFO', 'InitialUserProfile', 'If you do not have a CBS User Name and password, please contact {0} for assistance.', 'GeneralErrors', 'ECMPS Technical Support: (866) 470-0636', 'CAMD_Contacts', 'CAMD at CAMDForms@epa.gov', NULL, NULL, NULL, NULL, 'Messages with CAMD contact info' );
insert into camdecmpsmd.SYSTEM_PARAMETER ( SYS_PARAM_ID, SYS_PARAM_NAME, PARAM_NAME1, PARAM_VALUE1, PARAM_NAME2, PARAM_VALUE2, PARAM_NAME3, PARAM_VALUE3, PARAM_NAME4, PARAM_VALUE4, PARAM_NAME5, PARAM_VALUE5, NOTES ) overriding system value values ( 5, 'HOST_SETTINGS', 'ThisHost', 'ecmps.epa.gov/', 'EPA_Prod', 'ecmps.epa.gov/', 'EPA_Test', 'ecmps.epa.gov/ECMPST', NULL, NULL, NULL, NULL, NULL );
insert into camdecmpsmd.SYSTEM_PARAMETER ( SYS_PARAM_ID, SYS_PARAM_NAME, PARAM_NAME1, PARAM_VALUE1, PARAM_NAME2, PARAM_VALUE2, PARAM_NAME3, PARAM_VALUE3, PARAM_NAME4, PARAM_VALUE4, PARAM_NAME5, PARAM_VALUE5, NOTES ) overriding system value values ( 6, 'REPORT_SETTINGS', 'Hyperlink', 'http://ecmps.camdsupport.com/learn_docs.shtml?CHECK_CATALOG_ID=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL );
insert into camdecmpsmd.SYSTEM_PARAMETER ( SYS_PARAM_ID, SYS_PARAM_NAME, PARAM_NAME1, PARAM_VALUE1, PARAM_NAME2, PARAM_VALUE2, PARAM_NAME3, PARAM_VALUE3, PARAM_NAME4, PARAM_VALUE4, PARAM_NAME5, PARAM_VALUE5, NOTES ) overriding system value values ( 10, 'PGVP_AETB_RULE_DATE', 'RuleDate', '03/28/2011', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL );
insert into camdecmpsmd.SYSTEM_PARAMETER ( SYS_PARAM_ID, SYS_PARAM_NAME, PARAM_NAME1, PARAM_VALUE1, PARAM_NAME2, PARAM_VALUE2, PARAM_NAME3, PARAM_VALUE3, PARAM_NAME4, PARAM_VALUE4, PARAM_NAME5, PARAM_VALUE5, NOTES ) overriding system value values ( 11, 'EXPORT_SETTINGS', 'XSLT_Location_MP', 'http://ecmps.camdsupport.com/documents/ECMPS_MonitoringPlan.xslt', 'XSLT_Location_QA', NULL, 'XSLT_Location_EM', 'http://ecmps.camdsupport.com/documents/ECMPS_Emissions.xslt', NULL, NULL, NULL, NULL, 'Location of the XSLT files for the XML Transformations' );
insert into camdecmpsmd.SYSTEM_PARAMETER ( SYS_PARAM_ID, SYS_PARAM_NAME, PARAM_NAME1, PARAM_VALUE1, PARAM_NAME2, PARAM_VALUE2, PARAM_NAME3, PARAM_VALUE3, PARAM_NAME4, PARAM_VALUE4, PARAM_NAME5, PARAM_VALUE5, NOTES ) overriding system value values ( 12, 'MATS_RULE', 'ComplianceDeadline', '09/13/2015', 'DailyCalibrationRequiredDatehour', '09/13/2015 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL );


-- PARAMETER_METHOD_TO_FORMULA
insert into camdecmpsmd.PARAMETER_METHOD_TO_FORMULA ( PARAMETER_CD, METHOD_CD, SYSTEM_TYPE_LIST, ECMPS_ONLY, LOCATION_TYPE_LIST, FORMULA_LIST, NOT_FOUND_RESULT ) values ( 'CO2', 'AD', 'OILM,OILV,GAS', NULL, NULL, 'G-4A', 'C' );
insert into camdecmpsmd.PARAMETER_METHOD_TO_FORMULA ( PARAMETER_CD, METHOD_CD, SYSTEM_TYPE_LIST, ECMPS_ONLY, LOCATION_TYPE_LIST, FORMULA_LIST, NOT_FOUND_RESULT ) values ( 'CO2', 'CEM', NULL, NULL, NULL, 'F-2,F-11', 'A' );
insert into camdecmpsmd.PARAMETER_METHOD_TO_FORMULA ( PARAMETER_CD, METHOD_CD, SYSTEM_TYPE_LIST, ECMPS_ONLY, LOCATION_TYPE_LIST, FORMULA_LIST, NOT_FOUND_RESULT ) values ( 'CO2M', 'FSA', NULL, NULL, NULL, 'G-1', 'A' );
insert into camdecmpsmd.PARAMETER_METHOD_TO_FORMULA ( PARAMETER_CD, METHOD_CD, SYSTEM_TYPE_LIST, ECMPS_ONLY, LOCATION_TYPE_LIST, FORMULA_LIST, NOT_FOUND_RESULT ) values ( 'HCLRE', 'CEM', NULL, NULL, NULL, 'HC-2,HC-3', 'A' );
insert into camdecmpsmd.PARAMETER_METHOD_TO_FORMULA ( PARAMETER_CD, METHOD_CD, SYSTEM_TYPE_LIST, ECMPS_ONLY, LOCATION_TYPE_LIST, FORMULA_LIST, NOT_FOUND_RESULT ) values ( 'HCLRH', 'CEM', NULL, NULL, NULL, '19-1,19-2,19-3,19-3D,19-4,19-5,19-5D,19-6,19-7,19-8,19-9', 'A' );
insert into camdecmpsmd.PARAMETER_METHOD_TO_FORMULA ( PARAMETER_CD, METHOD_CD, SYSTEM_TYPE_LIST, ECMPS_ONLY, LOCATION_TYPE_LIST, FORMULA_LIST, NOT_FOUND_RESULT ) values ( 'HFRE', 'CEM', NULL, NULL, NULL, 'HF-2,HF-3', 'A' );
insert into camdecmpsmd.PARAMETER_METHOD_TO_FORMULA ( PARAMETER_CD, METHOD_CD, SYSTEM_TYPE_LIST, ECMPS_ONLY, LOCATION_TYPE_LIST, FORMULA_LIST, NOT_FOUND_RESULT ) values ( 'HFRH', 'CEM', NULL, NULL, NULL, '19-1,19-2,19-3,19-3D,19-4,19-5,19-5D,19-6,19-7,19-8,19-9', 'A' );
insert into camdecmpsmd.PARAMETER_METHOD_TO_FORMULA ( PARAMETER_CD, METHOD_CD, SYSTEM_TYPE_LIST, ECMPS_ONLY, LOCATION_TYPE_LIST, FORMULA_LIST, NOT_FOUND_RESULT ) values ( 'HGRE', 'CEM', NULL, NULL, NULL, 'A-2,A-3', 'A' );
insert into camdecmpsmd.PARAMETER_METHOD_TO_FORMULA ( PARAMETER_CD, METHOD_CD, SYSTEM_TYPE_LIST, ECMPS_ONLY, LOCATION_TYPE_LIST, FORMULA_LIST, NOT_FOUND_RESULT ) values ( 'HGRE', 'CEMST', NULL, NULL, NULL, 'A-2,A-3', 'A' );
insert into camdecmpsmd.PARAMETER_METHOD_TO_FORMULA ( PARAMETER_CD, METHOD_CD, SYSTEM_TYPE_LIST, ECMPS_ONLY, LOCATION_TYPE_LIST, FORMULA_LIST, NOT_FOUND_RESULT ) values ( 'HGRE', 'ST', NULL, NULL, NULL, 'A-3', 'A' );
insert into camdecmpsmd.PARAMETER_METHOD_TO_FORMULA ( PARAMETER_CD, METHOD_CD, SYSTEM_TYPE_LIST, ECMPS_ONLY, LOCATION_TYPE_LIST, FORMULA_LIST, NOT_FOUND_RESULT ) values ( 'HGRH', 'CEM', NULL, NULL, NULL, '19-1,19-2,19-3,19-3D,19-4,19-5,19-5D,19-6,19-7,19-8,19-9', 'A' );
insert into camdecmpsmd.PARAMETER_METHOD_TO_FORMULA ( PARAMETER_CD, METHOD_CD, SYSTEM_TYPE_LIST, ECMPS_ONLY, LOCATION_TYPE_LIST, FORMULA_LIST, NOT_FOUND_RESULT ) values ( 'HGRH', 'CEMST', NULL, NULL, NULL, '19-1,19-2,19-3,19-3D,19-4,19-5,19-5D,19-6,19-7,19-8,19-9', 'A' );
insert into camdecmpsmd.PARAMETER_METHOD_TO_FORMULA ( PARAMETER_CD, METHOD_CD, SYSTEM_TYPE_LIST, ECMPS_ONLY, LOCATION_TYPE_LIST, FORMULA_LIST, NOT_FOUND_RESULT ) values ( 'HGRH', 'ST', NULL, NULL, NULL, '19-1,19-5,19-5D,19-6,19-9', 'A' );
insert into camdecmpsmd.PARAMETER_METHOD_TO_FORMULA ( PARAMETER_CD, METHOD_CD, SYSTEM_TYPE_LIST, ECMPS_ONLY, LOCATION_TYPE_LIST, FORMULA_LIST, NOT_FOUND_RESULT ) values ( 'HI', 'AD', 'OILM,OILV,GAS', NULL, NULL, 'D-15A', 'C' );
insert into camdecmpsmd.PARAMETER_METHOD_TO_FORMULA ( PARAMETER_CD, METHOD_CD, SYSTEM_TYPE_LIST, ECMPS_ONLY, LOCATION_TYPE_LIST, FORMULA_LIST, NOT_FOUND_RESULT ) values ( 'HI', 'CALC', NULL, NULL, 'CS', 'F-25', 'A' );
insert into camdecmpsmd.PARAMETER_METHOD_TO_FORMULA ( PARAMETER_CD, METHOD_CD, SYSTEM_TYPE_LIST, ECMPS_ONLY, LOCATION_TYPE_LIST, FORMULA_LIST, NOT_FOUND_RESULT ) values ( 'HI', 'CALC', NULL, NULL, 'UB,UP', 'F-21A,F-21B,F-21C,F-21D', 'A' );
insert into camdecmpsmd.PARAMETER_METHOD_TO_FORMULA ( PARAMETER_CD, METHOD_CD, SYSTEM_TYPE_LIST, ECMPS_ONLY, LOCATION_TYPE_LIST, FORMULA_LIST, NOT_FOUND_RESULT ) values ( 'HI', 'CALC', NULL, NULL, 'US', 'F-21A,F-21B,F-21C', 'A' );
insert into camdecmpsmd.PARAMETER_METHOD_TO_FORMULA ( PARAMETER_CD, METHOD_CD, SYSTEM_TYPE_LIST, ECMPS_ONLY, LOCATION_TYPE_LIST, FORMULA_LIST, NOT_FOUND_RESULT ) values ( 'HI', 'CEM', NULL, NULL, NULL, 'F-15,F-16,F-17,F-18', 'A' );
insert into camdecmpsmd.PARAMETER_METHOD_TO_FORMULA ( PARAMETER_CD, METHOD_CD, SYSTEM_TYPE_LIST, ECMPS_ONLY, LOCATION_TYPE_LIST, FORMULA_LIST, NOT_FOUND_RESULT ) values ( 'NOX', 'NOXR', NULL, NULL, NULL, 'F-24A', 'A' );
insert into camdecmpsmd.PARAMETER_METHOD_TO_FORMULA ( PARAMETER_CD, METHOD_CD, SYSTEM_TYPE_LIST, ECMPS_ONLY, LOCATION_TYPE_LIST, FORMULA_LIST, NOT_FOUND_RESULT ) values ( 'NOXR', 'AE', 'NOXR', 'Yes', NULL, 'E-2', 'D' );
insert into camdecmpsmd.PARAMETER_METHOD_TO_FORMULA ( PARAMETER_CD, METHOD_CD, SYSTEM_TYPE_LIST, ECMPS_ONLY, LOCATION_TYPE_LIST, FORMULA_LIST, NOT_FOUND_RESULT ) values ( 'SO2', 'AD', 'OILM,OILV,GAS', 'Yes', NULL, 'D-12', 'C' );
insert into camdecmpsmd.PARAMETER_METHOD_TO_FORMULA ( PARAMETER_CD, METHOD_CD, SYSTEM_TYPE_LIST, ECMPS_ONLY, LOCATION_TYPE_LIST, FORMULA_LIST, NOT_FOUND_RESULT ) values ( 'SO2', 'F23', NULL, NULL, NULL, 'F-23', 'A' );
insert into camdecmpsmd.PARAMETER_METHOD_TO_FORMULA ( PARAMETER_CD, METHOD_CD, SYSTEM_TYPE_LIST, ECMPS_ONLY, LOCATION_TYPE_LIST, FORMULA_LIST, NOT_FOUND_RESULT ) values ( 'SO2RE', 'CEM', NULL, NULL, NULL, 'S-2,S-3', 'A' );
insert into camdecmpsmd.PARAMETER_METHOD_TO_FORMULA ( PARAMETER_CD, METHOD_CD, SYSTEM_TYPE_LIST, ECMPS_ONLY, LOCATION_TYPE_LIST, FORMULA_LIST, NOT_FOUND_RESULT ) values ( 'SO2RH', 'CEM', NULL, NULL, NULL, '19-1,19-2,19-3,19-3D,19-4,19-5,19-5D,19-6,19-7,19-8,19-9', 'A' );

-- COMMON_STACK_TEST_CODE
insert into camdecmpsmd.COMMON_STACK_TEST_CODE ( COMMON_STACK_TEST_CD, COMMON_STACK_TEST_CD_DESCRIPTION ) values ( 'AU', 'All Units Operating or Tested' );
insert into camdecmpsmd.COMMON_STACK_TEST_CODE ( COMMON_STACK_TEST_CD, COMMON_STACK_TEST_CD_DESCRIPTION ) values ( 'IU', 'Subset of Identical Units Tested' );
insert into camdecmpsmd.COMMON_STACK_TEST_CODE ( COMMON_STACK_TEST_CD, COMMON_STACK_TEST_CD_DESCRIPTION ) values ( 'NAUD', 'Not All Units Operating; Different Fuel Supplies' );
insert into camdecmpsmd.COMMON_STACK_TEST_CODE ( COMMON_STACK_TEST_CD, COMMON_STACK_TEST_CD_DESCRIPTION ) values ( 'NAUS', 'Not All Units Operating; Same Fuel Supply' );

-- GAS_COMPONENT_CODE
insert into camdecmpsmd.GAS_COMPONENT_CODE ( GAS_COMPONENT_CD, GAS_COMPONENT_DESCRIPTION, CAN_COMBINE_IND, BALANCE_COMPONENT_IND) values ( 'AIR', 'Purified air material', 0, 0 );
insert into camdecmpsmd.GAS_COMPONENT_CODE ( GAS_COMPONENT_CD, GAS_COMPONENT_DESCRIPTION, CAN_COMBINE_IND, BALANCE_COMPONENT_IND) values ( 'APPVD', 'Other EPA-approved EPA Protocol gas blend  ', 0, 0 );
insert into camdecmpsmd.GAS_COMPONENT_CODE ( GAS_COMPONENT_CD, GAS_COMPONENT_DESCRIPTION, CAN_COMBINE_IND, BALANCE_COMPONENT_IND) values ( 'BALA', 'Air Balance Gas', 1, 1 );
insert into camdecmpsmd.GAS_COMPONENT_CODE ( GAS_COMPONENT_CD, GAS_COMPONENT_DESCRIPTION, CAN_COMBINE_IND, BALANCE_COMPONENT_IND) values ( 'BALN', 'Nitrogen Balance Gas', 1, 1 );
insert into camdecmpsmd.GAS_COMPONENT_CODE ( GAS_COMPONENT_CD, GAS_COMPONENT_DESCRIPTION, CAN_COMBINE_IND, BALANCE_COMPONENT_IND) values ( 'CH4', 'Methane', 1, 0 );
insert into camdecmpsmd.GAS_COMPONENT_CODE ( GAS_COMPONENT_CD, GAS_COMPONENT_DESCRIPTION, CAN_COMBINE_IND, BALANCE_COMPONENT_IND) values ( 'CO', 'Carbon Monoxide ', 1, 0 );
insert into camdecmpsmd.GAS_COMPONENT_CODE ( GAS_COMPONENT_CD, GAS_COMPONENT_DESCRIPTION, CAN_COMBINE_IND, BALANCE_COMPONENT_IND) values ( 'CO2', 'Carbon Dioxide', 1, 0 );
insert into camdecmpsmd.GAS_COMPONENT_CODE ( GAS_COMPONENT_CD, GAS_COMPONENT_DESCRIPTION, CAN_COMBINE_IND, BALANCE_COMPONENT_IND) values ( 'GMIS', 'Gas manufacturer’s intermediate standard', 0, 0 );
insert into camdecmpsmd.GAS_COMPONENT_CODE ( GAS_COMPONENT_CD, GAS_COMPONENT_DESCRIPTION, CAN_COMBINE_IND, BALANCE_COMPONENT_IND) values ( 'H2S', 'Hydrogen Sulfide', 1, 0 );
insert into camdecmpsmd.GAS_COMPONENT_CODE ( GAS_COMPONENT_CD, GAS_COMPONENT_DESCRIPTION, CAN_COMBINE_IND, BALANCE_COMPONENT_IND) values ( 'HE', 'Helium', 1, 0 );
insert into camdecmpsmd.GAS_COMPONENT_CODE ( GAS_COMPONENT_CD, GAS_COMPONENT_DESCRIPTION, CAN_COMBINE_IND, BALANCE_COMPONENT_IND) values ( 'N2O', 'Nitrous Oxide', 1, 0 );
insert into camdecmpsmd.GAS_COMPONENT_CODE ( GAS_COMPONENT_CD, GAS_COMPONENT_DESCRIPTION, CAN_COMBINE_IND, BALANCE_COMPONENT_IND) values ( 'NO', 'Nitric Oxide', 1, 0 );
insert into camdecmpsmd.GAS_COMPONENT_CODE ( GAS_COMPONENT_CD, GAS_COMPONENT_DESCRIPTION, CAN_COMBINE_IND, BALANCE_COMPONENT_IND) values ( 'NO2', 'Nitrogen Dioxide', 1, 0 );
insert into camdecmpsmd.GAS_COMPONENT_CODE ( GAS_COMPONENT_CD, GAS_COMPONENT_DESCRIPTION, CAN_COMBINE_IND, BALANCE_COMPONENT_IND) values ( 'NOX', 'Total Oxides of Nitrogen', 1, 0 );
insert into camdecmpsmd.GAS_COMPONENT_CODE ( GAS_COMPONENT_CD, GAS_COMPONENT_DESCRIPTION, CAN_COMBINE_IND, BALANCE_COMPONENT_IND) values ( 'NTRM', 'NIST-traceable reference material', 0, 0 );
insert into camdecmpsmd.GAS_COMPONENT_CODE ( GAS_COMPONENT_CD, GAS_COMPONENT_DESCRIPTION, CAN_COMBINE_IND, BALANCE_COMPONENT_IND) values ( 'O2', 'Oxygen', 1, 0 );
insert into camdecmpsmd.GAS_COMPONENT_CODE ( GAS_COMPONENT_CD, GAS_COMPONENT_DESCRIPTION, CAN_COMBINE_IND, BALANCE_COMPONENT_IND) values ( 'PPN', 'Propane', 1, 0 );
insert into camdecmpsmd.GAS_COMPONENT_CODE ( GAS_COMPONENT_CD, GAS_COMPONENT_DESCRIPTION, CAN_COMBINE_IND, BALANCE_COMPONENT_IND) values ( 'PRM', 'SRM-equivalent compressed gas primary reference material', 0, 0 );
insert into camdecmpsmd.GAS_COMPONENT_CODE ( GAS_COMPONENT_CD, GAS_COMPONENT_DESCRIPTION, CAN_COMBINE_IND, BALANCE_COMPONENT_IND) values ( 'RGM', 'Research gas mixture', 0, 0 );
insert into camdecmpsmd.GAS_COMPONENT_CODE ( GAS_COMPONENT_CD, GAS_COMPONENT_DESCRIPTION, CAN_COMBINE_IND, BALANCE_COMPONENT_IND) values ( 'SO2', 'Sulfur Dioxide', 1, 0 );
insert into camdecmpsmd.GAS_COMPONENT_CODE ( GAS_COMPONENT_CD, GAS_COMPONENT_DESCRIPTION, CAN_COMBINE_IND, BALANCE_COMPONENT_IND) values ( 'SRM', 'Standard reference material', 0, 0 );
insert into camdecmpsmd.GAS_COMPONENT_CODE ( GAS_COMPONENT_CD, GAS_COMPONENT_DESCRIPTION, CAN_COMBINE_IND, BALANCE_COMPONENT_IND) values ( 'ZERO', 'Zero calibration gas', 0, 0 );

-- OP_DATE_CODE
insert into camdecmpsmd.OP_DATE_CODE ( OP_DATE_CD, OP_DATE_CD_DESCRIPTION) values ( 'A', 'Actual' );
insert into camdecmpsmd.OP_DATE_CODE ( OP_DATE_CD, OP_DATE_CD_DESCRIPTION) values ( 'P', 'Projected' );

-- TEST_FREQUENCY_CODE
insert into camdecmpsmd.TEST_FREQUENCY_CODE ( TEST_FREQUENCY_CD, TEST_FREQUENCY_CD_DESCRIPTION) values ( '2QTRS', 'Two Quarters' );
insert into camdecmpsmd.TEST_FREQUENCY_CODE ( TEST_FREQUENCY_CD, TEST_FREQUENCY_CD_DESCRIPTION) values ( '4QTRS', 'Four Quarters' );

-- BEGIN_END_HOUR_FLAG
insert into camdecmpsmd.BEGIN_END_HOUR_FLAG ( BEGIN_END_HOUR_FLG, BEGIN_END_HOUR_DESCRIPTION) values ( 'F', 'Final Hour' );
insert into camdecmpsmd.BEGIN_END_HOUR_FLAG ( BEGIN_END_HOUR_FLG, BEGIN_END_HOUR_DESCRIPTION) values ( 'I', 'Initial Hour' );
insert into camdecmpsmd.BEGIN_END_HOUR_FLAG ( BEGIN_END_HOUR_FLG, BEGIN_END_HOUR_DESCRIPTION) values ( 'N', 'Not Available' );
insert into camdecmpsmd.BEGIN_END_HOUR_FLAG ( BEGIN_END_HOUR_FLG, BEGIN_END_HOUR_DESCRIPTION) values ( 'T', 'Transition Hour' );

-- INDICATOR_CODE
insert into camdecmpsmd.INDICATOR_CODE ( INDICATOR_CD, INDICATOR_CD_DESCRIPTION) values ( 'E', 'Emergency' );
insert into camdecmpsmd.INDICATOR_CODE ( INDICATOR_CD, INDICATOR_CD_DESCRIPTION) values ( 'I', 'Ignition (Startup)' );
insert into camdecmpsmd.INDICATOR_CODE ( INDICATOR_CD, INDICATOR_CD_DESCRIPTION) values ( 'P', 'Primary' );
insert into camdecmpsmd.INDICATOR_CODE ( INDICATOR_CD, INDICATOR_CD_DESCRIPTION) values ( 'S', 'Secondary' );

-- EXEMPTION_TYPE_CODE
insert into camdecmpsmd.EXEMPTION_TYPE_CODE ( EXEMPT_TYPE_CD, EXEMPT_TYPE_CD_DESCRIPTION) values ( '25TON', '25 Ton Execption' );
insert into camdecmpsmd.EXEMPTION_TYPE_CODE ( EXEMPT_TYPE_CD, EXEMPT_TYPE_CD_DESCRIPTION) values ( 'NUE', 'New Unit Exemption' );
insert into camdecmpsmd.EXEMPTION_TYPE_CODE ( EXEMPT_TYPE_CD, EXEMPT_TYPE_CD_DESCRIPTION) values ( 'RUE', 'Retired Unit Exemption' );
insert into camdecmpsmd.EXEMPTION_TYPE_CODE ( EXEMPT_TYPE_CD, EXEMPT_TYPE_CD_DESCRIPTION) values ( 'RUE1', 'Retired Unit Exemption' );

-- OPERATING_STATUS_CODE
insert into camdecmpsmd.OPERATING_STATUS_CODE ( OP_STATUS_CD, OP_STATUS_CD_DESCRIPTION) values ( 'CAN', 'Cancelled' );
insert into camdecmpsmd.OPERATING_STATUS_CODE ( OP_STATUS_CD, OP_STATUS_CD_DESCRIPTION) values ( 'FUT', 'Future' );
insert into camdecmpsmd.OPERATING_STATUS_CODE ( OP_STATUS_CD, OP_STATUS_CD_DESCRIPTION) values ( 'OPR', 'Operating' );
insert into camdecmpsmd.OPERATING_STATUS_CODE ( OP_STATUS_CD, OP_STATUS_CD_DESCRIPTION) values ( 'RET', 'Retired' );
insert into camdecmpsmd.OPERATING_STATUS_CODE ( OP_STATUS_CD, OP_STATUS_CD_DESCRIPTION) values ( 'LTCS', 'Long-Term Cold Storage' );