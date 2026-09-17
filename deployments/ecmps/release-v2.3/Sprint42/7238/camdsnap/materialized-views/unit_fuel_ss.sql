create materialized view camdsnap.UNIT_FUEL_SS 
as 
select  fue.unit_id,
        fue.begin_date,
        fue.fuel_type,
        fue.indicator_cd,
        fue.act_or_proj_cd,
        fue.end_date,
        fue.ozone_seas_ind,
        fue.dem_so2,
        fue.dem_gcv,
        fue.userid,
        fue.add_date,
        fue.update_date,
        fue.sulfur_content,
        fue.uf_id,
        now() as refresh_time
  from  camdecmps.UNIT_FUEL fue;


comment on materialized view camdsnap.UNIT_FUEL_SS is 'snapshot table for snapshot CAMDSNAP.UNIT_FUEL_SS';
