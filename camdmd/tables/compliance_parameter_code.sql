CREATE TABLE IF NOT EXISTS camdmd.compliance_parameter_code
(
    comp_parameter_cd varchar(7) NOT NULL,
    mass_rate_parameter_cd varchar(7) NOT NULL,
    mass_total_parameter_cd varchar(7) NOT NULL,
    summary_parameter_cd varchar(7) NOT NULL,
    op_type_cd varchar(7) NOT NULL,
    op_type_os_q2_cd varchar(7),
    PRIMARY KEY (comp_parameter_cd)
);
COMMENT ON TABLE camdmd.compliance_parameter_code
    IS 'Lookup table for compliance parameter cd.';
COMMENT ON COLUMN camdmd.compliance_parameter_code.comp_parameter_cd
    IS 'The parameter code reported for a compliance program.';
COMMENT ON COLUMN camdmd.compliance_parameter_code.mass_rate_parameter_cd
    IS 'The hourly mass rate parameter corresponding to the compliance parameter.';
COMMENT ON COLUMN camdmd.compliance_parameter_code.mass_total_parameter_cd
    IS 'The hourly mass total parameter corresponding to the compliance parameter.';
COMMENT ON COLUMN camdmd.compliance_parameter_code.summary_parameter_cd
    IS 'The summary value parameter corresponding to the compliance parameter.';
COMMENT ON COLUMN camdmd.compliance_parameter_code.op_type_cd
    IS 'The operating type corresponding to the compliance parameter.';
COMMENT ON COLUMN camdmd.compliance_parameter_code.op_type_os_q2_cd
    IS 'The OS Q2 operating type corresponding to the compliance parameter.';