create materialized view camdsnap.ALLOWANCE_BLOCK_SS
as 
select  alb.allow_block_id,
        alb.prg_vintage_id,
        alb.begin_number,
        alb.end_number,
        alb.allow_type_cd,
        alb.allow_status_cd,
        alb.add_date,
        alb.update_date,
        alb.userid,
        now() as refresh_time
  from  camdams.ALLOWANCE_BLOCK alb;


comment on materialized view camdsnap.ALLOWANCE_BLOCK_SS is 'snapshot table for snapshot CAMDSNAP.ALLOWANCE_BLOCK_SS';
