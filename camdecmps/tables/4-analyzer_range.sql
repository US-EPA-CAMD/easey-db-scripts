-- Table: camdecmps.analyzer_range

-- DROP TABLE camdecmps.analyzer_range;

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
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_analyzer_range PRIMARY KEY (analyzer_range_id),
    CONSTRAINT fk_analyzer_rang_analyzer_rang FOREIGN KEY (analyzer_range_cd)
        REFERENCES camdecmpsmd.analyzer_range_code (analyzer_range_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_component_analyzer_rang FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT analyzer_range_c01 CHECK (begin_date <= end_date)
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

-- Index: idx_analyzer_range_analyzer_r

-- DROP INDEX camdecmps.idx_analyzer_range_analyzer_r;

CREATE INDEX idx_analyzer_range_analyzer_r
    ON camdecmps.analyzer_range USING btree
    (analyzer_range_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_analyzer_range_component

-- DROP INDEX camdecmps.idx_analyzer_range_component;

CREATE INDEX idx_analyzer_range_component
    ON camdecmps.analyzer_range USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);
