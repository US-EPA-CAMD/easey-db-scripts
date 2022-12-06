-- Table: camdecmpsmd.common_stack_test_code

-- DROP TABLE camdecmpsmd.common_stack_test_code;

CREATE TABLE camdecmpsmd.common_stack_test_code
(
    common_stack_test_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    common_stack_test_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_common_stack_test_code PRIMARY KEY (common_stack_test_cd)
);