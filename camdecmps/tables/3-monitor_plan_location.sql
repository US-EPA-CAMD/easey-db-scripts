CREATE TABLE IF NOT EXISTS camdecmps.monitor_plan_location
(
    monitor_plan_location_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_monitor_plan_location PRIMARY KEY (monitor_plan_location_id),
    CONSTRAINT uq_monitor_plan_location UNIQUE (mon_plan_id, mon_loc_id),
    CONSTRAINT fk_monitor_plan_location_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    CONSTRAINT fk_monitor_plan_location_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmps.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON DELETE CASCADE
);

COMMENT ON TABLE camdecmps.monitor_plan_location
    IS 'Identifies the location identity key associated with a plan.';

COMMENT ON COLUMN camdecmps.monitor_plan_location.monitor_plan_location_id
    IS 'Unique identifier of a monitoring plan location record. ';

COMMENT ON COLUMN camdecmps.monitor_plan_location.mon_plan_id
    IS 'Unique identifier of a monitoring plan record. ';

COMMENT ON COLUMN camdecmps.monitor_plan_location.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';
