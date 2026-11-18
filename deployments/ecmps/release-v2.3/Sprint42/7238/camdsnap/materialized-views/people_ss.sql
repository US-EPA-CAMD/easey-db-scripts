create materialized view camdsnap.PEOPLE_SS 
as 
select  ppl.ppl_id,
        ppl.last_name,
        ppl.first_name,
        ppl.middle_initial,
        ppl.suffix,
        cmp.company_name as affiliation,
        ppl.agency_id,
        ppl.userid,
        ppl.update_date,
        ppl.add_date,
        ppl.person_type_cd as people_type,
        case when person_type_cd = 'IND' then ppl_id else null end as rep_id,
        ppl.company_id as comp_id,
        null as cdx_user_id,
        now() as refresh_time
  from  camd.PERSON ppl 
        left join camd.COMPANY cmp
          on cmp.company_id = ppl.company_id;


comment on materialized view camdsnap.PEOPLE_SS is 'snapshot table for snapshot CAMDSNAP.PEOPLE_SS';
