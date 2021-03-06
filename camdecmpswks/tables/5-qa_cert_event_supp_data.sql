-- Table: camdecmpswks.qa_cert_event_supp_data

-- DROP TABLE camdecmpswks.qa_cert_event_supp_data;

CREATE TABLE IF NOT EXISTS camdecmpswks.qa_cert_event_supp_data
(
    qa_cert_event_supp_data_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    qa_cert_event_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    qa_cert_event_supp_data_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    qa_cert_event_supp_date_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    count_from_datehour timestamp without time zone NOT NULL,
    count numeric(38,0),
    count_from_included_ind numeric(38,0) NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    delete_ind numeric(1,0) NOT NULL DEFAULT 0,
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_qa_cert_event_supp_data PRIMARY KEY (qa_cert_event_supp_data_id),
    CONSTRAINT fk_qa_cert_event_supp_data_qa_cert_event FOREIGN KEY (qa_cert_event_id)
        REFERENCES camdecmpswks.qa_cert_event (qa_cert_event_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_qa_cert_event_supp_data_data_cd FOREIGN KEY (qa_cert_event_supp_data_cd)
        REFERENCES camdecmpsmd.qa_cert_event_supp_data_code (qa_cert_event_supp_data_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_qa_cert_event_supp_data_date_cd FOREIGN KEY (qa_cert_event_supp_date_cd)
        REFERENCES camdecmpsmd.qa_cert_event_supp_date_code (qa_cert_event_supp_date_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_qa_cert_event_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- -- Index: idx_qa_cert_event_supp_data_ce

-- -- DROP INDEX camdecmpswks.idx_qa_cert_event_supp_data_ce;

-- CREATE INDEX idx_qa_cert_event_supp_data_ce
--     ON camdecmpswks.qa_cert_event_supp_data USING btree
--     (qa_cert_event_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_qa_cert_event_supp_data_da

-- -- DROP INDEX camdecmpswks.idx_qa_cert_event_supp_data_da;

-- CREATE INDEX idx_qa_cert_event_supp_data_da
--     ON camdecmpswks.qa_cert_event_supp_data USING btree
--     (qa_cert_event_supp_data_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_qa_cert_event_supp_data_de

-- -- DROP INDEX camdecmpswks.idx_qa_cert_event_supp_data_de;

-- CREATE INDEX idx_qa_cert_event_supp_data_de
--     ON camdecmpswks.qa_cert_event_supp_data USING btree
--     (qa_cert_event_supp_date_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_qa_cert_event_supp_data_er

-- -- DROP INDEX camdecmpswks.idx_qa_cert_event_supp_data_er;

-- CREATE INDEX idx_qa_cert_event_supp_data_er
--     ON camdecmpswks.qa_cert_event_supp_data USING btree
--     (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_qa_cert_event_supp_data_ml

-- -- DROP INDEX camdecmpswks.idx_qa_cert_event_supp_data_ml;

-- CREATE INDEX idx_qa_cert_event_supp_data_ml
--     ON camdecmpswks.qa_cert_event_supp_data USING btree
--     (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
