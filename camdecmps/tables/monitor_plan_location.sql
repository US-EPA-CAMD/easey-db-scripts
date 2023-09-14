CREATE TABLE IF NOT EXISTS camdecmps.monitor_plan_location
(
    monitor_plan_location_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmps.monitor_plan_location
    IS 'Identifies the location identity key associated with a plan.';

COMMENT ON COLUMN camdecmps.monitor_plan_location.monitor_plan_location_id
    IS 'Unique identifier of a monitoring plan location record. ';

COMMENT ON COLUMN camdecmps.monitor_plan_location.mon_plan_id
    IS 'Unique identifier of a monitoring plan record. ';

COMMENT ON COLUMN camdecmps.monitor_plan_location.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';
