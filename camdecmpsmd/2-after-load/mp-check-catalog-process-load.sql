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
WHERE check_type_cd = 'DEFAULT' AND check_number IN (37, 38, 39, 40, 41, 42 ,47, 48, 49, 50, 51, 52, 53, 54, 56, 58, 73, 74, 75, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 97, 98, 99, );

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MPSCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'DEFAULT' AND check_number IN (37, 38, 39, 40, 41, 42, 47, 48, 49, 50, 51, 52, 53, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89. 90, 91, 98, 95, 96);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MP' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'FORMULA' AND check_number IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 19, 20);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MPSCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'FORMULA' AND check_number IN (1, 2, 3, 4, 5, 7, 8, 9, 10, 18);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MP' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'FUEL' AND check_number IN (39, 40, 41, 42, 43, 44, 45, 46, 48, 49, 51, 52);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MPSCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'FUEL' AND check_number IN (40, 41, 42, 43, 44, 45, 49, 51);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MP' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'FUELFLW' AND check_number IN (2, 3, 4, 5, 6, 7, 8, 10, 11, 17, 18, 19);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MPSCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'FUELFLW' AND check_number IN (2, 3, 4, 5, 6, 7, 8, 10);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MP' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'LOAD' AND check_number IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 17, 19, 20);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MPSCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'LOAD' AND check_number IN (2, 3, 4, 5, 6, 8, 13, 21, 22, 23, 24, 25, 26);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MP' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'MONLOC' AND check_number IN (2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 19, 74, 76, 77, 80, 81, 82, 83, 85, 86, 87, 88, 97, 98, 99, 100, 101, 103, 104, 105, 111);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MPSCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'MONLOC' AND check_number IN (2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 19, 74, 76, 81, 82, 83, 88, 106, 107, 109);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MP' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'MATSMTH' AND check_number IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MPSCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'MATSMTH' AND check_number IN (1, 2, 3, 4, 5, 6, 7, 8);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MP' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'METHOD' AND check_number IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14, 15, 16, 17, 18, 19, 20, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 37, 39, 40);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MPSCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'METHOD' AND check_number IN (1, 2, 3, 4, 5, 7, 8, 9, 10, 36);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MP' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = '' AND check_number IN (1, 4, 5, 6, 8, 9, 10, 11, 12, 13);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MPSCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = '' AND check_number IN (4, 5, 11, 3, 7);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MP' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'PROGRAM' AND check_number IN (1, 10, 11, 12, 14);


-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MP' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'QUAL' AND check_number IN (1, 3, 5, 7, 8, 11, 12, 14, 16, 18, 19, 20, 22, 23, 24, 25, 27, 28, 29, 34, 38, 39, 40, 41, 42, 43, 44, 45);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MPSCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'QUAL' AND check_number IN (7, 8, 16, 18, 19, 20, 22, 25, 27, 28, 29, 40, 41, 42, 43, 44, 45, 35, 36, 37, 46, 47);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MP' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'QUALLEE' AND check_number IN (1, 2, 3);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MPSCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'QUALLEE' AND check_number IN (1, 2, 3);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MP' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'SPAN' AND check_number IN (1, 2, 3, 4, 6, 7, 8, 9, 10, 11, 12, 13, 16, 17, 18, 20, 21, 36, 37, 47, 48, 50, 52, 53, 54, 60, 61);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MPSCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'SPAN' AND check_number IN (3, 6, 7, 8, 9, 10, 11, 12, 16, 17, 18, 20, 21, 36, 37, 50, 60, 61, 55, 56, 57, 58, 59);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MP' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'SYSTEM' AND check_number IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'MPSCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'SYSTEM' AND check_number IN (1, 2, 3, 4, 5, 7, 8, 9, 10, 24);