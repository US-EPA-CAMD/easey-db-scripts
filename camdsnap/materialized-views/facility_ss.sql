create materialized view camdsnap.FACILITY_SS
as 
select  fac.fac_id,
        fac.oris_code,
        fac.facility_name,
        fac.description,
        fac.state,
        fac.county_cd,
        fac.sic_code,
        fac.epa_region,
        fac.nerc_region,
        fac.airsid,
        fac.findsid,
        fac.stateid,
        fac.latitude,
        fac.longitude,
        fac.userid,
        fac.add_date,
        fac.update_date,
        fac.frs_id,
        fac.payee_id,
        fac.permit_exp_date,
        fac.latlon_source,
        fac.tribal_land_cd,
        now() as refresh_time
  from  camd.PLANT fac;


comment on materialized view camdsnap.FACILITY_SS is 'snapshot table for snapshot CAMDSNAP.FACILITY_SS';
