create materialized view camdsnap.PEOPLE_SS 
as 
select  ppl.ppl_id,
        ppl.initial_password_ind as initial_psswrd_flg,
        ppl.password,
        ppl.password_change_date as password_chg_date,
        ppl.last_name,
        ppl.first_name,
        ppl.middle_initial,
        ppl.suffix,
        ppl.job_title,
        cmp.company_name as affiliation,
        ppl.address1,
        ppl.address2,
        ppl.agency_id,
        ppl.city,
        ppl.state_cd as state,
        ppl.zip_code,
        ppl.login,
        ppl.email_address,
        ppl.email_removed_date,
        ppl.email_signature,
        ppl.fax_number,
        ppl.phone_number,
        ppl.extension,
        ppl.userid,
        ppl.update_date,
        ppl.add_date,
        ppl.country_cd as country,
        ppl.person_type_cd as people_type,
        case when person_type_cd = 'IND' then ppl_id else null end as rep_id,
        ppl.company_id as comp_id,
        ppl.acr_id,
        ppl.cromerr_locked_ind,
        ppl.cromerr_failed_cnt,
        ppl.password_locked_ind,
        ppl.password_failed_cnt,
        ppl.ppl_comment                           
        ppl.cell_phone_number,
        ppl.province,
        ppl.subscriber_ind,
        ppl.consultant_ind,
        ppl.security_group_cd,
        ppl.reset_password_code,
        ppl.reset_password_fail_cnt,
        ppl.reset_password_request_date,
        ppl.hide_phishing_ind,
        now() as refresh_time
  from  camd.PERSON ppl 
        left join camd.COMPANY cmp
          on cmp.company_id = ppl.company_id;


comment on materialized view camdsnap.PEOPLE_SS is 'snapshot table for snapshot CAMDSNAP.PEOPLE_SS';
