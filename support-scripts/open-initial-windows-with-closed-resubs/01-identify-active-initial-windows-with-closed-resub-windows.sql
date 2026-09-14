select  (
            coalesce( int.em_status_cd, '' ) = 'APPRVD' and coalesce( int.sub_availability_cd, '' ) = 'REQUIRE' and int.submission_id is null
            and 
            coalesce( res.em_status_cd, '' ) = 'RECVD' and coalesce( res.sub_availability_cd, '' ) = 'UPDATED' and res.submission_id is not null
        ) as use_script,
        (
            int.access_begin_date > res.access_begin_date
            or
            int.access_end_date < res.access_end_date
        ) as manual_dates,
        pln.oris_code,
        pln.facility_name,
        pln.locations,
        prd.period_abbreviation as quarter,
        ( int.em_status_cd || ' ' || int.sub_availability_cd || ' ' || coalesce( int.submission_id::text, '(none)' ) || ' ' || int.access_begin_date || ' ' || int.access_end_date ) as initial_status_sac_sub_beg_end,
        ( res.em_status_cd || ' ' || res.sub_availability_cd || ' ' || coalesce( res.submission_id::text, '(none)' ) || ' ' || res.access_begin_date || ' ' || res.access_end_date ) as resub_status_sac_sub_beg_end,
        ( 'select ' || int.em_sub_access_id || ' as initial_window_id, ' || res.em_sub_access_id || ' as resub_window_id union all' ) as sql_core,
        int.em_sub_access_id as initial_esa_id,
        res.em_sub_access_id as resub_esa_id,
        mon_plan_id,
        rpt_period_id
  from  camdecmpsaux.EM_SUBMISSION_ACCESS int
        join camdecmpsaux.EM_SUBMISSION_ACCESS res using ( mon_plan_id, rpt_period_id )
        join camdecmps.VW_MONITOR_PLAN pln using ( mon_plan_id ) 
        join camdecmpsmd.REPORTING_PERIOD prd using ( rpt_period_id )
 where  int.em_sub_type_cd = 'INITIAL'
   and  (
            int.em_status_cd = 'APPRVD' or
            int.sub_availability_cd = 'REQUIRE'-- or
            --int.submission_id is null
        )
   and  res.em_sub_type_cd = 'RQRESUB'
   and  (
            res.em_status_cd = 'RECVD' or
            res.sub_availability_cd = 'UPDATED'-- or
            --res.submission_id is not null
        )
   and  coalesce( res.submission_id, 0 ) >= 0
   and  int.em_sub_access_id != res.em_sub_access_id
 order
    by  use_script desc,
        oris_code,
        locations,
        quarter,
        initial_esa_id,
        resub_esa_id;
