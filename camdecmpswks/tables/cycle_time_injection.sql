CREATE TABLE IF NOT EXISTS camdecmpswks.cycle_time_injection
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