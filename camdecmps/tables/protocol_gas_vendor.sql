CREATE TABLE IF NOT EXISTS camdecmps.protocol_gas_vendor
(
    vendor_id character varying(8) COLLATE pg_catalog."default" NOT NULL,
    vendor_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    deactivation_date date,
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    userid character varying(160) COLLATE pg_catalog."default",
    active_ind numeric(1,0) NOT NULL DEFAULT 1,
    activation_date date
);

COMMENT ON TABLE camdecmps.protocol_gas_vendor
    IS ' EPA-approved vendors of protocol calibration gases.';

COMMENT ON COLUMN camdecmps.protocol_gas_vendor.vendor_id
    IS 'EPA-assigned identifier of a PGVP vendor.';

COMMENT ON COLUMN camdecmps.protocol_gas_vendor.vendor_name
    IS 'Name of the PGVP Vendor.';

COMMENT ON COLUMN camdecmps.protocol_gas_vendor.deactivation_date
    IS 'Date PGVP Vendor was deactivated from the PGVP program';

COMMENT ON COLUMN camdecmps.protocol_gas_vendor.add_date
    IS 'Date the record was created.';

COMMENT ON COLUMN camdecmps.protocol_gas_vendor.update_date
    IS 'Date record was updated.';

COMMENT ON COLUMN camdecmps.protocol_gas_vendor.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';

COMMENT ON COLUMN camdecmps.protocol_gas_vendor.active_ind
    IS 'Active Indicator for Vendor ID';
