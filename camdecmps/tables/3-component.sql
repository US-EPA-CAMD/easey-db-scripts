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
    analytical_principle_cd character varying(7) COLLATE pg_catalog."default",
    CONSTRAINT pk_component PRIMARY KEY (component_id),
    CONSTRAINT fk_component_acquisition_method_code FOREIGN KEY (acq_cd)
        REFERENCES camdecmpsmd.acquisition_method_code (acq_cd) MATCH SIMPLE,
    CONSTRAINT fk_component_analytical_principle_code FOREIGN KEY (analytical_principle_cd)
        REFERENCES camdecmpsmd.analytical_principle_code (analytical_principle_cd) MATCH SIMPLE,
    CONSTRAINT fk_component_basis_code FOREIGN KEY (basis_cd)
        REFERENCES camdecmpsmd.basis_code (basis_cd) MATCH SIMPLE,
    CONSTRAINT fk_component_component_type_code FOREIGN KEY (component_type_cd)
        REFERENCES camdecmpsmd.component_type_code (component_type_cd) MATCH SIMPLE,
    CONSTRAINT fk_component_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE
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
