CREATE TABLE IF NOT EXISTS camdmd.deduction_type_code
(
    deduction_type_cd varchar(7) NOT NULL,
    deduction_type_description varchar(1000) NOT NULL,
    PRIMARY KEY (deduction_type_cd)
);
COMMENT ON TABLE camdmd.deduction_type_code
    IS 'Lookup table for deduction type cd.';
COMMENT ON COLUMN camdmd.deduction_type_code.deduction_type_cd
    IS 'Deduction type code.';
COMMENT ON COLUMN camdmd.deduction_type_code.deduction_type_description
    IS 'Full description of deduction type.';