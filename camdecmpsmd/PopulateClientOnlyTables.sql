-- CONFIGURATION_TYPE_CODE
insert into CONFIGURATION_TYPE_CODE ( CONFIG_TYPE_CD, CONFIG_TYPE_CD_DESCRIPTION ) values ( 'COMMON', NULL );
insert into CONFIGURATION_TYPE_CODE ( CONFIG_TYPE_CD, CONFIG_TYPE_CD_DESCRIPTION ) values ( 'COMPLEX', NULL );
insert into CONFIGURATION_TYPE_CODE ( CONFIG_TYPE_CD, CONFIG_TYPE_CD_DESCRIPTION ) values ( 'MULTCOM', NULL );
insert into CONFIGURATION_TYPE_CODE ( CONFIG_TYPE_CD, CONFIG_TYPE_CD_DESCRIPTION ) values ( 'MULTIPL', NULL );
insert into CONFIGURATION_TYPE_CODE ( CONFIG_TYPE_CD, CONFIG_TYPE_CD_DESCRIPTION ) values ( 'SINGLE', NULL );


-- EVAL_SCORE_CODE
insert into EVAL_SCORE_CODE ( EVAL_SCORE_CD, EVAL_SCORE_DESCRIPTION ) values ( '-1', 'Fatal Error' );
insert into EVAL_SCORE_CODE ( EVAL_SCORE_CD, EVAL_SCORE_DESCRIPTION ) values ( '0', 'Critical Error Level 1' );
insert into EVAL_SCORE_CODE ( EVAL_SCORE_CD, EVAL_SCORE_DESCRIPTION ) values ( '1', 'Critical Error Level 2' );
insert into EVAL_SCORE_CODE ( EVAL_SCORE_CD, EVAL_SCORE_DESCRIPTION ) values ( '10', 'No Errors' );
insert into EVAL_SCORE_CODE ( EVAL_SCORE_CD, EVAL_SCORE_DESCRIPTION ) values ( '2', 'Critical Error Level 3' );
insert into EVAL_SCORE_CODE ( EVAL_SCORE_CD, EVAL_SCORE_DESCRIPTION ) values ( '3', 'Pretty bad' );
insert into EVAL_SCORE_CODE ( EVAL_SCORE_CD, EVAL_SCORE_DESCRIPTION ) values ( '4', 'Bad' );
insert into EVAL_SCORE_CODE ( EVAL_SCORE_CD, EVAL_SCORE_DESCRIPTION ) values ( '5', 'OK  I guess' );
insert into EVAL_SCORE_CODE ( EVAL_SCORE_CD, EVAL_SCORE_DESCRIPTION ) values ( '6', 'Not too horrible' );
insert into EVAL_SCORE_CODE ( EVAL_SCORE_CD, EVAL_SCORE_DESCRIPTION ) values ( '7', 'Passing, but still a C' );
insert into EVAL_SCORE_CODE ( EVAL_SCORE_CD, EVAL_SCORE_DESCRIPTION ) values ( '8', 'Non-Critical Error' );
insert into EVAL_SCORE_CODE ( EVAL_SCORE_CD, EVAL_SCORE_DESCRIPTION ) values ( '9', 'Information Message' );
insert into EVAL_SCORE_CODE ( EVAL_SCORE_CD, EVAL_SCORE_DESCRIPTION ) values ( '-2', 'Eval Score Use is Obsolete (Report to DJW2)' );


-- SYSTEM_PARAMETER_NAME
insert into SYSTEM_PARAMETER_NAME ( SYS_PARAM_NAME, SYS_PARAM_DESCRIPTION ) values ( 'ADD_EDIT_MESSAGES', 'Add/Edit Messages' );
insert into SYSTEM_PARAMETER_NAME ( SYS_PARAM_NAME, SYS_PARAM_DESCRIPTION ) values ( 'CLIENT_SETTINGS', 'Client Settings' );
insert into SYSTEM_PARAMETER_NAME ( SYS_PARAM_NAME, SYS_PARAM_DESCRIPTION ) values ( 'DB_PREFIX', 'Database prefix for this ECMPS Client Database' );
insert into SYSTEM_PARAMETER_NAME ( SYS_PARAM_NAME, SYS_PARAM_DESCRIPTION ) values ( 'CAMD_CONTACT_INFO', 'CAMD''s contact information' );
insert into SYSTEM_PARAMETER_NAME ( SYS_PARAM_NAME, SYS_PARAM_DESCRIPTION ) values ( 'HOST_SETTINGS', 'Host Settings' );
insert into SYSTEM_PARAMETER_NAME ( SYS_PARAM_NAME, SYS_PARAM_DESCRIPTION ) values ( 'DB_SETTINGS', 'Database settings' );
insert into SYSTEM_PARAMETER_NAME ( SYS_PARAM_NAME, SYS_PARAM_DESCRIPTION ) values ( 'REPORT_SETTINGS', 'Reports settings' );
insert into SYSTEM_PARAMETER_NAME ( SYS_PARAM_NAME, SYS_PARAM_DESCRIPTION ) values ( 'PGVP_AETB_RULE_DATE', 'PGVP/AETB Rule date' );
insert into SYSTEM_PARAMETER_NAME ( SYS_PARAM_NAME, SYS_PARAM_DESCRIPTION ) values ( 'EXPORT_SETTINGS', 'Export Settings' );
insert into SYSTEM_PARAMETER_NAME ( SYS_PARAM_NAME, SYS_PARAM_DESCRIPTION ) values ( 'MATS_RULE', 'MATS Rule Parameters' );


-- SYSTEM_PARAMETER
insert into SYSTEM_PARAMETER ( SYS_PARAM_ID, SYS_PARAM_NAME, PARAM_NAME1, PARAM_VALUE1, PARAM_NAME2, PARAM_VALUE2, PARAM_NAME3, PARAM_VALUE3, PARAM_NAME4, PARAM_VALUE4, PARAM_NAME5, PARAM_VALUE5, NOTES ) overriding system value values ( 1, 'CLIENT_SETTINGS', 'RequirePasswordFlg', '0', 'HostAutoLoginFlg', '1', NULL, NULL, NULL, NULL, NULL, NULL, 'The system settings for the ECMPS Client Tool' );
insert into SYSTEM_PARAMETER ( SYS_PARAM_ID, SYS_PARAM_NAME, PARAM_NAME1, PARAM_VALUE1, PARAM_NAME2, PARAM_VALUE2, PARAM_NAME3, PARAM_VALUE3, PARAM_NAME4, PARAM_VALUE4, PARAM_NAME5, PARAM_VALUE5, NOTES ) overriding system value values ( 2, 'DB_SETTINGS', 'DatabasePrefix', 'CHV-DWHITTEN', 'IsSharedDB', '0', 'UTC_Conversion', '1', NULL, NULL, NULL, NULL, 'The database settings for the Client Tool' );
insert into SYSTEM_PARAMETER ( SYS_PARAM_ID, SYS_PARAM_NAME, PARAM_NAME1, PARAM_VALUE1, PARAM_NAME2, PARAM_VALUE2, PARAM_NAME3, PARAM_VALUE3, PARAM_NAME4, PARAM_VALUE4, PARAM_NAME5, PARAM_VALUE5, NOTES ) overriding system value values ( 3, 'ADD_EDIT_MESSAGES', 'AddNewStackPipe', 'Successfully inserted new Stack/Pipe record. You should now assign any associated Units.', 'DeleteSubmittedTest', 'Warning: Removing this test from your Client Tool will not remove the test record from the EPA Host System.', 'DeleteSubmittedTEE', 'This record cannot be deleted because it already has been submitted. Contact EPA for permission to delete this record.', 'DeleteSubmittedEvent', 'This record cannot be deleted because it already has been submitted. Contact EPA for permission to delete this record.', 'CantDeleteThing', 'You cannot remove this <thing> record.', 'Messages used by the Add/Edit procedures' );
insert into SYSTEM_PARAMETER ( SYS_PARAM_ID, SYS_PARAM_NAME, PARAM_NAME1, PARAM_VALUE1, PARAM_NAME2, PARAM_VALUE2, PARAM_NAME3, PARAM_VALUE3, PARAM_NAME4, PARAM_VALUE4, PARAM_NAME5, PARAM_VALUE5, NOTES ) overriding system value values ( 4, 'CAMD_CONTACT_INFO', 'InitialUserProfile', 'If you do not have a CBS User Name and password, please contact {0} for assistance.', 'GeneralErrors', 'ECMPS Technical Support: (866) 470-0636', 'CAMD_Contacts', 'Karen VanSickle (202) 343-9220 or Paula Branch (202) 343-9168', NULL, NULL, NULL, NULL, 'Messages with CAMD contact info' );
insert into SYSTEM_PARAMETER ( SYS_PARAM_ID, SYS_PARAM_NAME, PARAM_NAME1, PARAM_VALUE1, PARAM_NAME2, PARAM_VALUE2, PARAM_NAME3, PARAM_VALUE3, PARAM_NAME4, PARAM_VALUE4, PARAM_NAME5, PARAM_VALUE5, NOTES ) overriding system value values ( 5, 'HOST_SETTINGS', 'ThisHost', 'ecmps.epa.gov/', 'EPA_Prod', 'ecmps.epa.gov/', 'EPA_Test', 'ecmps.epa.gov/ECMPST', NULL, NULL, NULL, NULL, NULL );
insert into SYSTEM_PARAMETER ( SYS_PARAM_ID, SYS_PARAM_NAME, PARAM_NAME1, PARAM_VALUE1, PARAM_NAME2, PARAM_VALUE2, PARAM_NAME3, PARAM_VALUE3, PARAM_NAME4, PARAM_VALUE4, PARAM_NAME5, PARAM_VALUE5, NOTES ) overriding system value values ( 6, 'REPORT_SETTINGS', 'Hyperlink', 'http://ecmps.camdsupport.com/learn_docs.shtml?CHECK_CATALOG_ID=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL );
insert into SYSTEM_PARAMETER ( SYS_PARAM_ID, SYS_PARAM_NAME, PARAM_NAME1, PARAM_VALUE1, PARAM_NAME2, PARAM_VALUE2, PARAM_NAME3, PARAM_VALUE3, PARAM_NAME4, PARAM_VALUE4, PARAM_NAME5, PARAM_VALUE5, NOTES ) overriding system value values ( 10, 'PGVP_AETB_RULE_DATE', 'RuleDate', '03/28/2011', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL );
insert into SYSTEM_PARAMETER ( SYS_PARAM_ID, SYS_PARAM_NAME, PARAM_NAME1, PARAM_VALUE1, PARAM_NAME2, PARAM_VALUE2, PARAM_NAME3, PARAM_VALUE3, PARAM_NAME4, PARAM_VALUE4, PARAM_NAME5, PARAM_VALUE5, NOTES ) overriding system value values ( 11, 'EXPORT_SETTINGS', 'XSLT_Location_MP', 'http://ecmps.camdsupport.com/documents/ECMPS_MonitoringPlan.xslt', 'XSLT_Location_QA', NULL, 'XSLT_Location_EM', 'http://ecmps.camdsupport.com/documents/ECMPS_Emissions.xslt', NULL, NULL, NULL, NULL, 'Location of the XSLT files for the XML Transformations' );
insert into SYSTEM_PARAMETER ( SYS_PARAM_ID, SYS_PARAM_NAME, PARAM_NAME1, PARAM_VALUE1, PARAM_NAME2, PARAM_VALUE2, PARAM_NAME3, PARAM_VALUE3, PARAM_NAME4, PARAM_VALUE4, PARAM_NAME5, PARAM_VALUE5, NOTES ) overriding system value values ( 12, 'MATS_RULE', 'ComplianceDeadline', '09/13/2015', 'DailyCalibrationRequiredDatehour', '09/13/2015 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL );
