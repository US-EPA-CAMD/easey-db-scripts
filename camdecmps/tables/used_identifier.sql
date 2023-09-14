CREATE TABLE IF NOT EXISTS camdecmps.used_identifier
(
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    table_cd character varying(1) COLLATE pg_catalog."default" NOT NULL,
    identifier character varying(6) COLLATE pg_catalog."default" NOT NULL,
    type_or_parameter_cd character varying(7) COLLATE pg_catalog."default",
    formula_or_basis_cd character varying(7) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    idkey character varying(45) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmps.used_identifier
    IS 'System, component, formula, stack identifiers used in QA or emissions data.';

COMMENT ON COLUMN camdecmps.used_identifier.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.used_identifier.table_cd
    IS 'Table code. ';

COMMENT ON COLUMN camdecmps.used_identifier.identifier
    IS 'ID previously submitted to EPA Host. ';

COMMENT ON COLUMN camdecmps.used_identifier.type_or_parameter_cd
    IS 'ID type or parameter code. ';

COMMENT ON COLUMN camdecmps.used_identifier.formula_or_basis_cd
    IS 'Formula or basis code. ';

COMMENT ON COLUMN camdecmps.used_identifier.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmps.used_identifier.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmps.used_identifier.update_date
    IS 'Date and time in which record was last updated.';

COMMENT ON COLUMN camdecmps.used_identifier.idkey
    IS 'Unique identifier of used identifier record. ';
