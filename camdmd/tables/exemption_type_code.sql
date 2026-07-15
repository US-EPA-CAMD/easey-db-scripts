CREATE TABLE IF NOT EXISTS camdmd.exemption_type_code
(
    exemption_type_cd varchar(7) NOT NULL,
    exemption_type_description varchar(1000) NOT NULL,
    PRIMARY KEY (exemption_type_cd)
);
COMMENT ON TABLE camdmd.exemption_type_code
    IS 'Program Exemption type lookup table.';
COMMENT ON COLUMN camdmd.exemption_type_code.exemption_type_cd
    IS 'Code indicating the type of exemption.';
COMMENT ON COLUMN camdmd.exemption_type_code.exemption_type_description
    IS 'Description of the exemption.';