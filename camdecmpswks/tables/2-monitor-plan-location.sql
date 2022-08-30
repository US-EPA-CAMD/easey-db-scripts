-- Table: camdecmpswks.monitor_plan_location

-- DROP TABLE camdecmpswks.monitor_plan_location;

CREATE TABLE camdecmpswks.monitor_plan_location
(
    monitor_plan_location_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_monitor_plan_location PRIMARY KEY (monitor_plan_location_id),
    CONSTRAINT uq_monitor_plan_location UNIQUE (mon_plan_id, mon_loc_id),
    CONSTRAINT fk_monitor_plan_location_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_monitor_plan_location_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmpswks.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);