create materialized view camdsnap.ACCOUNT_SS 
as 
select  acc.account_id,
        acc.account_number,
        acc.account_name,
        acc.account_type_cd,
        acc.state_cd as state,
        acc.add_date,
        acc.update_date,
        acc.userid,
        now() as refresh_time
  from  camdams.ACCOUNT acc;


comment on materialized view camdsnap.ACCOUNT_SS is 'snapshot table for snapshot CAMDSNAP.ACCOUNT_SS';
