CREATE TABLE IF NOT EXISTS camd.applic_result
(
    apd_id numeric(38,0) NOT NULL,
    apc_cd varchar(1) NOT NULL,
    add_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
COMMENT ON TABLE camd.applic_result
    IS 'Stores results of applicability determinations saved in SMS or CBS.';
COMMENT ON COLUMN camd.applic_result.apd_id
    IS 'Applicability determination identity key.';
COMMENT ON COLUMN camd.applic_result.apc_cd
    IS 'Lookup table for statutory or regulatory basis underlying APPLICABILITY DETERMINATION.';
COMMENT ON COLUMN camd.applic_result.add_date
    IS 'Date the record was created.';