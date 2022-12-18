-- Table: camdecmps.monitor_plan_location

-- DROP TABLE camdecmps.monitor_plan_location;

CREATE TABLE IF NOT EXISTS camdecmps.monitor_plan_location
(
    monitor_plan_location_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_monitor_plan_location PRIMARY KEY (monitor_plan_location_id),
    CONSTRAINT monitor_plan_location_u01 UNIQUE (mon_plan_id, mon_loc_id)
);

COMMENT ON TABLE camdecmps.monitor_plan_location
    IS 'Identifies the location identity key associated with a plan.';

COMMENT ON COLUMN camdecmps.monitor_plan_location.monitor_plan_location_id
    IS 'Unique identifier of a monitoring plan location record. ';

COMMENT ON COLUMN camdecmps.monitor_plan_location.mon_plan_id
    IS 'Unique identifier of a monitoring plan record. ';

COMMENT ON COLUMN camdecmps.monitor_plan_location.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

-- Index: idx_mon_plan_loc_plan_loc

-- DROP INDEX camdecmps.idx_mon_plan_loc_plan_loc;

CREATE INDEX IF NOT EXISTS idx_mon_plan_loc_plan_loc
    ON camdecmps.monitor_plan_location USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
