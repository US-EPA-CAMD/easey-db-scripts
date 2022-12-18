-- Table: camdecmps.component

-- DROP TABLE camdecmps.component;

CREATE TABLE IF NOT EXISTS camdecmps.component
(
    component_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    component_identifier character varying(3) COLLATE pg_catalog."default" NOT NULL,
    model_version character varying(15) COLLATE pg_catalog."default",
    serial_number character varying(20) COLLATE pg_catalog."default",
    manufacturer character varying(25) COLLATE pg_catalog."default",
    component_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    acq_cd character varying(7) COLLATE pg_catalog."default",
    basis_cd character varying(7) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    hg_converter_ind numeric(1,0),
    CONSTRAINT pk_component PRIMARY KEY (component_id),
    CONSTRAINT fk_acquisition_m_component FOREIGN KEY (acq_cd)
        REFERENCES camdecmpsmd.acquisition_method_code (acq_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_basis_code_component FOREIGN KEY (basis_cd)
        REFERENCES camdecmpsmd.basis_code (basis_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_component_typ_component FOREIGN KEY (component_type_cd)
        REFERENCES camdecmpsmd.component_type_code (component_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_locat_component FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.component
    IS 'Hardware or software used to measure Emissions at the monitoring location.  Record Type 510.';

COMMENT ON COLUMN camdecmps.component.component_id
    IS 'Unique identifier of a monitoring component record. ';

COMMENT ON COLUMN camdecmps.component.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.component.component_identifier
    IS 'The three digit code assigned by the source to identify the component. ';

COMMENT ON COLUMN camdecmps.component.model_version
    IS 'The model of any hardware component or the version number of the software component. ';

COMMENT ON COLUMN camdecmps.component.serial_number
    IS 'Serial number of the component. ';

COMMENT ON COLUMN camdecmps.component.manufacturer
    IS 'Name of the manufacturer or developer of the component. ';

COMMENT ON COLUMN camdecmps.component.component_type_cd
    IS 'Code used to identify the component type. ';

COMMENT ON COLUMN camdecmps.component.acq_cd
    IS 'Code used to identify the sample acquisition method. ';

COMMENT ON COLUMN camdecmps.component.basis_cd
    IS 'Code used to identify the moisture basis. ';

COMMENT ON COLUMN camdecmps.component.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.component.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.component.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.component.hg_converter_ind
    IS 'For an Hg component, indicates whether the analyzer has a converter.';

-- Index: component_idx$$_15b00009

-- DROP INDEX camdecmps."component_idx$$_15b00009";

CREATE INDEX IF NOT EXISTS "component_idx$$_15b00009"
    ON camdecmps.component USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST, component_identifier COLLATE pg_catalog."default" ASC NULLS LAST, component_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_component_acq_cd

-- DROP INDEX camdecmps.idx_component_acq_cd;

CREATE INDEX IF NOT EXISTS idx_component_acq_cd
    ON camdecmps.component USING btree
    (acq_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_component_basis_cd

-- DROP INDEX camdecmps.idx_component_basis_cd;

CREATE INDEX IF NOT EXISTS idx_component_basis_cd
    ON camdecmps.component USING btree
    (basis_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_component_component

-- DROP INDEX camdecmps.idx_component_component;

CREATE INDEX IF NOT EXISTS idx_component_component
    ON camdecmps.component USING btree
    (component_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_component_monlocid

-- DROP INDEX camdecmps.idx_component_monlocid;

CREATE INDEX IF NOT EXISTS idx_component_monlocid
    ON camdecmps.component USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
