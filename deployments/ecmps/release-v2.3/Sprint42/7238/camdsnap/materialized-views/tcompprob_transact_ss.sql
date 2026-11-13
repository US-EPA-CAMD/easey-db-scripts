create materialized view camdsnap.TCOMPPROB_TRANSACT_SS 
as 
select  cpt.tranevnt_cnt,
        cpt.acctnum_id,
        cpt.compyear_dt,
        cpt.block_total,
        cpt.trantype_cd,
        cpt.allwtrans_cd,
        cpt.allwyear_dt,
        now() as refresh_time
  from  camdams.NTCOMPPROB_TRANSACT cpt;


comment on materialized view camdsnap.TCOMPPROB_TRANSACT_SS is 'snapshot table for snapshot CAMDSNAP.TCOMPPROB_TRANSACT_SS';
