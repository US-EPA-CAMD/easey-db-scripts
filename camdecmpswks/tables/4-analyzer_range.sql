-- Table: camdecmpswks.analyzer_range

-- DROP TABLE camdecmpswks.analyzer_range;

CREATE TABLE IF NOT EXISTS camdecmpswks.analyzer_range
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
    CONSTRAINT fk_analyzer_range_analyzer_range_code FOREIGN KEY (analyzer_range_cd)
        REFERENCES camdecmpsmd.analyzer_range_code (analyzer_range_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_analyzer_range_component FOREIGN KEY (component_id)
        REFERENCES camdecmpswks.component (component_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT ck_analyzer_range_begin_date_end_date CHECK (begin_date <= end_date)
);

CREATE INDEX IF NOT EXISTS idx_analyzer_range_component
    ON camdecmpswks.analyzer_range USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;