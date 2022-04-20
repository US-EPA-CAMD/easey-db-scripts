-- Table: camdecmpsmd.eval_score_code

-- DROP TABLE camdecmpsmd.eval_score_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.eval_score_code
(
    eval_score_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    eval_score_description character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_eval_score_code PRIMARY KEY (eval_score_cd)
);