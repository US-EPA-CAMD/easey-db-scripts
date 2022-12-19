-- Table: camdecmpswks.mats_method_data

-- DROP TABLE camdecmpswks.mats_method_data;

CREATE TABLE IF NOT EXISTS camdecmpswks.mats_method_data
(
    mats_method_data_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mats_method_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    mats_method_parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    begin_date date NOT NULL,
    begin_hour numeric(2,0) NOT NULL,
    end_date date,
    end_hour numeric(2,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_mats_method_data PRIMARY KEY (mats_method_data_id),
    CONSTRAINT fk_mats_method_data_mats_method_code FOREIGN KEY (mats_method_cd)
        REFERENCES camdecmpsmd.mats_method_code (mats_method_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_mats_method_data_mats_method_parameter_code FOREIGN KEY (mats_method_parameter_cd)
        REFERENCES camdecmpsmd.mats_method_parameter_code (mats_method_parameter_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_mats_method_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);