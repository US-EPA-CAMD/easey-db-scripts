-- Table: camdecmpsmd.nsps4t_emission_standard_code

-- DROP TABLE IF EXISTS camdecmpsmd.nsps4t_emission_standard_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.nsps4t_emission_standard_code
(
    emission_standard_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    emission_standard_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    emission_standard_uom_cd character varying(7) COLLATE pg_catalog."default",
    emission_standard_load_cd character varying(7) COLLATE pg_catalog."default",
    CONSTRAINT pk_nsps4t_emission_standard PRIMARY KEY (emission_standard_cd),
    CONSTRAINT uq_nsps4t_emission_standard UNIQUE (emission_standard_description),
    CONSTRAINT fk_nsps4t_emission_standard_l FOREIGN KEY (emission_standard_load_cd)
        REFERENCES camdecmpsmd.nsps4t_electrical_load_code (electrical_load_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_nsps4t_emission_standard_u FOREIGN KEY (emission_standard_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS camdecmpsmd.nsps4t_emission_standard_code
    OWNER to "uImcwuf4K9dyaxeL";

COMMENT ON TABLE camdecmpsmd.nsps4t_emission_standard_code
    IS 'NSPS4T (quarterly) Summary Information. ';

COMMENT ON COLUMN camdecmpsmd.nsps4t_emission_standard_code.emission_standard_cd
    IS 'Code used to identify the NSPS4T Emission Standard.';

COMMENT ON COLUMN camdecmpsmd.nsps4t_emission_standard_code.emission_standard_description
    IS 'Description of the NSPS4T Emission Standard.';

COMMENT ON COLUMN camdecmpsmd.nsps4t_emission_standard_code.emission_standard_uom_cd
    IS 'Contains the unit of measure for the standard.';

COMMENT ON COLUMN camdecmpsmd.nsps4t_emission_standard_code.emission_standard_load_cd
    IS 'Contains the type of electrical load for the standard.';
-- Index: idx_nsps4t_emission_standard_l

-- DROP INDEX IF EXISTS camdecmpsmd.idx_nsps4t_emission_standard_l;

CREATE INDEX IF NOT EXISTS idx_nsps4t_emission_standard_l
    ON camdecmpsmd.nsps4t_emission_standard_code USING btree
    (emission_standard_load_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_nsps4t_emission_standard_u

-- DROP INDEX IF EXISTS camdecmpsmd.idx_nsps4t_emission_standard_u;

CREATE INDEX IF NOT EXISTS idx_nsps4t_emission_standard_u
    ON camdecmpsmd.nsps4t_emission_standard_code USING btree
    (emission_standard_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;