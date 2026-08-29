CREATE TABLE IF NOT EXISTS camdmd.application
(
    app_cd varchar(3) NOT NULL,
    applet_cd varchar(12) NOT NULL,
    current_version varchar(12),
    minimum_version varchar(12),
    host_status_cd varchar(7),
    PRIMARY KEY (app_cd, applet_cd)
);
COMMENT ON TABLE camdmd.application
    IS 'Stores the names of various APPLICATIONS for which PEOPLE have group rights.';
COMMENT ON COLUMN camdmd.application.app_cd
    IS 'Short abbreviation for APPLICATION name.';
COMMENT ON COLUMN camdmd.application.applet_cd
    IS 'Code of applet.';
COMMENT ON COLUMN camdmd.application.current_version
    IS 'Current version of application/applet.';
COMMENT ON COLUMN camdmd.application.minimum_version
    IS 'Minimum acceptable working version for CSA modules.';
COMMENT ON COLUMN camdmd.application.host_status_cd
    IS 'Code of the ECMP host status';