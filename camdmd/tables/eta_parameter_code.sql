CREATE TABLE IF NOT EXISTS camdmd.eta_parameter_code
(
    parameter_cd varchar(6) NOT NULL,
    parameter_description varchar(50) NOT NULL,
    parameter_label varchar(20) NOT NULL,
    parameter_column_name varchar(30) NOT NULL,
    parameter_column_alias varchar(30) NOT NULL,
    display_order numeric NOT NULL,
    PRIMARY KEY (parameter_cd)
);
COMMENT ON TABLE camdmd.eta_parameter_code
    IS 'Contains the parameters the ETA Report can contain.';
COMMENT ON COLUMN camdmd.eta_parameter_code.parameter_cd
    IS 'The parameter code returned in an ETA Report.';
COMMENT ON COLUMN camdmd.eta_parameter_code.parameter_description
    IS 'The parameter description displayed to a user.';
COMMENT ON COLUMN camdmd.eta_parameter_code.parameter_label
    IS 'The parameter description included in an ETA Report.';
COMMENT ON COLUMN camdmd.eta_parameter_code.parameter_column_name
    IS 'The parameter column name included in an ETA Report.';
COMMENT ON COLUMN camdmd.eta_parameter_code.parameter_column_alias
    IS 'The parameter column alias included in an ETA Report.';
COMMENT ON COLUMN camdmd.eta_parameter_code.display_order
    IS 'The display order for the parameter when displayed to a user.';