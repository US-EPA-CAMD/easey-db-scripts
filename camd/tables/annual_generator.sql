CREATE TABLE IF NOT EXISTS camd.annual_generator
(
    gen_id numeric(38,0) NOT NULL,
    eia_yr numeric(4,0) NOT NULL,
    gen_op_status varchar(2) NOT NULL,
    no_boilers numeric(4,0),
    annual_net numeric(10,2),
    os_net numeric(10,2),
    userid varchar(160) NOT NULL,
    add_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone,
    PRIMARY KEY (gen_id, eia_yr)
);
COMMENT ON TABLE camd.annual_generator
    IS 'Stores information on annual generator operation reported to EIA.';
COMMENT ON COLUMN camd.annual_generator.gen_id
    IS 'GENERATOR identity key.';
COMMENT ON COLUMN camd.annual_generator.eia_yr
    IS 'The year for which EIA identification information is provided.';
COMMENT ON COLUMN camd.annual_generator.gen_op_status
    IS 'Reported GENERATOR status code.  For example, operating, retired, cold storage, etc.';
COMMENT ON COLUMN camd.annual_generator.no_boilers
    IS 'Number of utility boilers associated with each GENERATOR on an annual basis.';
COMMENT ON COLUMN camd.annual_generator.annual_net
    IS 'Net generation in megawatts for a GENERATOR for a specified year.';
COMMENT ON COLUMN camd.annual_generator.os_net
    IS 'Net generation in megawatts for a GENERATOR for the ozone season of a specified year.';
COMMENT ON COLUMN camd.annual_generator.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';
COMMENT ON COLUMN camd.annual_generator.add_date
    IS 'Date the record was created.';
COMMENT ON COLUMN camd.annual_generator.update_date
    IS 'Date of the last record update.';