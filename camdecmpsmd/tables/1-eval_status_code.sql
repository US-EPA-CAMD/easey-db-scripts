-- Table: camdecmpsmd.eval_status_code

-- DROP TABLE camdecmpsmd.eval_status_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.eval_status_code
(
    eval_status_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    eval_status_cd_description character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_eval_status_code PRIMARY KEY (eval_status_cd)
);

COMMENT ON TABLE camdecmpsmd.eval_status_code
    IS 'Lookup table containing evaluation status codes.';

COMMENT ON COLUMN camdecmpsmd.eval_status_code.eval_status_cd
    IS 'Identifies the evaluation status.';

COMMENT ON COLUMN camdecmpsmd.eval_status_code.eval_status_cd_description
    IS 'Full description of evaluation status.';

INSERT INTO camdecmpsmd.eval_status_code(eval_status_cd, eval_status_cd_description)
VALUES
    ('EVAL', 'Needs Evaluation'),
    ('INQ', 'In Queue'),
    ('WIP', 'In Progress'),
    ('PASS', 'Passed'),
    ('ERR', 'Critical Errors'),
    ('INFO', 'Informational Message')
;