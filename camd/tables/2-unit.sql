-- Table: camd.unit

-- DROP TABLE IF EXISTS camd.unit;

CREATE TABLE IF NOT EXISTS camd.unit
(
    unit_id numeric(38,0) NOT NULL,
    fac_id numeric(38,0) NOT NULL,
    unitid character varying(6) COLLATE pg_catalog."default" NOT NULL,
    unit_description character varying(4000) COLLATE pg_catalog."default",
    indian_country_ind numeric(1,0) NOT NULL DEFAULT 0,
    stateid character varying(6) COLLATE pg_catalog."default",
    boiler_sequence_number numeric(38,0),
    comm_op_date date,
    comm_op_date_cd character varying(1) COLLATE pg_catalog."default",
    comr_op_date date,
    comr_op_date_cd character varying(1) COLLATE pg_catalog."default",
    source_category_cd character varying(7) COLLATE pg_catalog."default",
    naics_cd numeric(6,0),
    no_active_gen_ind numeric(1,0) NOT NULL DEFAULT 0,
    non_load_based_ind numeric(1,0) NOT NULL DEFAULT 0,
    actual_90th_op_date date,
    moved_ind numeric(1,0) NOT NULL DEFAULT 0,
    userid character varying(25) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone,
    CONSTRAINT pk_unit PRIMARY KEY (unit_id),
    CONSTRAINT uq_unit UNIQUE (fac_id, unitid),
    CONSTRAINT fk_unit_naics FOREIGN KEY (naics_cd)
        REFERENCES camdmd.naics_code (naics_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_unit_plant FOREIGN KEY (fac_id)
        REFERENCES camd.plant (fac_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_unit_source_category FOREIGN KEY (source_category_cd)
        REFERENCES camdmd.source_category_code (source_category_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camd.unit
    IS 'Identifies industrial boilers or electric generating units.';

COMMENT ON COLUMN camd.unit.unit_id
    IS 'Identity key for UNIT table.';

COMMENT ON COLUMN camd.unit.fac_id
    IS 'FACILITY ID identity key.';

COMMENT ON COLUMN camd.unit.unitid
    IS 'Unique identifier for each unit at a facility.';

COMMENT ON COLUMN camd.unit.unit_description
    IS 'Text description of UNIT or UNIT configuration.';

COMMENT ON COLUMN camd.unit.indian_country_ind
    IS 'Indicates whether of not a unit is located in Indian Country.';

COMMENT ON COLUMN camd.unit.stateid
    IS 'The state identification number for a FACILITY or UNIT.';

COMMENT ON COLUMN camd.unit.boiler_sequence_number
    IS 'A CAMD assigned unique identifier for each boiler or unit.';

COMMENT ON COLUMN camd.unit.comm_op_date
    IS 'First day of operation that a UNIT generated electricity for sale, including the sale of test generation.';

COMMENT ON COLUMN camd.unit.comm_op_date_cd
    IS 'Code indicating whether the UNIT initial operation date is projected or actual.';

COMMENT ON COLUMN camd.unit.comr_op_date
    IS 'First day of commercial operation for a UNIT.';

COMMENT ON COLUMN camd.unit.comr_op_date_cd
    IS 'Code indicating whether the commercial operation date for a UNIT is projected or actual.';

COMMENT ON COLUMN camd.unit.source_category_cd
    IS 'General description of FACILITY type.';

COMMENT ON COLUMN camd.unit.naics_cd
    IS 'North American Industry Classification System code.  Provides information about the economic sector and specific industry, on a facility level.';

COMMENT ON COLUMN camd.unit.no_active_gen_ind
    IS 'Indicator to show that the unit does not currently have an active generator (1) or that the unit does currently have an active generator (0).';

COMMENT ON COLUMN camd.unit.non_load_based_ind
    IS 'Non load based unit indicator.';

COMMENT ON COLUMN camd.unit.actual_90th_op_date
    IS 'Stores the actual 90th operating date for a unit.  Supplied by sources via SMS/CBS.';

COMMENT ON COLUMN camd.unit.moved_ind
    IS 'Indicates whether or not a unit was moved from another facility.';

COMMENT ON COLUMN camd.unit.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';

COMMENT ON COLUMN camd.unit.add_date
    IS 'Date the record was created.';

COMMENT ON COLUMN camd.unit.update_date
    IS 'Date of the last record update.';

-- Index: idx_unit_naics

-- DROP INDEX camd.idx_unit_naics;

CREATE INDEX IF NOT EXISTS idx_unit_naics
    ON camd.unit USING btree
    (naics_cd ASC NULLS LAST);

-- Index: idx_unit_plant

-- DROP INDEX camd.idx_unit_plant;

CREATE INDEX IF NOT EXISTS idx_unit_plant
    ON camd.unit USING btree
    (fac_id ASC NULLS LAST);

-- Index: idx_unit_source_category

-- DROP INDEX camd.idx_unit_source_category;

CREATE INDEX IF NOT EXISTS idx_unit_source_category
    ON camd.unit USING btree
    (source_category_cd COLLATE pg_catalog."default" ASC NULLS LAST);
