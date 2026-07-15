CREATE TABLE IF NOT EXISTS camd.rpt_recon_summ_ac_arp_not_cair
(
    prg_cd varchar(8),
    comp_year integer,
    arp_account_comp_id numeric(38,0)
);
COMMENT ON TABLE camd.rpt_recon_summ_ac_arp_not_cair
    IS 'Contains Account Compliance Ids for CAIRSO2 compliance accounts where ARP was used for compliance but CAIRSO2 was not.';
COMMENT ON COLUMN camd.rpt_recon_summ_ac_arp_not_cair.prg_cd
    IS 'Compliance Program for the report.';
COMMENT ON COLUMN camd.rpt_recon_summ_ac_arp_not_cair.comp_year
    IS 'Compliance Year for the report.';
COMMENT ON COLUMN camd.rpt_recon_summ_ac_arp_not_cair.arp_account_comp_id
    IS 'Account Compliance Id.';