-- Table: camdecmpswks.protocol_gas_vendor

-- DROP TABLE camdecmpswks.protocol_gas_vendor;

CREATE TABLE IF NOT EXISTS camdecmpswks.protocol_gas_vendor
(
    vendor_id character varying(8) COLLATE pg_catalog."default" NOT NULL,
    vendor_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    deactivation_date date,
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    userid character varying(25) COLLATE pg_catalog."default",
    active_ind numeric(1,0) NOT NULL DEFAULT 1,
    activation_date date,
    CONSTRAINT pk_protocol_gas_vendor PRIMARY KEY (vendor_id)
);
