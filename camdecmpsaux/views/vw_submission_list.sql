CREATE OR REPLACE VIEW camdecmpsaux.vw_submission_list
 AS
select  fac.oris_code,
       fac.facility_name,
       fac.state,
       (
           select  string_agg( coalesce( unt.unitid, stp.stack_name ), ', ' order by stp.stack_name, unt.unitid )
             from  camdecmps.MONITOR_PLAN_LOCATION mpl
                   join camdecmps.MONITOR_LOCATION loc using ( mon_loc_id )
                   left join camd.UNIT unt using ( unit_id )
                   left join camdecmps.STACK_PIPE stp using ( stack_pipe_id )
            where  mpl.mon_plan_id = sbs.mon_plan_id
       ) as locations,
       prd.period_abbreviation as reporting_period,
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
                CASE 
                WHEN sbq.submission_id = camdecmpsaux.get_last_submission(sbs.mon_plan_id,sbq.rpt_period_id,sbq.process_cd) 
                THEN 'Yes'
                ELSE  'No'
                END   
               )  as most_recent,
       sbq.status_cd as submission_status,
       sbq.severity_cd,
        (SELECT 
  CASE 
    WHEN COALESCE(CRIT1.crit1_count, 0) > 0 THEN 'Yes'
    ELSE 'No'
  END AS severity_critical_1
FROM (
    SELECT 
    q.submission_id,
    COUNT(cl.chk_session_id) FILTER (WHERE cl.severity_cd = 'CRIT1') AS crit1_count
  FROM 
    camdecmpsaux.submission_set s
  JOIN 
    camdecmpsaux.submission_queue q USING (submission_set_id)
  JOIN 
    camd.plant f USING (fac_id)
  JOIN 
    camdecmps.monitor_plan mp ON f.fac_id = mp.fac_id
  left JOIN  
    camdecmpsaux.check_session cs ON mp.chk_session_id  = cs.chk_session_id 
  left JOIN  
    camdecmpsaux.check_log cl ON cs.chk_session_id = cl.chk_session_id
  GROUP BY 
    q.submission_id
) CRIT1
WHERE CRIT1.submission_id = sbq.submission_id),
    	(SELECT 
  CASE 
    WHEN COALESCE(CRIT2.crit2_count, 0) > 0 THEN 'Yes'
    ELSE 'No'
  END AS severity_critical_2
FROM (
    SELECT 
    q.submission_id,
    COUNT(cl.chk_session_id) FILTER (WHERE cl.severity_cd = 'CRIT2') AS crit2_count
  FROM 
    camdecmpsaux.submission_set s
  JOIN 
    camdecmpsaux.submission_queue q USING (submission_set_id)
  JOIN 
    camd.plant f USING (fac_id)
  JOIN 
    camdecmps.monitor_plan mp ON f.fac_id = mp.fac_id
  left JOIN  
    camdecmpsaux.check_session cs ON mp.chk_session_id  = cs.chk_session_id 
  left JOIN  
    camdecmpsaux.check_log cl ON cs.chk_session_id = cl.chk_session_id
  GROUP BY 
    q.submission_id
) CRIT2
WHERE CRIT2.submission_id = sbq.submission_id),
(SELECT 
  CASE 
    WHEN COALESCE(NONCRIT.NONCRIT_count, 0) > 0 THEN 'Yes'
    ELSE 'No'
  END AS severity_non_critical
FROM (
    SELECT 
    q.submission_id,
    COUNT(cl.chk_session_id) FILTER (WHERE cl.severity_cd = 'NONCRIT') AS NONCRIT_count
  FROM 
    camdecmpsaux.submission_set s
  JOIN 
    camdecmpsaux.submission_queue q USING (submission_set_id)
  JOIN 
    camd.plant f USING (fac_id)
  JOIN 
    camdecmps.monitor_plan mp ON f.fac_id = mp.fac_id
  left JOIN  
    camdecmpsaux.check_session cs ON mp.chk_session_id  = cs.chk_session_id 
  left JOIN  
    camdecmpsaux.check_log cl ON cs.chk_session_id = cl.chk_session_id
  GROUP BY 
    q.submission_id
) NONCRIT
WHERE NONCRIT.submission_id = sbq.submission_id),
(SELECT 
  CASE 
    WHEN COALESCE(INFORM.INFORM_count, 0) > 0 THEN 'Yes'
    ELSE 'No'
  END AS severity_informational
FROM (
    SELECT 
    q.submission_id,
    COUNT(cl.chk_session_id) FILTER (WHERE cl.severity_cd = 'INFORM') AS INFORM_count
  FROM 
    camdecmpsaux.submission_set s
  JOIN 
    camdecmpsaux.submission_queue q USING (submission_set_id)
  JOIN 
    camd.plant f USING (fac_id)
  JOIN 
    camdecmps.monitor_plan mp ON f.fac_id = mp.fac_id
  left JOIN 
    camdecmpsaux.check_session cs ON mp.chk_session_id  = cs.chk_session_id 
  left JOIN 
    camdecmpsaux.check_log cl ON cs.chk_session_id = cl.chk_session_id
  GROUP BY 
    q.submission_id
) INFORM
WHERE INFORM.submission_id = sbq.submission_id),
(SELECT 
  CASE 
    WHEN COALESCE(ADFOR.counts, 0) > 0 THEN 'Yes'
    ELSE 'No'
  END AS severity_administrative_override
FROM (
    SELECT 
    q.submission_id,
    COUNT(cl.chk_session_id) FILTER (WHERE cl.severity_cd IN ('ADMNOVR','FORGIVE')) AS counts
  FROM 
    camdecmpsaux.submission_set s
  JOIN 
    camdecmpsaux.submission_queue q USING (submission_set_id)
  JOIN 
    camd.plant f USING (fac_id)
  JOIN 
    camdecmps.monitor_plan mp ON f.fac_id = mp.fac_id
  left JOIN  
    camdecmpsaux.check_session cs ON mp.chk_session_id  = cs.chk_session_id 
  left JOIN  
    camdecmpsaux.check_log cl ON cs.chk_session_id = cl.chk_session_id
  GROUP BY 
    q.submission_id
) ADFOR
WHERE ADFOR.submission_id = sbq.submission_id),
       sbs.user_id as submitter,
       sbs.mon_plan_id,
       sbq.rpt_period_id
 from  camdecmpsaux.SUBMISSION_SET sbs
       join camdecmpsaux.SUBMISSION_QUEUE sbq using ( submission_set_id )
       join camd.PLANT fac using ( fac_id )
       left join camdecmpsmd.REPORTING_PERIOD prd using( rpt_period_id )
       left join camdecmpsmd.SEVERITY_CODE sev using ( severity_cd )
order
   by  oris_code,
       locations,
       reporting_period desc,
       submission_id desc