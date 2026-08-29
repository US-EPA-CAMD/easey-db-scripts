ALTER TABLE camdecmpsmd.mats_report_type_code
    ADD COLUMN IF NOT EXISTS enforce_attachment_rules BOOLEAN DEFAULT TRUE;

ALTER TABLE camdecmpsmd.mats_report_type_code
    ALTER COLUMN enforce_attachment_rules SET NOT NULL;

UPDATE
    camdecmpsmd.mats_report_type_code
SET
    enforce_attachment_rules = FALSE
WHERE
    mats_rpt_type_cd IN ('EMPM', 'NOTIFY');

ALTER TABLE camdecmpsmd.mats_report_type_code
    ALTER COLUMN enforce_attachment_rules DROP DEFAULT;

DELETE FROM camdecmpsmd.mats_report_type_to_pollutant_crosscheck
WHERE mats_rpt_type_cd IN ('QATPS11', 'QATRCA', 'QATRRA');

DELETE FROM camdecmpsmd.mats_report_type_code
WHERE mats_rpt_type_cd IN ('QATPS11', 'QATRCA', 'QATRRA');

INSERT INTO camdecmpsmd.mats_report_type_code (mats_rpt_type_cd, mats_rpt_type_description, metadata_rpt_type_cd, requires_pollutant, requires_test_method, enforce_attachment_rules)
    VALUES ('ACA', 'Absolute Correlation Audit (ECMPS QA)', 'ACA', TRUE, FALSE, FALSE);

INSERT INTO camdecmpsmd.mats_report_type_code (mats_rpt_type_cd, mats_rpt_type_description, metadata_rpt_type_cd, requires_pollutant, requires_test_method, enforce_attachment_rules)
    VALUES ('SVA', 'Sample Volume Audit (ECMPS QA)', 'SVA', TRUE, FALSE, FALSE);

INSERT INTO camdecmpsmd.mats_report_type_to_pollutant_crosscheck (mats_rpt_type_cd, mats_pollutant_cd)
    VALUES ('ACA', 'FPM');

INSERT INTO camdecmpsmd.mats_report_type_to_pollutant_crosscheck (mats_rpt_type_cd, mats_pollutant_cd)
    VALUES ('SVA', 'FPM');

COMMENT ON COLUMN camdecmpsmd.mats_report_type_code.enforce_attachment_rules IS 'Flag indicating whether the attachment rules should be enforced.';

