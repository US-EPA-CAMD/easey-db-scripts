CREATE TABLE IF NOT EXISTS camdams.csosg2_safety_valve_conversion
(
    csosg2_safety_valve_conv_id numeric(38,0) NOT NULL,
    account_id numeric(38,0) NOT NULL,
    csosg2_total numeric(10,0) NOT NULL,
    csosg3_amount numeric(10,0) NOT NULL,
    csosg2_deduct numeric(10,0) NOT NULL,
    csosg3_trans_id numeric(38,0),
    csosg2_trans_id numeric(38,0),
    process_ind numeric(1,0) NOT NULL DEFAULT 0,
    notification_ind numeric(1,0) NOT NULL DEFAULT 0,
    userid varchar(160) NOT NULL,
    add_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone,
    PRIMARY KEY (csosg2_safety_valve_conv_id)
);
COMMENT ON TABLE camdams.csosg2_safety_valve_conversion
    IS 'Stores account-level information related to the RCU conversion of banked CSOSG2 allowances.';
COMMENT ON COLUMN camdams.csosg2_safety_valve_conversion.csosg2_safety_valve_conv_id
    IS 'Identity key for CSOSG2 safety valve conversion table.';
COMMENT ON COLUMN camdams.csosg2_safety_valve_conversion.account_id
    IS 'Identity key for account table.';
COMMENT ON COLUMN camdams.csosg2_safety_valve_conversion.csosg2_total
    IS 'Number of 2017-2020 CSOSG2 allowances held by the account.';
COMMENT ON COLUMN camdams.csosg2_safety_valve_conversion.csosg3_amount
    IS 'Number of 2021 CSOSG3 allowances to be allocated to the account.';
COMMENT ON COLUMN camdams.csosg2_safety_valve_conversion.csosg2_deduct
    IS 'Number of 2017-2020 CSOSG2 allowances to be deducted from the account.';
COMMENT ON COLUMN camdams.csosg2_safety_valve_conversion.csosg3_trans_id
    IS 'Identity key for transaction table (for the CSOSG3 allocation transaction).';
COMMENT ON COLUMN camdams.csosg2_safety_valve_conversion.csosg2_trans_id
    IS 'Identity key for transaction table (for the CSOSG2 deduction transaction).';
COMMENT ON COLUMN camdams.csosg2_safety_valve_conversion.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';
COMMENT ON COLUMN camdams.csosg2_safety_valve_conversion.add_date
    IS 'Date the record was created.';
COMMENT ON COLUMN camdams.csosg2_safety_valve_conversion.update_date
    IS 'Date of the last record update.';