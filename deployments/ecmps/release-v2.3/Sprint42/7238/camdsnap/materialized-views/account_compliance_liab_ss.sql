create materialized view camdsnap.ACCOUNT_COMPLIANCE_LIAB_SS
as 
select  acl.account_comp_liability_id,
        acl.account_comp_id,
        acl.liability_type_cd,
        acl.liability_amount,
        now() as refresh_time
  from  camdams.ACCOUNT_COMPLIANCE_LIABILITY acl;


comment on materialized view camdsnap.ACCOUNT_COMPLIANCE_LIAB_SS is 'snapshot table for snapshot CAMDSNAP.ACCOUNT_COMPLIANCE_LIAB_SS';
