CREATE TABLE IF NOT EXISTS camdecmpswks.protocol_gas
(
    protocol_gas_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    gas_level_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    gas_type_cd character varying(255) COLLATE pg_catalog."default" NOT NULL,
    vendor_id character varying(8) COLLATE pg_catalog."default",
    cylinder_id character varying(25) COLLATE pg_catalog."default",
    expiration_date date,
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    userid character varying(160) COLLATE pg_catalog."default"
);