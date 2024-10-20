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
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    span_uom_cd character varying(7) COLLATE pg_catalog."default"
);
