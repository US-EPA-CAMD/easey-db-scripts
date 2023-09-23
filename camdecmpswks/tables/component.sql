CREATE TABLE IF NOT EXISTS camdecmpswks.component
(
    component_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    component_identifier character varying(3) COLLATE pg_catalog."default" NOT NULL,
    model_version character varying(15) COLLATE pg_catalog."default",
    serial_number character varying(20) COLLATE pg_catalog."default",
    manufacturer character varying(25) COLLATE pg_catalog."default",
    component_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    acq_cd character varying(7) COLLATE pg_catalog."default",
    basis_cd character varying(7) COLLATE pg_catalog."default",
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    hg_converter_ind numeric(1,0)
);
