-- Program Parameter to Location Type (cross_chk_catalog_id 86):
INSERT INTO camdecmpsmd.cross_check_catalog_value (cross_chk_catalog_value_id, cross_chk_catalog_id, value1, value2, value3) OVERRIDING SYSTEM VALUE VALUES (9333, 86, 'PM', 'CS', 'MS');

-- Program Parameter to Severity (cross_chk_catalog_id 91):
INSERT INTO camdecmpsmd.cross_check_catalog_value (cross_chk_catalog_value_id, cross_chk_catalog_id, value1, value2, value3) OVERRIDING SYSTEM VALUE VALUES (9334, 91, 'PM', 'INFORM', null);

-- Component Type Code to Basis Code (cross_chk_catalog_id 190):
INSERT INTO camdecmpsmd.cross_check_catalog_value (cross_chk_catalog_value_id, cross_chk_catalog_id, value1, value2, value3) OVERRIDING SYSTEM VALUE VALUES (9335, 190, 'PM', 'D', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value (cross_chk_catalog_value_id, cross_chk_catalog_id, value1, value2, value3) OVERRIDING SYSTEM VALUE VALUES (9336, 190, 'PM', 'W', null);

-- Parameter Code to Formula Code for Formulas (cross_chk_catalog_id 195):
UPDATE camdecmpsmd.cross_check_catalog_value
SET value1 = 'PM'
WHERE cross_chk_catalog_id = 195
  AND value1 = 'PMRE'
  AND value2 IN ('11-16', '11-3', '11-34', '11-37', '11-46');

DELETE FROM camdecmpsmd.cross_check_catalog_value
WHERE cross_chk_catalog_id = 195
  AND value1 = 'PMRH'
  AND value2 IN ('11-16', '11-3', '11-34', '11-37', '11-46');