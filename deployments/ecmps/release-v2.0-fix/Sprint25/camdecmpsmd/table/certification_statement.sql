CREATE TABLE IF NOT EXISTS camdecmpsmd.certification_statement
(
    statement_id integer NOT NULL,
	prg_cd character varying(7) COLLATE pg_catalog."default" NULL,
    statement_location character varying(200) COLLATE pg_catalog."default" NOT NULL,
	display_order integer NOT NULL
);

COMMENT ON TABLE camdecmpsmd.certification_statement
    IS 'Certification Statement Table.';

COMMENT ON COLUMN camdecmpsmd.certification_statement.statement_id
    IS 'Certification Statement Ids';

COMMENT ON COLUMN camdecmpsmd.certification_statement.prg_cd
    IS 'Program code values.';

COMMENT ON COLUMN camdecmpsmd.certification_statement.statement_location
    IS 'Path to certification statement files in the EASEY Content.';

COMMENT ON COLUMN camdecmpsmd.certification_statement.display_order
    IS 'Order using statement_id.';

CREATE UNIQUE INDEX prg_cd_unique ON camdecmpsmd.certification_statement (prg_cd)
WHERE prg_cd IS NOT NULL;

ALTER TABLE IF EXISTS camdecmpsmd.certification_statement
    ADD CONSTRAINT pk_certification_statement PRIMARY KEY (statement_id);