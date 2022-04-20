-- Table: camdecmpsmd.check_parameter_code

-- DROP TABLE camdecmpsmd.check_parameter_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.check_parameter_code
(
    check_param_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    check_param_id_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    check_param_id_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    display_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    source_table character varying(100) COLLATE pg_catalog."default",
    check_data_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    chk_param_type_cd character varying(7) COLLATE pg_catalog."default",
    object_type character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT pk_check_parameter_code PRIMARY KEY (check_param_id),
    CONSTRAINT fk_check_parameter_code_check_data_type_code FOREIGN KEY (check_data_type_cd)
        REFERENCES camdecmpsmd.check_data_type_code (check_data_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_check_parameter_code_check_parameter_type_code FOREIGN KEY (chk_param_type_cd)
        REFERENCES camdecmpsmd.check_parameter_type_code (chk_param_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- Index: ix_check_parameter_code_name

-- DROP INDEX camdecmpsmd.ix_check_parameter_code_name;

CREATE INDEX ix_check_parameter_code_name
    ON camdecmpsmd.check_parameter_code USING btree
    (check_param_id_name COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: uq_check_parameter_code_name

-- DROP INDEX camdecmpsmd.uq_check_parameter_code_name;

CREATE UNIQUE INDEX uq_check_parameter_code_name
    ON camdecmpsmd.check_parameter_code USING btree
    (check_param_id_name COLLATE pg_catalog."default" ASC NULLS LAST);
