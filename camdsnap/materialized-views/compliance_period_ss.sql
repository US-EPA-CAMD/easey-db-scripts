create materialized view camdsnap.COMPLIANCE_PERIOD_SS
as 
select  cmp.comp_period_id,
        cmp.prg_vintage_id,
        cmp.freeze_ind,
        cmp.add_date,
        cmp.update_date,
        cmp.userid,
        now() as refresh_time
  from  camdams.COMPLIANCE_PERIOD cmp;


comment on materialized view camdsnap.COMPLIANCE_PERIOD_SS is 'snapshot table for snapshot CAMDSNAP.COMPLIANCE_PERIOD_SS';
