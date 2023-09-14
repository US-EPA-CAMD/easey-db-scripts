ALTER TABLE IF EXISTS camdaux.template_code
    ADD CONSTRAINT pk_template_code PRIMARY KEY (template_cd),
    ADD CONSTRAINT ck_template_type CHECK (template_type::text = ANY (ARRAY['1COLTBL'::text, '2COLTBL'::text, '3COLTBL'::text, 'DEFAULT'::text]));

CREATE INDEX IF NOT EXISTS idx_template_code_group_cd
    ON camdaux.template_code USING btree
    (group_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_template_code_template_type
    ON camdaux.template_code USING btree
    (template_type COLLATE pg_catalog."default" ASC NULLS LAST);
