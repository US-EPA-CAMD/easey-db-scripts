--camddmw_arch.ozone_unit_data_a
CREATE TABLE IF NOT EXISTS camddmw_arch.ozone_unit_data_a_dm_em_uo_2017 PARTITION OF camddmw_arch.ozone_unit_data_a
    FOR VALUES FROM ('2017') TO ('2018');
CREATE TABLE IF NOT EXISTS camddmw_arch.ozone_unit_data_a_dm_em_uo_2018 PARTITION OF camddmw_arch.ozone_unit_data_a
    FOR VALUES FROM ('2018') TO ('2019');

--camddmw_arch.annual_unit_data_a
CREATE TABLE IF NOT EXISTS camddmw_arch.annual_unit_data_a_dm_em_ua_2017 PARTITION OF camddmw_arch.annual_unit_data_a
    FOR VALUES FROM ('2017') TO ('2018');
CREATE TABLE IF NOT EXISTS camddmw_arch.annual_unit_data_a_dm_em_ua_2018 PARTITION OF camddmw_arch.annual_unit_data_a
    FOR VALUES FROM ('2018') TO ('2019');

--camddmw_arch.day_unit_data_a
CREATE TABLE IF NOT EXISTS camddmw_arch.day_unit_data_a_dm_em_ud_2017q1 PARTITION OF camddmw_arch.day_unit_data_a
    FOR VALUES FROM ('2017-01-01') TO ('2017-04-01');
CREATE TABLE IF NOT EXISTS camddmw_arch.day_unit_data_a_dm_em_ud_2017q2 PARTITION OF camddmw_arch.day_unit_data_a
    FOR VALUES FROM ('2017-04-01') TO ('2017-07-01');
CREATE TABLE IF NOT EXISTS camddmw_arch.day_unit_data_a_dm_em_ud_2017q3 PARTITION OF camddmw_arch.day_unit_data_a
    FOR VALUES FROM ('2017-07-01') TO ('2017-10-1');
CREATE TABLE IF NOT EXISTS camddmw_arch.day_unit_data_a_dm_em_ud_2017q4 PARTITION OF camddmw_arch.day_unit_data_a
    FOR VALUES FROM ('2017-10-01') TO ('2018-01-01');
CREATE TABLE IF NOT EXISTS camddmw_arch.day_unit_data_a_dm_em_ud_2018q1 PARTITION OF camddmw_arch.day_unit_data_a
    FOR VALUES FROM ('2018-01-01') TO ('2018-04-01');
CREATE TABLE IF NOT EXISTS camddmw_arch.day_unit_data_a_dm_em_ud_2018q2 PARTITION OF camddmw_arch.day_unit_data_a
    FOR VALUES FROM ('2018-04-01') TO ('2018-07-01');
CREATE TABLE IF NOT EXISTS camddmw_arch.day_unit_data_a_dm_em_ud_2018q3 PARTITION OF camddmw_arch.day_unit_data_a
    FOR VALUES FROM ('2018-07-01') TO ('2018-10-01');
CREATE TABLE IF NOT EXISTS camddmw_arch.day_unit_data_a_dm_em_ud_2018q4 PARTITION OF camddmw_arch.day_unit_data_a
    FOR VALUES FROM ('2018-10-01') TO ('2019-01-01');

--camddmw_arch.hour_unit_data_a
CREATE TABLE IF NOT EXISTS camddmw_arch.hour_unit_data_a_dm_em_uh_2017q1 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2017-01-01') TO ('2017-04-01');
CREATE TABLE IF NOT EXISTS camddmw_arch.hour_unit_data_a_dm_em_uh_2017q2 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2017-04-01') TO ('2017-07-01');
CREATE TABLE IF NOT EXISTS camddmw_arch.hour_unit_data_a_dm_em_uh_2017q3 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2017-07-01') TO ('2017-10-01');
CREATE TABLE IF NOT EXISTS camddmw_arch.hour_unit_data_a_dm_em_uh_2017q4 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2017-10-01') TO ('2018-01-01');
CREATE TABLE IF NOT EXISTS camddmw_arch.hour_unit_data_a_dm_em_uh_2018q1 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2018-01-01') TO ('2018-04-01');
CREATE TABLE IF NOT EXISTS camddmw_arch.hour_unit_data_a_dm_em_uh_2018q2 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2018-04-01') TO ('2018-07-01');
CREATE TABLE IF NOT EXISTS camddmw_arch.hour_unit_data_a_dm_em_uh_2018q3 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2018-07-01') TO ('2018-10-01');
CREATE TABLE IF NOT EXISTS camddmw_arch.hour_unit_data_a_dm_em_uh_2018q4 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2018-10-01') TO ('2019-01-01');

--camddmw_arch.hour_unit_mats_data_a
CREATE TABLE IF NOT EXISTS camddmw_arch.hour_unit_mats_data_a_dm_em_uh_2017q1 PARTITION OF camddmw_arch.hour_unit_mats_data_a
    FOR VALUES FROM ('2017-01-01') TO ('2017-04-01');
CREATE TABLE IF NOT EXISTS camddmw_arch.hour_unit_mats_data_a_dm_em_uh_2017q2 PARTITION OF camddmw_arch.hour_unit_mats_data_a
    FOR VALUES FROM ('2017-04-01') TO ('2017-07-01');
CREATE TABLE IF NOT EXISTS camddmw_arch.hour_unit_mats_data_a_dm_em_uh_2017q3 PARTITION OF camddmw_arch.hour_unit_mats_data_a
    FOR VALUES FROM ('2017-07-01') TO ('2017-10-01');
CREATE TABLE IF NOT EXISTS camddmw_arch.hour_unit_mats_data_a_dm_em_uh_2017q4 PARTITION OF camddmw_arch.hour_unit_mats_data_a
    FOR VALUES FROM ('2017-10-01') TO ('2018-01-01');
CREATE TABLE IF NOT EXISTS camddmw_arch.hour_unit_mats_data_a_dm_em_uh_2018q1 PARTITION OF camddmw_arch.hour_unit_mats_data_a
    FOR VALUES FROM ('2018-01-01') TO ('2018-04-01');
CREATE TABLE IF NOT EXISTS camddmw_arch.hour_unit_mats_data_a_dm_em_uh_2018q2 PARTITION OF camddmw_arch.hour_unit_mats_data_a
    FOR VALUES FROM ('2018-04-01') TO ('2018-07-01');
CREATE TABLE IF NOT EXISTS camddmw_arch.hour_unit_mats_data_a_dm_em_uh_2018q3 PARTITION OF camddmw_arch.hour_unit_mats_data_a
    FOR VALUES FROM ('2018-07-01') TO ('2018-10-01');
CREATE TABLE IF NOT EXISTS camddmw_arch.hour_unit_mats_data_a_dm_em_uh_2018q4 PARTITION OF camddmw_arch.hour_unit_mats_data_a
    FOR VALUES FROM ('2018-10-01') TO ('2019-01-01');

--camddmw_arch.month_unit_data_a
CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2017q1 PARTITION OF camddmw_arch.month_unit_data_a
	FOR VALUES FROM ('2016', '13') TO ('2017', '4');
CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2017q2 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2017', '4') TO ('2017', '7');
CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2017q3 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2017', '7') TO ('2017', '10');
CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2017q4 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2017', '10') TO ('2017', '13');
CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2018q1 PARTITION OF camddmw_arch.month_unit_data_a
	FOR VALUES FROM ('2017', '13') TO ('2018', '4');
CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2018q2 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2018', '4') TO ('2018', '7');
CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2018q3 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2018', '7') TO ('2018', '10');
CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2018q4 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2018', '10') TO ('2018', '13');

--camddmw_arch.quarter_unit_data_a
CREATE TABLE IF NOT EXISTS camddmw_arch.quarter_unit_data_a_dm_em_uq_2017q1 PARTITION OF camddmw_arch.quarter_unit_data_a
	FOR VALUES FROM ('2016', '5') TO ('2017', '2');
CREATE TABLE IF NOT EXISTS camddmw_arch.quarter_unit_data_a_dm_em_uq_2017q2 PARTITION OF camddmw_arch.quarter_unit_data_a
    FOR VALUES FROM ('2017', '2') TO ('2017', '3');
CREATE TABLE IF NOT EXISTS camddmw_arch.quarter_unit_data_a_dm_em_uq_2017q3 PARTITION OF camddmw_arch.quarter_unit_data_a
    FOR VALUES FROM ('2017', '3') TO ('2017', '4');
CREATE TABLE IF NOT EXISTS camddmw_arch.quarter_unit_data_a_dm_em_uq_2017q4 PARTITION OF camddmw_arch.quarter_unit_data_a
    FOR VALUES FROM ('2017', '4') TO ('2017', '5');
CREATE TABLE IF NOT EXISTS camddmw_arch.quarter_unit_data_a_dm_em_uq_2018q1 PARTITION OF camddmw_arch.quarter_unit_data_a
	FOR VALUES FROM ('2017', '5') TO ('2018', '2');
CREATE TABLE IF NOT EXISTS camddmw_arch.quarter_unit_data_a_dm_em_uq_2018q2 PARTITION OF camddmw_arch.quarter_unit_data_a
    FOR VALUES FROM ('2018', '2') TO ('2018', '3');
CREATE TABLE IF NOT EXISTS camddmw_arch.quarter_unit_data_a_dm_em_uq_2018q3 PARTITION OF camddmw_arch.quarter_unit_data_a
    FOR VALUES FROM ('2018', '3') TO ('2018', '4');
CREATE TABLE IF NOT EXISTS camddmw_arch.quarter_unit_data_a_dm_em_uq_2018q4 PARTITION OF camddmw_arch.quarter_unit_data_a
    FOR VALUES FROM ('2018', '4') TO ('2018', '5');

/*
RUN THIS AFTER PARTITIONS & DATA MOVED TO ARCHIVE
*/
--camddmw.ozone_unit_data
DROP TABLE camddmw.ozone_unit_data_dm_em_uo_2017;
DROP TABLE camddmw.ozone_unit_data_dm_em_uo_2018;

--camddmw.annual_unit_data
DROP TABLE camddmw.annual_unit_data_dm_em_ua_2017;
DROP TABLE camddmw.annual_unit_data_dm_em_ua_2018;

--camddmw.day_unit_data
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w01;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w02;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w03;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w04;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w05;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w06;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w07;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w08;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w09;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w10;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w11;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w12;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w13;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w14;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w15;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w16;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w17;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w18;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w19;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w20;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w21;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w22;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w23;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w24;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w25;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w26;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w27;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w28;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w29;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w30;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w31;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w32;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w33;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w34;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w35;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w36;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w37;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w38;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w39;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w40;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w41;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w42;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w43;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w44;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w45;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w46;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w47;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w48;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w49;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w50;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w51;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w52;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2017w53;

DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w01;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w02;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w03;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w04;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w05;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w06;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w07;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w08;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w09;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w10;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w11;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w12;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w13;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w14;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w15;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w16;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w17;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w18;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w19;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w20;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w21;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w22;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w23;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w24;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w25;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w26;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w27;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w28;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w29;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w30;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w31;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w32;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w33;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w34;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w35;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w36;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w37;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w38;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w39;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w40;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w41;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w42;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w43;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w44;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w45;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w46;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w47;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w48;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w49;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w50;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w51;
DROP TABLE camddmw.day_unit_data_dm_em_ud_2018w52;

--camddmw.hour_unit_data
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w01;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w02;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w03;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w04;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w05;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w06;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w07;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w08;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w09;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w10;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w11;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w12;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w13;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w14;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w15;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w16;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w17;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w18;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w19;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w20;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w21;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w22;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w23;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w24;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w25;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w26;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w27;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w28;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w29;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w30;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w31;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w32;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w33;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w34;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w35;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w36;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w37;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w38;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w39;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w40;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w41;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w42;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w43;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w44;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w45;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w46;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w47;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w48;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w49;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w50;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w51;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w52;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2017w53;

DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w01;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w02;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w03;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w04;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w05;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w06;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w07;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w08;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w09;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w10;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w11;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w12;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w13;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w14;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w15;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w16;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w17;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w18;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w19;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w20;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w21;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w22;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w23;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w24;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w25;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w26;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w27;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w28;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w29;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w30;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w31;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w32;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w33;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w34;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w35;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w36;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w37;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w38;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w39;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w40;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w41;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w42;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w43;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w44;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w45;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w46;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w47;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w48;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w49;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w50;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w51;
DROP TABLE camddmw.hour_unit_data_dm_em_uh_2018w52;

--camddmw.hour_unit_mats_data
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w01;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w02;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w03;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w04;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w05;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w06;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w07;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w08;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w09;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w10;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w11;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w12;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w13;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w14;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w15;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w16;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w17;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w18;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w19;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w20;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w21;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w22;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w23;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w24;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w25;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w26;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w27;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w28;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w29;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w30;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w31;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w32;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w33;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w34;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w35;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w36;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w37;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w38;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w39;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w40;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w41;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w42;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w43;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w44;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w45;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w46;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w47;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w48;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w49;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w50;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w51;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w52;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2017w53;

DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w01;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w02;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w03;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w04;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w05;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w06;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w07;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w08;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w09;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w10;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w11;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w12;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w13;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w14;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w15;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w16;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w17;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w18;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w19;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w20;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w21;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w22;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w23;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w24;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w25;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w26;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w27;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w28;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w29;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w30;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w31;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w32;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w33;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w34;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w35;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w36;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w37;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w38;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w39;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w40;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w41;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w42;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w43;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w44;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w45;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w46;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w47;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w48;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w49;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w50;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w51;
DROP TABLE camddmw.hour_unit_mats_data_dm_em_uh_mats_2018w52;

--camddmw.month_unit_data
DROP TABLE camddmw.month_unit_data_dm_em_um_2017m01;
DROP TABLE camddmw.month_unit_data_dm_em_um_2017m02;
DROP TABLE camddmw.month_unit_data_dm_em_um_2017m03;
DROP TABLE camddmw.month_unit_data_dm_em_um_2017m04;
DROP TABLE camddmw.month_unit_data_dm_em_um_2017m05;
DROP TABLE camddmw.month_unit_data_dm_em_um_2017m06;
DROP TABLE camddmw.month_unit_data_dm_em_um_2017m07;
DROP TABLE camddmw.month_unit_data_dm_em_um_2017m08;
DROP TABLE camddmw.month_unit_data_dm_em_um_2017m09;
DROP TABLE camddmw.month_unit_data_dm_em_um_2017m10;
DROP TABLE camddmw.month_unit_data_dm_em_um_2017m11;
DROP TABLE camddmw.month_unit_data_dm_em_um_2017m12;

DROP TABLE camddmw.month_unit_data_dm_em_um_2018m01;
DROP TABLE camddmw.month_unit_data_dm_em_um_2018m02;
DROP TABLE camddmw.month_unit_data_dm_em_um_2018m03;
DROP TABLE camddmw.month_unit_data_dm_em_um_2018m04;
DROP TABLE camddmw.month_unit_data_dm_em_um_2018m05;
DROP TABLE camddmw.month_unit_data_dm_em_um_2018m06;
DROP TABLE camddmw.month_unit_data_dm_em_um_2018m07;
DROP TABLE camddmw.month_unit_data_dm_em_um_2018m08;
DROP TABLE camddmw.month_unit_data_dm_em_um_2018m09;
DROP TABLE camddmw.month_unit_data_dm_em_um_2018m10;
DROP TABLE camddmw.month_unit_data_dm_em_um_2018m11;
DROP TABLE camddmw.month_unit_data_dm_em_um_2018m12;

--camddmw.quarter_unit_data
DROP TABLE camddmw.quarter_unit_data_dm_em_uq_2017q1;
DROP TABLE camddmw.quarter_unit_data_dm_em_uq_2017q2;
DROP TABLE camddmw.quarter_unit_data_dm_em_uq_2017q3;
DROP TABLE camddmw.quarter_unit_data_dm_em_uq_2017q4;

DROP TABLE camddmw.quarter_unit_data_dm_em_uq_2018q1;
DROP TABLE camddmw.quarter_unit_data_dm_em_uq_2018q2;
DROP TABLE camddmw.quarter_unit_data_dm_em_uq_2018q3;
DROP TABLE camddmw.quarter_unit_data_dm_em_uq_2018q4;
