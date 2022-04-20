-- Table: camdecmpsmd.severity_code

-- DROP TABLE camdecmpsmd.severity_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.severity_code
(
    severity_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    severity_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    severity_level numeric(2,0),
    es_type_ind numeric(1,0) NOT NULL DEFAULT 1,
    eval_status_cd character varying(7) COLLATE pg_catalog."default",
    CONSTRAINT pk_severity_code PRIMARY KEY (severity_cd),
    CONSTRAINT uq_severity_code_desc UNIQUE (severity_cd_description),
    CONSTRAINT uq_severity_code_lvl UNIQUE (severity_level),
    CONSTRAINT fk_severity_code_eval_status_code FOREIGN KEY (eval_status_cd)
        REFERENCES camdecmpsmd.eval_status_code (eval_status_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmpsmd.severity_code
    IS 'Lookup table for evaluation check severity codes.';

COMMENT ON COLUMN camdecmpsmd.severity_code.severity_cd
    IS ' Code used to identify the severity of the check result.';

COMMENT ON COLUMN camdecmpsmd.severity_code.severity_cd_description
    IS ' Description of lookup code.';

COMMENT ON COLUMN camdecmpsmd.severity_code.severity_level
    IS ' The severity level of the severity code.';

COMMENT ON COLUMN camdecmpsmd.severity_code.es_type_ind
    IS '1 indicates that the Severity Code is also an Error Suppression Type.';