CREATE TABLE IF NOT EXISTS camdmd.class_code
(
    class_cd varchar(7) NOT NULL,
    class_description varchar(1000) NOT NULL,
    affected_ind numeric(1,0) NOT NULL DEFAULT 0,
    PRIMARY KEY (class_cd)
);
COMMENT ON TABLE camdmd.class_code
    IS 'Look up table for program classification.';
COMMENT ON COLUMN camdmd.class_code.class_cd
    IS 'Code indicating the program class.';
COMMENT ON COLUMN camdmd.class_code.class_description
    IS 'Description of the program class.';
COMMENT ON COLUMN camdmd.class_code.affected_ind
    IS 'Indicates if the class indicates an affected status.';