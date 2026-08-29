CREATE TABLE IF NOT EXISTS camdmd.cbs_report_type_code
(
    cbs_report_type_cd varchar(100) NOT NULL,
    cbs_report_type_description varchar(1000) NOT NULL,
    PRIMARY KEY (cbs_report_type_cd)
);
COMMENT ON TABLE camdmd.cbs_report_type_code
    IS 'Look up table for report types.';
COMMENT ON COLUMN camdmd.cbs_report_type_code.cbs_report_type_cd
    IS 'Code indicating the type of report.';
COMMENT ON COLUMN camdmd.cbs_report_type_code.cbs_report_type_description
    IS 'Description of the report.';