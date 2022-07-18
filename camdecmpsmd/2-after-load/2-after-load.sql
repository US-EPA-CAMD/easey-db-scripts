-- NOTE: THE FOLLOWING TABLES NEED TO EXIST PRIOR TO RUNNING THIS SCRIPT
-- Table: camdecmpsmd.eval_status_code
-- Table: camdecmpsmd.test_type_group_code

--------------------------------------------------
-- LOAD EVALUATION STATUS CODES
--------------------------------------------------
INSERT INTO camdecmpsmd.eval_status_code(
	eval_status_cd, eval_status_cd_description)
	VALUES ('EVAL', 'Needs Evaluation');

INSERT INTO camdecmpsmd.eval_status_code(
	eval_status_cd, eval_status_cd_description)
	VALUES ('INQ', 'In Queue');

INSERT INTO camdecmpsmd.eval_status_code(
	eval_status_cd, eval_status_cd_description)
	VALUES ('WIP', 'In Progress');

INSERT INTO camdecmpsmd.eval_status_code(
	eval_status_cd, eval_status_cd_description)
	VALUES ('PASS', 'Passed');

INSERT INTO camdecmpsmd.eval_status_code(
	eval_status_cd, eval_status_cd_description)
	VALUES ('ERR', 'Critical Errors');

INSERT INTO camdecmpsmd.eval_status_code(
	eval_status_cd, eval_status_cd_description)
	VALUES ('INFO', 'Informational Message');

--------------------------------------------------
-- PROCESS_CODE UPDATES 
--------------------------------------------------
ALTER TABLE camdecmpsmd.process_code
    ADD COLUMN process_cd_name character varying(100);

ALTER TABLE camdecmpsmd.process_code
    ADD COLUMN parameter_group_override_cd character varying(7);

ALTER TABLE camdecmpsmd.process_code
    ADD COLUMN process_group_cd character varying(7);


UPDATE camdecmpsmd.process_code
SET process_cd_name = 'EM Import', process_group_cd = 'IMPORT'
WHERE process_cd = 'EMIMPRT';

UPDATE camdecmpsmd.process_code
SET process_cd_name = 'EM Report', parameter_group_override_cd = 'EM', process_group_cd = 'EM'
WHERE process_cd = 'HOURLY';

UPDATE camdecmpsmd.process_code
SET process_cd_name = 'MP Report', parameter_group_override_cd = 'MP', process_group_cd = 'MP'
WHERE process_cd = 'MP';

UPDATE camdecmpsmd.process_code
SET process_cd_name = 'MP Import', process_group_cd = 'IMPORT'
WHERE process_cd = 'MPIMPRT';

UPDATE camdecmpsmd.process_code
SET process_cd_name = 'MP Screen', parameter_group_override_cd = 'MP', process_group_cd = 'MP'
WHERE process_cd = 'MPSCRN';

UPDATE camdecmpsmd.process_code
SET process_cd_name = 'QA Non Test Report', parameter_group_override_cd = 'QA', process_group_cd = 'QA'
WHERE process_cd = 'OTHERQA';

UPDATE camdecmpsmd.process_code
SET process_cd_name = 'QA Calculations', parameter_group_override_cd = 'QA', process_group_cd = 'QA'
WHERE process_cd = 'QACALC';

UPDATE camdecmpsmd.process_code
SET process_cd_name = 'QA Import', process_group_cd = 'IMPORT'
WHERE process_cd = 'QAIMPRT';

UPDATE camdecmpsmd.process_code
SET process_cd_name = 'QA Screen', parameter_group_override_cd = 'QA', process_group_cd = 'QA'
WHERE process_cd = 'QASCRN';

UPDATE camdecmpsmd.process_code
SET process_cd_name = 'QA Test Report', parameter_group_override_cd = 'QA', process_group_cd = 'QA'
WHERE process_cd = 'TEST';

UPDATE camdecmpsmd.process_code
SET process_cd_name = 'LME Generation', parameter_group_override_cd = 'EM', process_group_cd = 'EM'
WHERE process_cd = 'LMEGEN';

UPDATE camdecmpsmd.process_code
SET process_cd_name = 'LME Import', process_group_cd = 'IMPORT'
WHERE process_cd = 'LMEIMPT';

UPDATE camdecmpsmd.process_code
SET process_cd_name = 'LME Screen', parameter_group_override_cd = 'EM', process_group_cd = 'EM'
WHERE process_cd = 'LMESCRN';

UPDATE camdecmpsmd.process_code
SET process_cd_name = 'EM Generation'
WHERE process_cd = 'EMGEN';


--------------------------------------------------
-- QUAL_TYPE_CODE UPDATES 
--------------------------------------------------
ALTER TABLE camdecmpsmd.qual_type_code
    ADD COLUMN qual_type_group_cd character varying(7) NOT NULL DEFAULT 'PCT';

UPDATE camdecmpsmd.qual_type_code
SET qual_type_group_cd = 'LEE'
WHERE qual_type_cd = 'LEE';

UPDATE camdecmpsmd.qual_type_code
SET qual_type_group_cd = 'LME'
WHERE qual_type_cd IN ('LMEA', 'LMES');


--------------------------------------------------
-- SEVERITY_CODE UPDATES 
--------------------------------------------------
ALTER TABLE camdecmpsmd.severity_code
    ADD COLUMN eval_status_cd character varying(7);

ALTER TABLE camdecmpsmd.severity_code
    ADD CONSTRAINT fk_severity_code_eval_status_code FOREIGN KEY (eval_status_cd)
    REFERENCES camdecmpsmd.eval_status_code (eval_status_cd) MATCH SIMPLE;

UPDATE camdecmpsmd.severity_code
SET eval_status_cd = 'PASS'
WHERE severity_cd IN ('NONE');

UPDATE camdecmpsmd.severity_code
SET eval_status_cd = 'INFO'
WHERE severity_cd IN ('ADMNOVR', 'INFORM', 'NONCRIT', 'FORGIVE');

UPDATE camdecmpsmd.severity_code
SET eval_status_cd = 'ERR'
WHERE severity_cd IN ('CRIT1', 'CRIT2', 'CRIT3', 'FATAL');

--------------------------------------------------
-- TEST TYPE GROUP CODES
--------------------------------------------------
INSERT INTO camdecmpsmd.test_type_group_code(
	test_type_group_cd, test_type_group_cd_description)
	VALUES ('APPESUM', 'Appendix E Correlation Test Summary');

INSERT INTO camdecmpsmd.test_type_group_code(
	test_type_group_cd, test_type_group_cd_description)
	VALUES ('CALINJ', 'Calibration Injection');

INSERT INTO camdecmpsmd.test_type_group_code(
	test_type_group_cd, test_type_group_cd_description)
	VALUES ('CYCSUM', 'Cycle Time Summary');

INSERT INTO camdecmpsmd.test_type_group_code(
	test_type_group_cd, test_type_group_cd_description)
	VALUES ('FLC', 'Flow to Load Check');

INSERT INTO camdecmpsmd.test_type_group_code(
	test_type_group_cd, test_type_group_cd_description)
	VALUES ('FLR', 'Flow to Load Reference');

INSERT INTO camdecmpsmd.test_type_group_code(
	test_type_group_cd, test_type_group_cd_description)
	VALUES ('FFLB', 'Fuel Flow to Load Baseline');

INSERT INTO camdecmpsmd.test_type_group_code(
	test_type_group_cd, test_type_group_cd_description)
	VALUES ('FFL', 'Fuel Flow to Load');

INSERT INTO camdecmpsmd.test_type_group_code(
	test_type_group_cd, test_type_group_cd_description)
	VALUES ('FFACC', 'Fuel Flowmeter Accuracy');

INSERT INTO camdecmpsmd.test_type_group_code(
	test_type_group_cd, test_type_group_cd_description)
	VALUES ('HGL3LS', 'Hg Linearity and 3-Level Summary');

INSERT INTO camdecmpsmd.test_type_group_code(
	test_type_group_cd, test_type_group_cd_description)
	VALUES ('LINSUM', 'Linearity Summary');

INSERT INTO camdecmpsmd.test_type_group_code(
	test_type_group_cd, test_type_group_cd_description)
	VALUES ('OLOLCAL', 'Online Offline Calibration');

INSERT INTO camdecmpsmd.test_type_group_code(
	test_type_group_cd, test_type_group_cd_description)
	VALUES ('RELACC', 'Relative Accuracy');

INSERT INTO camdecmpsmd.test_type_group_code(
	test_type_group_cd, test_type_group_cd_description)
	VALUES ('TSTQUAL', 'Test Qualification');

INSERT INTO camdecmpsmd.test_type_group_code(
	test_type_group_cd, test_type_group_cd_description)
	VALUES ('TTACC', 'Transmitter Transducer Accuracy');

INSERT INTO camdecmpsmd.test_type_group_code(
	test_type_group_cd, test_type_group_cd_description)
	VALUES ('PEI', 'Primary Element Inspection');

INSERT INTO camdecmpsmd.test_type_group_code(
	test_type_group_cd, test_type_group_cd_description)
	VALUES ('LME', 'Unit Default');

INSERT INTO camdecmpsmd.test_type_group_code(
	test_type_group_cd, test_type_group_cd_description)
	VALUES ('MISC', 'Miscellaneous');

--------------------------------------------------
-- UPDATE TEST TYPE CODES
--------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsmd.test_type_code
    ADD COLUMN group_cd character varying(7);

ALTER TABLE IF EXISTS camdecmpsmd.test_type_code
    ADD CONSTRAINT fk_test_type_code_group_code FOREIGN KEY (group_cd)
    REFERENCES camdecmpsmd.test_type_group_code (test_type_group_cd) MATCH SIMPLE;

UPDATE camdecmpsmd.test_type_code SET group_cd = 'CALINJ' WHERE test_type_cd = '7DAY';
UPDATE camdecmpsmd.test_type_code SET group_cd = 'CYCSUM' WHERE test_type_cd = 'CYCLE';
UPDATE camdecmpsmd.test_type_code SET group_cd = 'LINSUM' WHERE test_type_cd = 'LINE';
UPDATE camdecmpsmd.test_type_code SET group_cd = 'RELACC' WHERE test_type_cd = 'RATA';
UPDATE camdecmpsmd.test_type_code SET group_cd = 'FLR' WHERE test_type_cd = 'F2LREF';
UPDATE camdecmpsmd.test_type_code SET group_cd = 'FLC' WHERE test_type_cd = 'F2LCHK';
UPDATE camdecmpsmd.test_type_code SET group_cd = 'OLOLCAL' WHERE test_type_cd = 'ONOFF';
UPDATE camdecmpsmd.test_type_code SET group_cd = 'APPESUM' WHERE test_type_cd = 'APPE';
UPDATE camdecmpsmd.test_type_code SET group_cd = 'FFACC' WHERE test_type_cd = 'FFACC';
UPDATE camdecmpsmd.test_type_code SET group_cd = 'TTACC' WHERE test_type_cd = 'FFACCTT';
UPDATE camdecmpsmd.test_type_code SET group_cd = 'FFLB' WHERE test_type_cd = 'FF2LBAS';
UPDATE camdecmpsmd.test_type_code SET group_cd = 'FFL' WHERE test_type_cd = 'FF2LTST';
UPDATE camdecmpsmd.test_type_code SET group_cd = 'LME' WHERE test_type_cd = 'UNITDEF';
UPDATE camdecmpsmd.test_type_code SET group_cd = 'PEI' WHERE test_type_cd = 'PEI';

UPDATE camdecmpsmd.test_type_code SET group_cd = 'HGL3LS' WHERE test_type_cd IN (
	'HGLINE',
	'HGSI3'	
);

UPDATE camdecmpsmd.test_type_code SET group_cd = 'MISC' WHERE test_type_cd IN (
	'DAHS',
	'DGFMCAL',
	'MFMCAL',
	'TSCAL',
	'BCAL',
	'QGA',
	'LEAK',
	'OTHER',
	'PEMSACC'
);
