create materialized view camdsnap.UNIT_PHYSICAL_MOVE_SS 
as 
select  upm.unit_id,
        upm.new_unit_id,
        upm.effective_date,
        upm.userid,
        upm.add_date,
        upm.update_date,
        now() as refresh_time
  from  UNIT_PHYSICAL_MOVE upm;


comment on materialized view camdsnap.UNIT_PHYSICAL_MOVE_SS is 'snapshot table for snapshot CAMDSNAP.UNIT_PHYSICAL_MOVE_SS';
