CREATE TABLE camdecmpsmd.eval_status_code
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


-- LOAD EVALUATION STATUS CODES
INSERT INTO camdecmpsmd.eval_status_code(
	eval_status_cd, eval_status_cd_description)
	VALUES ('EVAL', 'Needs Evaluation');

INSERT INTO camdecmpsmd.eval_status_code(
	eval_status_cd, eval_status_cd_description)
	VALUES ('INQ', 'In Queue');

INSERT INTO camdecmpsmd.eval_status_code(
	eval_status_cd, eval_status_cd_description)
	VALUES ('WIP', 'In Progress');

INSERT INTO camdecmpsmd.eval_status_code(
	eval_status_cd, eval_status_cd_description)
	VALUES ('PASS', 'Passed');

INSERT INTO camdecmpsmd.eval_status_code(
	eval_status_cd, eval_status_cd_description)
	VALUES ('ERR', 'Critical Errors');

INSERT INTO camdecmpsmd.eval_status_code(
	eval_status_cd, eval_status_cd_description)
	VALUES ('INFO', 'Informational Message');
