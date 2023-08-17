-- Table: camdecmpsmd.check_catalog_result

-- DROP TABLE camdecmpsmd.check_catalog_result;

CREATE TABLE IF NOT EXISTS camdecmpsmd.check_catalog_result
(
    check_catalog_result_id numeric(38,0) NOT NULL,
    check_catalog_id numeric(38,0) NOT NULL,
    check_result character varying(75) COLLATE pg_catalog."default" NOT NULL,
    severity_cd character varying(7) COLLATE pg_catalog."default",
    response_catalog_id numeric(38,0),
    es_allowed_ind numeric(1,0) NOT NULL DEFAULT 1,
    CONSTRAINT pk_check_catalog_result PRIMARY KEY (check_catalog_result_id)
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

-- Index: idx_check_catalog_r_check_cata

-- DROP INDEX camdecmpsmd.idx_check_catalog_r_check_cata;

CREATE INDEX IF NOT EXISTS idx_check_catalog_r_check_cata
    ON camdecmpsmd.check_catalog_result USING btree
    (check_catalog_id ASC NULLS LAST);

-- Index: idx_check_catalog_r_response_c

-- DROP INDEX camdecmpsmd.idx_check_catalog_r_response_c;

CREATE INDEX IF NOT EXISTS idx_check_catalog_r_response_c
    ON camdecmpsmd.check_catalog_result USING btree
    (response_catalog_id ASC NULLS LAST);

-- Index: idx_check_catalog_r_severity_c

-- DROP INDEX camdecmpsmd.idx_check_catalog_r_severity_c;

CREATE INDEX IF NOT EXISTS idx_check_catalog_r_severity_c
    ON camdecmpsmd.check_catalog_result USING btree
    (severity_cd COLLATE pg_catalog."default" ASC NULLS LAST);
