create materialized view camdsnap.UNIT_CONTROL_SS 
as 
select  con.ctl_id,
        con.unit_id,
        con.control_cd,
        con.ce_param,
        con.install_date,
        con.opt_date,
        con.orig_cd,
        con.seas_cd,
        con.retire_date,
        con.userid,
        con.update_date,
        con.add_date,
        con.indicator_cd,
        now() as refresh_time
  from  camdecmps.UNIT_CONTROL con;


comment on materialized view camdsnap.UNIT_CONTROL_SS is 'snapshot table for snapshot CAMDSNAP.UNIT_CONTROL_SS';
