create or replace procedure camddmw.dm_refresh_program_year_dim
(
    out errorJson_out               json,
    out result_out                  boolean
)
as
$$
declare
    cProcedureName constant text := 'dm_refresh_program_year_dim';

    -- Stacked Diagnostic Variables
    vErrorReturnedSqlstate      text;
    vErrorMessageText           text;
    vErrorPgExceptionDetail     text;
    vErrorPgExceptionHint       text;
    vErrorPgExceptionContext    text;
    vErrorSchemaName            text;
    vErrorTableName             text;
    vErrorColumnName            text;
    vErrorConstraintName        text;
begin
	create temp table IF NOT EXISTS program_year_dim_temp (
		unit_id numeric(38) NOT NULL,
		prg_code varchar(7) NOT NULL,
		program_description varchar(1000) NULL,
		op_year numeric(4) NOT NULL,
		report_freq varchar(2) NULL,
		data_source varchar(35) NOT NULL DEFAULT 'CAMD',
		userid varchar(160) NOT NULL DEFAULT 'DMLOAD',
		add_date timestamp NOT NULL DEFAULT now(),
		non_egu_flg varchar(8) NULL,
		compliance_ind numeric(1) NULL,
		last_update_date timestamp NULL,
		PRIMARY KEY (unit_id, prg_code, op_year)
	) ON COMMIT DROP;

	delete from program_year_dim_temp;

	-- add ARP records for 1980, 1985, 1990 for units that reported emissions
	insert into program_year_dim_temp (unit_id, op_year, prg_code, program_description,	report_freq, non_egu_flg, compliance_ind, last_update_date)
	select
		aud.unit_id,
		aud.op_year,
		pc.prg_cd as prg_code,
		pc.prg_description as program_description,
		'Q' as report_freq,
		case
			when up.non_egu_flg = '1' then 'NON EGU'
			when up.non_egu_flg = '0' then 'EGU'
			else null
		end as non_egu_flg,
		0 as compliance_ind,
		greatest(u.add_date, u.update_date, up.add_date, up.update_date, aud.add_date) as last_update_date
	from
		camddmw_arch.annual_unit_data_a aud
	inner join camdsnap.unit_ss u on aud.unit_id = u.unit_id	
	inner join camdsnap.unit_program_ss up on
		u.unit_id = up.unit_id
		and up.prg_code = 'ARP'
	inner join camdmd.program_code pc on
		up.prg_code = pc.prg_cd
	where aud.op_year in (1980, 1985, 1990);

	-- add ARP records for opt-in, substition, and compensating units (from unit_program_phase)	
	insert into program_year_dim_temp (unit_id, op_year, prg_code, program_description,	report_freq, non_egu_flg, compliance_ind, last_update_date)
	select
		u.unit_id,
		y.year_to_load as op_year,
		pc.prg_cd as prg_code,
		pc.prg_description as program_description,
		'Q' as report_freq,
		case
			when up.non_egu_flg = '1' then 'NON EGU'
			when up.non_egu_flg = '0' then 'EGU'
			else null
		end as non_egu_flg,
		1 as compliance_ind,
		greatest(up.add_date, up.update_date) as last_update_date
	from camdsnap.unit_ss u	
	inner join camdsnap.unit_program_ss up on
		u.unit_id = up.unit_id
		and up.prg_code = 'ARP'
	inner join camdmd.program_code pc on
		up.prg_code = pc.prg_cd
	inner join camdsnap.unit_program_phase_ss upp on up.up_id = upp.up_id,
	lateral generate_series(upp.begin_year, case when upp.end_year is not null then upp.end_year when up.end_date is not null then extract(year from up.end_date) else extract(year from now()) end) as y(year_to_load);
	
	-- add relevant records (from unit_program)
	insert into program_year_dim_temp (unit_id, op_year, prg_code, program_description,	report_freq, non_egu_flg, compliance_ind, last_update_date)
	select
		up.unit_id,
		y.year_to_load,
		up.prg_code,
		pc.prg_description, 
		case 
			when exists (select	mprf.report_freq_cd
						 from camdsnap.monitor_location_ss ml
						 inner join camdsnap.monitor_plan_location_ss mpl on
						 	ml.mon_loc_id = mpl.mon_loc_id
						 inner join camdsnap.monitor_plan_reporting_freq_ss mprf on
							mpl.mon_plan_id = mprf.mon_plan_id
							and mprf.report_freq_cd = 'Q'
						 inner join camdecmpsmd.reporting_period rpb on
							mprf.begin_rpt_period_id = rpb.rpt_period_id
							and rpb.calendar_year <= y.year_to_load
						 left outer join camdecmpsmd.reporting_period rpe on
							mprf.end_rpt_period_id = rpe.rpt_period_id
						 where
							(mprf.end_rpt_period_id is null or rpe.calendar_year >= y.year_to_load)
							and u.unit_id = ml.unit_id) then 'Q'
			when exists (select	mprf.report_freq_cd
						 from camdsnap.monitor_location_ss ml
						 inner join camdsnap.monitor_plan_location_ss mpl on
						 	ml.mon_loc_id = mpl.mon_loc_id
						 inner join camdsnap.monitor_plan_reporting_freq_ss mprf on
							mpl.mon_plan_id = mprf.mon_plan_id
							and mprf.report_freq_cd = 'OS'
						 inner join camdecmpsmd.reporting_period rpb on
							mprf.begin_rpt_period_id = rpb.rpt_period_id
							and rpb.calendar_year <= y.year_to_load
						 left outer join camdecmpsmd.reporting_period rpe on
							mprf.end_rpt_period_id = rpe.rpt_period_id
						 where
							(mprf.end_rpt_period_id is null or rpe.calendar_year >= y.year_to_load)
							and u.unit_id = ml.unit_id) then 'OS'
			when exists (select peuq.unit_id
						 from camd.pre_ecmps_unit_quarter peuq
						 where peuq.unit_id = u.unit_id
							and peuq.op_year = y.year_to_load
							and peuq.op_quarter in (1, 4)) then 'Q'
			when exists (select peuq.unit_id
						 from camd.pre_ecmps_unit_quarter peuq
						 where peuq.unit_id = u.unit_id
							and peuq.op_year = y.year_to_load
							and peuq.op_quarter in (2, 3)) then 'OS'
			else 'Q'
		end as report_freq_cd,
		case
			when up.non_egu_flg = '1' then 'NON EGU'
			when up.non_egu_flg = '0' then 'EGU'
			else null
		end as non_egu_flg,
		case 	   		
			when y.year_to_load >= case
									when up.trueup_begin_year is not null then up.trueup_begin_year
									when up.unit_monitor_cert_deadline is not null then greatest(extract(year from up.unit_monitor_cert_deadline), extract(year from pp.prog_phase_begin_date))
									else greatest(least(extract(year from case
																			when (up.unit_monitor_cert_deadline is null or up.emissions_recording_begin_date is null) then coalesce(u.actual_90th_op_date, od90.nintieth_op_date)
																			else null
																		  end), 
														extract(year from (up.unit_monitor_cert_begin_date + 180))), 
												  extract(year from pp.prog_phase_begin_date))
								   end then 1
			when exists (select up_id from camdsnap.unit_program_phase_ss upp where upp.up_id = up.up_id and y.year_to_load between upp.begin_year and coalesce(upp.end_year, extract(year from now()))) then 1
			else 0
		end as comp_ind,
		greatest(up.add_date, up.update_date, pp.add_date, pp.update_date, u.add_date, u.update_date) as last_update_date
	from
		camdsnap.unit_program_ss up
	inner join camdsnap.unit_ss u on
		up.unit_id = u.unit_id
	inner join camdmd.class_code cc on
		up."class" = cc.class_cd
		and cc.affected_ind = 1
	inner join camdmd.program_code pc on
		up.prg_code = pc.prg_cd
	inner join camdsnap.program_phase_ss pp on
		up.prg_id = pp.prg_id
		and 
		(
			(up.prg_code = 'ARP' and up."class" = pp.phase)
			or 
			(
				up.prg_code in ('NBP', 'NHNOX')
				and pp.phase = 'OTC'
				and exists (select upo.up_id from camdsnap.unit_program_ss upo where upo.prg_code = 'OTC' and upo.unit_id = u.unit_id))
			or 
			(
				up.prg_code in ('NBP')
				and coalesce(pp.phase, 'NON-OTC') = 'NON-OTC'
				and not exists (select upo.up_id from camdsnap.unit_program_ss upo where upo.prg_code = 'OTC' and upo.unit_id = u.unit_id))
			or (up.prg_code not in ('ARP', 'NBP', 'NHNOX') and pp.phase is null)
		)
	left outer join camd.unit_program_90th_op_date od90 on
		up.unit_id = od90.unit_id
		and up.prg_code = od90.prg_cd	
	inner join camddmw.dm_determine_years_for_unit_program() upy on
		up.up_id = upy.up_id,
	lateral generate_series(upy.first_year, coalesce(upy.last_year, extract(year from now()))) as y(year_to_load)
	where
		up.unit_monitor_cert_begin_date is not null
		and up.def_ind = 0
		and not exists (select uos.uos_id from camdsnap.unit_op_status_ss uos where	uos.unit_id = up.unit_id and uos.op_status = 'CAN')
		and (
				(up.unit_monitor_cert_deadline is not null and up.emissions_recording_begin_date is not null)
				or (coalesce(u.actual_90th_op_date, od90.nintieth_op_date) is not null)
			)
		and	(pc.os_ind = 0 or least(up.unit_monitor_cert_begin_date, up.unit_monitor_cert_deadline, up.emissions_recording_begin_date) <= to_date('09/30/' || y.year_to_load, 'MM/DD/YYYY'))
		and (least(extract(year from up.unit_monitor_cert_begin_date), extract(year from up.unit_monitor_cert_deadline), extract(year from up.emissions_recording_begin_date)) <= y.year_to_load)
		-- exclude units based on exemptions and RET op status
		and case 
			-- RGGI without reporting requirement for year - DO NOT LOAD
			when up.prg_code = 'RGGI' and not exists (select prg_param_id 
														from camdecmpsaux.program_parameter pp 
														inner join camdecmpsmd.reporting_period rpb on 
															pp.begin_rpt_period_id = rpb.rpt_period_id
														left outer join camdecmpsmd.reporting_period rpe on 
															pp.end_rpt_period_id = rpe.rpt_period_id
														where up.prg_id = pp.prg_id 
															and pp.parameter_cd = 'CO2' 
															and y.year_to_load between rpb.calendar_year and coalesce(rpe.calendar_year, extract(year from now()))) then 0
			-- NUE or 25TON exemption active for year - DO NOT LOAD
			when exists(select up_id 
						from camdsnap.unit_program_exemption_ss upe 
						where upe.up_id = up.up_id 
							and upe.exempt_type in ('NUE','25TON') 
							and coalesce(upe.end_date, now()) >= to_date('01/01/' || y.year_to_load, 'MM/DD/YYYY')) then 0
			-- non-OS program with RUE active for entire year - DO NOT LOAD			
			when pc.os_ind = 0 
				and exists(select up_id 
							from camdsnap.unit_program_exemption_ss upe 
							where upe.up_id = up.up_id 
								and upe.exempt_type = 'RUE'
								and upe.begin_date <= to_date('01/01/' || y.year_to_load, 'MM/DD/YYYY')
								and coalesce(upe.end_date, now()) >= to_date('12/31/' || y.year_to_load, 'MM/DD/YYYY')) then 0
			-- OS program with RUE active for entire OS - DO NOT LOAD					
			when pc.os_ind = 1 
				and exists(select up_id 
							from camdsnap.unit_program_exemption_ss upe 
							where upe.up_id = up.up_id 
								and upe.exempt_type = 'RUE'
								and upe.begin_date <= to_date('05/01/' || y.year_to_load, 'MM/DD/YYYY')
								and coalesce(upe.end_date, now()) >= to_date('09/30/' || y.year_to_load, 'MM/DD/YYYY')) then 0
			-- unit is RET for entire year to load (or 5/1 - 9/30 of the year to load for OS programs) for non-RUE programs - DO NOT LOAD	
			when not exists(select prg_cd from camdmd.program_exemption pe where pe.exemption_type_cd = 'RUE' and pe.prg_cd = up.prg_code)		
				and exists(select uos_id 
							from camdsnap.unit_op_status_ss uos 
							where uos.unit_id = up.unit_id 
							and uos.op_status = 'RET' 
							and (
									(pc.os_ind = 0 and uos.begin_date <= to_date('01/01/' || y.year_to_load, 'MM/DD/YYYY') and coalesce(uos.end_date, now()) >= to_date('12/31/' || y.year_to_load, 'MM/DD/YYYY')) 
									or ((pc.os_ind = 1 and uos.begin_date <= to_date('05/01/' || y.year_to_load, 'MM/DD/YYYY') and coalesce(uos.end_date, now()) >= to_date('09/30/' || y.year_to_load, 'MM/DD/YYYY')))
								)) then 0				
			-- unit is LTCS for entire year to load (or 5/1 - 9/30 of the year to load for OS programs) - DO NOT LOAD
			when exists(select uos_id 
						from camdsnap.unit_op_status_ss uos 
						where uos.unit_id = up.unit_id 
						and uos.op_status = 'LTCS' 
						and (
								(pc.os_ind = 0 and uos.begin_date <= to_date('01/01/' || y.year_to_load, 'MM/DD/YYYY') and coalesce(uos.end_date, now()) >= to_date('12/31/' || y.year_to_load, 'MM/DD/YYYY')) 
								or ((pc.os_ind = 1 and uos.begin_date <= to_date('05/01/' || y.year_to_load, 'MM/DD/YYYY') and coalesce(uos.end_date, now()) >= to_date('09/30/' || y.year_to_load, 'MM/DD/YYYY')))
							)) then 0
			-- unit is RET or LTCS for entire year to load (or 5/1 - 9/30 of the year to load for OS programs) - DO NOT LOAD
			when exists(select uos_id 
						from camdsnap.unit_op_status_ss uos 
						where uos.unit_id = up.unit_id
						and uos.op_status in ('LTCS','RET')
						and (
								(pc.os_ind = 0 and uos.begin_date <= to_date('12/31/' || y.year_to_load, 'MM/DD/YYYY') and coalesce(uos.end_date, now()) >= to_date('01/01/' || y.year_to_load, 'MM/DD/YYYY')) 
								or ((pc.os_ind = 1 and uos.begin_date <= to_date('09/30/' || y.year_to_load, 'MM/DD/YYYY') and coalesce(uos.end_date, now()) >= to_date('05/01/' || y.year_to_load, 'MM/DD/YYYY')))
							))	
				 and not exists(select uos_id 
						from camdsnap.unit_op_status_ss uos 
						where uos.unit_id = up.unit_id
						and uos.op_status not in ('LTCS','RET')
						and (
								(pc.os_ind = 0 and uos.begin_date <= to_date('12/31/' || y.year_to_load, 'MM/DD/YYYY') and coalesce(uos.end_date, now()) >= to_date('01/01/' || y.year_to_load, 'MM/DD/YYYY')) 
								or ((pc.os_ind = 1 and uos.begin_date <= to_date('09/30/' || y.year_to_load, 'MM/DD/YYYY') and coalesce(uos.end_date, now()) >= to_date('05/01/' || y.year_to_load, 'MM/DD/YYYY')))
							)) then 0	
			-- Special Case - Alma units B1, B2, B3 for ARP before 1998 or after 2004 - DO NOT LOAD
			when up.unit_id in (2625,2626,2627) and up.prg_code = 'ARP'	and (y.year_to_load < 1998 or y.year_to_load > 2004) then 0
			else 1					
		end = 1
	on conflict do nothing;
	
	-- add ARP 1993 and 1994 records for units that reported emissions and have been loaded for 1990 and 1995 (if not already loaded) 
	insert into program_year_dim_temp (unit_id, op_year, prg_code, program_description,	report_freq, non_egu_flg, compliance_ind, last_update_date)
	select
		u.unit_id,
		y.year_to_load,
		pc.prg_cd as prg_code,
		pc.prg_description as program_description,
		'Q' as report_freq,
		case
			when up.non_egu_flg = '1' then 'NON EGU'
			when up.non_egu_flg = '0' then 'EGU'
			else null
		end as non_egu_flg,
		case
			when y.year_to_load >= case	
									when up.trueup_begin_year is not null then up.trueup_begin_year 
									when up.unit_monitor_cert_deadline is not null then greatest(extract(year from up.unit_monitor_cert_deadline), extract(year from pp.prog_phase_begin_date))
									else greatest(least(extract(year from case
																			when up.unit_monitor_cert_deadline is null
																				or up.emissions_recording_begin_date is null then
																				case
																					when u.actual_90th_op_date is not null then u.actual_90th_op_date
																					when od90.nintieth_op_date is not null then od90.nintieth_op_date
																					else null
																				end
																				else null
																			end), extract(year from (up.unit_monitor_cert_begin_date + 180))), extract(year from pp.prog_phase_begin_date))
								   end then 1
			when exists (select up_id from camdsnap.unit_program_phase_ss upp where upp.up_id = up.up_id and y.year_to_load between upp.begin_year and coalesce(upp.end_year, extract(year from now()))) then 1
		    else 0 						   
		end
		as compliance_ind,
		greatest(up.add_date, up.update_date, pp.add_date, pp.update_date) as last_update_date
	from
		camdsnap.unit_ss u
	inner join camdsnap.unit_program_ss up on
		u.unit_id = up.unit_id
		and up.prg_code = 'ARP'
	inner join camdmd.program_code pc on
		up.prg_code = pc.prg_cd
	inner join camdmd.class_code cc on 
		up."class" = cc.class_cd
		and cc.affected_ind = 1
	inner join camdsnap.program_phase_ss pp on
		up."class" = pp.phase
	left outer join camd.unit_program_90th_op_date od90	on
		up.unit_id = od90.unit_id and up.prg_code = od90.prg_cd 
	cross join generate_series(1993, 1994) as y(year_to_load)
	where
		up.unit_monitor_cert_begin_date is not null
		and exists (select unit_id from	camddmw_arch.annual_unit_data_a aud where aud.op_year = 1990 and aud.unit_id = u.unit_id)
		and exists (select unit_id from	camddmw_arch.annual_unit_data_a aud	where aud.op_year = 1995 and aud.unit_id = u.unit_id)
		and exists (select unit_id from program_year_dim_temp pydt where pydt.op_year = 1990 and pydt.unit_id = up.unit_id and pydt.prg_code = up.prg_code)
		and exists (select unit_id from program_year_dim_temp pydt where pydt.op_year = 1995 and pydt.unit_id = up.unit_id and pydt.prg_code = up.prg_code)
	on conflict do nothing;	
	
	--  Add ARP 1996+ records for LTCS units that have ARP NOx compliance results (if not already loaded)
	insert into program_year_dim_temp (unit_id, op_year, prg_code, program_description,	report_freq, non_egu_flg, compliance_ind, last_update_date)
	select
		u.unit_id,
		y.year_to_load,
		pc.prg_cd as prg_code,
		pc.prg_description as program_description,
		'Q' as report_freq,
		'EGU' as non_egu_flg,
		1 as compliance_ind,
		greatest(uos.add_date, uos.update_date, ncpr.add_date, ncpr.update_date) as last_update_date
	from
		camdsnap.unit_ss u
	inner join camdsnap.unit_program_ss up on
		u.unit_id = up.unit_id
		and up.prg_code = 'ARP'
	inner join camdmd.program_code pc on
		up.prg_code = pc.prg_cd
	cross join generate_series(1996, extract(year from now())) as y(year_to_load)
	inner join camdsnap.unit_op_status_ss uos on
	    u.unit_id = uos.unit_id
	    and uos.op_status = 'LTCS'
		and uos.begin_date <= to_date('01/01/' || y.year_to_load, 'MM/DD/YYYY')
			and (uos.end_date is null
				or uos.end_date >= to_date('12/31/' || y.year_to_load, 'MM/DD/YYYY'))
	inner join camdsnap.nox_comp_plan_ss ncp on 
		u.unit_id = ncp.unit_id
	inner join camdsnap.nox_comp_plan_result_ss ncpr on 
		ncp.comp_plan_id = ncpr.comp_plan_id 
		and ncpr.final_ind = 1
	inner join camdsnap.compliance_period_ss cp on 
		ncpr.comp_period_id = cp.comp_period_id
	inner join camdsnap.program_vintage_ss pv on 
		cp.prg_vintage_id = pv.prg_vintage_id 
		and pv.vintage_year = y.year_to_load
	where 
		not exists (select unit_id from program_year_dim_temp pydt where pydt.op_year = y.year_to_load and pydt.unit_id = up.unit_id and pydt.prg_code = up.prg_code)
	on conflict do nothing;

	-- delete records from program_year_dim that are not in program_year_dim_temp
	delete from camddmw.program_year_dim
		where not exists (select unit_id 
							from program_year_dim_temp pydt 
							where pydt.unit_id = pyd.unit_id  
								and pydt.prg_code = pyd.prg_code
								and pydt.op_year = pyd.op_year);

	-- update records in program_year_dim where data is different in program_year_dim_temp
	-- insert records into program_year_dim that are in program_year_dim_temp that are not in program_year_dim
	insert into camddmw.program_year_dim
		(unit_id, prg_code, op_year, program_description, report_freq, non_egu_flg, compliance_ind, last_update_date, data_source, userid, add_date)
	select unit_id, prg_code, op_year, program_description,	report_freq, non_egu_flg, compliance_ind, last_update_date, data_source, userid, add_date
		from program_year_dim_temp
	on conflict (unit_id, prg_code, op_year)
	do update set 
		program_description = excluded.program_description,
		report_freq = excluded.report_freq,
		non_egu_flg = excluded.non_egu_flg,
		compliance_ind = excluded.compliance_ind,
		last_update_date = excluded.last_update_date,
		data_source = excluded.data_source,
		userid = excluded.userid,
		add_date = excluded.add_date
	where program_year_dim_test.program_description <> excluded.program_description
		or program_year_dim_test.report_freq <> excluded.report_freq
		or program_year_dim_test.non_egu_flg <> excluded.non_egu_flg
		or program_year_dim_test.compliance_ind <> excluded.compliance_ind
		or program_year_dim_test.last_update_date <> excluded.last_update_date
		or program_year_dim_test.data_source <> excluded.data_source
		or program_year_dim_test.userid <> excluded.userid
		or program_year_dim_test.add_date <> excluded.add_date;

	result_out := true;
    
exception when others then
    get stacked diagnostics 
        vErrorReturnedSqlstate      = RETURNED_SQLSTATE,
        vErrorMessageText           = MESSAGE_TEXT,
        vErrorPgExceptionDetail     = PG_EXCEPTION_DETAIL,
        vErrorPgExceptionHint       = PG_EXCEPTION_HINT,
        vErrorPgExceptionContext    = PG_EXCEPTION_CONTEXT,
        vErrorSchemaName            = SCHEMA_NAME,
        vErrorTableName             = TABLE_NAME,
        vErrorColumnName            = COLUMN_NAME,
        vErrorConstraintName        = CONSTRAINT_NAME;
    
    errorJson_out := jsonb_build_object
                     (
                        'routine_name',             cProcedureName,
                        'returned_sqlstate',        vErrorReturnedSqlstate,
                        'message_text',             vErrorMessageText,
                        'pg_exception_detail',      vErrorPgExceptionDetail,
                        'pg_exception_hint',        vErrorPgExceptionHint,
                        'pg_exception_context',     vErrorPgExceptionContext,
                        'schema_name',              vErrorSchemaName,
                        'table_name',               vErrorTableName,
                        'column_name',              vErrorColumnName,
                        'constraint_name',          vErrorConstraintName
                     );
    
    result_out := false;
end;
$$
language plpgsql;

