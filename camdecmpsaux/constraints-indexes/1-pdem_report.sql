ALTER TABLE IF EXISTS camdecmpsaux.pdem_report
    ADD CONSTRAINT pdem_report_pk PRIMARY KEY ( pdem_report_id ),
    ADD CONSTRAINT pdem_report_uq UNIQUE ( mon_plan_id, rpt_period_id, submission_id ),
    ADD CONSTRAINT pdem_report_atc_fk FOREIGN KEY ( apportionment_type_cd ) REFERENCES camdecmpsmd.apportionment_type_code( apportionment_type_cd ),
    ADD CONSTRAINT pdem_report_pln_fk FOREIGN KEY ( mon_plan_id ) REFERENCES camdecmps.monitor_plan( mon_plan_id ),
    ADD CONSTRAINT pdem_report_prd_fk FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period( rpt_period_id ),
    ADD CONSTRAINT pdem_report_sub_fk FOREIGN KEY ( submission_id ) REFERENCES camdecmpsaux.submission_queue( submission_id ),
    ADD CONSTRAINT pdem_report_stm_ck CHECK ( triggered_time is not null or started_time is null ),
    ADD CONSTRAINT pdem_report_ctm_ck CHECK ( triggered_time is not null and started_time is not null and note_time is null or completed_time is null ),
    ADD CONSTRAINT pdem_report_ntm_ck CHECK ( triggered_time is not null and started_time is not null and completed_time is null or note_time is null ),
    ADD CONSTRAINT pdem_report_nte_ck CHECK ( ( note_time is not null ) =  ( note is not null) );

CREATE INDEX pdem_report_atc_ix ON camdecmpsaux.pdem_report USING btree ( apportionment_type_cd );
CREATE INDEX pdem_report_pln_ix ON camdecmpsaux.pdem_report USING btree ( mon_plan_id );
CREATE INDEX pdem_report_prd_ix ON camdecmpsaux.pdem_report USING btree ( rpt_period_id );
