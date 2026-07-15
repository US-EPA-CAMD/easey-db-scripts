CREATE TABLE IF NOT EXISTS camdams.temp_account_block
(
    account_comp_id numeric,
    prg_vintage_id numeric,
    old_begin_number numeric,
    old_end_number numeric,
    new_begin_number numeric,
    new_end_number numeric,
    trans_type_cd varchar(7)
);
COMMENT ON TABLE camdams.temp_account_block
    IS 'Temporary table used to store account block records beign staged for compliance.';
COMMENT ON COLUMN camdams.temp_account_block.account_comp_id
    IS 'Identity key for the account compliance block table.';
COMMENT ON COLUMN camdams.temp_account_block.prg_vintage_id
    IS 'Identity key for program vintage table.';
COMMENT ON COLUMN camdams.temp_account_block.old_begin_number
    IS 'Original beginning serial number for the allowance block.';
COMMENT ON COLUMN camdams.temp_account_block.old_end_number
    IS 'Original ending serial number for an allowance block.';
COMMENT ON COLUMN camdams.temp_account_block.new_begin_number
    IS 'Current beginning serial number for the allowance block.';
COMMENT ON COLUMN camdams.temp_account_block.new_end_number
    IS 'Current ending serial number for an allowance block.';
COMMENT ON COLUMN camdams.temp_account_block.trans_type_cd
    IS 'Code for type of transaction.';