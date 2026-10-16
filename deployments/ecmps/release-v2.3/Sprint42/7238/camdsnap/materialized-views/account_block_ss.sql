create materialized view camdsnap.ACCOUNT_BLOCK_SS
as 
select  acb.account_block_id,
        acb.account_id,
        acb.allow_block_id,
        acb.acquisition_date,
        acb.userid,
        acb.trans_id,
        now() as refresh_time
  from  camdams.ACCOUNT_BLOCK acb;


comment on materialized view camdsnap.ACCOUNT_BLOCK_SS is 'snapshot table for snapshot CAMDSNAP.ACCOUNT_BLOCK_SS';
