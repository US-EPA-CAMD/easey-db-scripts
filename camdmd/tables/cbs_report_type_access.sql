CREATE TABLE IF NOT EXISTS camdmd.cbs_report_type_access
(
    cbs_report_type_cd varchar(100) NOT NULL,
    security_group_cd varchar(7) NOT NULL,
    enabled_ind numeric(1,0) NOT NULL DEFAULT 1,
    PRIMARY KEY (cbs_report_type_cd, security_group_cd)
);
COMMENT ON TABLE camdmd.cbs_report_type_access
    IS 'Look up table for report type access.';
COMMENT ON COLUMN camdmd.cbs_report_type_access.cbs_report_type_cd
    IS 'Code indicating the type of report.';
COMMENT ON COLUMN camdmd.cbs_report_type_access.security_group_cd
    IS 'Group the access applies to.';
COMMENT ON COLUMN camdmd.cbs_report_type_access.enabled_ind
    IS 'Indicator for whether the report type is enabled for the group.';