ALTER TABLE IF EXISTS camdecmpsaux.pdem_report_user
    ADD CONSTRAINT pdem_report_user_pk PRIMARY KEY ( pdem_report_user_id ),
    ADD CONSTRAINT pdem_report_user_uq UNIQUE ( pdem_report_id, pdem_report_user_cd ),
    ADD CONSTRAINT pdem_report_user_rpt_fk FOREIGN KEY ( pdem_report_id ) REFERENCES camdecmpsaux.pdem_report ( pdem_report_id ) ON DELETE CASCADE,
    ADD CONSTRAINT pdem_report_user_usr_fk FOREIGN KEY ( pdem_report_user_cd ) REFERENCES camdecmpsmd.pdem_report_user_code ( pdem_report_user_cd );

CREATE INDEX pdem_report_user_rpt_ix ON camdecmpsaux.pdem_report_user USING btree ( pdem_report_id );
