-- Table: camdecmpswks.unit_control

-- DROP TABLE camdecmpswks.unit_control;

CREATE TABLE IF NOT EXISTS camdecmpswks.unit_control
(
    ctl_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    unit_id numeric(38,0) NOT NULL,
    control_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    ce_param character varying(7) COLLATE pg_catalog."default" NOT NULL,
    install_date date,
    opt_date date,
    orig_cd character varying(1) COLLATE pg_catalog."default",
    seas_cd character varying(1) COLLATE pg_catalog."default",
    retire_date date,
    indicator_cd character varying(7) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone,
    CONSTRAINT pk_unit_control PRIMARY KEY (ctl_id),
    CONSTRAINT fk_unit_control_control_equip_param_code FOREIGN KEY (ce_param)
        REFERENCES camdecmpsmd.control_equip_param_code (control_equip_param_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_unit_control_fuel_indicator_code FOREIGN KEY (indicator_cd)
        REFERENCES camdecmpsmd.fuel_indicator_code (fuel_indicator_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_unit_control_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);