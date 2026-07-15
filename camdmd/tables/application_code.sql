CREATE TABLE IF NOT EXISTS camdmd.application_code
(
    app_cd varchar(3) NOT NULL,
    app_name varchar(35) NOT NULL,
    PRIMARY KEY (app_cd)
);
COMMENT ON TABLE camdmd.application_code
    IS 'Stores the names of various APPLICATIONS for which PEOPLE have group rights.';
COMMENT ON COLUMN camdmd.application_code.app_cd
    IS 'Short abbreviation for APPLICATION name.';
COMMENT ON COLUMN camdmd.application_code.app_name
    IS 'Full name of software APPLICATION.';