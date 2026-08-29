CREATE TABLE IF NOT EXISTS camdmd.applicability_status_code
(
    app_status_cd varchar(7) NOT NULL,
    app_status_description varchar(1000) NOT NULL,
    PRIMARY KEY (app_status_cd)
);
COMMENT ON TABLE camdmd.applicability_status_code
    IS 'Status of program APPLICABILITY DETERMINATION';
COMMENT ON COLUMN camdmd.applicability_status_code.app_status_cd
    IS 'Status of program APPLICABILITY DETERMINATION';
COMMENT ON COLUMN camdmd.applicability_status_code.app_status_description
    IS 'Code for review status of Applicability Determination.';