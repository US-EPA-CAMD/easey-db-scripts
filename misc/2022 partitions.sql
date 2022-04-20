--camddmw.ozone_unit_data
CREATE TABLE IF NOT EXISTS camddmw.ozone_unit_data_dm_em_uo_2022 PARTITION OF camddmw.ozone_unit_data
    FOR VALUES FROM ('2022') TO ('2023');

--camddmw.annual_unit_data
CREATE TABLE IF NOT EXISTS camddmw.annual_unit_data_dm_em_ua_2022 PARTITION OF camddmw.annual_unit_data
    FOR VALUES FROM ('2022') TO ('2023');

--camddmw.day_unit_data FOR VALUES FROM ('2021-12-26') TO ('2022-01-02')
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w01 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-01-02') TO ('2022-01-09');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w02 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-01-09') TO ('2022-01-16');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w03 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-01-16') TO ('2022-01-23');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w04 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-01-23') TO ('2022-01-30');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w05 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-01-30') TO ('2022-02-06');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w06 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-02-06') TO ('2022-02-13');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w07 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-02-13') TO ('2022-02-20');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w08 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-02-20') TO ('2022-02-27');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w09 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-02-27') TO ('2022-03-06');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w10 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-03-06') TO ('2022-03-13');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w11 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-03-13') TO ('2022-03-20');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w12 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-03-20') TO ('2022-03-27');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w13 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-03-27') TO ('2022-04-03');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w14 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-04-03') TO ('2022-04-10');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w15 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-04-10') TO ('2022-04-17');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w16 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-04-17') TO ('2022-04-24');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w17 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-04-24') TO ('2022-05-01');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w18 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-05-01') TO ('2022-05-08');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w19 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-05-08') TO ('2022-05-15');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w20 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-05-15') TO ('2022-05-22');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w21 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-05-22') TO ('2022-05-29');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w22 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-05-29') TO ('2022-06-05');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w23 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-06-05') TO ('2022-06-12');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w24 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-06-12') TO ('2022-06-19');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w25 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-06-19') TO ('2022-06-26');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w26 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-06-26') TO ('2022-07-03');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w27 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-07-03') TO ('2022-07-10');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w28 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-07-10') TO ('2022-07-17');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w29 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-07-17') TO ('2022-07-24');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w30 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-07-24') TO ('2022-07-31');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w31 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-07-31') TO ('2022-08-07');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w32 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-08-07') TO ('2022-08-14');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w33 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-08-14') TO ('2022-08-21');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w34 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-08-21') TO ('2022-08-28');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w35 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-08-28') TO ('2022-09-04');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w36 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-09-04') TO ('2022-09-11');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w37 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-09-11') TO ('2022-09-18');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w38 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-09-18') TO ('2022-09-25');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w39 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-09-25') TO ('2022-10-02');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w40 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-10-02') TO ('2022-10-09');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w41 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-10-09') TO ('2022-10-16');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w42 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-10-16') TO ('2022-10-23');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w43 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-10-23') TO ('2022-10-30');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w44 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-10-30') TO ('2022-11-06');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w45 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-11-06') TO ('2022-11-13');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w46 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-11-13') TO ('2022-11-20');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w47 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-11-20') TO ('2022-11-27');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w48 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-11-27') TO ('2022-12-04');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w49 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-12-04') TO ('2022-12-11');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w50 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-12-11') TO ('2022-12-18');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w51 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-12-18') TO ('2022-12-25');
CREATE TABLE IF NOT EXISTS camddmw.day_unit_data_dm_em_ud_2022w52 PARTITION OF camddmw.day_unit_data FOR VALUES FROM ('2022-12-25') TO ('2023-01-01');

--camddmw.hour_unit_data FOR VALUES FROM ('2021-12-26') TO ('2022-01-02')
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w01 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-01-02') TO ('2022-01-09');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w02 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-01-09') TO ('2022-01-16');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w03 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-01-16') TO ('2022-01-23');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w04 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-01-23') TO ('2022-01-30');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w05 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-01-30') TO ('2022-02-06');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w06 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-02-06') TO ('2022-02-13');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w07 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-02-13') TO ('2022-02-20');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w08 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-02-20') TO ('2022-02-27');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w09 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-02-27') TO ('2022-03-06');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w10 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-03-06') TO ('2022-03-13');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w11 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-03-13') TO ('2022-03-20');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w12 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-03-20') TO ('2022-03-27');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w13 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-03-27') TO ('2022-04-03');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w14 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-04-03') TO ('2022-04-10');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w15 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-04-10') TO ('2022-04-17');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w16 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-04-17') TO ('2022-04-24');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w17 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-04-24') TO ('2022-05-01');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w18 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-05-01') TO ('2022-05-08');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w19 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-05-08') TO ('2022-05-15');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w20 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-05-15') TO ('2022-05-22');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w21 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-05-22') TO ('2022-05-29');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w22 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-05-29') TO ('2022-06-05');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w23 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-06-05') TO ('2022-06-12');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w24 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-06-12') TO ('2022-06-19');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w25 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-06-19') TO ('2022-06-26');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w26 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-06-26') TO ('2022-07-03');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w27 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-07-03') TO ('2022-07-10');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w28 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-07-10') TO ('2022-07-17');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w29 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-07-17') TO ('2022-07-24');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w30 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-07-24') TO ('2022-07-31');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w31 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-07-31') TO ('2022-08-07');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w32 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-08-07') TO ('2022-08-14');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w33 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-08-14') TO ('2022-08-21');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w34 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-08-21') TO ('2022-08-28');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w35 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-08-28') TO ('2022-09-04');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w36 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-09-04') TO ('2022-09-11');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w37 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-09-11') TO ('2022-09-18');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w38 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-09-18') TO ('2022-09-25');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w39 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-09-25') TO ('2022-10-02');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w40 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-10-02') TO ('2022-10-09');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w41 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-10-09') TO ('2022-10-16');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w42 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-10-16') TO ('2022-10-23');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w43 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-10-23') TO ('2022-10-30');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w44 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-10-30') TO ('2022-11-06');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w45 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-11-06') TO ('2022-11-13');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w46 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-11-13') TO ('2022-11-20');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w47 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-11-20') TO ('2022-11-27');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w48 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-11-27') TO ('2022-12-04');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w49 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-12-04') TO ('2022-12-11');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w50 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-12-11') TO ('2022-12-18');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w51 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-12-18') TO ('2022-12-25');
CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2022w52 PARTITION OF camddmw.hour_unit_data FOR VALUES FROM ('2022-12-25') TO ('2023-01-01');

--2022 ALREADY THERE
--camddmw.hour_unit_mats_data FOR VALUES FROM ('2021-12-26') TO ('2022-01-02')
--CREATE TABLE IF NOT EXISTS camddmw.hour_unit_mats_data_dm_em_uh_mats_2022w01 PARTITION OF camddmw.hour_unit_mats_data
--    FOR VALUES FROM ('2022-01-02') TO ('2022-01-09');
	
--camddmw.month_unit_data
CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2022m01 PARTITION OF camddmw.month_unit_data
	FOR VALUES FROM ('2021', '13') TO ('2022', '2');
CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2022m02 PARTITION OF camddmw.month_unit_data
	FOR VALUES FROM ('2022', '2') TO ('2022', '3');
CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2022m03 PARTITION OF camddmw.month_unit_data
	FOR VALUES FROM ('2022', '3') TO ('2022', '4');
CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2022m04 PARTITION OF camddmw.month_unit_data
	FOR VALUES FROM ('2022', '4') TO ('2022', '5');
CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2022m05 PARTITION OF camddmw.month_unit_data
	FOR VALUES FROM ('2022', '5') TO ('2022', '6');
CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2022m06 PARTITION OF camddmw.month_unit_data
	FOR VALUES FROM ('2022', '6') TO ('2022', '7');
CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2022m07 PARTITION OF camddmw.month_unit_data
	FOR VALUES FROM ('2022', '7') TO ('2022', '8');
CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2022m08 PARTITION OF camddmw.month_unit_data
	FOR VALUES FROM ('2022', '8') TO ('2022', '9');
CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2022m09 PARTITION OF camddmw.month_unit_data
	FOR VALUES FROM ('2022', '9') TO ('2022', '10');
CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2022m10 PARTITION OF camddmw.month_unit_data
	FOR VALUES FROM ('2022', '10') TO ('2022', '11');
CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2022m11 PARTITION OF camddmw.month_unit_data
	FOR VALUES FROM ('2022', '11') TO ('2022', '12');
CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2022m12 PARTITION OF camddmw.month_unit_data
	FOR VALUES FROM ('2022', '12') TO ('2022', '13');

--camddmw.quarter_unit_data
CREATE TABLE IF NOT EXISTS camddmw.quarter_unit_data_dm_em_uq_2022q1 PARTITION OF camddmw.quarter_unit_data
	FOR VALUES FROM ('2021', '5') TO ('2022', '2');
CREATE TABLE IF NOT EXISTS camddmw.quarter_unit_data_dm_em_uq_2022q2 PARTITION OF camddmw.quarter_unit_data
	FOR VALUES FROM ('2022', '2') TO ('2022', '3');
CREATE TABLE IF NOT EXISTS camddmw.quarter_unit_data_dm_em_uq_2022q3 PARTITION OF camddmw.quarter_unit_data
	FOR VALUES FROM ('2022', '3') TO ('2022', '4');
CREATE TABLE IF NOT EXISTS camddmw.quarter_unit_data_dm_em_uq_2022q4 PARTITION OF camddmw.quarter_unit_data
	FOR VALUES FROM ('2022', '4') TO ('2022', '5');
