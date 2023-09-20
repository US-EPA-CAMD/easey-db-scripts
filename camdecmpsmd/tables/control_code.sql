CREATE TABLE IF NOT EXISTS camdecmpsmd.control_code
(
    control_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    control_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    control_equip_param_cd character varying(7) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmpsmd.control_code
    IS 'Lookup table of control types.';

COMMENT ON COLUMN camdecmpsmd.control_code.control_cd
    IS 'Codes for identifying type of control equipment.';

COMMENT ON COLUMN camdecmpsmd.control_code.control_description
    IS 'Description of control equipment codes.';

COMMENT ON COLUMN camdecmpsmd.control_code.control_equip_param_cd
    IS 'Identifies control type.';
