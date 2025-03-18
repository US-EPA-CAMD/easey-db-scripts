CREATE TABLE IF NOT EXISTS camdecmpsaux.pdem_report
(
	pdem_report_id              bigserial,
	mon_plan_id                 varchar(45) NOT NULL,
	rpt_period_id               numeric(38) NOT NULL,
	submission_id               bigint NOT NULL,
	apportionment_type_cd       varchar(35) NULL,
    queued_time                 timestamp without time zone DEFAULT current_timestamp NOT NULL,
    triggered_time              timestamp without time zone,
    started_time                timestamp without time zone,
    completed_time              timestamp without time zone,
    note                        text COLLATE pg_catalog."default",
    note_time                   timestamp without time zone,
    status_cd                   varchar(8) generated always as ( 
                                                                    case 
                                                                        when ( triggered_time is null ) and ( started_time is null ) and ( completed_time is null ) and ( note_time is null )
                                                                        then 'QUEUED'
                                                                        when ( triggered_time is not null ) and ( started_time is null ) and ( completed_time is null ) and ( note_time is null )
                                                                        then 'WIP'
                                                                        when ( triggered_time is not null ) and ( started_time is not null ) and ( completed_time is null ) and ( note_time is null )
                                                                        then 'WIP'
                                                                        when ( triggered_time is not null ) and ( started_time is not null ) and ( completed_time is not null ) and ( note_time is null )
                                                                        then 'COMPLETE'
                                                                        when ( triggered_time is not null ) and ( started_time is not null ) and ( completed_time is null ) and ( note_time is not null )
                                                                        then 'FAILED'
                                                                        else 'UNKNOWN'
                                                                    end
                                                               ) stored
);

-- Table Comment
COMMENT ON TABLE camdecmpsaux.pdem_report IS 'The parent table for the Progam Data Emissions (PDEM) working data.';

-- Column Comments
COMMENT ON COLUMN camdecmpsaux.pdem_report.pdem_report_id IS 'Primary key.';
COMMENT ON COLUMN camdecmpsaux.pdem_report.mon_plan_id IS 'Foreign key into the camdecmps.MONITOR_PLAN table that uniquely identifies a monitoring plan of the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_report.rpt_period_id IS 'Foreign key into the REPORTING_PERIOD table that uniquely indentifies the reporting period of the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_report.submission_id IS 'Foreign key into the SUBMISSION_QUEUE table that uniquely identifies the (emisson report) submission generating the Program Data Emissions (PDEM).';
COMMENT ON COLUMN camdecmpsaux.pdem_report.apportionment_type_cd IS 'Code used to indicate the apportionment type of an emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_report.queued_time IS 'The timestamp for when the generation of the Program Data Emissions was gueued.';
COMMENT ON COLUMN camdecmpsaux.pdem_report.started_time IS 'The timestamp for when the generation of the Program Data Emissions was triggered.';
COMMENT ON COLUMN camdecmpsaux.pdem_report.started_time IS 'The timestamp for when the generation of the Program Data Emissions was started.';
COMMENT ON COLUMN camdecmpsaux.pdem_report.completed_time IS 'The timestamp for when the generation of the Program Data Emissions was successfully completed.';
COMMENT ON COLUMN camdecmpsaux.pdem_report.note IS 'The note indicating why the generation of the Program Data Emissions failed.';
COMMENT ON COLUMN camdecmpsaux.pdem_report.note_time IS 'The timestamp for when the generation of the Program Data Emissions failed.';
COMMENT ON COLUMN camdecmpsaux.pdem_report.status_cd IS 'Indicates the status of the PDEM Report update based on the report''s time stamps.';
