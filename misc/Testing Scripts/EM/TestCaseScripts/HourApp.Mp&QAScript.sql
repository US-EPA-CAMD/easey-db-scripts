-- ORIS 641, Unit CS1BYP for 2021 Q2
CALL camdecmpswks.revert_to_official_record('APFREEMA1-6E91F2DB94D7472E8563954A02B71CEC');


-- ORIS 994, MS2B for 2021 Q3
CALL camdecmpswks.revert_to_official_record('MDC-90E96B0F4DF04903A5D16E51A6CD382A');

update camdecmpswks.monitor_method set end_date = null, end_hour = null where mon_method_id = 'PAULDESKTO-C3B0205CBA3B4835B901E11BFB1ADD77';
update camdecmpswks.monitor_formula set end_date = null, end_hour = null where mon_form_id = 'PAULDESKTO-D3C7A0A5631043CC8C55BD59F1C049DE';

insert into camdecmpswks.monitor_method ( mon_method_id, mon_loc_id, parameter_cd, sub_data_cd, bypass_approach_cd, method_cd, begin_date, begin_hour, end_date, end_hour, userid, add_date, update_date ) values ( 'CHV-SABER-8C32627B94144AC5B37FE06331C6B827', '581', 'HFRH', NULL, NULL, 'CALC', '2021-07-01', 0, NULL, NULL, 'esupport', '2022-08-17 11:18:02', NULL );
insert into camdecmpswks.monitor_formula ( mon_form_id, mon_loc_id, parameter_cd, equation_cd, formula_identifier, begin_date, begin_hour, end_date, end_hour, formula_equation, userid, add_date, update_date ) values ( 'CHV-SABER-8344F05589FD4D14B9DD8CD56312FB71', '581', 'HFRH', 'MS-1', 'AAA', '2021-07-01', 0, NULL, NULL, NULL, 'esupport', '2022-08-17 11:18:39', NULL ) ;


-- ORIS 2364, CS001 for 2021 Q3
CALL camdecmpswks.revert_to_official_record('QUINNLWL3A-5F9ED59A5F5B49B0ADF0BC5B5E81F265');

update camdecmpswks.monitor_method set end_date = '06/30/2021', end_hour = 23 where mon_method_id = 'CAMD-C782666A9CA34974A188109B54A12630';
insert into camdecmpswks.MONITOR_METHOD ( MON_METHOD_ID, MON_LOC_ID, PARAMETER_CD, SUB_DATA_CD, BYPASS_APPROACH_CD, METHOD_CD, BEGIN_DATE, BEGIN_HOUR, END_DATE, END_HOUR, USERID, ADD_DATE, UPDATE_DATE ) values ( 'CHV-SABER-6A76FAA0DA5048568A9072B2D96B479F', '1091', 'NOXR', 'SPTS', NULL, 'AE', '2021-07-01', 0, NULL, NULL, 'esupport', '2022-08-17 11:16:10', NULL );


-- ORIS 6071, MS-2A for 2021 Q4
CALL camdecmpswks.revert_to_official_record('PGGHNTPIEN-4E01D1B017104D1199455152FE1C105C');
