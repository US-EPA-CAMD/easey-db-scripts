create materialized view camdsnap.UNIT_PROGRAM_SS 
as 
select  unp.up_id,
        unp.prg_id,
        unp.unit_id,
        unp.app_status_cd as app_status,
        unp.prg_cd as prg_code,
        unp.class_cd as class,
        unp.end_date,
        unp.optin_ind,
        unp.def_ind,
        unp.def_end_date,
        null as nox_phase,
        null as nox_group,
        null as nox_stan_limit,
        null as nox_year,
        null as ee_ind,
        null as ee_termyear,
        unp.userid,
        unp.add_date,
        unp.update_date,
        null as ee_limit,
        case when unp.non_egu_ind is null then '0' else to_char( unp.non_egu_ind ) end as non_egu_flg,
        unp.unit_monitor_cert_begin_date,
        unp.unit_monitor_cert_deadline,
        unp.emissions_recording_begin_date,
        unp.trueup_begin_year,
        null as first_optin_year,
        null as first_year_value,
        null as subsequent_year_value,
        now() as refresh_time
  from  UNIT_PROGRAM unp
 where  unp.prg_cd not in ( 'ARP' )
union
select  unp.up_id,
        unp.prg_id,
        unp.unit_id,
        unp.app_status_cd as app_status,
        unp.prg_cd as prg_code,
        unp.class_cd as class,
        unp.end_date,
        unp.optin_ind,
        unp.def_ind,
        unp.def_end_date,
        nun.nox_phase,
        nun.nox_group,
        nun.nox_standard_limit as nox_stan_limit,
        nun.nox_year,
        nun.ee_ind,
        nun.ee_termyear,
        unp.userid,
        unp.add_date,
        unp.update_date,
        nun.ee_limit,
        case when unp.non_egu_ind is null then '0' else to_char( unp.non_egu_ind ) end as non_egu_flg,
        unp.unit_monitor_cert_begin_date,
        unp.unit_monitor_cert_deadline,
        unp.emissions_recording_begin_date,
        unp.trueup_begin_year
        aoa.first_optin_year,
        aoa.first_year_value,
        aoa.subsequent_year_value,
        now() as refresh_time
  from  UNIT_PROGRAM  unp
        left join ARP_OPTIN_ALLOCATION aoa
          on aoa.unit_id = unp.unit_id
        left join NOX_UNIT nun
          on nun.unit_id = unp.unit_id
 where  unp.prg_cd IN ( 'ARP' );


comment on materialized view camdsnap.UNIT_PROGRAM_SS is 'snapshot table for snapshot CAMDSNAP.UNIT_PROGRAM_SS';
