create materialized view camdsnap.COMPANY_SS 
as 
select  cmp.company_id as comp_id,
        cmp.company_name as comp_name,
        cmp.userid,
        cmp.update_date,
        cmp.add_date,
        now() as refresh_time
  from  camd.COMPANY cmp;


comment on materialized view camdsnap.COMPANY_SS is 'snapshot table for snapshot CAMDSNAP.COMPANY_SS';
