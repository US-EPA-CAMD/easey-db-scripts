create materialized view camdsnap.ACCOUNT_PROGRAM_SS
as 
select  acp.account_prg_id,
        acp.account_id,
        acp.prg_cd,
        acp.account_status_cd,
        acp.add_date,
        acp.update_date,
        acp.userid,
        now() as refresh_time
  from  ACCOUNT_PROGRAM acp;


comment on materialized view camdsnap.ACCOUNT_PROGRAM_SS is 'snapshot table for snapshot CAMDSNAP.ACCOUNT_PROGRAM_SS';
