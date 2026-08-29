CREATE TABLE IF NOT EXISTS camdams.transaction_lock
(
    account_id numeric(38,0) NOT NULL,
    PRIMARY KEY (account_id)
);
COMMENT ON TABLE camdams.transaction_lock
    IS 'Table used to prevent the simultaneous use of the same account(s) in a transaction.';
COMMENT ON COLUMN camdams.transaction_lock.account_id
    IS 'Identity key for account table.';