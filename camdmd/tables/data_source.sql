CREATE TABLE IF NOT EXISTS camdmd.data_source
(
    data_source_cd varchar(3) NOT NULL,
    data_source_description varchar(35),
    PRIMARY KEY (data_source_cd)
);
COMMENT ON TABLE camdmd.data_source
    IS 'Lookup table that identifies the source of generator data.';
COMMENT ON COLUMN camdmd.data_source.data_source_cd
    IS 'Source of generator data.';
COMMENT ON COLUMN camdmd.data_source.data_source_description
    IS 'Full description of source of data.';