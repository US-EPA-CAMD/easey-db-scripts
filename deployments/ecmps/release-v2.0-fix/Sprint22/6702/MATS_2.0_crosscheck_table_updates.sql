-- Remove the PMPMA and PMPMC rows. cross_chk_catalog_id 8
DELETE FROM camdecmpsmd.cross_check_catalog_value
WHERE cross_chk_catalog_id = 8
AND value1 in ('PMPMA,PMPMC');

-- Remove the PMPMA and PMPMC rows. cross_chk_catalog_id 11
DELETE FROM camdecmpsmd.cross_check_catalog_value
WHERE cross_chk_catalog_id = 11
AND value1 in ('PMPMA,PMPMC');

-- Remove the MATS row. cross_chk_catalog_id 85
DELETE FROM camdecmpsmd.cross_check_catalog_value
WHERE value1 = 'MATS' AND cross_chk_catalog_id = 85;

-- Update value2 for HCL in cross_check_catalog_value to include MATSSUP 
UPDATE camdecmpsmd.cross_check_catalog_value
SET value2 = 'HCLRE,HCLRH,SO2RE,SO2RH,HCL,MATSSUP'
WHERE value1 = 'HCL' AND cross_chk_catalog_id = 85;

-- Update value2 for HF in cross_check_catalog_value to include MATSSUP 
UPDATE camdecmpsmd.cross_check_catalog_value
SET value2 = 'HFRE,HFRH,HF,MATSSUP'
WHERE value1 = 'HF' AND cross_chk_catalog_id = 85;

-- Update value2 for HG in cross_check_catalog_value to include MATSSUP 
UPDATE camdecmpsmd.cross_check_catalog_value
SET value2 = 'HGRE,HGRH,HG,MATSSUP'
WHERE value1 = 'HG' AND cross_chk_catalog_id = 85;

-- Update value2 for HG in cross_check_catalog_value to include MATSSUP 
UPDATE camdecmpsmd.cross_check_catalog_value
SET value2 = 'PMRE,PMRH,PM,MATSSUP'
WHERE value1 = 'PM' AND cross_chk_catalog_id = 85;

-- Remove the PMCO, PMPMA, and PMPMC rows
DELETE FROM CAMDECMPSMD.PARAMETER_CODE
WHERE parameter_cd IN ('PMCO', 'PMPMA', 'PMPMC');