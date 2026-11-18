create materialized view camdsnap.AGENCY_SS 
as 
select  agn.agency_id as agy_id,
        agn.agency_name,
        agn.agency_name2,
        agn.address1,
        agn.address2,
        agn.city,
        agn.state_cd as state,
        agn.zip_code,
        agn.phone_number,
        agn.fax_number,
        agn.userid,
        agn.add_date,
        agn.update_date,
        agn.extension,
        agn.agency_type_cd as agency_type,
        agn.tribal_land_cd,
        now() as refresh_time
  from  camd.AGENCY agn;


comment on materialized view camdsnap.AGENCY_SS is 'snapshot table for snapshot CAMDSNAP.AGENCY_SS';
