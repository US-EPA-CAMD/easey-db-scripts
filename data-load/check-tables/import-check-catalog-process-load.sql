INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MPIMPRT' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'IMPORT' AND check_number IN (1,2,3,4,5,6,7,8,9,10,11,12,31,32,36);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QAIMPRT' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'IMPORT' AND check_number IN (13,14,15,16,17,18,19,20,21,24,30,33,34,35,37);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'EMIMPRT' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'IMPORT' AND check_number IN (22,23,25,26,27,28,29,38);