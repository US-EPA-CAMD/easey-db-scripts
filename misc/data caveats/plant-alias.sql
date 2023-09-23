-- Table: camd.plant_alias

-- DROP TABLE camd.plant_alias;

CREATE TABLE IF NOT EXISTS camd.plant_alias
(
    plant_alias_id numeric(38,0) NOT NULL,
    fac_id numeric(38,0) NOT NULL,
    alias_type character varying(7) COLLATE pg_catalog."default" NOT NULL,
    alias_date timestamp without time zone,
    old_value character varying(40) COLLATE pg_catalog."default" NOT NULL,
    ampd_ind numeric(1,0) NOT NULL DEFAULT 0,
    userid character varying(160) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone,
    CONSTRAINT pk_plant_alias PRIMARY KEY (plant_alias_id),
    CONSTRAINT uq_plant_alias_type_date UNIQUE (fac_id, alias_type, alias_date),
    CONSTRAINT fk_plant_alias_plant FOREIGN KEY (fac_id)
        REFERENCES camd.plant (fac_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT ck_alias_type CHECK (alias_type::text = ANY (ARRAY['NAME'::character varying, 'ORIS'::character varying]::text[])),
    CONSTRAINT ck_ampd_ind CHECK (alias_type::text = 'ORIS'::text AND ampd_ind = 1::numeric OR alias_type::text = 'NAME'::text)
);

COMMENT ON TABLE camd.plant_alias
    IS 'Records cross-reference of FACILITY plant name and oris code changes.';

COMMENT ON COLUMN camd.plant_alias.plant_alias_id
    IS 'PLANT_ALIAS identity key.';

COMMENT ON COLUMN camd.plant_alias.fac_id
    IS 'FACILITY identity key.';

COMMENT ON COLUMN camd.plant_alias.alias_type
    IS 'Type of alias, NAME (PLANT) or ORIS (ORIS_CODE).';

COMMENT ON COLUMN camd.plant_alias.alias_date
    IS 'Date on which FACILITY or UNIT alias was created.';

COMMENT ON COLUMN camd.plant_alias.old_value
    IS 'Old oris code or name of FACILITY, as reported by representative on Certification of Representation forms or equivalent.';

COMMENT ON COLUMN camd.plant_alias.ampd_ind
    IS 'Indicates if the plant alias should be shown in AMPD.';

COMMENT ON COLUMN camd.plant_alias.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';

COMMENT ON COLUMN camd.plant_alias.add_date
    IS 'Date the record was created.';

COMMENT ON COLUMN camd.plant_alias.update_date
    IS 'Date of the last record update.';
-- Index: idx_plant_alias_plant

-- DROP INDEX camd.idx_plant_alias_plant;

CREATE INDEX IF NOT EXISTS idx_plant_alias_plant
    ON camd.plant_alias USING btree
    (fac_id ASC NULLS LAST);
-- Index: idx_plant_alias_type

-- DROP INDEX camd.idx_plant_alias_type;

CREATE INDEX IF NOT EXISTS idx_plant_alias_type
    ON camd.plant_alias USING btree
    (alias_type COLLATE pg_catalog."default" ASC NULLS LAST);