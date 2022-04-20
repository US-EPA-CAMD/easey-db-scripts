-- Table: camdecmpsmd.fuel_type_code

-- DROP TABLE camdecmpsmd.fuel_type_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.fuel_type_code
(
    fuel_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    fuel_type_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    fuel_group_cd character varying(7) COLLATE pg_catalog."default",
    CONSTRAINT pk_fuel_type_code PRIMARY KEY (fuel_type_cd),
    CONSTRAINT uq_fuel_type_code_desc UNIQUE (fuel_type_description),
    CONSTRAINT fk_fuel_type_group_code FOREIGN KEY (fuel_group_cd)
        REFERENCES camdecmpsmd.fuel_group_code (fuel_group_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmpsmd.fuel_type_code
    IS 'Lookup table containing codes for the fuels used by units.';

COMMENT ON COLUMN camdecmpsmd.fuel_type_code.fuel_type_cd
    IS 'The type of fuel which a UNIT is capable or will be capable of combusting.';

COMMENT ON COLUMN camdecmpsmd.fuel_type_code.fuel_type_description
    IS 'Full description of fuel type.';

COMMENT ON COLUMN camdecmpsmd.fuel_type_code.fuel_group_cd
    IS 'Identifies the category of fuel (e.g., gas, oil or other).';

-- Index: idx_fuel_type_group_code

-- DROP INDEX camdecmpsmd.idx_fuel_type_group_code;

CREATE INDEX idx_fuel_type_group_code
    ON camdecmpsmd.fuel_type_code USING btree
    (fuel_group_cd COLLATE pg_catalog."default" ASC NULLS LAST);
