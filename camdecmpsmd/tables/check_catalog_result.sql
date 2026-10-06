CREATE TABLE IF NOT EXISTS camdecmpsmd.check_catalog_result
(
    check_catalog_result_id numeric(38,0) NOT NULL,
    check_catalog_id numeric(38,0) NOT NULL,
    check_result character varying(75) COLLATE pg_catalog."default" NOT NULL,
    severity_cd character varying(7) COLLATE pg_catalog."default",
    response_catalog_id numeric(38,0),
    es_allowed_ind numeric(1,0) NOT NULL DEFAULT 1
);

COMMENT ON TABLE camdecmpsmd.check_catalog_result
    IS 'Catalog of evaluation check result codes.';

COMMENT ON COLUMN camdecmpsmd.check_catalog_result.check_catalog_result_id
    IS ' Unique identifier of a check catalog result record.';

COMMENT ON COLUMN camdecmpsmd.check_catalog_result.check_catalog_id
    IS ' Unique identifier of a check catalog record.';

COMMENT ON COLUMN camdecmpsmd.check_catalog_result.check_result
    IS ' Check result.';

COMMENT ON COLUMN camdecmpsmd.check_catalog_result.severity_cd
    IS ' Code used to identify the severity of the check result.';

COMMENT ON COLUMN camdecmpsmd.check_catalog_result.response_catalog_id
    IS ' Unique identifier of a response catalog record.';

COMMENT ON COLUMN camdecmpsmd.check_catalog_result.es_allowed_ind
    IS 'Indicates whether error suppression is allowed for this check result.';
