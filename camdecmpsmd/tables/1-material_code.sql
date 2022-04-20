-- Table: camdecmpsmd.material_code

-- DROP TABLE camdecmpsmd.material_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.material_code
(
    material_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    material_code_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_material_code PRIMARY KEY (material_cd)
);

COMMENT ON TABLE camdecmpsmd.material_code
    IS 'Lookup table for material codes.';

COMMENT ON COLUMN camdecmpsmd.material_code.material_cd
    IS 'Code used to identify the material that is used in the monitoring location. ';

COMMENT ON COLUMN camdecmpsmd.material_code.material_code_description
    IS 'Description of lookup code. ';