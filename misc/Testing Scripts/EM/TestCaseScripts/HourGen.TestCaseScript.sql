/* ORIS:    404    Locations: 1          Quarter: 2021 Q1           Location:           SQL Ord:    0 */ call camdecmpswks.load_emissions_workspace( 'MDC-7743327CA4FB4B8CA6C0C656ECC4E1B8', 2021, 1 );
/* ORIS:    404    Locations: 1          Quarter: 2021 Q1           Location: 1         SQL Ord:   49 */ update camdecmpswks.DAILY_CALIBRATION tar set ONLINE_OFFLINE_IND             = 1,  UPSCALE_GAS_LEVEL_CD           = 'HIGH',  ZERO_INJECTION_DATE            = '2021-01-01',  ZERO_INJECTION_HOUR            = 6,  ZERO_INJECTION_MIN             = 23,  UPSCALE_INJECTION_DATE         = '2021-01-01',  UPSCALE_INJECTION_HOUR         = 6,  UPSCALE_INJECTION_MIN          = 20,  ZERO_MEASURED_VALUE            = 0.000,  UPSCALE_MEASURED_VALUE         = 22.500,  ZERO_APS_IND                   = 0,  UPSCALE_APS_IND                = 0,  ZERO_CAL_ERROR                 = 0.00,  UPSCALE_CAL_ERROR              = 0.10,  ZERO_REF_VALUE                 = 0.000,  UPSCALE_REF_VALUE              = 22.400,  UPSCALE_GAS_TYPE_CD            = 'O2,BALN',  CYLINDER_IDENTIFIER            = '!DT0018566',  EXPIRATION_DATE                = '2028-10-13',  RPT_PERIOD_ID                  = 113,  VENDOR_ID                      = 'F22020',  INJECTION_PROTOCOL_CD          = NULL,  USERID                         = 'UNITTEST',  UPDATE_DATE                    = '2023-02-27' where  exists ( select 1 from camdecmpswks.DAILY_TEST_SUMMARY dts where MON_LOC_ID = '255' and RPT_PERIOD_ID = 113 and TEST_TYPE_CD = 'DAYCAL' and coalesce( COMPONENT_ID, 'nothing' ) = 'CAMD-CB4DE2E525D145FD90C41B9AA36B23D8' and coalesce( MON_SYS_ID, 'nothing' ) = 'nothing' and DAILY_TEST_DATE = '2021-01-01' and DAILY_TEST_HOUR = 6 and DAILY_TEST_MIN = 23 and coalesce( SPAN_SCALE_CD, 'nothing' ) = 'H' and tar.DAILY_TEST_SUM_ID = dts.DAILY_TEST_SUM_ID );
/* ORIS:    404    Locations: 2          Quarter: 2022 Q2           Location:           SQL Ord:    0 */ call camdecmpswks.load_emissions_workspace( 'MDC-FCD7105F0619452A8B8E51AC625CB649', 2022, 2 );
/* ORIS:    856    Locations: 2          Quarter: 2021 Q4           Location:           SQL Ord:    0 */ call camdecmpswks.load_emissions_workspace( 'CLV2UA3431-665B4D63BCFB4936893A28A7751749E6', 2021, 4 );
/* ORIS:    856    Locations: 2          Quarter: 2021 Q4           Location: 2         SQL Ord:   48 */ insert into camdecmpswks.DAILY_TEST_SUMMARY ( DAILY_TEST_SUM_ID, RPT_PERIOD_ID, MON_LOC_ID, MON_SYS_ID, COMPONENT_ID, DAILY_TEST_DATE, DAILY_TEST_HOUR, DAILY_TEST_MIN, TEST_TYPE_CD, TEST_RESULT_CD, SPAN_SCALE_CD, USERID, ADD_DATE, UPDATE_DATE ) values ('UNITTEST-' || uuid_generate_v4(), 116, '456', NULL, 'CLV2UA3431-782B19A55EC744A8903B41FE7EEB7547', '2021-11-16', 11, 38, 'DAYCAL', 'PASSED', NULL, 'UNITTEST', '2023-02-27', NULL );
/* ORIS:    856    Locations: 2          Quarter: 2021 Q4           Location: 2         SQL Ord:   48 */ insert into camdecmpswks.DAILY_TEST_SUMMARY ( DAILY_TEST_SUM_ID, RPT_PERIOD_ID, MON_LOC_ID, MON_SYS_ID, COMPONENT_ID, DAILY_TEST_DATE, DAILY_TEST_HOUR, DAILY_TEST_MIN, TEST_TYPE_CD, TEST_RESULT_CD, SPAN_SCALE_CD, USERID, ADD_DATE, UPDATE_DATE ) values ('UNITTEST-' || uuid_generate_v4(), 116, '456', NULL, 'CLV2UA3431-782B19A55EC744A8903B41FE7EEB7547', '2021-11-16', 11, 39, 'INTCHK', 'PASSED', NULL, 'UNITTEST', '2023-02-27', NULL );
/* ORIS:    856    Locations: 2          Quarter: 2021 Q4           Location: 2         SQL Ord:   50 */ insert into camdecmpswks.DAILY_CALIBRATION ( CAL_INJ_ID, DAILY_TEST_SUM_ID, ONLINE_OFFLINE_IND, UPSCALE_GAS_LEVEL_CD, ZERO_INJECTION_DATE, ZERO_INJECTION_HOUR, ZERO_INJECTION_MIN, UPSCALE_INJECTION_DATE, UPSCALE_INJECTION_HOUR, UPSCALE_INJECTION_MIN, ZERO_MEASURED_VALUE, UPSCALE_MEASURED_VALUE, ZERO_APS_IND, UPSCALE_APS_IND, ZERO_CAL_ERROR, UPSCALE_CAL_ERROR, ZERO_REF_VALUE, UPSCALE_REF_VALUE, UPSCALE_GAS_TYPE_CD, CYLINDER_IDENTIFIER, EXPIRATION_DATE, RPT_PERIOD_ID, VENDOR_ID, INJECTION_PROTOCOL_CD, USERID, ADD_DATE, UPDATE_DATE ) values ('UNITTEST-' || uuid_generate_v4(),  (  select dts.DAILY_TEST_SUM_ID from camdecmpswks.DAILY_TEST_SUMMARY dts where dts.MON_LOC_ID = '456' and dts.RPT_PERIOD_ID = 116 and dts.TEST_TYPE_CD = 'DAYCAL' and coalesce( dts.COMPONENT_ID, 'nothing' ) = 'CLV2UA3431-782B19A55EC744A8903B41FE7EEB7547' and coalesce( dts.MON_SYS_ID, 'nothing' ) = 'nothing' and dts.DAILY_TEST_DATE = '2021-11-16' and dts.DAILY_TEST_HOUR = 11 and dts.DAILY_TEST_MIN = 38 and coalesce( dts.SPAN_SCALE_CD, 'nothing' ) = 'nothing' ), 0, 'HIGH', '2021-11-16', 11, 34, '2021-11-16', 11, 38, -1.700, 838.200, 0, 0, 0.10, 0.10, 0.000, 840.000, NULL, NULL, NULL, 116, NULL, NULL, 'UNITTEST', '2023-02-27', NULL );
/* ORIS:   1305    Locations: CP001,     Quarter: 2022 Q2           Location:           SQL Ord:    0 */ call camdecmpswks.load_emissions_workspace( 'BPU094-545C837365784BE781EDECEAA08626A3', 2022, 2 );
/* ORIS:   1571    Locations: **GT3      Quarter: 2021 Q4           Location:           SQL Ord:    0 */ call camdecmpswks.load_emissions_workspace( 'MDC-C6D0A708A1804B74B25A2A8EBB0E46A9', 2021, 4 );
/* ORIS:   1571    Locations: **GT3      Quarter: 2021 Q4           Location: **GT3     SQL Ord:   11 */ delete from camdecmpswks.LONG_TERM_FUEL_FLOW where MON_LOC_ID = '843' and RPT_PERIOD_ID = 116 and MON_SYS_ID = 'MOC49Q90P1-BF9E0D9B138548F39777B02D8A99855E' and FUEL_FLOW_PERIOD_CD = '';
/* ORIS:   1571    Locations: **GT3      Quarter: 2021 Q4           Location: **GT3     SQL Ord:   11 */ delete from camdecmpswks.LONG_TERM_FUEL_FLOW where MON_LOC_ID = '843' and RPT_PERIOD_ID = 116 and MON_SYS_ID = 'MOC49Q90P1-EF4D1326B61D4A1CA0A6A336950976AC' and FUEL_FLOW_PERIOD_CD = '';
/* ORIS:   1678    Locations: CP1, 1,    Quarter: 2021 Q4           Location:           SQL Ord:    0 */ call camdecmpswks.load_emissions_workspace( 'DSGTRMSVR-F0FB3BF26F6143B89C80025014295D52', 2021, 4 );
/* ORIS:   2480    Locations: 3          Quarter: 2021 Q3           Location:           SQL Ord:    0 */ call camdecmpswks.load_emissions_workspace( 'MDC-AFF7F20EE3084D2F9F88B45361C73664', 2021, 3 );
/* ORIS:   6112    Locations: 3          Quarter: 2021 Q4           Location:           SQL Ord:    0 */ call camdecmpswks.load_emissions_workspace( '7TD4FC1-79B513C9566547F1A27CED1A308C8EFF', 2021, 4 );