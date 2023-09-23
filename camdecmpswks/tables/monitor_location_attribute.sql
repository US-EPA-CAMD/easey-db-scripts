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
    userid character varying(160) COLLATE pg_catalog."default"
);
