create or replace procedure camddmw.dm_refresh_unit_fact_update_details
(
    in 	fullrefresh_in 				boolean, 
    in 	incrementalrefreshdate_in	date, 
    out errorJson_out             	json,
    out result_out                	boolean
)
as
$$
declare
    cProcedureName constant text := 'dm_refresh_unit_fact_update_details';

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
	-- full refresh - update all detail columns in all records

	-- incremental refresh - update detail columns for records where
	--	-- unit_fact add_date is on or after the date to go back to OR
	--	-- add date in the details source table is on or after the date to go back to

	-- prg_code_info
	update camddmw.unit_fact uf
		set prg_code_info = details.info,
			last_update_date = details.last_update_date
	from (select uf.unit_id, 
		 	     uf.op_year, 
		 	     string_agg(pyd.prg_code, ', ' order by prg_code) as info,
		 	     greatest(max(pyd.last_update_date), uf.last_update_date) as last_update_date
		  from camddmw.unit_fact uf
			  inner join camddmw.program_year_dim pyd
				  on uf.unit_id = pyd.unit_id and uf.op_year = pyd.op_year
		  where (
				    fullrefresh_in
					or date_trunc('day', uf.add_date) >= incrementalrefreshdate_in
				    or date_trunc('day', pyd.add_date) >= incrementalrefreshdate_in
			    )		
		  group by uf.unit_id, uf.op_year, uf.last_update_date) details
	where uf.unit_id = details.unit_id 
		and uf.op_year = details.op_year;

	-- primary_fuel_info
	update camddmw.unit_fact uf
		set primary_fuel_info = details.info,
			last_update_date = details.last_update_date
	from (select uf.unit_id, 
		 	     uf.op_year, 
		 	     string_agg(fyd.fuel_type_description, ', ' order by fuel_type_description) as info,
		 	     greatest(max(fyd.last_update_date), uf.last_update_date) as last_update_date
		  from camddmw.unit_fact uf
			  inner join camddmw.fuel_year_dim fyd
				  on uf.unit_id = fyd.unit_id and uf.op_year = fyd.op_year and fyd."indicator" = 'P'
		  where (
				    fullrefresh_in
					or date_trunc('day', uf.add_date) >= incrementalrefreshdate_in
				    or date_trunc('day', fyd.add_date) >= incrementalrefreshdate_in
			    )		
		  group by uf.unit_id, uf.op_year, uf.last_update_date) details
	where uf.unit_id = details.unit_id 
		and uf.op_year = details.op_year;

	-- secondary_fuel_info
	update camddmw.unit_fact uf
		set secondary_fuel_info = details.info,
			last_update_date = details.last_update_date
	from (select uf.unit_id, 
		 	     uf.op_year, 
		 	     string_agg(fyd.fuel_type_description, ', ' order by fuel_type_description) as info,
		 	     greatest(max(fyd.last_update_date), uf.last_update_date) as last_update_date
		  from camddmw.unit_fact uf
			  inner join camddmw.fuel_year_dim fyd
				  on uf.unit_id = fyd.unit_id and uf.op_year = fyd.op_year and fyd."indicator" = 'S'
		  where (
				    fullrefresh_in
					or date_trunc('day', uf.add_date) >= incrementalrefreshdate_in
				    or date_trunc('day', fyd.add_date) >= incrementalrefreshdate_in
			    )		
		  group by uf.unit_id, uf.op_year, uf.last_update_date) details
	where uf.unit_id = details.unit_id 
		and uf.op_year = details.op_year;

	-- unit_type_info
	update camddmw.unit_fact uf
		set unit_type_info = details.info,
			last_update_date = details.last_update_date
	from (select uf.unit_id, 
		 	     uf.op_year, 
		 	     string_agg(case
								when utyd.op_year = extract(year from ubt.begin_date)
									and (
											extract(month from ubt.begin_date) <> 1 
											or extract(day from ubt.begin_date) <> 1
										) then
									utyd.unit_type_description || ' (Started ' || to_char(ubt.begin_date, 'Mon DD, YYYY') || ')'
								when utyd.op_year = extract(year from ubt.end_date)
									and (
											extract(month from ubt.end_date) <> 12 
											or extract(day from ubt.end_date) <> 31
										) then
									utyd.unit_type_description || ' (Ended ' || to_char(ubt.end_date, 'Mon DD, YYYY') || ')'
								else 
									utyd.unit_type_description
							end , ', ' 
							order by ubt.begin_date nulls first) as info,
		 	     greatest(max(utyd.last_update_date), uf.last_update_date) as last_update_date
		  from camddmw.unit_fact uf
			  inner join camddmw.unit_type_year_dim utyd
				  on uf.unit_id = utyd.unit_id and uf.op_year = utyd.op_year
			  inner join camdsnap.unit_bt_type_ss ubt
				  on utyd.unit_id = ubt.unit_id and utyd.unit_type = ubt.unit_type
				  	  and (
							  ubt.begin_date is null
							  or extract(year from ubt.begin_date) <= utyd.op_year
						  )
				  	  and (
							  ubt.end_date is null
							  or extract(year from ubt.end_date) >= utyd.op_year
						  )
		  where (
				    fullrefresh_in
					or date_trunc('day', uf.add_date) >= incrementalrefreshdate_in
				    or date_trunc('day', utyd.add_date) >= incrementalrefreshdate_in
			    )		
		  group by uf.unit_id, uf.op_year, uf.last_update_date) details
	where uf.unit_id = details.unit_id 
		and uf.op_year = details.op_year;

	-- nox_phase
	update camddmw.unit_fact uf
		set nox_phase = details.info,
			last_update_date = details.last_update_date
	from (select uf.unit_id, 
		 	     uf.op_year, 
		 	     string_agg(upyd.phase, ', ') as info,
		 	     greatest(max(upyd.last_update_date), uf.last_update_date) as last_update_date
		  from camddmw.unit_fact uf
			  inner join camddmw.unit_phase_year_dim upyd
				  on uf.unit_id = upyd.unit_id and uf.op_year = upyd.op_year and upyd."parameter" = 'NOX'
		  where (
				    fullrefresh_in
					or date_trunc('day', uf.add_date) >= incrementalrefreshdate_in
				    or date_trunc('day', upyd.add_date) >= incrementalrefreshdate_in
			    )		
		  group by uf.unit_id, uf.op_year, uf.last_update_date) details
	where uf.unit_id = details.unit_id 
		and uf.op_year = details.op_year;

	-- so2_phase
	update camddmw.unit_fact uf
		set so2_phase = details.info,
			last_update_date = details.last_update_date
	from (select uf.unit_id, 
		 	     uf.op_year, 
		 	     string_agg(upyd.phase, ', ') as info,
		 	     greatest(max(upyd.last_update_date), uf.last_update_date) as last_update_date
		  from camddmw.unit_fact uf
			  inner join camddmw.unit_phase_year_dim upyd
				  on uf.unit_id = upyd.unit_id and uf.op_year = upyd.op_year and upyd."parameter" = 'SO2'
		  where (
				    fullrefresh_in
					or date_trunc('day', uf.add_date) >= incrementalrefreshdate_in
				    or date_trunc('day', upyd.add_date) >= incrementalrefreshdate_in
			    )		
		  group by uf.unit_id, uf.op_year, uf.last_update_date) details
	where uf.unit_id = details.unit_id 
		and uf.op_year = details.op_year;

	-- so2_control_info
	update camddmw.unit_fact uf
		set so2_control_info = details.info,
			last_update_date = details.last_update_date
	from (select uf.unit_id, 
		 	     uf.op_year, 
		 	     string_agg(case
								when cyd.op_year = extract(year from coalesce(uc.install_date, uc.opt_date))
									and (
											extract(month from coalesce(uc.install_date, uc.opt_date)) <> 1 
											or extract(day from coalesce(uc.install_date, uc.opt_date)) <> 1
										) then
									cyd.control_description || ' (Began ' || to_char(coalesce(uc.install_date, uc.opt_date), 'Mon DD, YYYY') || ')'
								when cyd.op_year = extract(year from uc.retire_date)
									and (
											extract(month from uc.retire_date) <> 12 
											or extract(day from uc.retire_date) <> 31
										) then
									cyd.control_description || ' (Retired ' || to_char(uc.retire_date, 'Mon DD, YYYY') || ')'
								else 
									cyd.control_description
							end , '<br>' 
							order by coalesce(uc.install_date, uc.opt_date) nulls first) as info,
		 	     greatest(max(cyd.last_update_date), uf.last_update_date) as last_update_date
		  from camddmw.unit_fact uf
			  inner join camddmw.control_year_dim cyd
				  on uf.unit_id = cyd.unit_id and uf.op_year = cyd.op_year and cyd."parameter" = 'SO2'
			  inner join camdsnap.unit_control_ss uc
				  on cyd.unit_id = uc.unit_id and cyd."parameter" = uc.ce_param and cyd.control_code = uc.control_cd
				  	  and (
							  coalesce(uc.install_date, uc.opt_date) is null
							  or extract(year from coalesce(uc.install_date, uc.opt_date)) <= cyd.op_year
						  )
				  	  and (
							  uc.retire_date is null
							  or extract(year from uc.retire_date) >= cyd.op_year
						  )
		  where (
				    fullrefresh_in
					or date_trunc('day', uf.add_date) >= incrementalrefreshdate_in
				    or date_trunc('day', cyd.add_date) >= incrementalrefreshdate_in
			    )		
		  group by uf.unit_id, uf.op_year, uf.last_update_date) details
	where uf.unit_id = details.unit_id 
		and uf.op_year = details.op_year;

	-- nox_control_info
	update camddmw.unit_fact uf
		set nox_control_info = details.info,
			last_update_date = details.last_update_date
	from (select uf.unit_id, 
		 	     uf.op_year, 
		 	     string_agg(case
								when cyd.op_year = extract(year from coalesce(uc.install_date, uc.opt_date))
									and (
											extract(month from coalesce(uc.install_date, uc.opt_date)) <> 1 
											or extract(day from coalesce(uc.install_date, uc.opt_date)) <> 1
										) then
									cyd.control_description || ' (Began ' || to_char(coalesce(uc.install_date, uc.opt_date), 'Mon DD, YYYY') || ')'
								when cyd.op_year = extract(year from uc.retire_date)
									and (
											extract(month from uc.retire_date) <> 12 
											or extract(day from uc.retire_date) <> 31
										) then
									cyd.control_description || ' (Retired ' || to_char(uc.retire_date, 'Mon DD, YYYY') || ')'
								else 
									cyd.control_description
							end , '<br>' 
							order by coalesce(uc.install_date, uc.opt_date) nulls first) as info,
		 	     greatest(max(cyd.last_update_date), uf.last_update_date) as last_update_date
		  from camddmw.unit_fact uf
			  inner join camddmw.control_year_dim cyd
				  on uf.unit_id = cyd.unit_id and uf.op_year = cyd.op_year and cyd."parameter" = 'NOX'
			  inner join camdsnap.unit_control_ss uc
				  on cyd.unit_id = uc.unit_id and cyd."parameter" = uc.ce_param and cyd.control_code = uc.control_cd
				  	  and (
							  coalesce(uc.install_date, uc.opt_date) is null
							  or extract(year from coalesce(uc.install_date, uc.opt_date)) <= cyd.op_year
						  )
				  	  and (
							  uc.retire_date is null
							  or extract(year from uc.retire_date) >= cyd.op_year
						  )
		  where (
				    fullrefresh_in
					or date_trunc('day', uf.add_date) >= incrementalrefreshdate_in
				    or date_trunc('day', cyd.add_date) >= incrementalrefreshdate_in
			    )		
		  group by uf.unit_id, uf.op_year, uf.last_update_date) details
	where uf.unit_id = details.unit_id 
		and uf.op_year = details.op_year;

	-- part_control_info
	update camddmw.unit_fact uf
		set part_control_info = details.info,
			last_update_date = details.last_update_date
	from (select uf.unit_id, 
		 	     uf.op_year, 
		 	     string_agg(case
								when cyd.op_year = extract(year from coalesce(uc.install_date, uc.opt_date))
									and (
											extract(month from coalesce(uc.install_date, uc.opt_date)) <> 1 
											or extract(day from coalesce(uc.install_date, uc.opt_date)) <> 1
										) then
									cyd.control_description || ' (Began ' || to_char(coalesce(uc.install_date, uc.opt_date), 'Mon DD, YYYY') || ')'
								when cyd.op_year = extract(year from uc.retire_date)
									and (
											extract(month from uc.retire_date) <> 12 
											or extract(day from uc.retire_date) <> 31
										) then
									cyd.control_description || ' (Retired ' || to_char(uc.retire_date, 'Mon DD, YYYY') || ')'
								else 
									cyd.control_description
							end , '<br>' 
							order by coalesce(uc.install_date, uc.opt_date) nulls first) as info,
		 	     greatest(max(cyd.last_update_date), uf.last_update_date) as last_update_date
		  from camddmw.unit_fact uf
			  inner join camddmw.control_year_dim cyd
				  on uf.unit_id = cyd.unit_id and uf.op_year = cyd.op_year and cyd."parameter" = 'PART'
			  inner join camdsnap.unit_control_ss uc
				  on cyd.unit_id = uc.unit_id and cyd."parameter" = uc.ce_param and cyd.control_code = uc.control_cd
				  	  and (
							  coalesce(uc.install_date, uc.opt_date) is null
							  or extract(year from coalesce(uc.install_date, uc.opt_date)) <= cyd.op_year
						  )
				  	  and (
							  uc.retire_date is null
							  or extract(year from uc.retire_date) >= cyd.op_year
						  )
		  where (
				    fullrefresh_in
					or date_trunc('day', uf.add_date) >= incrementalrefreshdate_in
				    or date_trunc('day', cyd.add_date) >= incrementalrefreshdate_in
			    )		
		  group by uf.unit_id, uf.op_year, uf.last_update_date) details
	where uf.unit_id = details.unit_id 
		and uf.op_year = details.op_year;

	-- hg_control_info
	update camddmw.unit_fact uf
		set hg_control_info = details.info,
			last_update_date = details.last_update_date
	from (select uf.unit_id, 
		 	     uf.op_year, 
		 	     string_agg(case
								when cyd.op_year = extract(year from coalesce(uc.install_date, uc.opt_date))
									and (
											extract(month from coalesce(uc.install_date, uc.opt_date)) <> 1 
											or extract(day from coalesce(uc.install_date, uc.opt_date)) <> 1
										) then
									cyd.control_description || ' (Began ' || to_char(coalesce(uc.install_date, uc.opt_date), 'Mon DD, YYYY') || ')'
								when cyd.op_year = extract(year from uc.retire_date)
									and (
											extract(month from uc.retire_date) <> 12 
											or extract(day from uc.retire_date) <> 31
										) then
									cyd.control_description || ' (Retired ' || to_char(uc.retire_date, 'Mon DD, YYYY') || ')'
								else 
									cyd.control_description
							end , '<br>' 
							order by coalesce(uc.install_date, uc.opt_date) nulls first) as info,
		 	     greatest(max(cyd.last_update_date), uf.last_update_date) as last_update_date
		  from camddmw.unit_fact uf
			  inner join camddmw.control_year_dim cyd
				  on uf.unit_id = cyd.unit_id and uf.op_year = cyd.op_year and cyd."parameter" = 'HG'
			  inner join camdsnap.unit_control_ss uc
				  on cyd.unit_id = uc.unit_id and cyd."parameter" = uc.ce_param and cyd.control_code = uc.control_cd
				  	  and (
							  coalesce(uc.install_date, uc.opt_date) is null
							  or extract(year from coalesce(uc.install_date, uc.opt_date)) <= cyd.op_year
						  )
				  	  and (
							  uc.retire_date is null
							  or extract(year from uc.retire_date) >= cyd.op_year
						  )
		  where (
				    fullrefresh_in
					or date_trunc('day', uf.add_date) >= incrementalrefreshdate_in
				    or date_trunc('day', cyd.add_date) >= incrementalrefreshdate_in
			    )		
		  group by uf.unit_id, uf.op_year, uf.last_update_date) details
	where uf.unit_id = details.unit_id 
		and uf.op_year = details.op_year;

	-- capacity_input
	update camddmw.unit_fact uf
		set capacity_input = details.info,
			last_update_date = details.last_update_date
	from ((select distinct on (uf.unit_id, uf.op_year) 
				 uf.unit_id,
		 	     uf.op_year,
		 	     uc.max_hi_capacity as info,
		 	     uf.last_update_date as last_update_date
		  from camddmw.unit_fact uf
		  	inner join camdsnap.unit_capacity_ss uc
		  		on uf.unit_id = uc.unit_id
		  			and uc.begin_date <= to_date('12/31/' || uf.op_year, 'MM/DD/YYYY') 
		  			and (uc.end_date is null or uc.end_date >= to_date('12/31/' || uf.op_year, 'MM/DD/YYYY'))
		  where uf.op_year < extract(year from current_date)
		  	  and (
				  	  fullrefresh_in
					  or date_trunc('day', uf.add_date) >= incrementalrefreshdate_in
				      or date_trunc('day', coalesce(uc.update_date, uc.add_date)) >= incrementalrefreshdate_in
			      )				      
		  order by uf.unit_id, uf.op_year, uc.begin_date desc nulls last)
		  union all	
		  (select distinct on (uf.unit_id, uf.op_year) 
				 uf.unit_id,
		 	     uf.op_year,
		 	     uc.max_hi_capacity as info,
		 	     uf.last_update_date as last_update_date
		  from camddmw.unit_fact uf
		  	inner join camdsnap.unit_capacity_ss uc
		  		on uf.unit_id = uc.unit_id
		  			and extract(year from uc.begin_date) <= uf.op_year 
		  			and extract(year from uc.end_date) >= uf.op_year
		  where uf.op_year < extract(year from current_date)
		  	  and (
				  	  fullrefresh_in
					  or date_trunc('day', uf.add_date) >= incrementalrefreshdate_in
				      or date_trunc('day', coalesce(uc.update_date, uc.add_date)) >= incrementalrefreshdate_in
			      )	
			  and not exists (select uc_sub.unit_cap_id 
			  					  from camdsnap.unit_capacity_ss uc_sub 
			  					  where uc_sub.unit_id = uf.unit_id
			  					  	  and uc_sub.begin_date <= to_date('12/31/' || uf.op_year, 'MM/DD/YYYY') 
		  							  and (uc_sub.end_date is null or uc_sub.end_date >= to_date('12/31/' || uf.op_year, 'MM/DD/YYYY')) )    
		  order by uf.unit_id, uf.op_year, uc.begin_date desc nulls last)
		  union all	
		  (select distinct on (uf.unit_id, uf.op_year) 
				 uf.unit_id,
		 	     uf.op_year,
		 	     uc.max_hi_capacity as info,
		 	     uf.last_update_date as last_update_date
		  from camddmw.unit_fact uf
		  	inner join camdsnap.unit_capacity_ss uc
		  		on uf.unit_id = uc.unit_id
		  			and extract(year from uc.begin_date) <= extract(year from current_date)
		  			and (uc.end_date is null or extract(year from uc.end_date) >= extract(year from current_date))
		  where uf.op_year >= extract(year from current_date)
		  	  and (
				  	  fullrefresh_in
					  or date_trunc('day', uf.add_date) >= incrementalrefreshdate_in
				      or date_trunc('day', coalesce(uc.update_date, uc.add_date)) >= incrementalrefreshdate_in
			      )				      
		  order by uf.unit_id, uf.op_year, uc.begin_date)
		  union all	
		  (select distinct on (uf.unit_id, uf.op_year) 
				 uf.unit_id,
		 	     uf.op_year,
		 	     uc.max_hi_capacity as info,
		 	     uf.last_update_date as last_update_date
		  from camddmw.unit_fact uf
		  	inner join camdsnap.unit_capacity_ss uc
		  		on uf.unit_id = uc.unit_id
		  			and extract(year from uc.begin_date) <= uf.op_year 
		  			and extract(year from uc.end_date) >= uf.op_year
		  where uf.op_year >= extract(year from current_date)
		  	  and (
				  	  fullrefresh_in
					  or date_trunc('day', uf.add_date) >= incrementalrefreshdate_in
				      or date_trunc('day', coalesce(uc.update_date, uc.add_date)) >= incrementalrefreshdate_in
			      )	
			  and not exists (select uc_sub.unit_cap_id 
			  					  from camdsnap.unit_capacity_ss uc_sub 
			  					  where uc_sub.unit_id = uf.unit_id
			  					  	  and extract(year from uc_sub.begin_date) < extract(year from current_date)
		  							  and (uc_sub.end_date is null or extract(year from uc_sub.end_date) >= extract(year from current_date)) )    
		  order by uf.unit_id, uf.op_year, uc.begin_date desc nulls last)) details
	where uf.unit_id = details.unit_id 
		and uf.op_year = details.op_year;

	-- op_status_info
	update camddmw.unit_fact uf
		set op_status_info = details.info,
			last_update_date = details.last_update_date
	from (select uf.unit_id, 
		 	     uf.op_year, 
		 	     string_agg(case
								when osyd.op_year = extract(year from coalesce(upe.begin_date, uos.begin_date))
									and (
											extract(month from coalesce(upe.begin_date, uos.begin_date)) <> 12 
											or extract(day from coalesce(upe.begin_date, uos.begin_date)) <> 31
										) then
									osyd.op_status_description || ' (Retired ' || to_char(coalesce(uos.begin_date, upe.begin_date), 'MM/DD/YYYY') || ')' --using legacy logic that prefers uos begin_date over upe begin_date
								when osyd.op_year = extract(year from coalesce(uf.comm_op_date, uf.comr_op_date))
									and (
											extract(month from coalesce(uf.comm_op_date, uf.comr_op_date)) <> 1 
											or extract(day from coalesce(uf.comm_op_date, uf.comr_op_date)) <> 1
										) then
									osyd.op_status_description || ' (Started ' || to_char(coalesce(uf.comm_op_date, uf.comr_op_date), 'MM/DD/YYYY') || ')'
								else 
									osyd.op_status_description
							end , ', ' 
							order by uos.begin_date nulls first) as info,
		 	     greatest(max(osyd.last_update_date), uf.last_update_date) as last_update_date
		  from camddmw.unit_fact uf
			  inner join camddmw.op_status_year_dim osyd
				  on uf.unit_id = osyd.unit_id and uf.op_year = osyd.op_year
			  left outer join camdsnap.unit_program_ss up
			  	  on uf.unit_id = up.unit_id and up.prg_code = 'ARP'
			  left outer join camdsnap.unit_program_exemption_ss upe
			  	  on up.up_id = upe.up_id and upe.exempt_type = 'RUE' and upe.end_date is null
			  left outer join camdsnap.unit_op_status_ss uos
				  on uf.unit_id = uos.unit_id and uos.op_status = 'RET' and uos.end_date is null
		  where (
				    fullrefresh_in
					or date_trunc('day', uf.add_date) >= incrementalrefreshdate_in
				    or date_trunc('day', osyd.add_date) >= incrementalrefreshdate_in
			    )		
		  group by uf.unit_id, uf.op_year, uf.last_update_date) details
	where uf.unit_id = details.unit_id 
		and uf.op_year = details.op_year;

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

