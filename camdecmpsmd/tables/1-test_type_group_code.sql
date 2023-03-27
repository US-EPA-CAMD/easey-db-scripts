-- Table: camdecmpsmd.test_type_group_code

-- DROP TABLE camdecmpsmd.test_type_group_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.test_type_group_code
(
    test_type_group_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    test_type_group_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    child_depth numeric(2,0) DEFAULT 1,
    CONSTRAINT pk_test_type_group_code PRIMARY KEY (test_type_group_cd)
);

COMMENT ON TABLE camdecmpsmd.test_type_group_code
    IS 'Lookup table of test type groups.';

COMMENT ON COLUMN camdecmpsmd.test_type_group_code.test_type_group_cd
    IS 'Code used to identify test type groups. ';

COMMENT ON COLUMN camdecmpsmd.test_type_group_code.test_type_group_cd_description
    IS 'Description of a test type group code. ';


INSERT INTO camdecmpsmd.test_type_group_code(test_type_group_cd, test_type_group_cd_description, child_depth)
VALUES
    ('APPE', 'Appendix E Correlation Summary', 4),
    ('7DAY', 'Calibration Injection', 2),
    ('CYCLE', 'Cycle Time Summary', 3),
    ('F2LCHK', 'Flow to Load Check', 2),
    ('F2LREF', 'Flow to Load Reference', 2),
    ('FF2LBAS', 'Fuel Flow to Load Baseline', 2),
    ('FF2LTST', 'Fuel Flow to Load', 2),
    ('FFACC', 'Fuel Flowmeter Accuracy', 2),
    ('HG', 'Mercury Linearity and 3-Level Summary', 3),
    ('LINE', 'Linearity Summary', 3),
    ('ONOFF', 'Online Offline Calibration', 2),
    ('RATA', 'Relative Accuracy', 6),
    ('FFACCTT', 'Transmitter Transducer Accuracy', 2),
    ('PEI', 'Primary Element Inspection', 1),
    ('UNITDEF', 'Unit Default', 3),
    ('MISC', 'Miscellaneous', 1)
/*
    ('PS11CT', 'PS11 Correlation Test', 3),
    ('RCA', 'Response Correlation Audit', 3),
    ('RRA', 'Relative Response Audit', 3),
    ('SVA', 'Sample Volume Audit', 3),
    ('ACA', 'Absolute Correlation Audit', 3),
    ('3ME', 'Three-Level Measurement Error', 3),
    ('IBI', 'Beam Intensity Test', 2),
    ('RAA', 'Relative Accuracy Audit', 3),
    ('CGA', 'Cylinder Gas Audit', 3),
    ('QGA', 'Quarterly Gas Audit', 2),
    ('DSA', 'Dynamic Spiking Audit', 3)
*/
;



