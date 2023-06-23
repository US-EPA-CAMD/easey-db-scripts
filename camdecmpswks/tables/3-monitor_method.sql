-- Table: camdecmpswks.monitor_method

-- DROP TABLE camdecmpswks.monitor_method;

CREATE TABLE IF NOT EXISTS camdecmpswks.monitor_method
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
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
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