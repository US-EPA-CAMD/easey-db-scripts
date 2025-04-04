-- Update row with Program Parameter Code equal to "PM" changing Method Parameter List to "PMRE,PMRH,PM"
UPDATE camdecmpsmd.cross_check_catalog_value
SET value2 = 'PMRE,PMRH,PM',
    value3 = 'PMRE (or PMRH version for heat input based method or PM Supplemental Method)'
WHERE cross_chk_catalog_value_id = 8018
  AND cross_chk_catalog_id = 85;

-- Remove row for Equation Code "F-29" and "K-5".
DELETE FROM camdecmpsmd.equation_code
WHERE equation_cd IN ('F-29', 'K-5');

-- Remove rows where Parameter Code equals "PMRH" and Formula Code equals "11-3", "11-16", "11-34", "11-37" or "11-46".
DELETE FROM camdecmpsmd.cross_check_catalog_value
WHERE cross_chk_catalog_id = 16
  AND value1 = 'PMRH'
  AND value3 IN ('11-3', '11-16', '11-34', '11-37', '11-46');

-- Change Parameter Code to "PM" for rows where Parameter Code equals "PMRE" and Formula Code equals "11-3", "11-16", "11-34", "11-37" or "11-46".
UPDATE camdecmpsmd.cross_check_catalog_value
SET value1 = 'PM'
WHERE cross_chk_catalog_id = 16
  AND value1 = 'PMRE'
  AND value3 IN ('11-3', '11-16', '11-34', '11-37', '11-46');

--PARAMETER_METHOD TO FORMULA
--Change row where Parameter Code equals to "NOX" and Method Code equals "CALC"
UPDATE camdecmpsmd.cross_check_catalog_value
SET value2 = 'F-28'
WHERE cross_chk_catalog_value_id = 8957
  AND cross_chk_catalog_id = 8;
