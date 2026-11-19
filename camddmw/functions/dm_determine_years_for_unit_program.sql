create or replace function camddmw.dm_determine_years_for_unit_program() 
returns table (up_id numeric(38, 0), first_year numeric(4), last_year numeric(4)) 
language plpgsql 
as 
$$ 
declare 
	up_rec RECORD;
begin 
	for up_rec in
        select
            up.up_id,
            up.unit_id,
            u.account,
            up.prg_code,
            lpad(f.oris_code::text, 6, '0') || 'FACLTY'          as facility_account,
			unit_monitor_cert_begin_date, 
			coalesce(u.actual_90th_op_date, od90.nintieth_op_date) as op_date_90,
            extract(year from up.unit_monitor_cert_begin_date)   as umcbd_year,
            extract(year from up.unit_monitor_cert_deadline)     as umcd_year,
            extract(year from up.emissions_recording_begin_date) as erbd_year,
			extract(year from pp.phase_monitor_cert_deadline)	 as pmcd_year,
			least (
				extract(year from up.unit_monitor_cert_begin_date),
				extract(year from up.emissions_recording_begin_date)
			) as first_year, -- default first year to earlier of year umcbd and erbd
			least(extract(year from up.end_date), extract(year from p.end_date)) as last_year
        from camdsnap.unit_ss u
        inner join camdsnap.facility_ss f
        	on u.fac_id = f.fac_id
        inner join camdsnap.unit_program_ss up
        	on u.unit_id = up.unit_id
        inner join camdsnap.program_phase_ss pp
        	on up.prg_id = pp.prg_id
	        and (
	                (up.prg_code = 'ARP' and up."class" = pp.phase)
	              	or (
							up.prg_code in ('NBP', 'NHNOX')
	                      	and pp.phase = 'OTC'
	                        and exists (select upo.up_id from camdsnap.unit_program_ss upo where upo.prg_code = 'OTC' and upo.unit_id  = u.unit_id)
					   )
                    or (
                            up.prg_code in ('NBP')
                            and coalesce(pp.phase, 'NON-OTC') = 'NON-OTC'
                            and not exists (select upo.up_id from camdsnap.unit_program_ss upo where upo.prg_code = 'OTC' and upo.unit_id  = u.unit_id)
					   )
                    or (
                            up.prg_code not in ('ARP', 'NBP', 'NHNOX') and pp.phase is null
					   ) 
				)
        left outer join camd.unit_program_90th_op_date od90 on up.unit_id = od90.unit_id and up.prg_code = od90.prg_cd
		inner join camdsnap.program_ss p on up.prg_id = p.prg_id
	loop 
		up_id := up_rec.up_id;
		first_year := up_rec.first_year;
		last_year := up_rec.last_year;
		
		if first_year is not null then
			-- when first year is initially populated, first year should be the later of first year and pmcd
			first_year := greatest(first_year, up_rec.pmcd_year);
		else
			-- when first year is not initially populated, first year should be the later of pmcd and the earlier of 90th op date or umcbd + 180
			first_year := greatest(
							least(
								extract(year from case
								                    when up_rec.umcd_year is null or up_rec.erbd_year is null then
							                            up_rec.op_date_90
								                    else null
								                  end), 
								extract(year from (up_rec.unit_monitor_cert_begin_date + 180))
							), 
							up_rec.pmcd_year
						);
		end if;
			
		-- first year should not be before the earliest unit program date
		first_year := greatest(first_year, least (up_rec.umcbd_year, up_rec.umcd_year, up_rec.erbd_year));

		-- first year should not be earlier than erbd year if first year with emissions data is after erbd year
		if first_year < up_rec.erbd_year
			and (select coalesce(min(aud_all.op_year), 9999)
					from (select aud.op_year from camddmw.annual_unit_data aud where aud.unit_id = up_rec.unit_id
						  union all
						  select aud_a.op_year from camddmw_arch.annual_unit_data_a aud_a where aud_a.unit_id = up_rec.unit_id) aud_all) >= up_rec.erbd_year then
			first_year := up_rec.erbd_year;
		end if;

		-- first year should not be after the first year with compliance data for the unit
		first_year := least(first_year, (select min(op_year) from camddmw.account_compliance_dim acd where acd.account_number = up_rec.account and acd.prg_code = up_rec.prg_code));

        -- first year should not be after the first year with compliance data for the unit's facility account for years before 2006
		first_year := least(first_year, (select min(op_year) from camddmw.account_compliance_dim acd where acd.account_number = up_rec.facility_account and acd.prg_code = up_rec.prg_code and acd.op_year < 2006));
        
		-- first year should not be before the year of a physical move effective date
		first_year := greatest(first_year, (select max(extract(year from effective_date)) from camdsnap.unit_physical_move_ss upm where upm.new_unit_id = up_rec.unit_id));

		-- first possible year for NBP is 2003 regardless of unit program dates	
		if up_rec.prg_code = 'NBP' then
			first_year := greatest(first_year, 2003);
		end if;

		-- first possible year for OTC is 199 regardless of unit program dates	
		if up_rec.prg_code = 'OTC' then
			first_year := greatest(first_year, 1999);
		end if;
        
		return next;
	end loop;
end;
$$;