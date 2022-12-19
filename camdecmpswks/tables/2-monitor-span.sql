-- Table: camdecmpswks.monitor_span

-- DROP TABLE camdecmpswks.monitor_span;

CREATE TABLE IF NOT EXISTS camdecmpswks.monitor_span
(
    span_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mpc_value numeric(6,1),
    mec_value numeric(6,1),
    mpf_value numeric(10,0),
    max_low_range numeric(6,1),
    span_value numeric(13,3),
    full_scale_range numeric(13,3),
    begin_date date NOT NULL,
    begin_hour numeric(2,0) NOT NULL,
    end_date date,
    end_hour numeric(2,0),
    default_high_range numeric(5,0),
    flow_span_value numeric(10,0),
    flow_full_scale_range numeric(10,0),
    component_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    span_scale_cd character varying(7) COLLATE pg_catalog."default",
    span_method_cd character varying(7) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    span_uom_cd character varying(7) COLLATE pg_catalog."default",
    CONSTRAINT pk_monitor_span PRIMARY KEY (span_id),
    CONSTRAINT fk_monitor_span_component_type_code FOREIGN KEY (component_type_cd)
        REFERENCES camdecmpsmd.component_type_code (component_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_span_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_monitor_span_span_method_code FOREIGN KEY (span_method_cd)
        REFERENCES camdecmpsmd.span_method_code (span_method_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_span_span_scale_code FOREIGN KEY (span_scale_cd)
        REFERENCES camdecmpsmd.span_scale_code (span_scale_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_span_units_of_measure_code FOREIGN KEY (span_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);