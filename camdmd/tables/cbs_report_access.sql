CREATE TABLE IF NOT EXISTS camdmd.cbs_report_access
(
    cbs_report_id numeric(38,0) NOT NULL,
    security_group_cd varchar(7) NOT NULL,
    enabled_ind numeric(1,0) NOT NULL DEFAULT 1,
    PRIMARY KEY (cbs_report_id, security_group_cd)
);
COMMENT ON TABLE camdmd.cbs_report_access
    IS 'Look up table for access to reports.';
COMMENT ON COLUMN camdmd.cbs_report_access.cbs_report_id
    IS 'Primary key field of the report.';
COMMENT ON COLUMN camdmd.cbs_report_access.security_group_cd
    IS 'Group the access applies to.';
COMMENT ON COLUMN camdmd.cbs_report_access.enabled_ind
    IS 'Indicator for whether the report is enabled for the group.';