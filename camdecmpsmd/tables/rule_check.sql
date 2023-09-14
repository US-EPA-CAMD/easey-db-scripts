CREATE TABLE IF NOT EXISTS camdecmpsmd.rule_check
(
    rule_check_id numeric(38,0) NOT NULL,
    category_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    check_catalog_id numeric(38,0) NOT NULL
);

COMMENT ON TABLE camdecmpsmd.rule_check
    IS 'Evaluation check rules.';

COMMENT ON COLUMN camdecmpsmd.rule_check.rule_check_id
    IS ' Unique identifier of a rule check record.';

COMMENT ON COLUMN camdecmpsmd.rule_check.category_cd
    IS ' Code used to identify the check category.';

COMMENT ON COLUMN camdecmpsmd.rule_check.check_catalog_id
    IS ' Unique identifier of a check catalog record.';
