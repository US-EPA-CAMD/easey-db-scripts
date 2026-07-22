create materialized view camdsnap.ACCOUNT_OWNER_SS 
as 
select  aco.account_owner_id as account_own_id,
        aco.account_id,
        aco.agency_id,
        aco.company_id comp_id,
        aco.ppl_id,
        aco.'OWN' as ont_type_cd,
        aco.begin_date,
        aco.end_date,
        aco.add_date,
        aco.update_date,
        aco.userid
  from  ACCOUNT_OWNER aco;


comment on materialized view camdsnap.ACCOUNT_OWNER_SS is 'snapshot table for snapshot CAMDSNAP.ACCOUNT_OWNER_SS';
