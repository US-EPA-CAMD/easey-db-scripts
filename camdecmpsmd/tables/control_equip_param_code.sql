CREATE TABLE IF NOT EXISTS camdecmpsmd.control_equip_param_code
(
    control_equip_param_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    control_equip_param_desc character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.control_equip_param_code
    IS 'Lookup table of control equipment parameters.';

COMMENT ON COLUMN camdecmpsmd.control_equip_param_code.control_equip_param_cd
    IS '"Parameters to be controlled.';

COMMENT ON COLUMN camdecmpsmd.control_equip_param_code.control_equip_param_desc
    IS 'Full description of control equipment parameter.';