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
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    injection_cycle_time numeric(2,0),
    calc_injection_cycle_time numeric(2,0)
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
