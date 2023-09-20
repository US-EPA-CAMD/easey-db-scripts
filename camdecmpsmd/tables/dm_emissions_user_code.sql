CREATE TABLE IF NOT EXISTS camdecmpsmd.dm_emissions_user_code
(
    dm_emissions_user_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    dm_emissions_user_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    active_flg character varying(1) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.dm_emissions_user_code
    IS 'Lookup table of codes that indicate a user of ECMPS D&M Emissions data.';

COMMENT ON COLUMN camdecmpsmd.dm_emissions_user_code.dm_emissions_user_cd
    IS 'Code indicating a user of ECMPS D&M Emissions data.';

COMMENT ON COLUMN camdecmpsmd.dm_emissions_user_code.dm_emissions_user_description
    IS 'Description of D&M Emissions User Code.';

COMMENT ON COLUMN camdecmpsmd.dm_emissions_user_code.active_flg
    IS 'Flag indicating whether the D&M Emissions User is currently an active user.';