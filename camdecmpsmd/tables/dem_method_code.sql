CREATE TABLE IF NOT EXISTS camdecmpsmd.dem_method_code
(
    dem_method_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    dem_method_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    dem_parameter character varying(7) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.dem_method_code
    IS 'Lookup table containing the codes that indicate the demonstration method.';

COMMENT ON COLUMN camdecmpsmd.dem_method_code.dem_method_cd
    IS 'Unique code that indicates the demonstration method.';

COMMENT ON COLUMN camdecmpsmd.dem_method_code.dem_method_description
    IS 'Full description of the demonstration method code.';

COMMENT ON COLUMN camdecmpsmd.dem_method_code.dem_parameter
    IS 'Demonstration parameter for the demonstration method, either GCV or SULFUR.';