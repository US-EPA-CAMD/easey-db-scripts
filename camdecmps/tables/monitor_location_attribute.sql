CREATE TABLE IF NOT EXISTS camdecmps.monitor_location_attribute
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
    userid character varying(25) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmps.monitor_location_attribute
    IS 'Stack characteristic data applicable for the configuration type identified in the monitoring plan.  Name of stack must being with "CS" followed by up to four alphanumeric characters. Record Type 503.';

COMMENT ON COLUMN camdecmps.monitor_location_attribute.mon_loc_attrib_id
    IS 'Unique combination of DB_Token and identity key generated by sequence generator. ';

COMMENT ON COLUMN camdecmps.monitor_location_attribute.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.monitor_location_attribute.grd_elevation
    IS 'The number of feet above sea level at ground level of the stack or unit. ';

COMMENT ON COLUMN camdecmps.monitor_location_attribute.duct_ind
    IS 'Used to indicate that this location is a duct. ';

COMMENT ON COLUMN camdecmps.monitor_location_attribute.bypass_ind
    IS 'Used to indicate that the stack is used for bypass. ';

COMMENT ON COLUMN camdecmps.monitor_location_attribute.cross_area_flow
    IS 'The reported inside cross-sectional area in square feet of the stack or duct at the flow monitoring location. ';

COMMENT ON COLUMN camdecmps.monitor_location_attribute.cross_area_exit
    IS 'The inside cross-sectional area in square feet of the stack at the exit. ';

COMMENT ON COLUMN camdecmps.monitor_location_attribute.begin_date
    IS 'Date on which information became effective or activity started. ';

COMMENT ON COLUMN camdecmps.monitor_location_attribute.end_date
    IS 'Last date in which information was effective.  This date will be null for active records. ';

COMMENT ON COLUMN camdecmps.monitor_location_attribute.stack_height
    IS 'The height in feet of a stack exit above ground level. ';

COMMENT ON COLUMN camdecmps.monitor_location_attribute.shape_cd
    IS 'Code identifying the shape of a monitor location. ';

COMMENT ON COLUMN camdecmps.monitor_location_attribute.material_cd
    IS 'Code used to identify the material that is used in the monitoring location. ';

COMMENT ON COLUMN camdecmps.monitor_location_attribute.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.monitor_location_attribute.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.monitor_location_attribute.userid
    IS 'User account or source of data that added or updated record. ';