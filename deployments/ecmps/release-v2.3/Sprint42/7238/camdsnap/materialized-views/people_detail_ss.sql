create materialized view camdsnap.PEOPLE_DETAIL_SS
as 
select  ppl_id,
        last_name || ', ' || first_name || ' ' || middle_initial as name,
        first_name || ' ' || ltrim( coalesce( middle_initial || ' ', '' ) ) || last_name || case when suffix is not null then ' ' || suffix else '' end as display_name,
        last_name,
        first_name,
        middle_initial,
        suffix,
        cmp.company_name as affiliation
        case when ppl.PERSON_TYPE_CD = 'IND' then ppl.ppl_id else null end as rep_id,
        ppl.userid,
        ppl.update_date,
        ppl.add_date,
        coalesce( ppl.update_date, ppl.add_date ) as last_modified,
        ppl.person_type_cd,
        ptc.person_type_description,
        ptc.person_type_group_cd,
        ( ppl.person_type_cd || ', ' || ptc.person_type_group_cd ) as person_type_and_grp,
        to_char( cmp.company_id ) as comp_id,
        now() as refresh_time
  from  camd.PERSON ppl
        join camdmd.COUNTRY_CODE ccd
          on ccd.country_cd = ppl.country_cd
        left join camdmd.PERSON_TYPE_CODE ptc
          on ptc.person_type_cd = ppl.person_type_cd
        left join camd.COMPANY cmp
          on cmp.company_id = ppl.company_id
 where  ppl.person_type_cd in ( 'IND', 'OTH', 'LGC', 'VND', 'CNS', 'ALB' )
union   all
select  ppl.ppl_id,
        last_name || ', ' || first_name || ' ' || middle_initial as name,
        first_name || ' ' || ltrim( coalesce( middle_initial || ' ', '' ) ) || last_name || case when suffix is not null then ' ' || suffix else '' end as display_name,
        last_name,
        first_name,
        middle_initial,
        suffix,
        agn.agency_name as affiliation,
        case when ppl.person_type_cd = 'IND' then ppl.ppl_id else null end as rep_id,
        ppl.userid,
        ppl.update_date,
        ppl.add_date,
        coalesce( ppl.update_date, ppl.add_date ) as last_modified,
        ppl.person_type_cd,
        ptc.person_type_description,
        ptc.person_type_group_cd,
        ( ppl.person_type_cd || ',' || ptc.person_type_group_cd ) as person_type_and_grp,
        '' as comp_id,
        now() as refresh_time
  from  camd.PERSON ppl
        join camdmd.COUNTRY_CODE ccd
          on ccd.country_cd = ppl.country_cd
        left join camdmd.PERSON_TYPE_CODE ptc
          on ptc.person_type_cd = ppl.person_type_cd
        left join camd.AGENCY agn
          on agn.AGENCY_ID = ppl.AGENCY_ID
 where  ppl.person_type_cd in ( 'STA', 'EPR', 'CMD' );


comment on materialized view camdsnap.PEOPLE_DETAIL_SS is 'snapshot table for snapshot CAMDSNAP.PEOPLE_DETAIL_SS';
