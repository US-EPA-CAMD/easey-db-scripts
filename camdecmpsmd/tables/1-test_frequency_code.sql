-- Table: camdecmpsmd.test_frequency_code

-- DROP TABLE camdecmpsmd.test_frequency_code;

CREATE TABLE camdecmpsmd.test_frequency_code
(
    test_frequency_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    test_frequency_cd_description character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_test_frequency_code PRIMARY KEY (test_frequency_cd)
);