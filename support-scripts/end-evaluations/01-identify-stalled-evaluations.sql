/*
    The purpose of this script is to identify POTENTIALLY stalled evaluations
    
    The query RETURNS ANY EVALUATION that is NOT 'COMPLETE' or 'ERROR', and was queued in the LAST 60 DAYS. 
    
    ANALYZE THE RESULTS, before using them with the Correct Stalled Evaluations query.  More recent evaluations are more likely not actually have stalled.
*/
select  evq.evaluation_id,
        evs.queued_time::date as queued_date,
        fac.oris_code,
        fac.facility_name,
        (
            select  string_agg( coalesce( unt.unitid, stp.stack_name ), ', ' order by stp.stack_name, unt.unitid )
              from  camdecmpswks.MONITOR_PLAN_LOCATION mpl
                    join camdecmpswks.MONITOR_LOCATION loc using ( mon_loc_id )
                    left join camdecmpswks.UNIT unt using ( unit_id )
                    left join camdecmpswks.STACK_PIPE stp using ( stack_pipe_id )
             where  mpl.mon_plan_id = pln.mon_plan_id
        ) as locations,
        case (evq.process_cd)
            when 'QA' then
                case
                    when evq.test_sum_id is not null then 'QAT' 
                    when evq.qa_cert_event_id is not null then 'QCE' 
                    when evq.test_extension_exemption_id is not null then 'TEE' 
                    else 'Unknown QA'
                end
            else
                evq.process_cd
        end as file_type_cd,
        case ( evq.process_cd )
            when 'EM' then
                'Quarter: ' || prd.period_abbreviation
            when 'QA' then
                'Location: "' 
                || 
                (
                    select  coalesce( unt.unitid, stp.stack_name )
                      from  camdecmpswks.MONITOR_LOCATION loc
                            left join camdecmpswks.UNIT unt using ( unit_id )
                            left join camdecmpswks.STACK_PIPE stp using ( stack_pipe_id )
                     where  loc.mon_loc_id = coalesce( tst.mon_loc_id, qce.mon_loc_id, tee.mon_loc_id )
                )
                || '"' ||
                case
                    when evq.test_sum_id is not null then
                        ', Test Num "' || tst.test_num || '" for Test Type "' || tst.test_type_cd || '"'
                    when evq.qa_cert_event_id is not null then
                        case
                            -- Get from Workspace if it exists
                            when qce.qa_cert_event_id is not null then
                                ', Cert Event: ' || qce.qa_cert_event_cd
                                || case when qce.mon_sys_id is not null then ', System: ' || ( select sys.system_identifier || ' (' || sys.sys_type_cd || ')' from camdecmpswks.MONITOR_SYSTEM sys where sys.mon_sys_id = qce.mon_sys_id ) else '' end
                                || case when qce.component_id is not null then ', Component: ' || ( select cmp.component_identifier || ' (' || cmp.component_type_cd || ')' from camdecmpswks.COMPONENT cmp where cmp.component_id = qce.component_id ) else '' end
                                || ', and ' || to_char ( qce.qa_cert_event_date + qce.qa_cert_event_hour * interval '1 hour', 'yyyy-mm-dd hour hh24' ) || '.'
                        end
                    when evq.test_extension_exemption_id is not null then
                        case
                            -- Get from Workspace if it exists
                            when tee.test_extension_exemption_id is not null then
                                ', Extens/Exempt: ' || tee.extens_exempt_cd
                                || case when tee.mon_sys_id is not null then ', System: ' || ( select sys.system_identifier || ' (' || sys.sys_type_cd || ')' from camdecmpswks.MONITOR_SYSTEM sys where sys.mon_sys_id = tee.mon_sys_id ) else '' end
                                || case when tee.component_id is not null then ', Component: ' || ( select cmp.component_identifier || ' (' || cmp.component_type_cd || ')' from camdecmpswks.COMPONENT cmp where cmp.component_id = tee.component_id ) else '' end
                                || case when tee.fuel_cd is not null then ', Fuel: ' || tee.fuel_cd else '' end
                                || ', and ' || ( select prd.period_abbreviation from camdecmpsmd.REPORTING_PERIOD prd where prd.rpt_period_id = tee.rpt_period_id ) || '.'
                        end
                   else 'Unknown QA'
                end
        end evaluation_info,
        evq.status_cd as evaluation_status,
        evq.queued_time as evaluation_queued,
        evq.started_time as evaluation_started,
        evq.completed_time as evaluation_completed,
        evq.note as evaluation_note,
        evq.note_time as evaluation_noted,
        evq.evaluation_set_id,
        evs.queued_time as set_queued
        --, evq.*
        --, evs.*
  from  camdecmpsaux.EVALUATION_QUEUE evq
        join camdecmpsaux.EVALUATION_SET evs using ( evaluation_set_id )
        left join camdecmpswks.MONITOR_PLAN pln using ( mon_plan_id )
        left join camdecmpsmd.REPORTING_PERIOD prd using ( rpt_period_id )
        join camd.PLANT fac on fac.fac_id = pln.fac_id
        left join camdecmpswks.TEST_SUMMARY tst using ( test_sum_id )
        left join camdecmpswks.QA_CERT_EVENT qce using ( qa_cert_event_id )
        left join camdecmpswks.TEST_EXTENSION_EXEMPTION tee using ( test_extension_exemption_id )
--/*        
 where  coalesce( evq.status_cd ) not in ( 'COMPLETE', 'ERROR' )
   and  (
            evq.queued_time::date >= ( current_date - interval '60 days' )
        )
--*/
 order
    by  evs.queued_time::date,
        oris_code,
        locations,
        evq.evaluation_set_id,
        case ( evq.process_cd )
        when 'MP' then 1 
        when 'EM' then 2
        else
            case
                when evq.test_sum_id is not null then 3
                when evq.qa_cert_event_id is not null then 4
                when evq.test_extension_exemption_id is not null then 5
                else 0
            end
        end,
        evaluation_info,
        evaluation_queued
        