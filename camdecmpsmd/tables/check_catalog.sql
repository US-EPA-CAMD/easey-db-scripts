CREATE TABLE IF NOT EXISTS camdecmpsmd.check_catalog
(
    check_catalog_id numeric(38,0) NOT NULL,
    check_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    check_number numeric(38,0) NOT NULL,
    check_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    check_description character varying(1000) COLLATE pg_catalog."default",
    check_procedure character varying(200) COLLATE pg_catalog."default",
    old_check_name character varying(100) COLLATE pg_catalog."default",
    tech_note text COLLATE pg_catalog."default",
    todo_note character varying(1000) COLLATE pg_catalog."default",
    check_applicability_cd character varying(7) COLLATE pg_catalog."default",
    check_status_cd character varying(7) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    test_status_cd character varying(7) COLLATE pg_catalog."default",
    code_status_cd character varying(7) COLLATE pg_catalog."default",
    run_check_flg character varying(1) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmpsmd.check_catalog
    IS 'Catalog of evaluation checks.';

COMMENT ON COLUMN camdecmpsmd.check_catalog.check_catalog_id
    IS ' Unique identifier of a check catalog record.';

COMMENT ON COLUMN camdecmpsmd.check_catalog.check_type_cd
    IS ' Code used to identify the check type.';

COMMENT ON COLUMN camdecmpsmd.check_catalog.check_number
    IS ' The check number.';

COMMENT ON COLUMN camdecmpsmd.check_catalog.check_name
    IS ' The name of the check.';

COMMENT ON COLUMN camdecmpsmd.check_catalog.check_description
    IS ' Description of lookup code.';

COMMENT ON COLUMN camdecmpsmd.check_catalog.check_procedure
    IS ' The check procedure.';

COMMENT ON COLUMN camdecmpsmd.check_catalog.old_check_name
    IS ' The old check name.';

COMMENT ON COLUMN camdecmpsmd.check_catalog.tech_note
    IS ' The text of the check specification.';

COMMENT ON COLUMN camdecmpsmd.check_catalog.todo_note
    IS ' Note related to the check specification.';

COMMENT ON COLUMN camdecmpsmd.check_catalog.check_applicability_cd
    IS ' Code used to identify the check applicability.';

COMMENT ON COLUMN camdecmpsmd.check_catalog.check_status_cd
    IS ' Code used to identify the check status.';

COMMENT ON COLUMN camdecmpsmd.check_catalog.test_status_cd
    IS ' Code used to identify the test status.';

COMMENT ON COLUMN camdecmpsmd.check_catalog.code_status_cd
    IS ' Code used to identify the code status.';

COMMENT ON COLUMN camdecmpsmd.check_catalog.run_check_flg
    IS ' Flag indicating the run check status.';
