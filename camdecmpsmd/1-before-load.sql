-- PROCESS_CODE
ALTER TABLE IF EXISTS camdecmpmd.process_code
    DROP COLUMN IF EXISTS program_cd_name;

ALTER TABLE IF EXISTS camdecmpmd.process_code
    DROP COLUMN IF EXISTS parameter_group_override_cd;

ALTER TABLE IF EXISTS camdecmpmd.process_code
    DROP COLUMN IF EXISTS process_group_cd;


