ALTER TABLE IF EXISTS camdecmpsmd.rule_check
    rule_check_id numeric(38,0) NOT NULL,
    category_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    check_catalog_id numeric(38,0) NOT NULL,
    ADD CONSTRAINT pk_rule_check PRIMARY KEY (rule_check_id),
    ADD CONSTRAINT uq_rule_check UNIQUE (check_catalog_id, category_cd);
    ADD CONSTRAINT pk_rule_check_category_code FOREIGN KEY (category_cd)
        REFERENCES camdecmpsmd.category_code (category_cd) MATCH SIMPLE,
    ADD CONSTRAINT pk_rule_check_check_catalog FOREIGN KEY (check_catalog_id)
        REFERENCES camdecmpsmd.check_catalog (check_catalog_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_rule_check_category_cd
    ON camdecmpsmd.rule_check USING btree
    (category_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_rule_check_check_catalog_id
    ON camdecmpsmd.rule_check USING btree
    (check_catalog_id COLLATE pg_catalog."default" ASC NULLS LAST);
