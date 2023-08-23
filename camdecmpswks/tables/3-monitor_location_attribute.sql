-- Table: camdecmpswks.monitor_location_attribute

-- DROP TABLE camdecmpswks.monitor_location_attribute;

CREATE TABLE IF NOT EXISTS camdecmpswks.monitor_location_attribute
(
    mon_loc_attrib_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    grd_elevation numeric(5,0),
    duct_ind numeric(38,0),
    bypass_ind numeric(38,0),
    cross_area_flow numeric(4,0),
    cross_area_exit numeric(4,0),
    begin_date date NOT NULL,
    end_date date,
    stack_height numeric(4,0),
    shape_cd character varying(7) COLLATE pg_catalog."default",
    material_cd character varying(7) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    userid character varying(25) COLLATE pg_catalog."default",
    CONSTRAINT pk_monitor_location_attribute PRIMARY KEY (mon_loc_attrib_id),
    CONSTRAINT fk_monitor_location_attribute_material_code FOREIGN KEY (material_cd)
        REFERENCES camdecmpsmd.material_code (material_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_location_attribute_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_monitor_location_attribute_shape_code FOREIGN KEY (shape_cd)
        REFERENCES camdecmpsmd.shape_code (shape_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE INDEX IF NOT EXISTS idx_mon_loc_attribute_mon_loc_id
    ON camdecmpswks.monitor_location_attribute USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;