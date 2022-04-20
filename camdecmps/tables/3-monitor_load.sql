-- Table: camdecmps.monitor_load

-- DROP TABLE camdecmps.monitor_load;

CREATE TABLE IF NOT EXISTS camdecmps.monitor_load
(
    load_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    load_analysis_date date,
    begin_date date NOT NULL,
    begin_hour numeric(2,0) NOT NULL,
    end_date date,
    end_hour numeric(2,0),
    max_load_value numeric(6,0),
    second_normal_ind numeric(38,0),
    up_op_boundary numeric(6,0),
    low_op_boundary numeric(6,0),
    normal_level_cd character varying(7) COLLATE pg_catalog."default",
    second_level_cd character varying(7) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    max_load_uom_cd character varying(7) COLLATE pg_catalog."default",
    CONSTRAINT pk_monitor_load PRIMARY KEY (load_id),
    CONSTRAINT fk_monitor_locat_monitor_load FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.monitor_load
    IS 'Defines maximum load and normal operating levels for information for a monitoring location. Record Types 535 and 536.';

COMMENT ON COLUMN camdecmps.monitor_load.load_id
    IS 'Unique identifier of a monitoring load record. ';

COMMENT ON COLUMN camdecmps.monitor_load.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.monitor_load.load_analysis_date
    IS 'The date in which load analysis was performed.  This date only applies to CEM and Appendix D locations. ';

COMMENT ON COLUMN camdecmps.monitor_load.begin_date
    IS 'Date on which information became effective or activity started. ';

COMMENT ON COLUMN camdecmps.monitor_load.begin_hour
    IS 'Hour in which information became effective. ';

COMMENT ON COLUMN camdecmps.monitor_load.end_date
    IS 'Last date in which information was effective.  This date will be null for active records. ';

COMMENT ON COLUMN camdecmps.monitor_load.end_hour
    IS 'Last hour in which information was effective.  This value will be null for active records. ';

COMMENT ON COLUMN camdecmps.monitor_load.max_load_value
    IS 'Maximum hourly gross load. ';

COMMENT ON COLUMN camdecmps.monitor_load.second_normal_ind
    IS 'Used to indicate the reporting of an additional normal load or a second operating level. ';

COMMENT ON COLUMN camdecmps.monitor_load.up_op_boundary
    IS 'Upper boundary of range of operation. ';

COMMENT ON COLUMN camdecmps.monitor_load.low_op_boundary
    IS 'Lower boundary of range of operation. ';

COMMENT ON COLUMN camdecmps.monitor_load.normal_level_cd
    IS 'Code used to identify the normal load or operating level. ';

COMMENT ON COLUMN camdecmps.monitor_load.second_level_cd
    IS 'Code used to identify the second most frequently used load or operating level. ';

COMMENT ON COLUMN camdecmps.monitor_load.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.monitor_load.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.monitor_load.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.monitor_load.max_load_uom_cd
    IS 'Code used to identify the units of measure for maximum load value ';

-- Index: idx_monitor_load_mon_loc_id

-- DROP INDEX camdecmps.idx_monitor_load_mon_loc_id;

CREATE INDEX idx_monitor_load_mon_loc_id
    ON camdecmps.monitor_load USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
