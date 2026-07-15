CREATE TABLE IF NOT EXISTS camd.rpt_recon_summ_ac_arp_and_cair
(
    prg_cd varchar(8),
    comp_year integer,
    arp_account_comp_id numeric(38,0)
);
COMMENT ON TABLE camd.rpt_recon_summ_ac_arp_and_cair
    IS 'Contains ARP Account Compliance Ids for CAIRSO2 compliance accounts where both ARP and CAIRSO2 were used for compliance.';
COMMENT ON COLUMN camd.rpt_recon_summ_ac_arp_and_cair.prg_cd
    IS 'Compliance Program for the report.';
COMMENT ON COLUMN camd.rpt_recon_summ_ac_arp_and_cair.comp_year
    IS 'Compliance Year for the report.';
COMMENT ON COLUMN camd.rpt_recon_summ_ac_arp_and_cair.arp_account_comp_id
    IS 'Account Compliance Id.';