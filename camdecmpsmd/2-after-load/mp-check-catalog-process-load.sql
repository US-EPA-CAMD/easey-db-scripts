INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MP' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'CAPAC' AND check_number IN (1,2,3,4,5);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MPSCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'CAPAC' AND check_number IN (1,2,3,5,6);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MP' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'COMPON' AND check_number IN (3,4,5,6,7,8,10,11,12,13,14,16,18,19,20,21,22,26,30,33,34,37,38,39,44,45,46,47,48,51,52,56,80,81);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MPSCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'COMPON' AND check_number IN (3,4,5,6,7,8,10,11,12,13,14,16,18,19,20,21,22,37,53,54,55,81);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MP' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'CONTROL' AND check_number IN (1,2,4,5,6,8,9,11,13,14,16);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MPSCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'CONTROL' AND check_number IN (1,2,4,5,6,9,15);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MP' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'DEFAULT' AND check_number IN ();

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MPSCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'DEFAULT' AND check_number IN ();

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MP' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = '' AND check_number IN ();

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MPSCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = '' AND check_number IN ();