-- Table: camdecmpsmd.fuel_flow_period_code

-- DROP TABLE IF EXISTS camdecmpsmd.fuel_flow_period_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.fuel_flow_period_code
(
    fuel_flow_period_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    ff_period_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_fuel_flow_period_code PRIMARY KEY (fuel_flow_period_cd)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS camdecmpsmd.fuel_flow_period_code
    OWNER to "uImcwuf4K9dyaxeL";

COMMENT ON TABLE camdecmpsmd.fuel_flow_period_code
    IS 'Lookup table for fuel flow period code.';

COMMENT ON COLUMN camdecmpsmd.fuel_flow_period_code.fuel_flow_period_cd
    IS 'Unique code value for a lookup table.';

COMMENT ON COLUMN camdecmpsmd.fuel_flow_period_code.ff_period_cd_description
    IS 'Description of lookup code.';