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
