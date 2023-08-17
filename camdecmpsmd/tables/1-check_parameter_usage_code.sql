-- Table: camdecmpsmd.check_parameter_usage_code

-- DROP TABLE camdecmpsmd.check_parameter_usage_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.check_parameter_usage_code
(
    check_param_usage_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    check_param_usage_cd_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_check_parameter_usage_code PRIMARY KEY (check_param_usage_cd)
);

-- Index: uq_check_parameter_usage_code

-- DROP INDEX camdecmpsmd.uq_check_parameter_usage_code;

CREATE UNIQUE INDEX IF NOT EXISTS uq_check_parameter_usage_code
    ON camdecmpsmd.check_parameter_usage_code USING btree
    (check_param_usage_cd_name COLLATE pg_catalog."default" ASC NULLS LAST);
