CREATE TABLE IF NOT EXISTS camdmd.cbs_report
(
    cbs_report_id numeric(38,0) NOT NULL,
    cbs_report_type_cd varchar(100) NOT NULL,
    cbs_report_name varchar(1000) NOT NULL,
    cbs_report_description varchar(1000) NOT NULL,
    PRIMARY KEY (cbs_report_id)
);
COMMENT ON TABLE camdmd.cbs_report
    IS 'Look up table for reports.';
COMMENT ON COLUMN camdmd.cbs_report.cbs_report_id
    IS 'Primary key field of the report.';
COMMENT ON COLUMN camdmd.cbs_report.cbs_report_type_cd
    IS 'Code indicating the type of report.';
COMMENT ON COLUMN camdmd.cbs_report.cbs_report_name
    IS 'The Name of the report.';
COMMENT ON COLUMN camdmd.cbs_report.cbs_report_description
    IS 'Description of the report.';