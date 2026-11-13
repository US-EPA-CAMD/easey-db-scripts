create materialized view camdsnap.UNIT_OP_STATUS_SS 
as 
select  uos.unit_op_status_id as uos_id,
        uos.unit_id,
        uos.op_status_cd as op_status,
        uos.begin_date,
        uos.end_date,
        uos.add_date,
        uos.update_date,
        uos.userid,
        now() as refresh_time
  from  camd.UNIT_OP_STATUS uos;


comment on materialized view camdsnap.UNIT_OP_STATUS_SS is 'snapshot table for snapshot CAMDSNAP.UNIT_OP_STATUS_SS';
