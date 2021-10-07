--------------------------------------------------
-- PROGRAM CODE UPDATES 
--------------------------------------------------
ALTER TABLE camdmd.program_code
    ADD COLUMN emissions_ui_filter numeric(1,0) NOT NULL DEFAULT 0;

ALTER TABLE camdmd.program_code
    ADD COLUMN allowance_ui_filter numeric(1,0) NOT NULL DEFAULT 0;

ALTER TABLE camdmd.program_code
    ADD COLUMN compliance_ui_filter numeric(1,0) NOT NULL DEFAULT 0;

ALTER TABLE camdmd.program_code
    ADD COLUMN rue_ind numeric(1,0) NOT NULL DEFAULT 0;

ALTER TABLE camdmd.program_code
    ADD COLUMN so2_cert_ind numeric(1,0) NOT NULL DEFAULT 0;

ALTER TABLE camdmd.program_code
    ADD COLUMN nox_cert_ind numeric(1,0) NOT NULL DEFAULT 0;

ALTER TABLE camdmd.program_code
    ADD COLUMN noxc_cert_ind numeric(1,0) NOT NULL DEFAULT 0;

ALTER TABLE camdmd.program_code
    ADD COLUMN notes character varying(1000) NOT NULL DEFAULT 0;

update camdmd.program_code
set emissions_ui_filter = 1
where prg_cd not in ('MATS');

update camdmd.program_code
set allowance_ui_filter = 1
where prg_cd not in ('MATS', 'NHNOX', 'NSPS4T', 'RGGI', 'SIPNOX');

update camdmd.program_code
set compliance_ui_filter = 1
where prg_cd in ('ARP', 'CSNOX', 'CSOSG1', 'CSOSG2', 'CSOSG3', 'CSSO2G1', 'CSSO2G2', 'TXSO2', 'CSNOXOS');

update camdmd.program_code
set trading_end_date = '2003-05-06',
penalty_factor = 3,
first_comp_year = 1999,
comp_parameter_cd = 'NOX',
notes = 'OTC is not treated as a OS program in ECMPS'
where prg_cd = 'OTC';

update camdmd.program_code
set trading_end_date = '2009-03-25',
penalty_factor = 3,
first_comp_year = 2003,
comp_parameter_cd = 'NOX'
where prg_cd = 'NBP';

update camdmd.program_code
set first_comp_year = 2009
where prg_cd = 'CAIRNOX';

update camdmd.program_code
set first_comp_year = 2010
where prg_cd = 'CAIRSO2';

update camdmd.program_code
set notes = 'SIPNOX is treated as a OS program in ECMPS'
where prg_cd = 'SIPNOX';

update camdmd.program_code
set rue_ind = 1
where prg_cd in ('ARP', 'CAIRNOX', 'CAIROS', 'CAIRSO2', 'CSNOX', 'CSNOXOS', 'CSOSG1', 'CSOSG2', 'CSOSG3', 'CSSO2G1', 'CSSO2G2', 'TRNOX', 'TRNOXOS', 'TRSO2G1', 'TRSO2G2', 'TXSO2');

update camdmd.program_code
set so2_cert_ind = 1
where prg_cd in ('ARP', 'CAIRSO2', 'CSSO2G1', 'CSSO2G2', 'TRSO2G1', 'TRSO2G2', 'TXSO2');

update camdmd.program_code
set nox_cert_ind = 1
where prg_cd in ('ARP', 'CAIRNOX', 'CAIROS', 'CSNOX', 'CSNOXOS', 'CSOSG1', 'CSOSG2', 'CSOSG3', 'NBP', 'NHNOX', 'SIPNOX', 'TRNOX', 'TRNOXOS');

update camdmd.program_code
set noxc_cert_ind = 1
where prg_cd in ('CAIRNOX', 'CAIROS', 'CSNOX', 'CSNOXOS', 'CSOSG1', 'CSOSG2', 'CSOSG3', 'NBP', 'NHNOX', 'SIPNOX', 'TRNOX', 'TRNOXOS');

--------------------------------------------------
-- FUEL TYPE CODE UPDATES 
--------------------------------------------------
update camdecmpsmd.fuel_type_code
set fuel_group_cd = 'COAL'
where fuel_type_cd in ('C', 'CRF', 'PTC');

--------------------------------------------------
-- ACCOUNT TYPE CODE
--------------------------------------------------
update camdmd.account_type_code
set account_type_description = 'Facility Account'
where account_type_cd = 'FACLTY';

--------------------------------------------------
-- PROGRAM_EXEMPTION
--------------------------------------------------
INSERT INTO camdmd.program_exemption(prg_cd, exemption_type_cd)
VALUES ('ARP', 'NUE');
INSERT INTO camdmd.program_exemption(prg_cd, exemption_type_cd)
VALUES ('ARP', 'RUE');
INSERT INTO camdmd.program_exemption(prg_cd, exemption_type_cd)
VALUES ('CAIRNOX', 'RUE');
INSERT INTO camdmd.program_exemption(prg_cd, exemption_type_cd)
VALUES ('CAIROS', 'RUE');
INSERT INTO camdmd.program_exemption(prg_cd, exemption_type_cd)
VALUES ('CAIRSO2', 'RUE');
INSERT INTO camdmd.program_exemption(prg_cd, exemption_type_cd)
VALUES ('CSNOX', 'RUE');
INSERT INTO camdmd.program_exemption(prg_cd, exemption_type_cd)
VALUES ('CSNOXOS', 'RUE');
INSERT INTO camdmd.program_exemption(prg_cd, exemption_type_cd)
VALUES ('CSOSG1', 'RUE');
INSERT INTO camdmd.program_exemption(prg_cd, exemption_type_cd)
VALUES ('CSOSG2', 'RUE');
INSERT INTO camdmd.program_exemption(prg_cd, exemption_type_cd)
VALUES ('CSSO2G1', 'RUE');
INSERT INTO camdmd.program_exemption(prg_cd, exemption_type_cd)
VALUES ('CSSO2G2', 'RUE');
INSERT INTO camdmd.program_exemption(prg_cd, exemption_type_cd)
VALUES ('NBP', '25TON');
INSERT INTO camdmd.program_exemption(prg_cd, exemption_type_cd)
VALUES ('TXSO2', 'RUE');
INSERT INTO camdmd.program_exemption(prg_cd, exemption_type_cd)
VALUES ('CSOSG3', 'RUE');