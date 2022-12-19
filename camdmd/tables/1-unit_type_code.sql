-- Table: camdmd.unit_type_code

-- DROP TABLE camdmd.unit_type_code;

CREATE TABLE IF NOT EXISTS camdmd.unit_type_code
(
    unit_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    unit_type_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    sort_order numeric(1,0),
    unit_type_group_cd character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_unit_type_cd PRIMARY KEY (unit_type_cd),
    CONSTRAINT fk_unit_type_unit_type_group FOREIGN KEY (unit_type_group_cd)
        REFERENCES camdmd.unit_type_group_code (unit_type_group_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdmd.unit_type_code
    IS 'Lookup table of boiler types';

COMMENT ON COLUMN camdmd.unit_type_code.unit_type_cd
    IS 'The type of UNIT or boiler.';

COMMENT ON COLUMN camdmd.unit_type_code.unit_type_description
    IS 'Description of UNIT TYPE.';

COMMENT ON COLUMN camdmd.unit_type_code.sort_order
    IS 'Sort order of list.';

COMMENT ON COLUMN camdmd.unit_type_code.unit_type_group_cd
    IS 'Identifies the category of unit types (e.g., boiler, turbine).';