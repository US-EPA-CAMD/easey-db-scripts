ALTER TABLE IF EXISTS camdecmpsmd.eval_score_code
    ADD CONSTRAINT pk_eval_score_code PRIMARY KEY (eval_score_cd),
    ADD CONSTRAINT uq_eval_score_code_description UNIQUE (eval_score_description);
