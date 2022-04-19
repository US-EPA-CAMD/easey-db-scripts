-- ------------ Write CREATE-TABLE-stage scripts -----------

CREATE TABLE IF NOT EXISTS camdecmps.protocol_gas(
    protocol_gas_id CHARACTER VARYING(45) NOT NULL,
    test_sum_id CHARACTER VARYING(45) NOT NULL,
    gas_level_cd CHARACTER VARYING(7) NOT NULL,
    gas_type_cd CHARACTER VARYING(255) NOT NULL,
    vendor_id CHARACTER VARYING(8),
    cylinder_id CHARACTER VARYING(25),
    expiration_date TIMESTAMP WITHOUT TIME ZONE,
    add_date TIMESTAMP WITHOUT TIME ZONE,
    update_date TIMESTAMP WITHOUT TIME ZONE,
    userid CHARACTER VARYING(8)
)
        WITH (
        OIDS=FALSE
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



-- ------------ Write CREATE-INDEX-stage scripts -----------

CREATE INDEX idx_protocol_gas_0001
ON camdecmps.protocol_gas
USING BTREE (vendor_id ASC);



-- ------------ Write CREATE-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.protocol_gas
ADD CONSTRAINT pk_protocol_gas PRIMARY KEY (protocol_gas_id);



-- ------------ Write CREATE-FOREIGN-KEY-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.protocol_gas
ADD CONSTRAINT fk_gas_level_cd FOREIGN KEY (gas_level_cd) 
REFERENCES camdecmpsmd.gas_level_code (gas_level_cd)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.protocol_gas
ADD CONSTRAINT fk_test_summary_protocol_gas FOREIGN KEY (test_sum_id) 
REFERENCES camdecmps.test_summary (test_sum_id)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.protocol_gas
ADD CONSTRAINT fk_vendor_id FOREIGN KEY (vendor_id) 
REFERENCES camdecmps.protocol_gas_vendor (vendor_id)
ON DELETE NO ACTION;
