create materialized view camdsnap.NOX_COMP_PLAN_SS
as 
select  npl.comp_plan_id,
        npl.unit_id,
        npl.begin_date,
        npl.end_date,
        npl.comp_plan_type_cd,
        npl.sign_date,
        npl.add_date,
        npl.update_date,
        npl.userid,
        now() as refresh_time
  from  camdams.NOX_COMP_PLAN npl;


comment on materialized view camdsnap.NOX_COMP_PLAN_SS is 'snapshot table for snapshot CAMDSNAP.NOX_COMP_PLAN_SS';
