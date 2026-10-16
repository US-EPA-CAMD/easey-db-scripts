create materialized view camdsnap.UNIT_SS
as 
select  unt.unit_id,
        acu.account_number as account,
        unt.unit_description,
        unt.fac_id,
        unt.unitid,
        unt.stateid,
        unt.boiler_sequence_number as blrseq,
        unt.comm_op_date,
        unt.comm_op_date_cd,
        unt.comr_op_date,
        unt.comr_op_date_cd,
        unt.userid,
        unt.add_date,
        unt.update_date,
        unt.naics_cd,
        unt.non_load_based_ind,
        unt.actual_90th_op_date,
        unt.source_category_cd,
        unt.no_active_gen_ind,
        unt.indian_country_ind,
        unt.moved_ind,
        now() as refresh_time
  from  camd.UNIT unt
        left join camdams.ACCOUNT_UNIT acu
          on acu.unit_id = unt.unit_id;


comment on materialized view camdsnap.UNIT_SS is 'snapshot table for snapshot CAMDSNAP.UNIT_SS';
