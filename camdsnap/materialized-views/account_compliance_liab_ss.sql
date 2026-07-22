create materialized view camdsnap.ACCOUNT_COMPLIANCE_LIAB_SS
as 
select  acl.ACCOUNT_COMP_LIABILITY_ID,
        acl.ACCOUNT_COMP_ID,
        acl.LIABILITY_TYPE_CD,
        acl.LIABILITY_AMOUNT 
  from  camdams.ACCOUNT_COMPLIANCE_LIABILITY acl;


comment on materialized view camdsnap.ACCOUNT_COMPLIANCE_LIAB_SS is 'snapshot table for snapshot CAMDSNAP.ACCOUNT_COMPLIANCE_LIAB_SS';
