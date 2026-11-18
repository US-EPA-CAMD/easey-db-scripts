create materialized view camdsnap.TRANSACTION_BLOCK_SS
as 
select  trb.trans_block_id,
        trb.trans_id,
        trb.begin_number,
        trb.end_number,
        trb.prg_vintage_id,
        now() as refresh_time
  from  camdams.TRANSACTION_BLOCK trb;


comment on materialized view camdsnap.TRANSACTION_BLOCK_SS is 'snapshot table for snapshot CAMDSNAP.TRANSACTION_BLOCK_SS';
