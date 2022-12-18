-- Table: camdecmpsmd.rule_check

-- DROP TABLE camdecmpsmd.rule_check;

CREATE TABLE IF NOT EXISTS camdecmpsmd.rule_check
(
    rule_check_id numeric(38,0) NOT NULL,
    category_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    check_catalog_id numeric(38,0) NOT NULL,
    CONSTRAINT pk_rule_check PRIMARY KEY (rule_check_id),
    CONSTRAINT pk_category_code_rule_check FOREIGN KEY (category_cd)
        REFERENCES camdecmpsmd.category_code (category_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT pk_check_catalog_rule_check FOREIGN KEY (check_catalog_id)
        REFERENCES camdecmpsmd.check_catalog (check_catalog_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmpsmd.rule_check
    IS 'Evaluation check rules.';

COMMENT ON COLUMN camdecmpsmd.rule_check.rule_check_id
    IS ' Unique identifier of a rule check record.';

COMMENT ON COLUMN camdecmpsmd.rule_check.category_cd
    IS ' Code used to identify the check category.';

COMMENT ON COLUMN camdecmpsmd.rule_check.check_catalog_id
    IS ' Unique identifier of a check catalog record.';

-- Index: idx_rule_check_category_c

-- DROP INDEX camdecmpsmd.idx_rule_check_category_c;

CREATE INDEX IF NOT EXISTS idx_rule_check_category_c
    ON camdecmpsmd.rule_check USING btree
    (category_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: uq_rule_chk_chk_cata_cate

-- DROP INDEX camdecmpsmd.uq_rule_chk_chk_cata_cate;

CREATE UNIQUE INDEX uq_rule_chk_chk_cata_cate
    ON camdecmpsmd.rule_check USING btree
    (check_catalog_id ASC NULLS LAST, category_cd COLLATE pg_catalog."default" ASC NULLS LAST);
