CREATE TABLE IF NOT EXISTS camdecmps.protocol_gas
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

COMMENT ON TABLE camdecmps.protocol_gas
    IS 'Data about EPA protocol calibration gases used during RATAs and linearity checks.';

COMMENT ON COLUMN camdecmps.protocol_gas.protocol_gas_id
    IS 'Unique identifier of a protocol gas record.';

COMMENT ON COLUMN camdecmps.protocol_gas.test_sum_id
    IS 'Unique identifier of the parent test summary record.';

COMMENT ON COLUMN camdecmps.protocol_gas.gas_level_cd
    IS 'Code used to identify calibration gas level.';

COMMENT ON COLUMN camdecmps.protocol_gas.gas_type_cd
    IS 'Code used to identify the contents of the cylinder.';

COMMENT ON COLUMN camdecmps.protocol_gas.vendor_id
    IS 'EPA-assigned identifier for a PGVP Vendor.';

COMMENT ON COLUMN camdecmps.protocol_gas.cylinder_id
    IS 'Identifier stamped on the calibration gas cylinder';

COMMENT ON COLUMN camdecmps.protocol_gas.expiration_date
    IS 'Expiration Date of the calibration gas cylinder';

COMMENT ON COLUMN camdecmps.protocol_gas.add_date
    IS 'Date the record was created.';

COMMENT ON COLUMN camdecmps.protocol_gas.update_date
    IS 'Date record was updated.';

COMMENT ON COLUMN camdecmps.protocol_gas.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';
