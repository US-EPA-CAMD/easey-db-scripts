select 	concat( 'ORIS ', fac.oris_code, ' (', fac.facility_name, ') Location ', coalesce( unt.unitid , stp.stack_name ) ) as location,
		tst.test_type_cd ,
		tst.test_num ,
		--to_char( ( tst.end_date + make_time( cast( tst.end_hour as integer ), cast( tst.end_min as integer ), 0 ) ), 'yyyy-mm-dd hh24:mi' ) as Test_DateHour,
        DateAdd(minute, tst.end_min, DateAdd(hour, tst.end_hour, tst.end_date)) as Test_DateHour,
		concat( coalesce( sys.system_identifier, cmp.component_identifier ), ' (', coalesce( sys.sys_type_cd, cmp.component_type_cd), ')' ) as Sys_Cmp_Info,
		chl.severity_cd ,
		concat( chk.check_type_cd, '-', chk.check_number, '-', chl.check_result ) as result_cd,
		'(update)' as Fired,
		chl.result_message,
		null as notes,
		(
			select	concat( '"QAT" "', mpl.mon_plan_id, '" "', tst.test_sum_id, '"' )
			  from	ECMPS.dbo.MONITOR_PLAN_LOCATION mpl
			  		join ECMPS.dbo.MONITOR_PLAN pln on pln.mon_plan_id = mpl.mon_plan_id
			 where	mpl.mon_loc_id = loc.mon_loc_id 
			   --and	pln.end_rpt_period_Id is null
	           and 	coalesce( pln.END_RPT_PERIOD_ID, 999 ) in 
	             	( 
		                select  max( coalesce( ex2.END_RPT_PERIOD_ID, 999 ) ) 
		                  from  ECMPS.dbo.MONITOR_PLAN_LOCATION ex1
		                        join ECMPS.dbo.MONITOR_PLAN ex2 on ex2.MON_PLAN_ID = ex1.MON_PLAN_ID
		                where ex1.MON_LOC_ID = loc.MON_LOC_ID
	             	)
		) as command_line_params
		--/*
		--, chl.severity_cd		
		--, chl.suppressed_severity_cd 
		--*/
		/*
		, chs.severity_cd as session_severity_cd
		, chs.process_cd
		, chs.updated_status_flg
		, chs.session_begin_date
		, chs.session_end_date
		, chs.session_comment
		, tst.test_sum_id
		--*/
  from  ECMPS.dbo.MONITOR_LOCATION loc
  		left join ECMPS.dbo.UNIT unt on unt.unit_id = loc.unit_id 
  		left join ECMPS.dbo.STACK_PIPE stp on stp.stack_pipe_id  = loc.stack_pipe_id 
  		join ECMPS.dbo.FACILITY fac on fac.fac_id in ( unt.fac_id, stp.fac_id )
  		join ECMPS.dbo.TEST_SUMMARY tst on tst.mon_loc_id = loc.mon_loc_id 
  		left join ECMPS.dbo.MONITOR_SYSTEM sys on sys.mon_sys_id = tst.mon_sys_id 
  		left join ECMPS.dbo.COMPONENT cmp on cmp.component_id = tst.component_id 
  		left join ECMPS_AUX.dbo.CHECK_SESSION chs on chs.test_sum_id = tst.test_sum_id 
  		left join ECMPS_AUX.dbo.CHECK_LOG chl  on chl.chk_session_id = chs.chk_session_id 
  		left join ECMPS_AUX.dbo.CHECK_CATALOG_RESULT ccr on ccr.check_catalog_result_id  = chl.check_catalog_result_id 
  		left join ECMPS_AUX.dbo.CHECK_CATALOG chk on chk.check_catalog_id = ccr.check_catalog_id 
  		left join ECMPS_AUX.dbo.SEVERITY_CODE sev on sev.severity_cd = chl.severity_cd 
 --where 	fac.oris_code in ( 3, 6030, 6068 )
   --and	tst.test_type_cd in ( 'RATA' )
   --and	fac.oris_code in ( 6068 ) and coalesce( unt.unitid , stp.stack_name ) in ( '2' )
 order 
 	by	oris_code ,
		facility_name ,
		coalesce( unt.unitid , stp.stack_name ),
		test_type_cd,
		test_num,
		sev.severity_level desc,
		severity_cd,
		check_type_cd,
		check_number,
		chl.check_result,
		chl.result_message
