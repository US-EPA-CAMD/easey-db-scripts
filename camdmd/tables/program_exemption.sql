CREATE TABLE IF NOT EXISTS camdmd.program_exemption
(
    prg_cd varchar(7) NOT NULL,
    exemption_type_cd varchar(7) NOT NULL,
    PRIMARY KEY (prg_cd, exemption_type_cd)
);
COMMENT ON TABLE camdmd.program_exemption
    IS 'Cross check between programs and exemption types.';
COMMENT ON COLUMN camdmd.program_exemption.prg_cd
    IS 'Code indicating the regulatory program.';
COMMENT ON COLUMN camdmd.program_exemption.exemption_type_cd
    IS 'Code indicating the type of exemption.';