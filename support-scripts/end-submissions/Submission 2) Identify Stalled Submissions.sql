select  sbs.queued_time::date as queued_date,
        sbq.submission_set_id,
        sbq.submission_id,
        fac.oris_code,
        fac.facility_name,
        coalesce
        (
            (
                select  string_agg( coalesce( unt.unitid, stp.stack_name ), ', ' order by stp.stack_name, unt.unitid )
                  from  camdecmpswks.MONITOR_PLAN_LOCATION mpl
                        join camdecmpswks.MONITOR_LOCATION loc using ( mon_loc_id )
                        left join camdecmpswks.UNIT unt using ( unit_id )
                        left join camdecmpswks.STACK_PIPE stp using ( stack_pipe_id )
                 where  mpl.mon_plan_id = wmp.mon_plan_id
            )
            ,
            (
                select  string_agg( coalesce( unt.unitid, stp.stack_name ), ', ' order by stp.stack_name, unt.unitid )
                  from  camdecmps.MONITOR_PLAN_LOCATION mpl
                        join camdecmps.MONITOR_LOCATION loc using ( mon_loc_id )
                        left join camd.UNIT unt using ( unit_id )
                        left join camdecmps.STACK_PIPE stp using ( stack_pipe_id )
                 where  mpl.mon_plan_id = omp.mon_plan_id
            )
        ) as locations,
        case (sbq.process_cd)
            when 'QA' then
                case
                    when sbq.test_sum_id is not null then 'QAT' 
                    when sbq.qa_cert_event_id is not null then 'QCE' 
                    when sbq.test_extension_exemption_id is not null then 'TEE' 
                    else 'Unknown QA'
                end
            else
                sbq.process_cd
        end as file_type_cd,
        case ( sbq.process_cd )
            when 'EM' then
                'Quarter: ' || prd.period_abbreviation
            when 'QA' then
                'Location: "' 
                || 
                coalesce
                (
                    (
                        select  coalesce( unt.unitid, stp.stack_name )
                          from  camdecmpswks.MONITOR_LOCATION loc
                                left join camdecmpswks.UNIT unt using ( unit_id )
                                left join camdecmpswks.STACK_PIPE stp using ( stack_pipe_id )
                         where  loc.mon_loc_id = coalesce( wts.mon_loc_id, wce.mon_loc_id, wee.mon_loc_id )
                    )
                    ,
                    (
                        select  coalesce( unt.unitid, stp.stack_name )
                          from  camdecmps.MONITOR_LOCATION loc
                                left join camd.UNIT unt using ( unit_id )
                                left join camdecmps.STACK_PIPE stp using ( stack_pipe_id )
                         where  loc.mon_loc_id = coalesce( ots.mon_loc_id, oce.mon_loc_id, oee.mon_loc_id )
                    )
                )
                || '"' ||
                case
                    when sbq.test_sum_id is not null then
                        ', Test Num "' || coalesce( wts.test_num, ots.test_num ) || '" for Test Type "' || coalesce( wts.test_type_cd, ots.test_type_cd ) || '"'
                    when sbq.qa_cert_event_id is not null then
                        case
                            -- Get from Workspace if it exists
                            when wce.qa_cert_event_id is not null then
                                ', Cert Event: ' || wce.qa_cert_event_cd
                                || case when wce.mon_sys_id is not null then ', System: ' || ( select sys.system_identifier || ' (' || sys.sys_type_cd || ')' from camdecmpswks.MONITOR_SYSTEM sys where sys.mon_sys_id = wce.mon_sys_id ) else '' end
                                || case when wce.component_id is not null then ', Component: ' || ( select cmp.component_identifier || ' (' || cmp.component_type_cd || ')' from camdecmpswks.COMPONENT cmp where cmp.component_id = wce.component_id ) else '' end
                                || ', and ' || to_char ( wce.qa_cert_event_date + wce.qa_cert_event_hour * interval '1 hour', 'yyyy-mm-dd hour hh24' ) || '.'
                            -- Otherwise get from Official if it exists
                            when oce.qa_cert_event_id is not null then
                                ', Cert Event: ' || oce.qa_cert_event_cd
                                || case when oce.mon_sys_id is not null then ', System: ' || ( select sys.system_identifier || ' (' || sys.sys_type_cd || ')' from camdecmpswks.MONITOR_SYSTEM sys where sys.mon_sys_id = oce.mon_sys_id ) else '' end
                                || case when oce.component_id is not null then ', Component: ' || ( select cmp.component_identifier || ' (' || cmp.component_type_cd || ')' from camdecmpswks.COMPONENT cmp where cmp.component_id = oce.component_id ) else '' end
                                || ', and ' || to_char ( oce.qa_cert_event_date + oce.qa_cert_event_hour * interval '1 hour', 'yyyy-mm-dd hour hh24' ) || '.'
                        end
                    when sbq.test_extension_exemption_id is not null then
                        case
                            -- Get from Workspace if it exists
                            when wee.test_extension_exemption_id is not null then
                                ', Extens/Exempt: ' || wee.extens_exempt_cd
                                || case when wee.mon_sys_id is not null then ', System: ' || ( select sys.system_identifier || ' (' || sys.sys_type_cd || ')' from camdecmpswks.MONITOR_SYSTEM sys where sys.mon_sys_id = wee.mon_sys_id ) else '' end
                                || case when wee.component_id is not null then ', Component: ' || ( select cmp.component_identifier || ' (' || cmp.component_type_cd || ')' from camdecmpswks.COMPONENT cmp where cmp.component_id = wee.component_id ) else '' end
                                || case when wee.fuel_cd is not null then ', Fuel: ' || wee.fuel_cd else '' end
                                || ', and ' || ( select prd.period_abbreviation from camdecmpsmd.REPORTING_PERIOD prd where prd.rpt_period_id = wee.rpt_period_id ) || '.'
                            -- Otherwise get from Official if it exists
                            when oee.test_extension_exemption_id is not null then
                                ', Extens/Exempt: ' || oee.extens_exempt_cd
                                || case when oee.mon_sys_id is not null then ', System: ' || ( select sys.system_identifier || ' (' || sys.sys_type_cd || ')' from camdecmpswks.MONITOR_SYSTEM sys where sys.mon_sys_id = oee.mon_sys_id ) else '' end
                                || case when oee.component_id is not null then ', Component: ' || ( select cmp.component_identifier || ' (' || cmp.component_type_cd || ')' from camdecmpswks.COMPONENT cmp where cmp.component_id = oee.component_id ) else '' end
                                || case when oee.fuel_cd is not null then ', Fuel: ' || oee.fuel_cd else '' end
                                || ', and ' || ( select prd.period_abbreviation from camdecmpsmd.REPORTING_PERIOD prd where prd.rpt_period_id = oee.rpt_period_id ) || '.'
                        end
                   else 'Unknown QA'
                end
        end submission_info,
        sbq.severity_cd,
        (
            select  string_agg( grp.submission_info, E'\r\n' order by grp.submission_id )
              from  (
                        select  sbq.submission_set_id,
                                sbq.submission_id,
                                (
                                    'Submission Id: ' || sbq.submission_id
                                    || E'\t' || 'Status: "' || sbq.status_cd
                                    || E'\t' || 'File Type: "'
                                    || 
                                    case (sbq.process_cd)
                                        when 'QA' then
                                            case
                                                when sbq.test_sum_id is not null then 'QAT' 
                                                when sbq.qa_cert_event_id is not null then 'QCE' 
                                                when sbq.test_extension_exemption_id is not null then 'TEE' 
                                                else 'Unknown QA'
                                            end
                                        else
                                            sbq.process_cd
                                    end
                                    || '"' ||
                                    case ( sbq.process_cd )
                                        when 'EM' then
                                            E'\t' || 'Quarter: ' || ( select prd.period_abbreviation from camdecmpsmd.REPORTING_PERIOD prd where prd.rpt_period_id = sbq.rpt_period_id )
                                        when 'QA' then
                                            case
                                                when sbq.test_sum_id is not null then
                                                    E'\t' || 'Test Type: "' || coalesce( wts.test_type_cd, ots.test_type_cd ) || '"' ||
                                                    E'\t' || 'Test Num: "' || coalesce( wts.test_num, ots.test_num ) || '"'
                                                when sbq.qa_cert_event_id is not null then
                                                    case
                                                        -- Get from Workspace if it exists
                                                        when wce.qa_cert_event_id is not null then
                                                            E'\t' || 'Cert Event: ' || wce.qa_cert_event_cd
                                                            || case when wce.mon_sys_id is not null then E'\t' || 'System: "' || ( select sys.system_identifier || ' (' || sys.sys_type_cd || ')"' from camdecmpswks.MONITOR_SYSTEM sys where sys.mon_sys_id = wce.mon_sys_id ) else '' end
                                                            || case when wce.component_id is not null then E'\t' || 'Component: "' || ( select cmp.component_identifier || ' (' || cmp.component_type_cd || ')"' from camdecmpswks.COMPONENT cmp where cmp.component_id = wce.component_id ) else '' end
                                                            || E'\t' || 'Hour: ' || to_char ( wce.qa_cert_event_date + wce.qa_cert_event_hour * interval '1 hour', 'yyyy-mm-dd hour hh24' ) || '.'
                                                        -- Otherwise get from Official if it exists
                                                        when oce.qa_cert_event_id is not null then
                                                            E'\t' || 'Cert Event: ' || oce.qa_cert_event_cd
                                                            || case when oce.mon_sys_id is not null then E'\t' || 'System: "' || ( select sys.system_identifier || ' (' || sys.sys_type_cd || ')"' from camdecmpswks.MONITOR_SYSTEM sys where sys.mon_sys_id = oce.mon_sys_id ) else '' end
                                                            || case when oce.component_id is not null then E'\t' || 'Component: "' || ( select cmp.component_identifier || ' (' || cmp.component_type_cd || ')"' from camdecmpswks.COMPONENT cmp where cmp.component_id = oce.component_id ) else '' end
                                                            || E'\t' || 'Hour: ' || to_char ( oce.qa_cert_event_date + oce.qa_cert_event_hour * interval '1 hour', 'yyyy-mm-dd hour hh24' ) || '.'
                                                    end
                                                when sbq.test_extension_exemption_id is not null then
                                                    case
                                                        -- Get from Workspace if it exists
                                                        when wee.test_extension_exemption_id is not null then
                                                            E'\t' || 'Extens/Exempt: ' || wee.extens_exempt_cd
                                                            || case when wee.mon_sys_id is not null then E'\t' || 'System: "' || ( select sys.system_identifier || ' (' || sys.sys_type_cd || ')"' from camdecmpswks.MONITOR_SYSTEM sys where sys.mon_sys_id = wee.mon_sys_id ) else '' end
                                                            || case when wee.component_id is not null then E'\t' || 'Component: "' || ( select cmp.component_identifier || ' (' || cmp.component_type_cd || ')"' from camdecmpswks.COMPONENT cmp where cmp.component_id = wee.component_id ) else '' end
                                                            || case when wee.fuel_cd is not null then E'\t' || 'Fuel: "' || wee.fuel_cd || '"' else '' end
                                                            || E'\t' || 'Quarter: ' || ( select prd.period_abbreviation from camdecmpsmd.REPORTING_PERIOD prd where prd.rpt_period_id = wee.rpt_period_id ) || '.'
                                                        -- Otherwise get from Official if it exists
                                                        when oee.test_extension_exemption_id is not null then
                                                            E'\t' || 'Extens/Exempt: ' || oee.extens_exempt_cd
                                                            || case when oee.mon_sys_id is not null then E'\t' || 'System: "' || ( select sys.system_identifier || ' (' || sys.sys_type_cd || ')"' from camdecmpswks.MONITOR_SYSTEM sys where sys.mon_sys_id = oee.mon_sys_id ) else '' end
                                                            || case when oee.component_id is not null then E'\t' || 'Component: "' || ( select cmp.component_identifier || ' (' || cmp.component_type_cd || ')"' from camdecmpswks.COMPONENT cmp where cmp.component_id = oee.component_id ) else '' end
                                                            || case when oee.fuel_cd is not null then E'\t' || 'Fuel: "' || oee.fuel_cd || '"' else '' end
                                                            || E'\t' || 'Quarter: ' || ( select prd.period_abbreviation from camdecmpsmd.REPORTING_PERIOD prd where prd.rpt_period_id = oee.rpt_period_id ) || '.'
                                                    end
                                               else ''
                                            end
                                    end
                                    || E'\t' || 'Severity: "' || sbq.Severity_Cd || '"'
                                ) as submission_info
                          from  camdecmpsaux.SUBMISSION_QUEUE sbq
                                left join camdecmpsmd.REPORTING_PERIOD prd using ( rpt_period_id )
                                left join camdecmps.TEST_SUMMARY ots using ( test_sum_id )
                                left join camdecmpswks.TEST_SUMMARY wts using ( test_sum_id )
                                left join camdecmps.QA_CERT_EVENT oce using ( qa_cert_event_id )
                                left join camdecmpswks.QA_CERT_EVENT wce using ( qa_cert_event_id )
                                left join camdecmps.TEST_EXTENSION_EXEMPTION oee using ( test_extension_exemption_id )
                                left join camdecmpswks.TEST_EXTENSION_EXEMPTION wee using ( test_extension_exemption_id )
                         where  sbq.submission_set_id = sbs.submission_set_id
                    ) grp
        ) as submission_set,
        sbq.status_cd as submission_status,
        sbs.status_cd as set_status,
        sbq.queued_time as submission_queued,
        sbs.queued_time as set_queued,
        sbq.started_time as submission_started,
        sbs.started_time as set_started,
        sbq.completed_time as submission_completed,
        sbs.completed_time as set_completed,
        sbq.note as submission_note,
        sbs.note as submission_note,
        sbq.note_time as submission_noted,
        sbs.note_time as set_noted
        --, sbq.*
        --, sbs.*
  from  camdecmpsaux.SUBMISSION_QUEUE sbq
        join camdecmpsaux.SUBMISSION_SET sbs using ( submission_set_id )
        left join camdecmps.MONITOR_PLAN omp using ( mon_plan_id )
        left join camdecmpswks.MONITOR_PLAN wmp using ( mon_plan_id )
        join camd.PLANT fac on fac.fac_id in ( omp.fac_id , wmp.fac_id )
        left join camdecmpsmd.REPORTING_PERIOD prd using ( rpt_period_id )
        left join camdecmps.TEST_SUMMARY ots using ( test_sum_id )
        left join camdecmpswks.TEST_SUMMARY wts using ( test_sum_id )
        left join camdecmps.QA_CERT_EVENT oce using ( qa_cert_event_id )
        left join camdecmpswks.QA_CERT_EVENT wce using ( qa_cert_event_id )
        left join camdecmps.TEST_EXTENSION_EXEMPTION oee using ( test_extension_exemption_id )
        left join camdecmpswks.TEST_EXTENSION_EXEMPTION wee using ( test_extension_exemption_id )
--/*
 where  coalesce( sbq.status_cd ) not in ( 'COMPLETE', 'ERROR' )
   and  (
            sbq.queued_time::date >= ( current_date - interval '60 days' )
        )
--*/
--where  sbq.submission_id > 0
 order
    by  sbs.queued_time::date,
        oris_code,
        locations,
        case ( sbq.process_cd )
            when 'MP' then 1 
            when 'EM' then 2
            else
                case
                    when sbq.test_sum_id is not null then 3
                    when sbq.qa_cert_event_id is not null then 4
                    when sbq.test_extension_exemption_id is not null then 5
                    else 0
                end
        end,
        submission_info,
        submission_queued
        