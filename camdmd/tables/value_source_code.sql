CREATE TABLE IF NOT EXISTS camdmd.value_source_code
(
    value_source_cd varchar(7) NOT NULL,
    value_source_cd_description varchar(1000) NOT NULL,
    PRIMARY KEY (value_source_cd)
);
COMMENT ON TABLE camdmd.value_source_code
    IS 'Lookup table containing ECMPS sources used to determine emission values.';
COMMENT ON COLUMN camdmd.value_source_code.value_source_cd
    IS 'ECMPS source used to determine EMISS_VALUE.';
COMMENT ON COLUMN camdmd.value_source_code.value_source_cd_description
    IS 'Full description of ECMPS source used to determine EMISS_VALUE.';