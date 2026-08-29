CREATE TABLE IF NOT EXISTS camdams.general_account_attribute
(
    account_id numeric(38,0) NOT NULL,
    form_received_date timestamp without time zone,
    broker_ind numeric(1,0) NOT NULL DEFAULT 0,
    broker_transfer_ind numeric(1,0) NOT NULL DEFAULT 0,
    broker_hold_ind numeric(1,0) NOT NULL DEFAULT 0,
    broker_other_ind numeric(1,0) NOT NULL DEFAULT 0,
    utility_ind numeric(1,0) NOT NULL DEFAULT 0,
    non_utility_ind numeric(1,0) NOT NULL DEFAULT 0,
    coal_ind numeric(1,0) NOT NULL DEFAULT 0,
    oil_ind numeric(1,0) NOT NULL DEFAULT 0,
    gas_ind numeric(1,0) NOT NULL DEFAULT 0,
    other_fuel_ind numeric(1,0) NOT NULL DEFAULT 0,
    pollution_ind numeric(1,0) NOT NULL DEFAULT 0,
    consumer_ind numeric(1,0) NOT NULL DEFAULT 0,
    environment_ind numeric(1,0) NOT NULL DEFAULT 0,
    public_other_ind numeric(1,0) NOT NULL DEFAULT 0,
    industrial_boiler_ind numeric(1,0) NOT NULL DEFAULT 0,
    other_ind numeric(1,0) NOT NULL DEFAULT 0,
    other_description varchar(1000),
    PRIMARY KEY (account_id)
);
COMMENT ON TABLE camdams.general_account_attribute
    IS 'Lists account information for general accounts.';
COMMENT ON COLUMN camdams.general_account_attribute.account_id
    IS 'Identity key for account table.';
COMMENT ON COLUMN camdams.general_account_attribute.form_received_date
    IS 'Date account form was received.';
COMMENT ON COLUMN camdams.general_account_attribute.broker_ind
    IS 'Indicates whether the authorized account rep is employed by an allowance brokerage firm.';
COMMENT ON COLUMN camdams.general_account_attribute.broker_transfer_ind
    IS 'Indicates if the account is used to transfer allowances between clients.';
COMMENT ON COLUMN camdams.general_account_attribute.broker_hold_ind
    IS 'Indicates if the account will be used to hold allowances for investment purposes.';
COMMENT ON COLUMN camdams.general_account_attribute.broker_other_ind
    IS 'Indicates if the account will be used for other purposes.';
COMMENT ON COLUMN camdams.general_account_attribute.utility_ind
    IS 'Indicates account owner represents a utility.';
COMMENT ON COLUMN camdams.general_account_attribute.non_utility_ind
    IS 'Indicates account owner represents a non utility generator of electricity.';
COMMENT ON COLUMN camdams.general_account_attribute.coal_ind
    IS 'Indicates account owner represents a fuel supplier that supplies coal.';
COMMENT ON COLUMN camdams.general_account_attribute.oil_ind
    IS 'Indicates account owner represents a fuel supplier that supplies oil.';
COMMENT ON COLUMN camdams.general_account_attribute.gas_ind
    IS 'Indicates account owner represents a fuel supplier that supplies gas.';
COMMENT ON COLUMN camdams.general_account_attribute.other_fuel_ind
    IS 'Indicates account owner represents a fuel supplier that supplies other fuel types.';
COMMENT ON COLUMN camdams.general_account_attribute.pollution_ind
    IS 'Indicates account owner represents a pollution control equipment business.';
COMMENT ON COLUMN camdams.general_account_attribute.consumer_ind
    IS 'Indicates account owner represents a consumer public interest group.';
COMMENT ON COLUMN camdams.general_account_attribute.environment_ind
    IS 'Indicates account owner represents an environmental public interest group.';
COMMENT ON COLUMN camdams.general_account_attribute.public_other_ind
    IS 'Indicates account owner represents another type of public interest group.';
COMMENT ON COLUMN camdams.general_account_attribute.industrial_boiler_ind
    IS 'Indicates account owner represents an industrial boiler.';
COMMENT ON COLUMN camdams.general_account_attribute.other_ind
    IS 'Indicates account owner represents a different type of business.';
COMMENT ON COLUMN camdams.general_account_attribute.other_description
    IS 'Text description of other business represented by account owner.';