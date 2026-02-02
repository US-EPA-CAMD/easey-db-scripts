select  cmb.oris_code,
        cmb.facility_name,
        cmb.locations,
        cmb.file_type_cd,
        cmb.quarter,
        cmb.locaiton_name,
        cmb.file_identifiers,
        cmb.submission_id,
        cmb.report_primary_columns,
        cmb.report_primary_values
  from  (
            select  lst.oris_code,
                    lst.facility_name,
                    lst.locations,
                    lst.file_type_cd,
                    lst.quarter,
                    lst.locaiton_name,
                    lst.file_identifiers,
                    lst.submission_id,
                    lst.report_primary_columns,
                    lst.report_primary_values
              from  (
                        select  pln.oris_code,
                                pln.facility_name,
                                pln.locations,
                                'EM' as file_type_cd,
                                prd.period_description as quarter,
                                null as locaiton_name,
                                null as file_identifiers,
                                dat.submission_id,
                                'mon_plan_id; rpt_period_id' as report_primary_columns,
                                ( dat.mon_plan_id || '; ' || dat.rpt_period_id ) as report_primary_values
                          from  camdecmps.EMISSION_EVALUATION dat
                                left join camdecmps.VW_MONITOR_PLAN pln using ( mon_plan_id )
                                left join camdecmpsmd.REPORTING_PERIOD prd using ( rpt_period_id )
                         where  dat.submission_id >= 0
                         limit  1000
                    ) lst
            union   all
            select  lst.oris_code,
                    lst.facility_name,
                    lst.locations,
                    lst.file_type_cd,
                    lst.quarter,
                    lst.locaiton_name,
                    lst.file_identifiers,
                    lst.submission_id,
                    lst.report_primary_columns,
                    lst.report_primary_values
              from  (
                        select  pln.oris_code,
                                pln.facility_name,
                                pln.locations,
                                'ESA' as file_type_cd,
                                prd.period_description as quarter,
                                null as locaiton_name,
                                null as file_identifiers,
                                dat.submission_id,
                                'mon_plan_id; rpt_period_id' as report_primary_columns,
                                ( dat.mon_plan_id || '; ' || dat.rpt_period_id ) as report_primary_values
                          from  camdecmpsaux.EM_SUBMISSION_ACCESS dat
                                left join camdecmps.VW_MONITOR_PLAN pln using ( mon_plan_id )
                                left join camdecmpsmd.REPORTING_PERIOD prd using ( rpt_period_id )
                         where  dat.submission_id >= 0
                         limit  1000
                    ) lst
            union   all
            select  lst.oris_code,
                    lst.facility_name,
                    lst.locations,
                    lst.file_type_cd,
                    lst.quarter,
                    lst.locaiton_name,
                    lst.file_identifiers,
                    lst.submission_id,
                    lst.report_primary_columns,
                    lst.report_primary_values
              from  (
                        select  pln.oris_code,
                                pln.facility_name,
                                pln.locations,
                                'MP' as file_type_cd,
                                null as quarter,
                                null as locaiton_name,
                                null as file_identifiers,
                                dat.submission_id,
                                'mon_plan_id' as report_primary_columns,
                                dat.mon_plan_id as report_primary_values
                          from  camdecmps.MONITOR_PLAN dat
                                left join camdecmps.VW_MONITOR_PLAN pln using ( mon_plan_id )
                         where  dat.submission_id >= 0
                         limit  1000
                    ) lst
            union   all
            select  lst.oris_code,
                    lst.facility_name,
                    lst.locations,
                    lst.file_type_cd,
                    lst.quarter,
                    lst.locaiton_name,
                    lst.file_identifiers,
                    lst.submission_id,
                    lst.report_primary_columns,
                    lst.report_primary_values
              from  (
                        select  pln.oris_code,
                                pln.facility_name,
                                pln.locations,
                                'QAT' as file_type_cd,
                                prd.period_description as quarter,
                                coalesce( unt.unitid, stp.stack_name ) as locaiton_name,
                                ( dat.test_type_cd || ': ' || dat.test_num ) as file_identifiers,
                                dat.submission_id,
                                'test_sum_id' as report_primary_columns,
                                dat.test_sum_id as report_primary_values
                          from  camdecmps.QA_SUPP_DATA dat
                                left join camdecmpsmd.REPORTING_PERIOD prd
                                  on ( prd.rpt_period_id = dat.rpt_period_id or dat.rpt_period_id is null and dat.end_date between prd.begin_date and prd.end_Date )
                                left join camdecmps.MONITOR_PLAN_LOCATION mpl using ( mon_loc_id )
                                left join camdecmps.MONITOR_PLAN sel 
                                  on sel.mon_plan_id = mpl.mon_plan_id
                                 and sel.begin_rpt_period_id <= prd.rpt_period_id
                                 and ( sel.end_rpt_period_id is null or sel.end_rpt_period_id >= prd.rpt_period_id )
                                left join camdecmps.VW_MONITOR_PLAN pln
                                  on pln.mon_plan_id = sel.mon_plan_id
                                left join camdecmps.MONITOR_LOCATION loc using ( mon_loc_id )
                                left join camd.UNIT unt using ( unit_id )
                                left join camdecmps.STACK_PIPE stp using ( stack_pipe_id )
                         where  dat.submission_id >= 0
                         limit  1000
                    ) lst
            union   all
            select  lst.oris_code,
                    lst.facility_name,
                    lst.locations,
                    lst.file_type_cd,
                    lst.quarter,
                    lst.locaiton_name,
                    lst.file_identifiers,
                    lst.submission_id,
                    lst.report_primary_columns,
                    lst.report_primary_values
              from  (
                        select  pln.oris_code,
                                pln.facility_name,
                                pln.locations,
                                'QCE' as file_type_cd,
                                prd.period_description as quarter,
                                coalesce( unt.unitid, stp.stack_name ) as locaiton_name,
                                (
                                    'Code: ' || dat.qa_cert_event_cd || ' ' ||
                                    case
                                       when dat.mon_sys_id is not null and dat.component_id is not null
                                       then 'Sys: ' || sys.system_identifier || ' (' || sys.sys_type_cd || ') ' ||
                                            'Cmp: ' || cmp.component_identifier || ' (' || cmp.component_type_cd || ')'
                                       when dat.mon_sys_id is not null
                                       then 'Sys: ' || sys.system_identifier || ' (' || sys.sys_type_cd || ')'
                                       when dat.mon_sys_id is not null and dat.component_id is not null
                                       then 'Cmp: ' || cmp.component_identifier || ' (' || cmp.component_type_cd || ')'
                                       else ''
                                    end ||
                                    to_char( dat.qa_cert_event_date + dat.qa_cert_event_hour * interval '1 hour', ' for yyyy-mm-dd hh24' )
                                ) as file_identifiers,
                                dat.submission_id,
                                'qa_cert_event_id' as report_primary_columns,
                                dat.qa_cert_event_id as report_primary_values
                          from  camdecmps.QA_CERT_EVENT dat
                                left join camdecmpsmd.REPORTING_PERIOD prd
                                  on dat.qa_cert_event_date  between prd.begin_date and prd.end_Date 
                                left join camdecmps.MONITOR_PLAN_LOCATION mpl using ( mon_loc_id )
                                left join camdecmps.MONITOR_PLAN sel 
                                  on sel.mon_plan_id = mpl.mon_plan_id
                                 and sel.begin_rpt_period_id <= prd.rpt_period_id
                                 and ( sel.end_rpt_period_id is null or sel.end_rpt_period_id >= prd.rpt_period_id )
                                left join camdecmps.VW_MONITOR_PLAN pln
                                  on pln.mon_plan_id = sel.mon_plan_id
                                left join camdecmps.MONITOR_LOCATION loc using ( mon_loc_id )
                                left join camd.UNIT unt using ( unit_id )
                                left join camdecmps.STACK_PIPE stp using ( stack_pipe_id )
                                left join camdecmps.MONITOR_SYSTEM sys using ( mon_sys_id )
                                left join camdecmps.COMPONENT cmp using ( component_id )
                         where  dat.submission_id >= 0
                         limit  1000
                    ) lst
            union   all
            select  lst.oris_code,
                    lst.facility_name,
                    lst.locations,
                    lst.file_type_cd,
                    lst.quarter,
                    lst.locaiton_name,
                    lst.file_identifiers,
                    lst.submission_id,
                    lst.report_primary_columns,
                    lst.report_primary_values
              from  (
                        select  pln.oris_code,
                                pln.facility_name,
                                pln.locations,
                                'TEE' as file_type_cd,
                                prd.period_description as quarter,
                                coalesce( unt.unitid, stp.stack_name ) as locaiton_name,
                                (
                                    'Code: ' || dat.extens_exempt_cd || ' ' ||
                                    case
                                       when dat.mon_sys_id is not null and dat.component_id is not null
                                       then 'Sys: ' || sys.system_identifier || ' (' || sys.sys_type_cd || ') ' ||
                                            'Cmp: ' || cmp.component_identifier || ' (' || cmp.component_type_cd || ')'
                                       when dat.mon_sys_id is not null
                                       then 'Sys: ' || sys.system_identifier || ' (' || sys.sys_type_cd || ')'
                                       when dat.mon_sys_id is not null and dat.component_id is not null
                                       then 'Cmp: ' || cmp.component_identifier || ' (' || cmp.component_type_cd || ')'
                                       else ''
                                    end ||
                                    case 
                                        when dat.Fuel_Cd is not null
                                        then 'Fuel: ' || dat.fuel_cd
                                        else ''
                                    end ||                                    
                                    (' for ' || prd.period_abbreviation  )
                                ) as file_identifiers,
                                dat.submission_id,
                                'test_extension_exemption_id' as report_primary_columns,
                                dat.test_extension_exemption_id as report_primary_values
                          from  camdecmps.TEST_EXTENSION_EXEMPTION dat
                                left join camdecmpsmd.REPORTING_PERIOD prd
                                  on prd.rpt_period_id = dat.rpt_period_id
                                left join camdecmps.MONITOR_PLAN_LOCATION mpl using ( mon_loc_id )
                                left join camdecmps.MONITOR_PLAN sel 
                                  on sel.mon_plan_id = mpl.mon_plan_id
                                 and sel.begin_rpt_period_id <= prd.rpt_period_id
                                 and ( sel.end_rpt_period_id is null or sel.end_rpt_period_id >= prd.rpt_period_id )
                                left join camdecmps.VW_MONITOR_PLAN pln
                                  on pln.mon_plan_id = sel.mon_plan_id
                                left join camdecmps.MONITOR_LOCATION loc using ( mon_loc_id )
                                left join camd.UNIT unt using ( unit_id )
                                left join camdecmps.STACK_PIPE stp using ( stack_pipe_id )
                                left join camdecmps.MONITOR_SYSTEM sys using ( mon_sys_id )
                                left join camdecmps.COMPONENT cmp using ( component_id )
                         where  dat.submission_id >= 0
                         limit  1000
                    ) lst
        ) cmb
 order 
    by  oris_code,
        locations,
        case ( file_type_cd ) when 'MP' then 1 when 'EM' then 2 when 'QAT' then 3 when 'QCE' then 4 when 'TEE' then 5 when 'ESA' then 6 else 9 end,
        quarter,
        locaiton_name,
        submission_id,
        report_primary_values
;
