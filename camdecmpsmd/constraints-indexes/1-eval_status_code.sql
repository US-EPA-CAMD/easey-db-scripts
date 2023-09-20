ALTER TABLE IF EXISTS camdecmpsmd.eval_status_code
    ADD CONSTRAINT pk_eval_status_code PRIMARY KEY (eval_status_cd),
    ADD CONSTRAINT uq_eval_status_code_description UNIQUE (eval_status_cd_description);
