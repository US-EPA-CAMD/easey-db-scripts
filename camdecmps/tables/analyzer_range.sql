CREATE TABLE IF NOT EXISTS camdecmps.analyzer_range
(
    analyzer_range_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    component_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    analyzer_range_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    dual_range_ind numeric(38,0),
    begin_date date,
    begin_hour numeric(2,0),
    end_date date,
    end_hour numeric(2,0),
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);

COMMENT ON TABLE camdecmps.analyzer_range
    IS 'Analyzer range data, including changes.';

COMMENT ON COLUMN camdecmps.analyzer_range.analyzer_range_id
    IS 'Unique identifier of an analyzer range history record. ';

COMMENT ON COLUMN camdecmps.analyzer_range.component_id
    IS 'Unique identifier of a monitoring component record. ';

COMMENT ON COLUMN camdecmps.analyzer_range.analyzer_range_cd
    IS 'Code used to identify the analyzer range. ';

COMMENT ON COLUMN camdecmps.analyzer_range.dual_range_ind
    IS 'Used to indicate whether the component is a dual-range analyzer. ';

COMMENT ON COLUMN camdecmps.analyzer_range.begin_date
    IS 'Date in which information became effective or activity started. ';

COMMENT ON COLUMN camdecmps.analyzer_range.begin_hour
    IS 'Hour in which information became effective or activity started. ';

COMMENT ON COLUMN camdecmps.analyzer_range.end_date
    IS 'Last date in which information was effective or date in which activity ended. ';

COMMENT ON COLUMN camdecmps.analyzer_range.end_hour
    IS 'Last hour in which information was effective or hour in which activity ended. ';

COMMENT ON COLUMN camdecmps.analyzer_range.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.analyzer_range.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.analyzer_range.update_date
    IS 'Date and time in which record was last updated. ';
