create materialized view camdsnap.PEOPLE_DETAIL_SS
as 
select  ppl_id,
        initial_password_ind as initial_psswrd_flg,
        password,
        coalesce( ppl.password_change_date, ppl.add_date ) as password_chg_date,
        to_char( coalesce( ppl.password_change_date, ppl.add_date ), 'HH:MI:SS PM' ) as password_chg_time,
        last_name || ', ' || first_name || ' ' || middle_initial as name,
        first_name || ' ' || ltrim( coalesce( middle_initial || ' ', '' ) ) || last_name || case when suffix is not null then ' ' || suffix else '' end as display_name,
        last_name,
        first_name,
        middle_initial,
        suffix,
        job_title,
        cmp.company_name as affiliation,
        address1,
        address2,
        city,
        state_cd as state,
        zip_code,
        case
            when ppl.zip_code is null
            then null
            when length( ppl.zip_code ) > 5
            then substr( ppl.zip_code, 1, 5 ) || '-' || substr( ppl.zip_code, 6, 10 )
            else ppl.zip_code
        end as formatted_zip_code,
        country_name as country_cd,
        login,
        email_address,
        fax_number,
        case
            when ppl.fax_number is null
            then null
            when length( ppl.fax_number ) = 9
            then substr( ppl.fax_number, 1, 3 ) || '-' || substr( ppl.fax_number, 4, 3 )
            else '(' || substr( ppl.fax_number, 1, 3 ) || ') ' || substr( ppl.fax_number, 4, 3 ) || '-' || substr( ppl.fax_number, 7, 4 )
        end as formatted_fax_number,
        phone_number,
        extension,
        case
            when ppl.phone_number is null
            then null
            when length( ppl.phone_number ) = 9
            then case
                    when length( ppl.extension ) > 1
                    then substr( ppl.phone_number, 1, 3 ) || '-' || substr( ppl.phone_number, 4, 3 )
                    else substr( ppl.phone_number, 1, 3 ) || '-' || substr( ppl.phone_number, 4, 3 ) || ' x ' || ppl.extension
                 end
            else case
                    when length( ppl.extension ) > 1
                    then '(' || substr( ppl.phone_number, 1, 3 ) || ') ' || substr( ppl.phone_number, 4, 3 ) || '-' || substr( ppl.phone_number, 7, 4 )
                    else '(' || substr( ppl.phone_number, 1, 3 ) || ') ' || substr( ppl.phone_number, 4, 3 ) || '-' || substr( ppl.phone_number, 7, 4 ) || ' x ' || ppl.extension
                 end
        end as formatted_phone_number,
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
        ppl.ppl_comment,
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
        initial_password_ind as initial_psswrd_flg,
        password,
        coalesce( ppl.password_change_date, ppl.add_date ) as password_chg_date,
        to_char( coalesce( ppl.password_change_date, ppl.add_date ), 'HH:MI:SS PM' ) as password_chg_time,
        last_name || ', ' || first_name || ' ' || middle_initial as name,
        first_name || ' ' || ltrim( coalesce( middle_initial || ' ', '' ) ) || last_name || case when suffix is not null then ' ' || suffix else '' end as display_name,
        last_name,
        first_name,
        middle_initial,
        suffix,
        job_title,
        agn.agency_name as affiliation,
        ppl.address1,
        ppl.address2,
        ppl.city,
        ppl.state_cd as state,
        ppl.zip_code,
        case
            when ppl.zip_code is null
            then null
            when length( ppl.zip_code ) > 5
            then substr( ppl.zip_code, 1, 5 ) || '-' || substr( ppl.zip_code, 6, 10 )
            else ppl.zip_code
        end as formatted_zip_code,
        country_name as country_cd,
        login,
        email_address,
        ppl.fax_number,
        case
            when ppl.fax_number is null
             null
            when length( ppl.fax_number ) = 9
            then substr( ppl.fax_number, 1, 3 ) || '-' || substr( ppl.fax_number, 4, 3 )
            else '(' || substr( ppl.fax_number, 1, 3 ) || ') ' || substr( ppl.fax_number, 4, 3 ) || '-' || substr( ppl.fax_number, 7, 4 )
        end as formatted_fax_number,
        ppl.phone_number,
        ppl.extension,
        case
            when ppl.phone_number is null
            then null
            when length ( ppl.phone_number ) = 9
            then case
                    when length( ppl.extension ) > 1
                    then substr( ppl.phone_number, 1, 3 ) || '-' || substr( ppl.phone_number, 4, 3 )
                    else substr( ppl.phone_number, 1, 3 ) || '-' || substr( ppl.phone_number, 4, 3 ) || ' x ' || ppl.extension
                 end
            else case
                    when length (p.extension) > 1
                    then '(' || substr( ppl.phone_number, 1, 3 ) || ') ' || substr( ppl.phone_number, 4, 3 ) || '-' || substr( ppl.phone_number, 7, 4 )
                    else '(' || substr( ppl.phone_number, 1, 3 ) || ') ' || substr( ppl.phone_number, 4, 3 ) || '-' || substr( ppl.phone_number, 7, 4 ) || ' x ' || ppl.extension
                 end
        end as formatted_phone_number,
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
        ppl.ppl_comment,
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
