-- Table: camdecmpswks.monitor_qualification_lme

-- DROP TABLE camdecmpswks.monitor_qualification_lme;

CREATE TABLE camdecmpswks.monitor_qualification_lme
(
    mon_lme_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_qual_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    qual_data_year numeric(4,0) NOT NULL,
    so2_tons numeric(4,1),
    nox_tons numeric(4,1),
    op_hours numeric(38,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_monitor_qualification_lme PRIMARY KEY (mon_lme_id),
    CONSTRAINT fk_monitor_qualification_lme_monitor_qualification FOREIGN KEY (mon_qual_id)
        REFERENCES camdecmpswks.monitor_qualification (mon_qual_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);
-- Index: idx_monitor_qualification_lme_mon_qual_id

-- DROP INDEX camdecmpswks.idx_monitor_qualification_lme_mon_qual_id;

CREATE INDEX idx_monitor_qualification_lme_mon_qual_id
    ON camdecmpswks.monitor_qualification_lme USING btree
    (mon_qual_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;