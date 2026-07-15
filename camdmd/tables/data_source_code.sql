CREATE TABLE IF NOT EXISTS camdmd.data_source_code
(
    data_source_cd varchar(7) NOT NULL,
    data_source_cd_description varchar(1000) NOT NULL,
    PRIMARY KEY (data_source_cd)
);
COMMENT ON TABLE camdmd.data_source_code
    IS 'Lookup table for data source cd.';
COMMENT ON COLUMN camdmd.data_source_code.data_source_cd
    IS 'Data source code for emissions data.';
COMMENT ON COLUMN camdmd.data_source_code.data_source_cd_description
    IS 'Full description of data source code for emissions data.';