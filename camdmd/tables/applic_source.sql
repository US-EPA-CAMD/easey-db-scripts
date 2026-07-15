CREATE TABLE IF NOT EXISTS camdmd.applic_source
(
    applic_source_code varchar(3) NOT NULL,
    applic_source_code_description varchar(12),
    PRIMARY KEY (applic_source_code)
);
COMMENT ON TABLE camdmd.applic_source
    IS 'Source of program APPLICABILITY DETERMINATION';
COMMENT ON COLUMN camdmd.applic_source.applic_source_code
    IS 'Code for method of providing Applicability Determination.';
COMMENT ON COLUMN camdmd.applic_source.applic_source_code_description
    IS 'Description of method of providing Applicability Determination.';