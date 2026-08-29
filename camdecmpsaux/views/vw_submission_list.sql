CREATE OR REPLACE VIEW camdecmpsaux.vw_submission_list
 AS
select  fac.oris_code,
        fac.facility_name,
        fac.state,
        case ( sbq.process_cd )
            when 'QA' then
                case
                    when sbq.test_sum_id is not null then 'QAT'
                    when sbq.qa_cert_event_id is not null then 'QCE'
                    when sbq.test_extension_exemption_id is not null then 'TEE'
                    else sbq.process_cd
                end
            else null
        end as qa_data_type_cd,
        ts.test_type_cd as test_type_cd,
        pln.locations,
        prd.period_abbreviation as reporting_period,
        case
            when sbq.process_cd = 'MP' then
                null
            when sbq.process_cd = 'EM' then
                (
                    select  prd.period_abbreviation
                      from  camdecmpsmd.REPORTING_PERIOD prd
                     where  prd.rpt_period_id = sbq.rpt_period_id
                )
            when sbq.process_cd = 'QA' and sbq.test_sum_id is not null then
                (
                    select  
                    	case 
                    	when tst.test_type_cd is not null and tst.test_num is not null
                    	then tst.test_type_cd || ' - ' || tst.test_num
                    	end
                      from  camdecmps.TEST_SUMMARY tst
                     where  tst.test_sum_id = sbq.test_sum_id
                   UNION ALL
                     SELECT 'Data Unavailable'
					 WHERE NOT EXISTS (
					  SELECT 1 from  camdecmps.TEST_SUMMARY tst
                     where  tst.test_sum_id = sbq.test_sum_id
                     )
                )
            when sbq.process_cd = 'QA' and sbq.qa_cert_event_id is not null then
                (
                select 
                	case 
	                	when sys.sys_type_cd  is not null and sys.system_identifier is not null and cmp.component_type_cd  is not null and cmp.component_identifier is not null
	                	then qce.qa_cert_event_cd || ' (' || camdecmps.format_date_hour(qce.qa_cert_event_date, qce.qa_cert_event_hour, 0::numeric) || ') S: (' || sys.sys_type_cd || '/' || sys.system_identifier || ') C: (' || cmp.component_type_cd || '/' || cmp.component_identifier || ')'
                		when sys.sys_type_cd  is not null and sys.system_identifier is not null
                		then qce.qa_cert_event_cd || ' (' || camdecmps.format_date_hour(qce.qa_cert_event_date, qce.qa_cert_event_hour, 0::numeric) || ') S: (' || sys.sys_type_cd || '/' || sys.system_identifier || ')'
                		when cmp.component_type_cd  is not null and cmp.component_identifier is not null 
                		then qce.qa_cert_event_cd || ' (' || camdecmps.format_date_hour(qce.qa_cert_event_date, qce.qa_cert_event_hour, 0::numeric) || ') C: (' || cmp.component_type_cd || '/' || cmp.component_identifier || ')'
                	end                      
                    from  camdecmps.QA_CERT_EVENT qce
                            left join camdecmps.MONITOR_SYSTEM sys using ( mon_sys_id )
                            left join camdecmps.COMPONENT cmp using ( component_id )
                     where  qce.qa_cert_event_id = sbq.qa_cert_event_id
                UNION ALL
                     SELECT 'Data Unavailable'
					 WHERE NOT EXISTS (
					  SELECT 1 from  camdecmps.QA_CERT_EVENT qce
                     where  qce.qa_cert_event_id = sbq.qa_cert_event_id
                     )
                )
            when sbq.process_cd = 'QA' and sbq.test_extension_exemption_id is not null then
                (
                 select 
                	case 
                    	when tee.extens_exempt_cd is not null and prd.period_abbreviation is not null and sys.sys_type_cd  is not null and sys.system_identifier is not null and cmp.component_type_cd  is not null and cmp.component_identifier is not null
	                	then tee.extens_exempt_cd || ' (' || prd.period_abbreviation || ') S: (' || sys.sys_type_cd || '/' || sys.system_identifier || ') C: (' || cmp.component_type_cd || '/' || cmp.component_identifier ||  ')'
	                	when tee.extens_exempt_cd is not null and prd.period_abbreviation is not null and sys.sys_type_cd  is not null and sys.system_identifier is not null 
	                	then tee.extens_exempt_cd || ' (' || prd.period_abbreviation || ') S: (' || sys.sys_type_cd || '/' || sys.system_identifier || ')'
                        when tee.extens_exempt_cd is not null and prd.period_abbreviation is not null and cmp.component_type_cd  is not null and cmp.component_identifier is not null
	                	then tee.extens_exempt_cd || ' (' || prd.period_abbreviation || ') C: (' || cmp.component_type_cd || '/' || cmp.component_identifier ||  ')'
	                	else tee.extens_exempt_cd || ' (' || prd.period_abbreviation || ')'
                    end
                      from  camdecmps.TEST_EXTENSION_EXEMPTION tee
                            join camdecmpsmd.REPORTING_PERIOD prd using ( rpt_period_id )
                            left join camdecmps.MONITOR_SYSTEM sys using ( mon_sys_id )
                            left join camdecmps.COMPONENT cmp using ( component_id )
                     where  tee.test_extension_exemption_id = sbq.test_extension_exemption_id
                UNION ALL
                     SELECT 'Data Unavailable'
					 WHERE NOT EXISTS (
					  SELECT 1 from  camdecmps.TEST_EXTENSION_EXEMPTION tee
                     where  tee.test_extension_exemption_id = sbq.test_extension_exemption_id
                     )
                )
        end as identifying_information,
        (
           select  rfc.report_freq_cd_description
             from  camdecmps.MONITOR_PLAN_REPORTING_FREQ frq
                   join camdecmpsmd.report_freq_code rfc using ( report_freq_cd )
            where  frq.mon_plan_id = sbs.mon_plan_id
            order 
               by  frq.end_rpt_period_id desc
            limit  1
       ) as reporting_frequency,
       sbq.process_cd,
       sbq.submission_id,
       sbq.queued_time,
       sev.severity_cd_description as severity_level,
       case
          when sbq.submission_id = ls.last_submission_id
          then 'Yes'
          else 'No'
       end most_recent,
       sbq.status_cd as submission_status,
       sbq.severity_cd,
       sbs.user_id as submitter,
       sbs.mon_plan_id,
       sbq.rpt_period_id
  from  camdecmpsaux.SUBMISSION_QUEUE sbq
        join camdecmpsaux.SUBMISSION_SET sbs using ( submission_set_id )
        join camd.PLANT fac using ( fac_id )
        join camdecmps.VW_MONITOR_PLAN pln using ( mon_plan_id )
        left join camdecmpsmd.REPORTING_PERIOD prd using( rpt_period_id )
        left join camdecmpsmd.SEVERITY_CODE sev using ( severity_cd )
        left join camdecmps.test_summary ts on ts.test_sum_id = sbq.test_sum_id   
        join camdecmpsaux.vw_last_submission ls using (submission_id)
        where  sbq.process_cd IN ('EM', 'QA', 'MP')
 order
    by  oris_code,
        locations,
        submission_id desc