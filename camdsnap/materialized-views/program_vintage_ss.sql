create materialized view camdsnap.PROGRAM_VINTAGE_SS
as 
select  prv.prg_vintage_id,
        prv.prg_cd,
        prv.prg_vintage_name ,
        prv.begin_date,
        prv.end_date,
        prv.allocation_ind,
        prv.add_date,
        prv.update_date,
        prv.userid,
        now() as refresh_time
  from  camdams.PROGRAM_VINTAGE prv;


comment on materialized view camdsnap.PROGRAM_VINTAGE_SS is 'snapshot table for snapshot CAMDSNAP.PROGRAM_VINTAGE_SS';
