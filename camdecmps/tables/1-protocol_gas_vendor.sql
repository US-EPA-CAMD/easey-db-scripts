-- ------------ Write CREATE-TABLE-stage scripts -----------

CREATE TABLE IF NOT EXISTS camdecmps.protocol_gas_vendor(
    vendor_id CHARACTER VARYING(8) NOT NULL,
    vendor_name CHARACTER VARYING(50) NOT NULL,
    deactivation_date TIMESTAMP WITHOUT TIME ZONE,
    add_date TIMESTAMP WITHOUT TIME ZONE,
    update_date TIMESTAMP WITHOUT TIME ZONE,
    userid CHARACTER VARYING(8),
    active_ind NUMERIC(1,0) NOT NULL DEFAULT 1,
    activation_date TIMESTAMP WITHOUT TIME ZONE
)
        WITH (
        OIDS=FALSE
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



-- ------------ Write CREATE-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.protocol_gas_vendor
ADD CONSTRAINT pk_protocol_gas_vendor PRIMARY KEY (vendor_id);
