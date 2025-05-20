CREATE OR REPLACE VIEW camdecmpsaux.vw_submission_list
 AS
select  fac.oris_code,
       fac.facility_name,
       fac.state,
        case 
        when sbq.test_sum_id is not null then 'Test'
        when sbq.qa_cert_event_id is not null then 'Event'
        when sbq.test_extension_exemption_id is not null then 'TEE'
        else null
        END AS qa_data_type_cd,
        ts.test_type_cd as test_type_cd,
       (
           select  string_agg( coalesce( unt.unitid, stp.stack_name ), ', ' order by stp.stack_name, unt.unitid )
             from  camdecmps.MONITOR_PLAN_LOCATION mpl
                   join camdecmps.MONITOR_LOCATION loc using ( mon_loc_id )
                   left join camd.UNIT unt using ( unit_id )
                   left join camdecmps.STACK_PIPE stp using ( stack_pipe_id )
            where  mpl.mon_plan_id = sbs.mon_plan_id
       ) as locations,
		case 
		    when sbq.process_cd = 'EM' then prd.period_abbreviation::text
		    when sbq.process_cd = 'MP' then null
		    when sbq.process_cd = 'QA' then 
		        case
		            when ts.test_sum_id is not null then COALESCE(ts.test_type_cd, 'no test type') || ', ' || COALESCE(ts.test_num::text, 'no test number')
		            when tee.test_extension_exemption_id is not null then COALESCE(tee.extension_exemption_cd, 'no TEE type') || ', ' || COALESCE(tee.year_quarter::text,'no yr/quarter') || ', ' || COALESCE(tee.system_identifier::text,'no system ID')
		            when cem.cert_event_id is not null then COALESCE(cem.cert_event_cd,'no Event type') || ', ' || COALESCE(cem.event_date_time::text,'no date/hour') || ', ' || COALESCE(cem.system_identifier::text,'no system ID') || ', ' || COALESCE(cem.component_identifier::text,'no component ID')
		            else prd.period_abbreviation::text
		        end
		else prd.period_abbreviation::text
		END AS identifying_information,
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
	           (SELECT
                case 
                when sbq.submission_id = camdecmpsaux.get_last_submission(sbs.mon_plan_id,sbq.rpt_period_id,sbq.process_cd) 
                then 'Yes'
                else  'No'
                END   
               )  as most_recent,
       sbq.status_cd as submission_status,
       sbq.severity_cd,
        (SELECT 
  case 
    when COALESCE(CRIT1.crit1_count, 0) > 0 then 'Yes'
    else 'No'
  END AS severity_critical_1
FROM (
    SELECT 
    q.submission_id,
    COUNT(cl.chk_session_id) FILTER (WHERE cl.severity_cd = 'CRIT1') AS crit1_count
  FROM 
    camdecmpsaux.submission_set s
  join 
    camdecmpsaux.submission_queue q USING (submission_set_id)
  join 
    camd.plant f USING (fac_id)
  join 
    camdecmps.monitor_plan mp ON f.fac_id = mp.fac_id
  left join  
    camdecmpsaux.check_session cs ON mp.chk_session_id  = cs.chk_session_id 
  left join  
    camdecmpsaux.check_log cl ON cs.chk_session_id = cl.chk_session_id
  GROUP BY 
    q.submission_id
) CRIT1
WHERE CRIT1.submission_id = sbq.submission_id),
    	(SELECT 
  case 
    when COALESCE(CRIT2.crit2_count, 0) > 0 then 'Yes'
    else 'No'
  END AS severity_critical_2
FROM (
    SELECT 
    q.submission_id,
    COUNT(cl.chk_session_id) FILTER (WHERE cl.severity_cd = 'CRIT2') AS crit2_count
  FROM 
    camdecmpsaux.submission_set s
  join 
    camdecmpsaux.submission_queue q USING (submission_set_id)
  join 
    camd.plant f USING (fac_id)
  join 
    camdecmps.monitor_plan mp ON f.fac_id = mp.fac_id
  left join  
    camdecmpsaux.check_session cs ON mp.chk_session_id  = cs.chk_session_id 
  left join  
    camdecmpsaux.check_log cl ON cs.chk_session_id = cl.chk_session_id
  GROUP BY 
    q.submission_id
) CRIT2
WHERE CRIT2.submission_id = sbq.submission_id),
(SELECT 
  case 
    when COALESCE(NONCRIT.NONCRIT_count, 0) > 0 then 'Yes'
    else 'No'
  END AS severity_non_critical
FROM (
    SELECT 
    q.submission_id,
    COUNT(cl.chk_session_id) FILTER (WHERE cl.severity_cd = 'NONCRIT') AS NONCRIT_count
  FROM 
    camdecmpsaux.submission_set s
  join 
    camdecmpsaux.submission_queue q USING (submission_set_id)
  join 
    camd.plant f USING (fac_id)
  join 
    camdecmps.monitor_plan mp ON f.fac_id = mp.fac_id
  left join  
    camdecmpsaux.check_session cs ON mp.chk_session_id  = cs.chk_session_id 
  left join  
    camdecmpsaux.check_log cl ON cs.chk_session_id = cl.chk_session_id
  GROUP BY 
    q.submission_id
) NONCRIT
WHERE NONCRIT.submission_id = sbq.submission_id),
(SELECT 
  case 
    when COALESCE(INFORM.INFORM_count, 0) > 0 then 'Yes'
    else 'No'
  END AS severity_informational
FROM (
    SELECT 
    q.submission_id,
    COUNT(cl.chk_session_id) FILTER (WHERE cl.severity_cd = 'INFORM') AS INFORM_count
  FROM 
    camdecmpsaux.submission_set s
  join 
    camdecmpsaux.submission_queue q USING (submission_set_id)
  join 
    camd.plant f USING (fac_id)
  join 
    camdecmps.monitor_plan mp ON f.fac_id = mp.fac_id
  left join 
    camdecmpsaux.check_session cs ON mp.chk_session_id  = cs.chk_session_id 
  left join 
    camdecmpsaux.check_log cl ON cs.chk_session_id = cl.chk_session_id
  GROUP BY 
    q.submission_id
) INFORM
WHERE INFORM.submission_id = sbq.submission_id),
(SELECT 
  case 
    when COALESCE(ADFOR.counts, 0) > 0 then 'Yes'
    else 'No'
  END AS severity_administrative_override
FROM (
    SELECT 
    q.submission_id,
    COUNT(cl.chk_session_id) FILTER (WHERE cl.severity_cd IN ('ADMNOVR','FORGIVE')) AS counts
  FROM 
    camdecmpsaux.submission_set s
  join 
    camdecmpsaux.submission_queue q USING (submission_set_id)
  join 
    camd.plant f USING (fac_id)
  join 
    camdecmps.monitor_plan mp ON f.fac_id = mp.fac_id
  left join  
    camdecmpsaux.check_session cs ON mp.chk_session_id  = cs.chk_session_id 
  left join  
    camdecmpsaux.check_log cl ON cs.chk_session_id = cl.chk_session_id
  GROUP BY 
    q.submission_id
) ADFOR
WHERE ADFOR.submission_id = sbq.submission_id),
       sbs.user_id as submitter,
       sbs.mon_plan_id,
       sbq.rpt_period_id
 from  camdecmpsaux.SUBMisSION_SET sbs
       join camdecmpsaux.SUBMisSION_QUEUE sbq using ( submission_set_id )
       join camd.PLANT fac using ( fac_id )
       left join camdecmpsmd.REPORTING_PERIOD prd using( rpt_period_id )
       left join camdecmpsmd.SEVERITY_CODE sev using ( severity_cd )
       left join camdecmps.test_summary ts on ts.test_sum_id = sbq.test_sum_id
       left join camdecmps.vw_qa_cert_event_maintenance cem on  sbq.qa_cert_event_id = cem.cert_event_id
       left join camdecmps.vw_qa_test_extens_exempt_maintenance tee on sbq.test_extension_exemption_id = tee.test_extension_exemption_id    
order
   by  oris_code,
       locations,
       identifying_information desc,
       submission_id desc