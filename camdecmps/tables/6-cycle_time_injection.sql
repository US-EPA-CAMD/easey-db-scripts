-- Table: camdecmps.cycle_time_injection

-- DROP TABLE camdecmps.cycle_time_injection;

CREATE TABLE IF NOT EXISTS camdecmps.cycle_time_injection
(
    cycle_time_inj_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    cycle_time_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    begin_monitor_value numeric(13,3),
    end_monitor_value numeric(13,3),
    begin_date date,
    begin_hour numeric(2,0),
    begin_min numeric(2,0),
    end_date date,
    end_hour numeric(2,0),
    end_min numeric(2,0),
    gas_level_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    cal_gas_value numeric(13,3),
    userid character varying(8) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    injection_cycle_time numeric(2,0),
    calc_injection_cycle_time numeric(2,0),
    CONSTRAINT pk_cycle_time_injection PRIMARY KEY (cycle_time_inj_id),
    CONSTRAINT fk_cycle_time_su_cycle_time_in FOREIGN KEY (cycle_time_sum_id)
        REFERENCES camdecmps.cycle_time_summary (cycle_time_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_gas_level_cod_cycle_time_in FOREIGN KEY (gas_level_cd)
        REFERENCES camdecmpsmd.gas_level_code (gas_level_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.cycle_time_injection
    IS 'Cycle time test data and results.  Record Type 621.';

COMMENT ON COLUMN camdecmps.cycle_time_injection.cycle_time_inj_id
    IS 'Unique identifier of a cycle time injection record. ';

COMMENT ON COLUMN camdecmps.cycle_time_injection.cycle_time_sum_id
    IS 'Unique identifier of a cycle time summary record. ';

COMMENT ON COLUMN camdecmps.cycle_time_injection.begin_monitor_value
    IS 'Stable analyzer response at the start of the cycle time test. ';

COMMENT ON COLUMN camdecmps.cycle_time_injection.end_monitor_value
    IS 'Stable analyzer response at the end of the cycle time test. ';

COMMENT ON COLUMN camdecmps.cycle_time_injection.begin_date
    IS 'Date of the cycle time injection. ';

COMMENT ON COLUMN camdecmps.cycle_time_injection.begin_hour
    IS 'Hour in which information became effective or activity started. ';

COMMENT ON COLUMN camdecmps.cycle_time_injection.begin_min
    IS 'Minute in which the cycle time injection began. ';

COMMENT ON COLUMN camdecmps.cycle_time_injection.end_date
    IS 'Last date in which information was effective or date in which activity ended. ';

COMMENT ON COLUMN camdecmps.cycle_time_injection.end_hour
    IS 'Last hour in which information was effective or hour in which activity ended. ';

COMMENT ON COLUMN camdecmps.cycle_time_injection.end_min
    IS 'Last minute in which information was effective or minute in which activity ended. ';

COMMENT ON COLUMN camdecmps.cycle_time_injection.gas_level_cd
    IS 'Code used to identify calibration gas level. ';

COMMENT ON COLUMN camdecmps.cycle_time_injection.cal_gas_value
    IS 'Calibration gas value. ';

COMMENT ON COLUMN camdecmps.cycle_time_injection.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.cycle_time_injection.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.cycle_time_injection.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.cycle_time_injection.injection_cycle_time
    IS 'Component cycle time. ';

COMMENT ON COLUMN camdecmps.cycle_time_injection.calc_injection_cycle_time
    IS 'Component cycle time. ';

-- Index: cycle_time_injection_idx001

-- DROP INDEX camdecmps.cycle_time_injection_idx001;

CREATE INDEX cycle_time_injection_idx001
    ON camdecmps.cycle_time_injection USING btree
    (cycle_time_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_cycle_time_inje_gas_level

-- DROP INDEX camdecmps.idx_cycle_time_inje_gas_level;

CREATE INDEX idx_cycle_time_inje_gas_level
    ON camdecmps.cycle_time_injection USING btree
    (gas_level_cd COLLATE pg_catalog."default" ASC NULLS LAST);
