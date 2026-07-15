CREATE TABLE IF NOT EXISTS camd.rpt_recon_summ_transaction
(
    prg_cd varchar(8),
    comp_year integer,
    trans_prg_cd varchar(8),
    trans_account_comp_id numeric(38,0),
    trans_type_cd varchar(7),
    trans_id numeric(38,0)
);
COMMENT ON TABLE camd.rpt_recon_summ_transaction
    IS 'Contains Generic Filter information from XML for the report request.';
COMMENT ON COLUMN camd.rpt_recon_summ_transaction.prg_cd
    IS 'Compliance Program for the report.';
COMMENT ON COLUMN camd.rpt_recon_summ_transaction.comp_year
    IS 'Compliance Year for the report.';
COMMENT ON COLUMN camd.rpt_recon_summ_transaction.trans_prg_cd
    IS 'Compliance Program for the transaction, which is the same as the program for the report exception for ARP and CAIRSO2 reports.';
COMMENT ON COLUMN camd.rpt_recon_summ_transaction.trans_account_comp_id
    IS 'Account Compliance Id for the transaction';
COMMENT ON COLUMN camd.rpt_recon_summ_transaction.trans_type_cd
    IS 'Type of the transaction.';
COMMENT ON COLUMN camd.rpt_recon_summ_transaction.trans_id
    IS 'Transaction Id';