create materialized view camdsnap.UNIT_OWNER_SS 
as 
select  uno.comp_id as own_id,
        uno.unit_id,
        uno.owner_type_cd as ont_type_cd,
        uno.begin_date,
        uno.end_date,
        uno.userid,
        uno.add_date,
        uno.update_date,
        'Official' as relationship,
        uno.unit_owner_id as uon_id,
        now() as refresh_time
  from  camd.UNIT_OWNER uno;


comment on materialized view camdsnap.UNIT_OWNER_SS is 'snapshot table for snapshot CAMDSNAP.UNIT_OWNER_SS';
