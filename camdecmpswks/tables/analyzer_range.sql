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
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);
