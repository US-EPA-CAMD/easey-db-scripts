create materialized view camdsnap.ACCOUNT_COMPLIANCE_BALANCE_SS
as 
select  acb.account_comp_bal_id,
        acb.account_comp_id,
        acb.balance_cd,
        acb.begin_balance,
        acb.end_balance,
        now() as refresh_time
  from  camdams.ACCOUNT_COMPLIANCE_BALANCE acb;


comment on materialized view camdsnap.ACCOUNT_COMPLIANCE_BALANCE_SS is 'snapshot table for snapshot CAMDSNAP.ACCOUNT_COMPLIANCE_BALANCE_SS';
