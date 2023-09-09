CREATE TABLE IF NOT EXISTS camdecmps.monitor_system_component
(
    mon_sys_comp_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    component_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    begin_hour numeric(2,0) NOT NULL,
    begin_date date NOT NULL,
    end_date date,
    end_hour numeric(2,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_monitor_system_component PRIMARY KEY (mon_sys_comp_id),
    CONSTRAINT fk_monitor_system_component_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE
        ON DELETE CASCADE,
    CONSTRAINT fk_monitor_system_component_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
        ON DELETE CASCADE
);

COMMENT ON TABLE camdecmps.monitor_system_component
    IS 'Collection of components that make up a monitoring system.  Record Type 510.';

COMMENT ON COLUMN camdecmps.monitor_system_component.mon_sys_comp_id
    IS 'Unique identifier of a Monitoring System Component record. ';

COMMENT ON COLUMN camdecmps.monitor_system_component.mon_sys_id
    IS 'Unique identifier of a monitoring system record. ';

COMMENT ON COLUMN camdecmps.monitor_system_component.component_id
    IS 'Unique identifier of a monitoring component record. ';

COMMENT ON COLUMN camdecmps.monitor_system_component.begin_hour
    IS 'Hour in which information became effective. ';

COMMENT ON COLUMN camdecmps.monitor_system_component.begin_date
    IS 'Date on which information became effective or activity started. ';

COMMENT ON COLUMN camdecmps.monitor_system_component.end_date
    IS 'Last date in which information was effective.  This date will be null for active records. ';

COMMENT ON COLUMN camdecmps.monitor_system_component.end_hour
    IS 'Last hour in which information was effective.  This value will be null for active records. ';

COMMENT ON COLUMN camdecmps.monitor_system_component.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.monitor_system_component.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.monitor_system_component.update_date
    IS 'Date and time in which record was last updated. ';
