-- Table: camdecmpsmd.test_type_group_code

-- DROP TABLE camdecmpsmd.test_type_group_code;

CREATE TABLE camdecmpsmd.test_type_group_code
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
    ('APPESUM', 'Appendix E Correlation Test Summary', 4),
    ('CALINJ', 'Calibration Injection', 2),
    ('CYCSUM', 'Cycle Time Summary', 3),
    ('FLC', 'Flow to Load Check', 2),
    ('FLR', 'Flow to Load Reference', 2),
    ('FFLB', 'Fuel Flow to Load Baseline', 2),
    ('FFL', 'Fuel Flow to Load', 2),
    ('FFACC', 'Fuel Flowmeter Accuracy', 2),
    ('HGL3LS', 'Hg Linearity and 3-Level Summary', 3),
    ('LINSUM', 'Linearity Summary', 3),
    ('OLOLCAL', 'Online Offline Calibration', 2),
    ('RELACC', 'Relative Accuracy', 6),
    ('TTACC', 'Transmitter Transducer Accuracy', 2),
    ('PEI', 'Primary Element Inspection', 1),
    ('LME', 'Unit Default', 3),
    ('MISC', 'Miscellaneous', 1)
;



