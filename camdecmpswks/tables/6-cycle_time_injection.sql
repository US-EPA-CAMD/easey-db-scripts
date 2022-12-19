-- Table: camdecmpswks.cycle_time_injection

-- DROP TABLE camdecmpswks.cycle_time_injection;

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
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    injection_cycle_time numeric(2,0),
    calc_injection_cycle_time numeric(2,0),
    CONSTRAINT pk_cycle_time_injection PRIMARY KEY (cycle_time_inj_id),
    CONSTRAINT fk_cycle_time_injection_cycle_time_summary FOREIGN KEY (cycle_time_sum_id)
        REFERENCES camdecmpswks.cycle_time_summary (cycle_time_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_cycle_time_injection_gas_level_code FOREIGN KEY (gas_level_cd)
        REFERENCES camdecmpsmd.gas_level_code (gas_level_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);