CREATE TABLE IF NOT EXISTS camdmd.app_instance_code
(
    app_instance_cd varchar(50) NOT NULL,
    app_instance_description varchar(100) NOT NULL,
    PRIMARY KEY (app_instance_cd)
);
COMMENT ON TABLE camdmd.app_instance_code
    IS 'Table containing Application codes';
COMMENT ON COLUMN camdmd.app_instance_code.app_instance_cd
    IS 'Application Instance code';
COMMENT ON COLUMN camdmd.app_instance_code.app_instance_description
    IS 'Description of Application Instance Code';