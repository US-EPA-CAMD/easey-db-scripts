-- Table: camdecmps.monitor_method

-- DROP TABLE camdecmps.monitor_method;

CREATE TABLE IF NOT EXISTS camdecmps.monitor_method
(
    mon_method_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    sub_data_cd character varying(7) COLLATE pg_catalog."default",
    bypass_approach_cd character varying(7) COLLATE pg_catalog."default",
    method_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    begin_date date NOT NULL,
    begin_hour numeric(2,0) NOT NULL,
    end_date date,
    end_hour numeric(2,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_monitor_method PRIMARY KEY (mon_method_id),
    CONSTRAINT fk_monitor_method_bypass_approach_code FOREIGN KEY (bypass_approach_cd)
        REFERENCES camdecmpsmd.bypass_approach_code (bypass_approach_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_method_method_code FOREIGN KEY (method_cd)
        REFERENCES camdecmpsmd.method_code (method_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_method_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_monitor_method_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_method_substitute_data_code FOREIGN KEY (sub_data_cd)
        REFERENCES camdecmpsmd.substitute_data_code (sub_data_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.monitor_method
    IS 'Identifies each parameter that a specific monitoring plan is monitoring.';

COMMENT ON COLUMN camdecmps.monitor_method.mon_method_id
    IS 'Unique identifier of a monitoring method record. ';

COMMENT ON COLUMN camdecmps.monitor_method.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.monitor_method.parameter_cd
    IS 'Code used to identify the parameter. ';

COMMENT ON COLUMN camdecmps.monitor_method.sub_data_cd
    IS 'Code used to identify the substitute data approach type. ';

COMMENT ON COLUMN camdecmps.monitor_method.bypass_approach_cd
    IS 'Code used to identify the value to be used for an unmonitored bypass stack. ';

COMMENT ON COLUMN camdecmps.monitor_method.method_cd
    IS 'Code used to identify the monitoring methodology. ';

COMMENT ON COLUMN camdecmps.monitor_method.begin_date
    IS 'Date on which information became effective or activity started. ';

COMMENT ON COLUMN camdecmps.monitor_method.begin_hour
    IS 'Hour in which information became effective. ';

COMMENT ON COLUMN camdecmps.monitor_method.end_date
    IS 'Last date in which information was effective.  This date will be null for active records. ';

COMMENT ON COLUMN camdecmps.monitor_method.end_hour
    IS 'Last hour in which information was effective.  This value will be null for active records. ';

COMMENT ON COLUMN camdecmps.monitor_method.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.monitor_method.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.monitor_method.update_date
    IS 'Date and time in which record was last updated. ';

-- Index: idx_mm_monlocid

-- DROP INDEX camdecmps.idx_mm_monlocid;

CREATE INDEX IF NOT EXISTS idx_mm_monlocid
    ON camdecmps.monitor_method USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_mm_paramcd

-- DROP INDEX camdecmps.idx_mm_paramcd;

CREATE INDEX IF NOT EXISTS idx_mm_paramcd
    ON camdecmps.monitor_method USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_monitor_method_bypass_app

-- DROP INDEX camdecmps.idx_monitor_method_bypass_app;

CREATE INDEX IF NOT EXISTS idx_monitor_method_bypass_app
    ON camdecmps.monitor_method USING btree
    (bypass_approach_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_monitor_method_method_cd

-- DROP INDEX camdecmps.idx_monitor_method_method_cd;

CREATE INDEX IF NOT EXISTS idx_monitor_method_method_cd
    ON camdecmps.monitor_method USING btree
    (method_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_monitor_method_sub_data_c

-- DROP INDEX camdecmps.idx_monitor_method_sub_data_c;

CREATE INDEX IF NOT EXISTS idx_monitor_method_sub_data_c
    ON camdecmps.monitor_method USING btree
    (sub_data_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: monitor_method_idx$$_15f60005

-- DROP INDEX camdecmps."monitor_method_idx$$_15f60005";

CREATE INDEX IF NOT EXISTS "monitor_method_idx$$_15f60005"
    ON camdecmps.monitor_method USING btree
    (begin_date ASC NULLS LAST, begin_hour ASC NULLS LAST, parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);
