CREATE TABLE IF NOT EXISTS camdecmpsmd.dm_emissions_user_code(
    dm_emissions_user_cd CHARACTER VARYING(7) NOT NULL,
    dm_emissions_user_description CHARACTER VARYING(1000) NOT NULL,
    active_flg CHARACTER VARYING(1) NOT NULL
)
        WITH (
        OIDS=FALSE
        );
COMMENT ON TABLE camdecmpsmd.dm_emissions_user_code
     IS 'Lookup table of codes that indicate a user of ECMPS D&M Emissions data.';
COMMENT ON COLUMN camdecmpsmd.dm_emissions_user_code.dm_emissions_user_cd
     IS 'Code indicating a user of ECMPS D&M Emissions data.';
COMMENT ON COLUMN camdecmpsmd.dm_emissions_user_code.dm_emissions_user_description
     IS 'Description of D&M Emissions User Code.';
COMMENT ON COLUMN camdecmpsmd.dm_emissions_user_code.active_flg
     IS 'Flag indicating whether the D&M Emissions User is currently an active user.';


ALTER TABLE camdecmpsmd.dm_emissions_user_code
ADD CONSTRAINT dm_emissions_user_code_pk PRIMARY KEY (dm_emissions_user_cd);

ALTER TABLE camdecmpsmd.dm_emissions_user_code
ADD CONSTRAINT dm_emissions_user_code_uq UNIQUE (dm_emissions_user_description);