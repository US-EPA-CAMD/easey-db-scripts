CREATE TABLE IF NOT EXISTS camdams.compliance_stack_config
(
    comp_stack_config_id numeric(38,0) NOT NULL,
    comp_period_id numeric(38,0) NOT NULL,
    fac_id numeric(38,0) NOT NULL,
    stack_name varchar(6) NOT NULL,
    unit_id numeric(38,0) NOT NULL,
    account_id numeric(38,0) NOT NULL,
    apportion_percent numeric(9,7),
    add_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone,
    userid varchar(160) NOT NULL,
    PRIMARY KEY (comp_stack_config_id)
);
COMMENT ON TABLE camdams.compliance_stack_config
    IS 'This table stores the stack configuration for a given compliance year.';
COMMENT ON COLUMN camdams.compliance_stack_config.comp_stack_config_id
    IS 'Identity key for compliance stack config table.';
COMMENT ON COLUMN camdams.compliance_stack_config.comp_period_id
    IS 'Identity key for compliance period table.';
COMMENT ON COLUMN camdams.compliance_stack_config.fac_id
    IS 'Identity key for facility table.';
COMMENT ON COLUMN camdams.compliance_stack_config.stack_name
    IS 'Public identifier for stack.';
COMMENT ON COLUMN camdams.compliance_stack_config.unit_id
    IS 'Identity key for unit table.';
COMMENT ON COLUMN camdams.compliance_stack_config.account_id
    IS 'Identity key for account table.';
COMMENT ON COLUMN camdams.compliance_stack_config.apportion_percent
    IS 'Percent of stack''s emissions allocated to the unit.';
COMMENT ON COLUMN camdams.compliance_stack_config.add_date
    IS 'Date the record was created.';
COMMENT ON COLUMN camdams.compliance_stack_config.update_date
    IS 'Date of the last record update.';
COMMENT ON COLUMN camdams.compliance_stack_config.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';