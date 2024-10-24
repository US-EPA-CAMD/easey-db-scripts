CREATE TABLE IF NOT EXISTS camdmd.unit_type_group_code
(
    unit_type_group_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    unit_type_group_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdmd.unit_type_group_code
    IS 'Lookup table containing the groups of unit types to which unit type codes correspond.';

COMMENT ON COLUMN camdmd.unit_type_group_code.unit_type_group_cd
    IS 'Identifies the group in which the unit type is cataloged.';

COMMENT ON COLUMN camdmd.unit_type_group_code.unit_type_group_description
    IS 'Full description of the unit type group.';
