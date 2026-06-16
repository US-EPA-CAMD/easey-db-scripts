-- Update Descriptions with Unchange Codes
UPDATE camdecmpsmd.test_type_group_code SET test_type_group_cd_description = 'Appendix E Correlation Test'                          WHERE test_type_group_cd = 'APPESUM';
UPDATE camdecmpsmd.test_type_group_code SET test_type_group_cd_description = '7-Day Calibration Error Test'                         WHERE test_type_group_cd = 'CALINJ';
UPDATE camdecmpsmd.test_type_group_code SET test_type_group_cd_description = 'Cycle Time Test'                                      WHERE test_type_group_cd = 'CYCSUM';
UPDATE camdecmpsmd.test_type_group_code SET test_type_group_cd_description = 'Fuel Flowmeter Accuracy Test'                         WHERE test_type_group_cd = 'FFACC';
UPDATE camdecmpsmd.test_type_group_code SET test_type_group_cd_description = 'Fuel Flow-to-Load Test'                               WHERE test_type_group_cd = 'FFL';
UPDATE camdecmpsmd.test_type_group_code SET test_type_group_cd_description = 'Fuel Flow-to-Load Baseline'                           WHERE test_type_group_cd = 'FFLB';
UPDATE camdecmpsmd.test_type_group_code SET test_type_group_cd_description = 'Flow-to-Load Check'                                   WHERE test_type_group_cd = 'FLC';
UPDATE camdecmpsmd.test_type_group_code SET test_type_group_cd_description = 'Flow-to-Load Reference'                               WHERE test_type_group_cd = 'FLR';
UPDATE camdecmpsmd.test_type_group_code SET test_type_group_cd_description = 'Hg Linearity and 3-Level System Integrity Check Data' WHERE test_type_group_cd = 'HGL3LS';
UPDATE camdecmpsmd.test_type_group_code SET test_type_group_cd_description = 'Linearity Check Data'                                 WHERE test_type_group_cd = 'LINSUM';
UPDATE camdecmpsmd.test_type_group_code SET test_type_group_cd_description = 'Unit Default Test (LME)'                              WHERE test_type_group_cd = 'LME';
UPDATE camdecmpsmd.test_type_group_code SET test_type_group_cd_description = 'Online Offline Calibration Error Demonstration'       WHERE test_type_group_cd = 'OLOLCAL';
UPDATE camdecmpsmd.test_type_group_code SET test_type_group_cd_description = 'Relative Accuracy Test (RATA)'                        WHERE test_type_group_cd = 'RELACC';
UPDATE camdecmpsmd.test_type_group_code SET test_type_group_cd_description = 'Transmitter Transducer Test'                          WHERE test_type_group_cd = 'TTACC';

COMMIT;
