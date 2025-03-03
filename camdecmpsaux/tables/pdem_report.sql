CREATE TABLE IF NOT EXISTS camdecmpsaux.pdem_report
(
	pdem_report_id              bigserial,
	mon_plan_id                 varchar(45) NOT NULL,
	rpt_period_id               numeric(38) NOT NULL,
	submission_id               bigint NOT NULL,
	apportionment_type_cd       varchar(35) NULL,
    queued_time                 timestamp without time zone DEFAULT current_timestamp NOT NULL,
    started_time                timestamp without time zone,
    completed_time              timestamp without time zone,
    note                        text COLLATE pg_catalog."default",
    note_time                   timestamp without time zone,
    
    CONSTRAINT pdem_report_pk PRIMARY KEY ( pdem_report_id ),
	CONSTRAINT pdem_report_uq UNIQUE ( mon_plan_id, rpt_period_id, submission_id ),
	CONSTRAINT pdem_report_atc_fk FOREIGN KEY ( apportionment_type_cd ) REFERENCES camdecmpsmd.apportionment_type_code( apportionment_type_cd ),
	CONSTRAINT pdem_report_pln_fk FOREIGN KEY ( mon_plan_id ) REFERENCES camdecmps.monitor_plan( mon_plan_id ),
	CONSTRAINT pdem_report_prd_fk FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period( rpt_period_id ),
	CONSTRAINT pdem_report_sub_fk FOREIGN KEY ( submission_id ) REFERENCES camdecmpsaux.submission_queue( submission_id )
);

CREATE INDEX pdem_report_atc_ix ON camdecmpsaux.pdem_report USING btree ( apportionment_type_cd );
CREATE INDEX pdem_report_pln_ix ON camdecmpsaux.pdem_report USING btree ( mon_plan_id );
CREATE INDEX pdem_report_prd_ix ON camdecmpsaux.pdem_report USING btree ( rpt_period_id );

-- Table Comment
COMMENT ON TABLE camdecmpsaux.pdem_report IS 'The parent table for the Progam Data Emissions (PDEM) working data.';

-- Column Comments
COMMENT ON COLUMN camdecmpsaux.pdem_report.pdem_report_id IS 'Primary key.';
COMMENT ON COLUMN camdecmpsaux.pdem_report.mon_plan_id IS 'Foreign key into the camdecmps.MONITOR_PLAN table that uniquely identifies a monitoring plan of the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_report.rpt_period_id IS 'Foreign key into the REPORTING_PERIOD table that uniquely indentifies the reporting period of the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_report.submission_id IS 'Foreign key into the SUBMISSION_QUEUE table that uniquely identifies the (emisson report) submission generating the Program Data Emissions (PDEM).';
COMMENT ON COLUMN camdecmpsaux.pdem_report.apportionment_type_cd IS 'Code used to indicate the apportionment type of an emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_report.queued_time IS 'The timestamp for when the generation of the Program Data Emissions was gueued.';
COMMENT ON COLUMN camdecmpsaux.pdem_report.started_time IS 'The timestamp for when the generation of the Program Data Emissions was started.';
COMMENT ON COLUMN camdecmpsaux.pdem_report.completed_time IS 'The timestamp for when the generation of the Program Data Emissions was successfully completed.';
COMMENT ON COLUMN camdecmpsaux.pdem_report.note IS 'The note indicating why the generation of the Program Data Emissions failed.';
COMMENT ON COLUMN camdecmpsaux.pdem_report.note_time IS 'The timestamp for when the generation of the Program Data Emissions failed.';
