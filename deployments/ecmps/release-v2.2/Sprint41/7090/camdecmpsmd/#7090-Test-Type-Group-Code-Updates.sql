DO $$
BEGIN
    
    -- Update Descriptions with Unchange Codes
    UPDATE camdecmpsmd.test_type_group_code set test_type_group_cd_description = 'Fuel Flowmeter Accuracy Test' WHERE test_type_group_cd = 'FFACC';

    -- Insert New Descriptions with New Codes
    INSERT INTO camdecmpsmd.test_type_group_code (test_type_group_cd, test_type_group_cd_description, child_depth) VALUES ('APPE', 'Appendix E Correlation Test', 4);
    INSERT INTO camdecmpsmd.test_type_group_code (test_type_group_cd, test_type_group_cd_description, child_depth) VALUES ('7DAY', '7-Day Calibration Error Test', 2);
    INSERT INTO camdecmpsmd.test_type_group_code (test_type_group_cd, test_type_group_cd_description, child_depth) VALUES ('CYCLE', 'Cycle Time Test', 3);
    INSERT INTO camdecmpsmd.test_type_group_code (test_type_group_cd, test_type_group_cd_description, child_depth) VALUES ('F2LCHK', 'Flow-to-Load Check', 2);
    INSERT INTO camdecmpsmd.test_type_group_code (test_type_group_cd, test_type_group_cd_description, child_depth) VALUES ('F2LREF', 'Flow-to-Load Reference', 2);
    INSERT INTO camdecmpsmd.test_type_group_code (test_type_group_cd, test_type_group_cd_description, child_depth) VALUES ('FF2LBAS', 'Fuel Flow-to-Load Baseline', 2);
    INSERT INTO camdecmpsmd.test_type_group_code (test_type_group_cd, test_type_group_cd_description, child_depth) VALUES ('FF2LTST', 'Fuel Flow-to-Load Test', 2);
    INSERT INTO camdecmpsmd.test_type_group_code (test_type_group_cd, test_type_group_cd_description, child_depth) VALUES ('HGTEST', 'Hg Linearity and 3-Level System Integrity Check Data', 3);
    INSERT INTO camdecmpsmd.test_type_group_code (test_type_group_cd, test_type_group_cd_description, child_depth) VALUES ('LINE', 'Linearity Check Data', 3);
    INSERT INTO camdecmpsmd.test_type_group_code (test_type_group_cd, test_type_group_cd_description, child_depth) VALUES ('ONOFF', 'Online Offline Calibration Error Demonstration', 2);
    INSERT INTO camdecmpsmd.test_type_group_code (test_type_group_cd, test_type_group_cd_description, child_depth) VALUES ('RATA', 'Relative Accuracy Test (RATA)', 6);
    INSERT INTO camdecmpsmd.test_type_group_code (test_type_group_cd, test_type_group_cd_description, child_depth) VALUES ('FFACCTT', 'Transmitter Transducer Test', 2);
    INSERT INTO camdecmpsmd.test_type_group_code (test_type_group_cd, test_type_group_cd_description, child_depth) VALUES ('UNITDEF', 'Unit Default Test', 3);

    -- Update the Test Type Code's Group to the New Group
    UPDATE camdecmpsmd.test_type_code SET group_cd = 'APPE' WHERE group_cd = 'APPESUM';
    UPDATE camdecmpsmd.test_type_code SET group_cd = '7DAY' WHERE group_cd = 'CALINJ';
    UPDATE camdecmpsmd.test_type_code SET group_cd = 'CYCLE' WHERE group_cd = 'CYCSUM';
    UPDATE camdecmpsmd.test_type_code SET group_cd = 'F2LCHK' WHERE group_cd = 'FLC';
    UPDATE camdecmpsmd.test_type_code SET group_cd = 'F2LREF' WHERE group_cd = 'FLR';
    UPDATE camdecmpsmd.test_type_code SET group_cd = 'FF2LBAS' WHERE group_cd = 'FFLB';
    UPDATE camdecmpsmd.test_type_code SET group_cd = 'FF2LTST' WHERE group_cd = 'FFL';
    UPDATE camdecmpsmd.test_type_code SET group_cd = 'LINE' WHERE group_cd = 'LINSUM';
    UPDATE camdecmpsmd.test_type_code SET group_cd = 'HGTEST' WHERE group_cd = 'HGL3LS';
    UPDATE camdecmpsmd.test_type_code SET group_cd = 'ONOFF' WHERE group_cd = 'OLOLCAL';
    UPDATE camdecmpsmd.test_type_code SET group_cd = 'RATA' WHERE group_cd = 'RELACC';
    UPDATE camdecmpsmd.test_type_code SET group_cd = 'FFACCTT' WHERE group_cd = 'TTACC';
    UPDATE camdecmpsmd.test_type_code SET group_cd = 'UNITDEF' WHERE group_cd = 'LME';

    -- Remove the Old Test Type Group Codes with Replacement New Code
    DELETE FROM camdecmpsmd.test_type_group_code WHERE test_type_group_cd = 'APPESUM';
    DELETE FROM camdecmpsmd.test_type_group_code WHERE test_type_group_cd = 'CALINJ';
    DELETE FROM camdecmpsmd.test_type_group_code WHERE test_type_group_cd = 'CYCSUM';
    DELETE FROM camdecmpsmd.test_type_group_code WHERE test_type_group_cd = 'FLC';
    DELETE FROM camdecmpsmd.test_type_group_code WHERE test_type_group_cd = 'FLR';
    DELETE FROM camdecmpsmd.test_type_group_code WHERE test_type_group_cd = 'FFLB';
    DELETE FROM camdecmpsmd.test_type_group_code WHERE test_type_group_cd = 'FFL';
    DELETE FROM camdecmpsmd.test_type_group_code WHERE test_type_group_cd = 'LINSUM';
    DELETE FROM camdecmpsmd.test_type_group_code WHERE test_type_group_cd = 'HGL3LS';
    DELETE FROM camdecmpsmd.test_type_group_code WHERE test_type_group_cd = 'OLOLCAL';
    DELETE FROM camdecmpsmd.test_type_group_code WHERE test_type_group_cd = 'RELACC';
    DELETE FROM camdecmpsmd.test_type_group_code WHERE test_type_group_cd = 'TTACC';
    DELETE FROM camdecmpsmd.test_type_group_code WHERE test_type_group_cd = 'LME';
    
END 44;
