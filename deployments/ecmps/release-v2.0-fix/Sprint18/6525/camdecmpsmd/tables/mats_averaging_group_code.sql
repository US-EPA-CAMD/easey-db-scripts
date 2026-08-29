CREATE TABLE IF NOT EXISTS camdecmpsmd.mats_averaging_group_code (
    mats_avg_group_cd varchar(7) COLLATE pg_catalog."default" NOT NULL,
    mats_avg_group_description varchar(100) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.mats_averaging_group_code IS 'Lookup table of MATS averaging groups.';

COMMENT ON COLUMN camdecmpsmd.mats_averaging_group_code.mats_avg_group_description IS 'Averaging group description.';

