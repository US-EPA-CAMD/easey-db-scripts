DROP TABLE camdecmpswks.unit;

CREATE TABLE camdecmpswks.unit
(
    unit_id numeric(38,0) NOT NULL,
    fac_id numeric(38,0) NOT NULL,
    unitid character varying(6) COLLATE pg_catalog."default" NOT NULL,
    unit_description character varying(4000) COLLATE pg_catalog."default",
    indian_country_ind numeric(1,0) NOT NULL DEFAULT 0,
    stateid character varying(6) COLLATE pg_catalog."default",
    boiler_sequence_number numeric(38,0),
    comm_op_date date,
    comm_op_date_cd character varying(1) COLLATE pg_catalog."default",
    comr_op_date date,
    comr_op_date_cd character varying(1) COLLATE pg_catalog."default",
    source_category_cd character varying(7) COLLATE pg_catalog."default",
    naics_cd numeric(6,0),
    no_active_gen_ind numeric(1,0) NOT NULL DEFAULT 0,
    non_load_based_ind numeric(1,0) NOT NULL DEFAULT 0,
    actual_90th_op_date date,
    moved_ind numeric(1,0) NOT NULL DEFAULT 0,
    userid character varying(160) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
);
