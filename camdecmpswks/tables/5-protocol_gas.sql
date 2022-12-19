-- Table: camdecmpswks.protocol_gas

-- DROP TABLE camdecmpswks.protocol_gas;

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
    userid character varying(25) COLLATE pg_catalog."default",
    CONSTRAINT pk_protocol_gas PRIMARY KEY (protocol_gas_id),
    CONSTRAINT fk_protocol_gas_gas_level_code FOREIGN KEY (gas_level_cd)
        REFERENCES camdecmpsmd.gas_level_code (gas_level_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_protocol_gas_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);