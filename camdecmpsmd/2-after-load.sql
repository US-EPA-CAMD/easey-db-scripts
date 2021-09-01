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
