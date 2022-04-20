-- Table: camdecmpsmd.check_operator_data_type

-- DROP TABLE camdecmpsmd.check_operator_data_type;

CREATE TABLE IF NOT EXISTS camdecmpsmd.check_operator_data_type
(
    check_operator_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    check_data_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_check_operator_data_type PRIMARY KEY (check_operator_cd, check_data_type_cd),
    CONSTRAINT fk_check_operator_data_type_check_data_type_code FOREIGN KEY (check_data_type_cd)
        REFERENCES camdecmpsmd.check_data_type_code (check_data_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_check_operator_data_type_check_operator_code FOREIGN KEY (check_operator_cd)
        REFERENCES camdecmpsmd.check_operator_code (check_operator_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);