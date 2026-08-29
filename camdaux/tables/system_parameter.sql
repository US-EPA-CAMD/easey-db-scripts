CREATE TABLE IF NOT EXISTS camdaux.system_parameter
(
    system_parameter_name varchar(100) NOT NULL,
    system_parameter_value varchar(1000),
    system_parameter_description varchar(1000),
    PRIMARY KEY (system_parameter_name)
);
COMMENT ON TABLE camdaux.system_parameter
    IS 'Contains parameters specific to and instance of the CAMD database.';
COMMENT ON COLUMN camdaux.system_parameter.system_parameter_name
    IS 'The name of the system parameter, capitalized and without spaces.';
COMMENT ON COLUMN camdaux.system_parameter.system_parameter_value
    IS 'The value of the system parameter.';
COMMENT ON COLUMN camdaux.system_parameter.system_parameter_description
    IS 'The purpose of the system parameter.';