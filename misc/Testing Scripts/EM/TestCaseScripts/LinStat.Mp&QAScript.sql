-- ORIS 6177, Unit U2B for 2021 Q3
CALL camdecmpswks.revert_to_official_record('MDC-BFA54314FEC9414DA50989BCEABEC583');

insert 
  into  camdecmpswks.COMPONENT
        ( 
            COMPONENT_ID, MON_LOC_ID, COMPONENT_IDENTIFIER, MODEL_VERSION, SERIAL_NUMBER, MANUFACTURER, COMPONENT_TYPE_CD, ACQ_CD, BASIS_CD, HG_CONVERTER_IND, USERID, ADD_DATE, UPDATE_DATE
        )
values  ( 'CHV-SABER-CDEBAE650E874833925A0D72DF00A6C9', '2171', 'LK1', 'BBB', 'CCC', 'AAA', 'NOX', 'DIL', 'W', NULL, 'esupport', '2022-09-09 17:17:20', NULL );

insert 
  into  camdecmpswks.ANALYZER_RANGE ( ANALYZER_RANGE_ID, COMPONENT_ID, ANALYZER_RANGE_CD, DUAL_RANGE_IND, BEGIN_DATE, BEGIN_HOUR, END_DATE, END_HOUR, USERID, ADD_DATE, UPDATE_DATE )
values  ( 'CHV-SABER-67F02CCA646F459CA8A390CF07312931', 'CHV-SABER-CDEBAE650E874833925A0D72DF00A6C9', 'A', 1, '2021-09-26', 2, NULL, NULL, 'esupport', '2022-09-09 17:17:47', NULL ) on conflict (ANALYZER_RANGE_ID) do update set COMPONENT_ID = EXCLUDED.COMPONENT_ID, ANALYZER_RANGE_CD = EXCLUDED.ANALYZER_RANGE_CD, DUAL_RANGE_IND = EXCLUDED.DUAL_RANGE_IND, BEGIN_DATE = EXCLUDED.BEGIN_DATE, BEGIN_HOUR = EXCLUDED.BEGIN_HOUR, END_DATE = EXCLUDED.END_DATE, END_HOUR = EXCLUDED.END_HOUR, USERID = EXCLUDED.USERID, ADD_DATE = EXCLUDED.ADD_DATE, UPDATE_DATE = EXCLUDED.UPDATE_DATE;

insert
  into  camdecmpswks.MONITOR_SYSTEM_COMPONENT ( MON_SYS_COMP_ID, MON_SYS_ID, COMPONENT_ID, BEGIN_DATE, BEGIN_HOUR, END_DATE, END_HOUR, USERID, ADD_DATE, UPDATE_DATE )
values  ( 'CHV-SABER-42083992695F4F73AB33D0609BDBEAB1', 'KMMONTAL-5F0477BBBB63418A827A3AFED61812B9', 'CHV-SABER-CDEBAE650E874833925A0D72DF00A6C9', '2021-09-26', 2, NULL, NULL, 'esupport', '2022-09-09 17:18:12', NULL );

insert 
  into  camdecmpswks.QA_CERT_EVENT 
        ( 
            QA_CERT_EVENT_ID, MON_LOC_ID, MON_SYS_ID, COMPONENT_ID, 
            QA_CERT_EVENT_CD, QA_CERT_EVENT_DATE, QA_CERT_EVENT_HOUR, REQUIRED_TEST_CD, 
            CONDITIONAL_DATA_BEGIN_DATE, CONDITIONAL_DATA_BEGIN_HOUR, LAST_TEST_COMPLETED_DATE, LAST_TEST_COMPLETED_HOUR, 
            LAST_UPDATED, UPDATED_STATUS_FLG, NEEDS_EVAL_FLG, CHK_SESSION_ID, SUBMISSION_ID, SUBMISSION_AVAILABILITY_CD, 
            USERID, ADD_DATE, UPDATE_DATE 
        )
values  ( 
            'CHV-SABER-C0E96095272A44479813FAD15057AC87', '2171', NULL, 'KMMONTAL-52E205CBAB2F48A6BB9920C2864F5EFA', 
            '175', '2021-09-26', 1, '9', 
            '2021-09-26', 3, NULL, NULL, 
            '2022-09-09', 'Y', 'N', 'CHV-SABER-9D8E48B102EE4815917075F702253183', NULL, NULL, 
            'esupport', '2022-09-09 17:16:24', '2022-09-09 17:17:20'
        );


-- ORIS 880041, Unit X015 for 2021 Q4
CALL camdecmpswks.revert_to_official_record('MDC-EC0E1E1664394A6DB9DF0DBCFD5C93C1');

update camdecmpswks.monitor_span set end_date = '12/31/2021', end_hour = 22 where span_id = 'DECLRAYME-EB5D468B9595403BB9B2D00315C28B83';