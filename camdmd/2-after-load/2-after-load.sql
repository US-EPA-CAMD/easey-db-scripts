-- NOTE: THE FOLLOWING TABLES NEED TO EXIST PRIOR TO RUNNING THIS SCRIPT
-- Table: camdmd.account_type_group_code
-- Table: camdmd.unit_type_group_code

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

ALTER TABLE camdmd.program_code
    ADD COLUMN bulk_file_active numeric(1,0) NOT NULL DEFAULT 0;

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
set bulk_file_active = 1
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
set os_ind = 1,
notes = 'SIPNOX is treated as a OS program in ECMPS'
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
-- LOAD ACCOUNT TYPE GROUPS
--------------------------------------------------
INSERT INTO camdmd.account_type_group_code(
	account_type_group_cd, account_type_group_description)
	VALUES ('FACLTY', 'Facility');

INSERT INTO camdmd.account_type_group_code(
	account_type_group_cd, account_type_group_description)
	VALUES ('GENERAL', 'General');

INSERT INTO camdmd.account_type_group_code(
	account_type_group_cd, account_type_group_description)
	VALUES ('OVERDF', 'Overdraft');

INSERT INTO camdmd.account_type_group_code(
	account_type_group_cd, account_type_group_description)
	VALUES ('RESERVE', 'Reserve');

INSERT INTO camdmd.account_type_group_code(
	account_type_group_cd, account_type_group_description)
	VALUES ('RETIRE', 'Surrender');

INSERT INTO camdmd.account_type_group_code(
	account_type_group_cd, account_type_group_description)
	VALUES ('SHOLD', 'State Holding');

INSERT INTO camdmd.account_type_group_code(
	account_type_group_cd, account_type_group_description)
	VALUES ('UNIT', 'Unit');

-- ADD CONSTRAINT
ALTER TABLE camdmd.account_type_code
    ADD CONSTRAINT fk_account_type_account_type_group FOREIGN KEY (account_type_group_cd)
    REFERENCES camdmd.account_type_group_code (account_type_group_cd) MATCH SIMPLE;

--------------------------------------------------
-- LOAD UNIT TYPE GROUPS
--------------------------------------------------
INSERT INTO camdmd.unit_type_group_code(
	unit_type_group_cd, unit_type_group_description)
	VALUES ('B', 'Boilers');

INSERT INTO camdmd.unit_type_group_code(
	unit_type_group_cd, unit_type_group_description)
	VALUES ('F', 'Furnaces');

INSERT INTO camdmd.unit_type_group_code(
	unit_type_group_cd, unit_type_group_description)
	VALUES ('T', 'Turbines');

-- MODIFY UNIT_TYPE_CODE TO INCLUDE GROUP
ALTER TABLE camdmd.unit_type_code
    ADD COLUMN unit_type_group_cd character varying;

COMMENT ON COLUMN camdmd.unit_type_code.unit_type_group_cd
    IS 'Identifies the category of unit types (e.g., boiler, turbine).';


-- MODIFY UNIT_TYPE_CODE DATA TO INCLUDE GROUP
update camdmd.unit_type_code
set unit_type_group_cd = 'T'
where unit_type_cd in ('CC','CT','ICE','OT','IGC');

update camdmd.unit_type_code
set unit_type_group_cd = 'B'
where unit_type_cd not in ('CC','CT','ICE','OT','IGC');

update camdmd.unit_type_code
set unit_type_group_cd = 'F'
where unit_type_cd in ('PRH','KLN');


-- MODIFY UNIT_TYPE_CODE TO MAKE GROUP NOT NULL
ALTER TABLE camdmd.unit_type_code
    ALTER COLUMN unit_type_group_cd SET NOT NULL;


-- ADD CONSTRAINT
ALTER TABLE camdmd.unit_type_code
    ADD CONSTRAINT fk_unit_type_unit_type_group FOREIGN KEY (unit_type_group_cd)
    REFERENCES camdmd.unit_type_group_code (unit_type_group_cd) MATCH SIMPLE;