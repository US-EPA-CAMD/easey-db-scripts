create materialized view camdsnap.ACCOUNT_COMPLIANCE_PENALTY_SS
as 
select  acp.account_comp_id,
        acp.penalty_amount,
        now() as refresh_time
  from  ACCOUNT_COMPLIANCE_PENALTY acp;


comment on materialized view camdsnap.ACCOUNT_COMPLIANCE_PENALTY_SS is 'snapshot table for snapshot CAMDSNAP.ACCOUNT_COMPLIANCE_PENALTY_SS';
