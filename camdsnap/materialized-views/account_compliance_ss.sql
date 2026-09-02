create materialized view camdsnap.ACCOUNT_COMPLIANCE_SS
as 
select  account_comp_id,
        account_id,
        add_date,
        comp_period_id,
        comp_status_cd,
        credit_total,
        emiss_liability,
        offset_liability,
        takeback_liability,
        underutilization_liability,
        update_date,
        userid,
        now() as refresh_time
  from  camdams.ACCOUNT_COMPLIANCE;


comment on materialized view camdsnap.ACCOUNT_COMPLIANCE_SS is 'snapshot table for snapshot CAMDSNAP.ACCOUNT_COMPLIANCE_SS';
