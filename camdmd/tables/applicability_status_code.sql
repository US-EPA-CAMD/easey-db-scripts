CREATE TABLE IF NOT EXISTS camdmd.applicability_status_code
(
    app_status_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    app_status_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdmd.applicability_status_code
    IS 'Status of program APPLICABILITY DETERMINATION';

COMMENT ON COLUMN camdmd.applicability_status_code.app_status_cd
    IS 'Status of program APPLICABILITY DETERMINATION';

COMMENT ON COLUMN camdmd.applicability_status_code.app_status_description
    IS 'Code for review status of Applicability Determination.';
