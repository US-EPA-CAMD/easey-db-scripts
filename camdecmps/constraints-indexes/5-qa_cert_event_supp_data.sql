ALTER TABLE IF EXISTS camdecmps.qa_cert_event_supp_data
    ADD CONSTRAINT pk_qa_cert_event_supp_data PRIMARY KEY (qa_cert_event_supp_data_id),
    ADD CONSTRAINT fk_qa_cert_event_supp_data_data_cd FOREIGN KEY (qa_cert_event_supp_data_cd)
        REFERENCES camdecmpsmd.qa_cert_event_supp_data_code (qa_cert_event_supp_data_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_qa_cert_event_supp_data_date_cd FOREIGN KEY (qa_cert_event_supp_date_cd)
        REFERENCES camdecmpsmd.qa_cert_event_supp_date_code (qa_cert_event_supp_date_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_qa_cert_event_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_qa_cert_event_supp_data_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_qa_cert_event_supp_data_qa_cert_event FOREIGN KEY (qa_cert_event_id)
        REFERENCES camdecmps.qa_cert_event (qa_cert_event_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_supp_data_qa_cert_event_id
    ON camdecmps.qa_cert_event_supp_data USING btree
    (qa_cert_event_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_supp_data_qa_cert_event_supp_data_cd
    ON camdecmps.qa_cert_event_supp_data USING btree
    (qa_cert_event_supp_data_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_supp_data_qa_cert_event_supp_date_cd
    ON camdecmps.qa_cert_event_supp_data USING btree
    (qa_cert_event_supp_date_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_supp_data_mon_loc_id
    ON camdecmps.qa_cert_event_supp_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_supp_data_rpt_period_id
    ON camdecmps.qa_cert_event_supp_data USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_supp_data_rpt_period_id_mon_loc_id
    ON camdecmps.qa_cert_event_supp_data USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
