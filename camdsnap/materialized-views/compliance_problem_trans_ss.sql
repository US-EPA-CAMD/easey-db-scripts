create materialized view camdsnap.COMPLIANCE_PROBLEM_TRANS_SS
as 
select cpt.trans_id,
       cpt.account_comp_id,
       cpt.block_total,
        now() as refresh_time
  from COMPLIANCE_PROBLEM_TRANSACTION cpt;


comment on materialized view camdsnap.COMPLIANCE_PROBLEM_TRANS_SS is 'snapshot table for snapshot CAMDSNAP.COMPLIANCE_PROBLEM_TRANS_SS';

