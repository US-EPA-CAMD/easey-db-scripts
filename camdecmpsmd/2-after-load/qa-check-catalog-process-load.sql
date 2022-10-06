INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QA' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'SEVNDAY' AND check_number IN (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,31,32,33);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QASCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'SEVNDAY' AND check_number IN (1,3,5,6,7,8,9,10,11,12,13,14,28,29,30,31,32,33,34);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QA' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'AETB' AND check_number IN (1,2,3,4,5,6,7,8,9,10);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QASCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'AETB' AND check_number IN (1,2,3,4,5,6,7,8,9);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QA' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'APPE' AND check_number IN (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,52);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QASCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'APPE' AND check_number IN (1,3,4,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,45,46,47,48,49,50,51,53,54,55,56);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QA' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'CYCLE' AND check_number IN (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QASCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'CYCLE' AND check_number IN (1,4,5,6,7,8,10,11,12,17,18,19,20,21,22);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QA' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'F2LCHK' AND check_number IN (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QASCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'F2LCHK' AND check_number IN (2,3,4,5,6,7,8,9,10,11,12,13,14,16,17,18,19);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QA' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'F2LREF' AND check_number IN (1,2,3,4,5,6,7,8,9,10,11,12,13);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QASCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'F2LREF' AND check_number IN (2,3,4,5,6,7,10,11,12,13,14,15,16);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QA' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'FFACC' AND check_number IN (1,2,3,4,5,6,7,8,9,10,11,14);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QASCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'FFACC' AND check_number IN (3,4,5,6,7,8,9,10,11,12,13,14);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QA' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'FF2LBAS' AND check_number IN (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QASCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'FF2LBAS' AND check_number IN (2,3,4,5,6,7,8,10,11,12,13,14,15,16,17,18,19,20);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QA' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'FF2LTST' AND check_number IN (1,2,3,4,5,6,7,8,9,10,11,12);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QASCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'FF2LTST' AND check_number IN (2,3,5,6,7,8,9,10,11,12,13,14);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QA' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'TEST' AND check_number IN (1,2,3,4,5,6,7,8,9,10,12,14,15,16,17,18,20,21,22,23,24);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QASCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'TEST' AND check_number IN (1,2,3,4,5,6,7,8,10,12,13,14,15,16,17,18,19,20,23,24);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QA' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'LINEAR' AND check_number IN (1,2,3,4,5,6,9,11,12,13,14,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,36,37);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QASCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'LINEAR' AND check_number IN (4,9,10,15,16,17,18,19,20,21,30,31,32,33,34,35,36,37,38);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QA' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'ONOFF' AND check_number IN (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,40,41,42,43,44);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QASCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'ONOFF' AND check_number IN (3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,37,38,39,40,41,42,43,44,45);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QA' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'PGVP' AND check_number IN (1,2,3,4,5,6,7,10,11,14);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QASCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'PGVP' AND check_number IN (2,3,4,5,8,9,12,13,14);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QA' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'QACERT' AND check_number IN (1,2,3,4,5,6,7,8,9,10,12,13,14,15,16);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QASCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'QACERT' AND check_number IN (1,2,3,4,5,6,7,8,9,10,11);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QA' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'RATA' AND check_number IN (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,87,88,89,90,91,92,93,94,95,96,97,98,122,131,132);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QASCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'RATA' AND check_number IN (1,4,9,10,11,14,16,17,18,19,20,21,22,23,24,26,27,29,30,31,33,49,54,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,81,82,83,85,94,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,123,124,125,126,127,128,129,130);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QA' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'EXTEXEM' AND check_number IN (1,2,3,4,5,6,7,9);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QASCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'EXTEXEM' AND check_number IN (1,2,3,4,5,6,7,8);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QA' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'FFACCTT' AND check_number IN (1,2,3,4,5,6,7,8,9,10,11,14);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QASCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'FFACCTT' AND check_number IN (3,4,5,6,7,8,9,10,11,12,13,14);

-----------------------------------------------------------------------------------------------
INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QA' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'UNITDEF' AND check_number IN (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27);

INSERT INTO camdecmpsmd.check_catalog_process(check_catalog_id, process_cd)
SELECT check_catalog_id, 'QASCRN' FROM camdecmpsmd.check_catalog 
WHERE check_type_cd = 'UNITDEF' AND check_number IN (1,2,3,4,5,6,8,9,16,17,18,19,20,21,28,29,30);
