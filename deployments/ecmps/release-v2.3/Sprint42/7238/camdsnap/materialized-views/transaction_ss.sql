create materialized view camdsnap.TRANSACTION_SS
as 
select  trn.trans_id,
        trn.trans_number,
        trn.prg_cd,
        trn.trans_type_cd,
        trn.trans_status_cd,
        trn.buy_account_id,
        trn.buy_ppl_id,
        trn.sell_account_id,
        trn.sell_ppl_id,
        trn.perpetuity_ind,
        trn.changed_trans_id,
        trn.account_comp_id,
        trn.trans_date,
        trn.form_received_date,
        trn.update_date,
        trn.userid,
        now() as refresh_time
  from  camdams.TRANSACTION trn;


comment on materialized view camdsnap.TRANSACTION_SS is 'snapshot table for snapshot CAMDSNAP.TRANSACTION_SS';
