ALTER TABLE IF EXISTS camdmd.program_code
    ADD COLUMN IF NOT EXISTS emissions_ui_filter numeric(1,0) NOT NULL DEFAULT 0;

ALTER TABLE IF EXISTS camdmd.program_code
    ADD COLUMN IF NOT EXISTS allowance_ui_filter numeric(1,0) NOT NULL DEFAULT 0;

ALTER TABLE IF EXISTS camdmd.program_code
    ADD COLUMN IF NOT EXISTS compliance_ui_filter numeric(1,0) NOT NULL DEFAULT 0;

ALTER TABLE IF EXISTS camdmd.program_code
    ADD COLUMN IF NOT EXISTS rue_ind numeric(1,0) NOT NULL DEFAULT 0;

ALTER TABLE IF EXISTS camdmd.program_code
    ADD COLUMN IF NOT EXISTS so2_cert_ind numeric(1,0) NOT NULL DEFAULT 0;

ALTER TABLE IF EXISTS camdmd.program_code
    ADD COLUMN IF NOT EXISTS nox_cert_ind numeric(1,0) NOT NULL DEFAULT 0;

ALTER TABLE IF EXISTS camdmd.program_code
    ADD COLUMN IF NOT EXISTS noxc_cert_ind numeric(1,0) NOT NULL DEFAULT 0;

ALTER TABLE IF EXISTS camdmd.program_code
    ADD COLUMN IF NOT EXISTS notes character varying(1000) NOT NULL DEFAULT 0;

ALTER TABLE IF EXISTS camdmd.program_code
    ADD COLUMN IF NOT EXISTS bulk_file_active numeric(1,0) NOT NULL DEFAULT 0;

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

UPDATE camdmd.program_code
SET bulk_file_active = 1
WHERE prg_cd IN ('ARP', 'CSNOX', 'CSNOXOS', 'CSOSG1', 'CSOSG2', 'CSOSG3', 'CSSO2G1', 'CSSO2G2', 'TXSO2');
--------------------------------------------------------------------------------------------------------------------
update camdecmpsmd.fuel_type_code
set fuel_group_cd = 'COAL'
where fuel_type_cd in ('C', 'CRF', 'PTC');
--------------------------------------------------------------------------------------------------------------------
update camdmd.account_type_code
set account_type_description = 'Facility Account'
where account_type_cd = 'FACLTY';
--------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdmd.unit_type_code
    ADD COLUMN IF NOT EXISTS unit_type_group_cd character varying;

COMMENT ON COLUMN camdmd.unit_type_code.unit_type_group_cd
    IS 'Identifies the category of unit types (e.g., boiler, turbine).';

update camdmd.unit_type_code
set unit_type_group_cd = 'T'
where unit_type_cd in ('CC','CT','ICE','OT','IGC');

update camdmd.unit_type_code
set unit_type_group_cd = 'B'
where unit_type_cd not in ('CC','CT','ICE','OT','IGC');

update camdmd.unit_type_code
set unit_type_group_cd = 'F'
where unit_type_cd in ('PRH','KLN');

ALTER TABLE IF EXISTS camdmd.unit_type_code
    ALTER COLUMN unit_type_group_cd SET NOT NULL;
--------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsmd.process_code
    ADD COLUMN IF NOT EXISTS process_cd_name character varying(100);

ALTER TABLE IF EXISTS camdecmpsmd.process_code
    ADD COLUMN IF NOT EXISTS parameter_group_override_cd character varying(7);

ALTER TABLE IF EXISTS camdecmpsmd.process_code
    ADD COLUMN IF NOT EXISTS process_group_cd character varying(7);

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
--------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsmd.qual_type_code
    ADD COLUMN IF NOT EXISTS qual_type_group_cd character varying(7) NOT NULL DEFAULT 'PCT';

UPDATE camdecmpsmd.qual_type_code
SET qual_type_group_cd = 'LEE'
WHERE qual_type_cd = 'LEE';

UPDATE camdecmpsmd.qual_type_code
SET qual_type_group_cd = 'LME'
WHERE qual_type_cd IN ('LMEA', 'LMES');
--------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsmd.severity_code
    ADD COLUMN IF NOT EXISTS eval_status_cd character varying(7);

UPDATE camdecmpsmd.severity_code
SET eval_status_cd = 'PASS'
WHERE severity_cd IN ('NONE');

UPDATE camdecmpsmd.severity_code
SET eval_status_cd = 'INFO'
WHERE severity_cd IN ('ADMNOVR', 'INFORM', 'NONCRIT', 'FORGIVE');

UPDATE camdecmpsmd.severity_code
SET eval_status_cd = 'ERR'
WHERE severity_cd IN ('CRIT1', 'CRIT2', 'CRIT3', 'FATAL');
--------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsmd.test_type_code
    ADD COLUMN IF NOT EXISTS group_cd character varying(7) DEFAULT 'MISC';

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

UPDATE camdecmpsmd.test_type_code SET group_cd = null WHERE test_type_cd IN (
	'AF2LCHK',
	'DAYCAL',
    'HGSI1',
    'INTCHK',
    'PEMSCAL'
);
--------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpswks.monitor_plan
    ADD COLUMN IF NOT EXISTS eval_status_cd character varying(7) NOT NULL DEFAULT 'EVAL';

ALTER TABLE IF EXISTS camdecmpswks.qa_cert_event
    ADD COLUMN IF NOT EXISTS eval_status_cd character varying(7) NOT NULL DEFAULT 'EVAL';

ALTER TABLE IF EXISTS camdecmpswks.test_extension_exemption
    ADD COLUMN IF NOT EXISTS eval_status_cd character varying(7) NOT NULL DEFAULT 'EVAL';

ALTER TABLE IF EXISTS camdecmpswks.test_summary
    ADD COLUMN IF NOT EXISTS eval_status_cd character varying(7) NOT NULL DEFAULT 'EVAL';

ALTER TABLE IF EXISTS camdecmpswks.emission_evaluation
    ADD COLUMN IF NOT EXISTS eval_status_cd character varying(7) NOT NULL DEFAULT 'EVAL';
--------------------------------------------------------------------------------------------------------------------
DO $$
DECLARE
	startVal bigint := 1;
	sqlStatement text;
BEGIN
	DROP VIEW IF EXISTS camdecmps.vw_emissions_submissions_progress;
	DROP VIEW IF EXISTS camdecmps.vw_emissions_submissions_expected;
	DROP VIEW IF EXISTS camdecmps.vw_emissions_submissions_received;
	DROP VIEW IF EXISTS camdecmps.vw_emissions_submissions_gdm;
	SELECT COALESCE(MAX(em_sub_access_id)+1, 1) FROM camdecmpsaux.em_submission_access INTO startVal;
	ALTER TABLE IF EXISTS camdecmpsaux.em_submission_access
		ALTER COLUMN em_sub_access_id TYPE bigint;
	sqlStatement := format('
	ALTER TABLE IF EXISTS camdecmpsaux.em_submission_access
		ALTER COLUMN em_sub_access_id ADD GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START %s MINVALUE 1 MAXVALUE 999999999999 );
	', startVal);
	RAISE NOTICE 'Executing...%', sqlStatement;
	EXECUTE sqlStatement;
END $$;
--------------------------------------------------------------------------------------------------------------------
DO $$
DECLARE
	startVal bigint := 1;
	sqlStatement text;
BEGIN
	SELECT COALESCE(MAX(es_spec_id)+1, 1) FROM camdecmpsaux.es_spec INTO startVal;
	ALTER TABLE IF EXISTS camdecmpsaux.es_spec
		ALTER COLUMN di DROP NOT NULL;
	ALTER TABLE IF EXISTS camdecmpsaux.es_spec
		ALTER COLUMN es_spec_id TYPE bigint;
	sqlStatement := format('
	ALTER TABLE IF EXISTS camdecmpsaux.es_spec
		ALTER COLUMN es_spec_id ADD GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START %s MINVALUE 1 MAXVALUE 999999999999 );
	', startVal);
	RAISE NOTICE 'Executing...%', sqlStatement;
	EXECUTE sqlStatement;
END $$;
--------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsmd.es_match_data_type_code
  ADD COLUMN es_match_data_type_url character varying(100);

update camdecmpsmd.es_match_data_type_code
set es_match_data_type_url = '/master-data-mgmt/control-equip-param-codes'
where es_match_data_type_cd = 'CEPARAM';

update camdecmpsmd.es_match_data_type_code
set es_match_data_type_url = '/master-data-mgmt/component-type-codes'
where es_match_data_type_cd = 'COMPTYP';

update camdecmpsmd.es_match_data_type_code
set es_match_data_type_url = '/master-data-mgmt/fuel-type-codes'
where es_match_data_type_cd = 'FUELTYP';

update camdecmpsmd.es_match_data_type_code
set es_match_data_type_url = '/monitor-plan-mgmt/workspace/configurations'
where es_match_data_type_cd = 'MONPLAN';

update camdecmpsmd.es_match_data_type_code
set es_match_data_type_url = '/master-data-mgmt/es-parameter-codes'
where es_match_data_type_cd = 'PARAM';

update camdecmpsmd.es_match_data_type_code
set es_match_data_type_url = '/master-data-mgmt/program-codes'
where es_match_data_type_cd = 'PROGRAM';

update camdecmpsmd.es_match_data_type_code
set es_match_data_type_url = '/master-data-mgmt/qualification-type-codes'
where es_match_data_type_cd = 'QUALTYP';

update camdecmpsmd.es_match_data_type_code
set es_match_data_type_url = '/master-data-mgmt/system-type-codes'
where es_match_data_type_cd = 'SYSTYP';

update camdecmpsmd.es_match_data_type_code
set es_match_data_type_url = '/qa-certification-mgmt/workspace/locations/{id}/test-summary'
where es_match_data_type_cd = 'TESTNUM';

update camdecmpsmd.es_match_data_type_code
set es_match_data_type_url = '/master-data-mgmt/test-type-codes'
where es_match_data_type_cd = 'TESTTYP';

update camdecmpsmd.es_match_data_type_code
set es_match_data_type_url = '/master-data-mgmt/mats-method-parameter-codes'
where es_match_data_type_cd = 'MATSPAR';

ALTER TABLE IF EXISTS camdecmpsmd.es_match_data_type_code
  ALTER COLUMN es_match_data_type_url SET NOT NULL;
--------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpswks.check_session
    ADD COLUMN IF NOT EXISTS batch_id character varying(45);
--------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdaux.dataset
	ADD COLUMN IF NOT EXISTS group_cd character varying(7),
	ADD CONSTRAINT ck_group_cd CHECK(
		group_cd = ANY(ARRAY['MDM', 'MDMREL', 'REPORT', 'EMVIEW'])
	);

UPDATE camdaux.dataset SET group_cd =
	CASE
		WHEN template_cd = 'SUMRPT' OR template_cd = 'DTLRPT' THEN 'REPORT'
		ELSE template_cd
	END;

ALTER TABLE IF EXISTS camdaux.dataset
	ALTER COLUMN group_cd SET NOT NULL;

ALTER TABLE IF EXISTS camdaux.datatable
	ALTER COLUMN display_name DROP NOT NULL,
	ADD COLUMN IF NOT EXISTS template_cd character varying(25);
--------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.component
	ADD COLUMN IF NOT EXISTS analytical_principle_cd character varying(7);

ALTER TABLE IF EXISTS camdecmpswks.component
	ADD COLUMN IF NOT EXISTS analytical_principle_cd character varying(7);
