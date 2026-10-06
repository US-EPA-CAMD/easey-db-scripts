create materialized view camdsnap.UNIT_BT_TYPE_SS 
as 
select  ubt.unit_boiler_type_id as unit_bt_id,
        ubt.unit_id,
        ubt.unit_type_cd as unit_type,
        ubt.begin_date,
        ubt.end_date,
        ubt.add_date,
        ubt.userid,
        ubt.update_date,
        now() as refresh_time
  from  camd.UNIT_BOILER_TYPE ubt;


comment on materialized view camdsnap.UNIT_BT_TYPE_SS is 'snapshot table for snapshot CAMDSNAP.UNIT_BT_TYPE_SS';
