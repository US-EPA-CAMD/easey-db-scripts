CREATE TABLE IF NOT EXISTS camdecmpsaux.es_spec
(
    es_spec_id numeric(38,0) NOT NULL,
    check_catalog_result_id numeric(38,0) NOT NULL,
    severity_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    fac_id numeric(38,0),
    location_name_list character varying(1000) COLLATE pg_catalog."default",
    es_match_data_type_cd character varying(7) COLLATE pg_catalog."default",
    match_data_value character varying(100) COLLATE pg_catalog."default",
    es_match_time_type_cd character varying(7) COLLATE pg_catalog."default",
    match_historical_ind numeric(1,0),
    match_time_begin_value timestamp without time zone,
    match_time_end_value timestamp without time zone,
    di character varying(50) COLLATE pg_catalog."default" NOT NULL,
    es_reason_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    note character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    active_ind numeric(1,0) NOT NULL DEFAULT 1,
    userid character varying(160) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
);

COMMENT ON TABLE camdecmpsaux.es_spec
    IS 'Error Suppression Specifications';

COMMENT ON COLUMN camdecmpsaux.es_spec.es_spec_id
    IS 'Unique identifier of an Error Suppression Spec record.';

COMMENT ON COLUMN camdecmpsaux.es_spec.check_catalog_result_id
    IS 'The id of the Check Result being suppressed.';

COMMENT ON COLUMN camdecmpsaux.es_spec.severity_cd
    IS 'Code used to identify the severity of the check result.';

COMMENT ON COLUMN camdecmpsaux.es_spec.fac_id
    IS 'The specific facility, if any, for which the suppression should occur.';

COMMENT ON COLUMN camdecmpsaux.es_spec.location_name_list
    IS 'The specific location, if any, for which the suppression should occur.';

COMMENT ON COLUMN camdecmpsaux.es_spec.es_match_data_type_cd
    IS 'The matching data type for the suppression.';

COMMENT ON COLUMN camdecmpsaux.es_spec.match_data_value
    IS 'The matching data value for the suppression.';

COMMENT ON COLUMN camdecmpsaux.es_spec.es_match_time_type_cd
    IS 'The matching time type for the suppression.';

COMMENT ON COLUMN camdecmpsaux.es_spec.match_historical_ind
    IS 'The matching data value for the suppression.';

COMMENT ON COLUMN camdecmpsaux.es_spec.match_time_begin_value
    IS 'The matching data value for the suppression.';

COMMENT ON COLUMN camdecmpsaux.es_spec.match_time_end_value
    IS 'The matching data value for the suppression.';

COMMENT ON COLUMN camdecmpsaux.es_spec.di
    IS 'The data integrity value of the error suppression.';

COMMENT ON COLUMN camdecmpsaux.es_spec.es_reason_cd
    IS 'The reason for the suppression.';

COMMENT ON COLUMN camdecmpsaux.es_spec.note
    IS 'Additional information about the suppression.';

COMMENT ON COLUMN camdecmpsaux.es_spec.active_ind
    IS 'Whether the suppression is active.';

COMMENT ON COLUMN camdecmpsaux.es_spec.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmpsaux.es_spec.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmpsaux.es_spec.update_date
    IS 'Date and time in which record was last updated.';
