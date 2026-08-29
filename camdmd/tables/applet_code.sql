CREATE TABLE IF NOT EXISTS camdmd.applet_code
(
    applet_cd varchar(3) NOT NULL,
    applet_name varchar(35) NOT NULL,
    PRIMARY KEY (applet_cd)
);
COMMENT ON TABLE camdmd.applet_code
    IS 'Stores the names of various APPLETS for which PEOPLE have group rights.';
COMMENT ON COLUMN camdmd.applet_code.applet_cd
    IS 'Short abbreviation for APPLET name.';
COMMENT ON COLUMN camdmd.applet_code.applet_name
    IS 'Full name of software APPLET.';