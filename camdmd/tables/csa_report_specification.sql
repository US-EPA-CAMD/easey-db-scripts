CREATE TABLE IF NOT EXISTS camdmd.csa_report_specification
(
    csa_report_name varchar(30) NOT NULL,
    csa_report_spec_name varchar(30) NOT NULL,
    csa_report_spec sys.xmltype,
    PRIMARY KEY (csa_report_name, csa_report_spec_name)
);
COMMENT ON COLUMN camdmd.csa_report_specification.csa_report_name
    IS 'The name of the report to which the specification belongs.';
COMMENT ON COLUMN camdmd.csa_report_specification.csa_report_spec_name
    IS 'The name of the spec.';
COMMENT ON COLUMN camdmd.csa_report_specification.csa_report_spec
    IS 'The specification as XML.';