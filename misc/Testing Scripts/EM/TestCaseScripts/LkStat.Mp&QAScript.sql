-- ORIS 6193, Unit 061B for 2021 Q4
CALL camdecmpswks.revert_to_official_record('MDC-519E245D136246FDBF31B1B2BA8AAD36');

delete from camdecmpswks.TEST_SUMMARY where TEST_SUM_ID = 'CHV-SABER-6AEEFB9929554C9A9389E241FEA06D1D';

insert 
  into  camdecmpswks.TEST_SUMMARY
        ( TEST_SUM_ID, MON_LOC_ID, TEST_TYPE_CD, TEST_NUM, MON_SYS_ID, COMPONENT_ID, GP_IND, TEST_REASON_CD, TEST_RESULT_CD, RPT_PERIOD_ID, BEGIN_DATE, BEGIN_HOUR, BEGIN_MIN, END_DATE, END_HOUR, END_MIN, SPAN_SCALE_CD, INJECTION_PROTOCOL_CD, TEST_COMMENT, TEST_DESCRIPTION, CALC_GP_IND, CALC_TEST_RESULT_CD, CALC_SPAN_VALUE, LAST_UPDATED, UPDATED_STATUS_FLG, NEEDS_EVAL_FLG, CHK_SESSION_ID, USERID, ADD_DATE, UPDATE_DATE )
values  ( 'CHV-SABER-6AEEFB9929554C9A9389E241FEA06D1D', '2182', 'LEAK', 'AAA', NULL, 'CAMD-F9878D7BC6F646F9AB0E3E14846558CA', 0, 'QA', 'FAILED', NULL, NULL, NULL, NULL, '2021-09-10', 0, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-09-14 11:07:16', 'Y', 'N', 'CHV-SABER-089CA86F99C141FAAB79E21C5BB8AD02', 'esupport', '2022-09-14 11:07:16', NULL );


-- ORIS 6193, Unit 062B for 2021 Q4
CALL camdecmpswks.revert_to_official_record('MDC-95170A4EC71440E2B533BF7082194FCC');

delete from camdecmpswks.qa_supp_data where qa_supp_data_id = '8N8GNN2-0A9508BFFC0144378D68FC13918979AD';
delete from camdecmpswks.operating_supp_data where op_supp_data_id = '8N8GNN2-E09341BD0D1D434B8AF2C3CF4222E295';


-- ORIS 10671, CS1, 1AUnit for 2021 Q4
CALL camdecmpswks.revert_to_official_record('ECG-0003-296AB4D76ECE49ACA9DA77494C813BBD');

delete from camdecmpswks.qa_supp_data where qa_supp_data_id = 'CEMS2351-2F32459CD1524BC488627C77A8FFCA6E';