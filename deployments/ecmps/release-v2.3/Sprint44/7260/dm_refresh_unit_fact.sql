create or replace procedure camddmw.dm_refresh_unit_fact
(
    out errorJson_out             json,
    out result_out                boolean
)
as
$$
declare
    cProcedureName constant text := 'dm_refresh_unit_fact';

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
	-- add records for units with emissions data in either annual_unit_data or annual_unit_data_a
	insert into camddmw.unit_fact_test (unit_id, op_year, fac_id, facility_name, orispl_code, unitid, comm_op_date, comr_op_date, userid, add_date, data_source, last_update_date)
	select
		aud.unit_id,
		aud.op_year,
		f.fac_id,
		f.facility_name,
		f.oris_code,
		u.unitid,
		u.comm_op_date,
		u.comr_op_date,
		'DMLOAD' as userid,
		now() as add_date,
		CASE
			WHEN coalesce(greatest(sum_op_time, so2_mass, nox_mass, nox_rate, heat_input, co2_mass), 0) > 0 THEN 'EMISSIONS'
			ELSE 'REPORTED'
		END as data_source, -- set data_source based on presence of non-null, non-zero values
		greatest(u.add_date, u.update_date, f.add_date, f.update_date, aud.add_date) as last_update_date
	from
		(select unit_id, op_year, sum_op_time, so2_mass, nox_mass, nox_rate, heat_input, co2_mass, add_date from camddmw.annual_unit_data
		 union all
		 select unit_id, op_year, sum_op_time, so2_mass, nox_mass, nox_rate, heat_input, co2_mass, add_date from camddmw_arch.annual_unit_data_a) aud
	inner join camdsnap.unit_ss u on aud.unit_id = u.unit_id	
	inner join camdsnap.facility_ss f on u.fac_id = f.fac_id
	where not exists (select uf.unit_id from camddmw.unit_fact_test uf where uf.unit_id = aud.unit_id and uf.op_year = aud.op_year);

	-- add records for units with transaction or compliance data - TODO uncomment after we have all of the underlying tables created and populated
	/*
	-- unit account is the buying account for at least one AMS transaction during the op_year
	insert into camddmw.unit_fact_test (unit_id, op_year, fac_id, facility_name, orispl_code, unitid, comm_op_date, comr_op_date, userid, add_date, data_source, last_update_date)
	select
		u.unit_id,
		avy.op_year,
		f.fac_id,
		f.facility_name,
		f.oris_code,
		u.unitid,
		u.comm_op_date,
		u.comr_op_date,
		'DMLOAD' as userid,
		now() as add_date,
		'ACCOUNT' as data_source,
		greatest(u.add_date, u.update_date, f.add_date, f.update_date, a.add_date, a.update_date, t.add_date, t.update_date) as last_update_date
	from camdsnap.unit_ss u	
	inner join camdsnap.facility_ss f on u.fac_id = f.fac_id
	cross join camddmw.allowance_valid_year avy
	inner join camdsnap.account_ss a on u.account = a.account_number
	inner join camdsnap.transaction_ss t on a.account_id = t.buy_account_id and avy.op_year = extract(year from t.trans_date)
	left outer join camdnats.ttransact nt on u.account = bt.buyacct_id and avy.op_year = substr(t.cnfrmdte_dt, 1, 4)
	where not exists (select uf.unit_id from camddmw.unit_fact uf where uf.unit_id = aud.unit_id and uf.op_year = aud.op_year);	

	-- unit account is the buying account for at least one NATS transaction during the op_year
	insert into camddmw.unit_fact_test (unit_id, op_year, fac_id, facility_name, orispl_code, unitid, comm_op_date, comr_op_date, userid, add_date, data_source, last_update_date)
	select
		u.unit_id,
		avy.op_year,
		f.fac_id,
		f.facility_name,
		f.oris_code,
		u.unitid,
		u.comm_op_date,
		u.comr_op_date,
		'DMLOAD' as userid,
		now() as add_date,
		'ACCOUNT' as data_source,
		greatest(u.add_date, u.update_date, f.add_date, f.update_date, to_date(a.dateadd_dt, 'YYYYMMDD'), a.last_update_date) as last_update_date
	from camdsnap.unit_ss u	
	inner join camdsnap.facility_ss f on u.fac_id = f.fac_id
	cross join camddmw.allowance_valid_year avy
	inner join camdnats.taccount a on u.account = a.acctnum_id
	inner join camdnats.ttransact t on a.acctnum_id = t.buyacct_id and avy.op_year = substr(.cnfrmdte_dt, 1, 4)
	where not exists (select uf.unit_id from camddmw.unit_fact uf where uf.unit_id = aud.unit_id and uf.op_year = aud.op_year);	
	
	-- unit account has final compliance for the op_year in AMS data
	insert into camddmw.unit_fact_test (unit_id, op_year, fac_id, facility_name, orispl_code, unitid, comm_op_date, comr_op_date, userid, add_date, data_source, last_update_date)
	select
		u.unit_id,
		avy.op_year,
		f.fac_id,
		f.facility_name,
		f.oris_code,
		u.unitid,
		u.comm_op_date,
		u.comr_op_date,
		'DMLOAD' as userid,
		now() as add_date,
		'ACCOUNT' as data_source,
		greatest(u.add_date, u.update_date, f.add_date, f.update_date, a.add_date, a.update_date, ac.add_date, ac.update_date) as last_update_date
	from camdsnap.unit_ss u	
	inner join camdsnap.facility_ss f on u.fac_id = f.fac_id
	cross join camddmw.allowance_valid_year avy
	inner join camdsnap.account_ss a on u.account = a.account_number
	inner join camdsnap.account_compliance_ss ac on a.account_id = ac.account_id and ac.comp_status_cd = 'FINAL'
	inner join camdsnap.compliance_period_ss on ac.comp_period_id = cp.comp_period_id
	inner join camdsnap.program_vintage pv on cp.prg_vintage_id = pv.prg_vintage_id and avy.op_year = pv.vintage_year
	where not exists (select uf.unit_id from camddmw.unit_fact uf where uf.unit_id = aud.unit_id and uf.op_year = aud.op_year);

	-- unit account has final compliance for the op_year in NATS data
	insert into camddmw.unit_fact_test (unit_id, op_year, fac_id, facility_name, orispl_code, unitid, comm_op_date, comr_op_date, userid, add_date, data_source, last_update_date)
	select
		u.unit_id,
		avy.op_year,
		f.fac_id,
		f.facility_name,
		f.oris_code,
		u.unitid,
		u.comm_op_date,
		u.comr_op_date,
		'DMLOAD' as userid,
		now() as add_date,
		'ACCOUNT' as data_source,
		greatest(u.add_date, u.update_date, f.add_date, f.update_date, to_date(a.dateadd_dt, 'YYYYMMDD'), a.last_update_date) as last_update_date
	from camdsnap.unit_ss u	
	inner join camdsnap.facility_ss f on u.fac_id = f.fac_id
	cross join camddmw.allowance_valid_year avy
	inner join camdnats.taccount a on u.account = a.acctnum_id
	inner join camdnats.tars_allw_ded tad on a.acctnum_id = tad.acctnum_id and avy.op_year = tad.compyear_dt
	where not exists (select uf.unit_id from camddmw.unit_fact uf where uf.unit_id = aud.unit_id and uf.op_year = aud.op_year);
	
	-- unit account has compliance overdraft deduction for the op_year
	insert into camddmw.unit_fact_test (unit_id, op_year, fac_id, facility_name, orispl_code, unitid, comm_op_date, comr_op_date, userid, add_date, data_source, last_update_date)
	select
		u.unit_id,
		avy.op_year,
		f.fac_id,
		f.facility_name,
		f.oris_code,
		u.unitid,
		u.comm_op_date,
		u.comr_op_date,
		'DMLOAD' as userid,
		now() as add_date,
		'ACCOUNT' as data_source,
		greatest(u.add_date, u.update_date, f.add_date, f.update_date, to_date(a.dateadd_dt, 'YYYYMMDD'), a.last_update_date) as last_update_date
	from camdsnap.unit_ss u	
	inner join camdsnap.facility_ss f on u.fac_id = f.fac_id
	cross join camddmw.allowance_valid_year avy
	inner join camdnats.taccount a on u.account = a.acctnum_id
	inner join camdnats.tars_ovdft_ded tod on a.acctnum_id = tod.acctnum_id and avy.op_year = tod.compyear_dt 
		and exists(select tranvent_cnt from camdnats.ttransact t where t.tranvent_cnt = tod.tranevnt_cnt)
	where not exists (select uf.unit_id from camddmw.unit_fact uf where uf.unit_id = aud.unit_id and uf.op_year = aud.op_year);
	*/
	
	-- add records for remaining relevant units based on program data
	insert into camddmw.unit_fact_test (unit_id, op_year, fac_id, facility_name, orispl_code, unitid, comm_op_date, comr_op_date, userid, add_date, data_source, last_update_date)
	select
		u.unit_id,
		avy.valid_year,
		f.fac_id,
		f.facility_name,
		f.oris_code,
		u.unitid,
		u.comm_op_date,
		u.comr_op_date,
		'DMLOAD' as userid,
		now() as add_date,
		'REMAIN' as data_source,
		greatest(u.add_date, u.update_date, f.add_date, f.update_date, pyd_unit.last_update_date,
	             (select max(greatest(uos.add_date, uos.update_date)) from camdsnap.unit_op_status_ss uos where uos.unit_id = u.unit_id)) as last_update_date
	from camdsnap.unit_ss u	
	inner join camdsnap.facility_ss f on u.fac_id = f.fac_id
	cross join camddmw.allowance_valid_year avy
	inner join (select pyd.unit_id, max(pyd.last_update_date) as last_update_date, string_agg(distinct prg_code, ',') as prg_list
				from camddmw.program_year_dim pyd
				group by pyd.unit_id) pyd_unit on u.unit_id = pyd_unit.unit_id
	where not exists (select uf.unit_id from camddmw.unit_fact_test uf where uf.unit_id = u.unit_id and uf.op_year = avy.valid_year)
		and not exists (select uos.uos_id from camdsnap.unit_op_status_ss uos where uos.unit_id = u.unit_id and uos.op_status = 'CAN')
		and exists (select pyd.unit_id from camddmw.program_year_dim pyd where pyd.unit_id = u.unit_id and pyd.op_year = avy.valid_year)
		and (
				extract(year from u.add_date) <= avy.valid_year
				or u.add_date < to_date('03/08/2003','MM/DD/YYYY') 
				or exists (select pyd.unit_id from camddmw.program_year_dim pyd where pyd.unit_id = u.unit_id and pyd.op_year = avy.valid_year)
			)
		and avy.valid_year >= (select min(op_year) from camddmw.program_year_dim pyd where pyd.unit_id = u.unit_id)
		and (
				(
					(avy.valid_year < 1999 or avy.valid_year > 2002) 
					and not pyd_unit.prg_list = 'OTC'
				)
				or (
						((avy.valid_year < 2003 and f.state <> 'NC') or (avy.valid_year < 2004 and f.state = 'NC"')) 
						and not pyd_unit.prg_list = 'NBP'
					) 
				or	(
						avy.valid_year in (1980,1985,1990,1993,1994) 
						and pyd_unit.prg_list = 'ARP' 
						and not exists(select upe.up_id 
										from camdsnap.unit_program_exemption_ss upe 
										inner join camdsnap.unit_program_ss up on upe.up_id = up.up_id and up.unit_id = u.unit_id 
										where upe.exempt_type = 'RUE' and upe.begin_date = to_date('01/01/1995','MM/DD/YYYY') and upe.end_date is null)
					)		
			)
		and case 
			when exists(select uos.uos_id 
						from camdsnap.unit_op_status_ss uos 
						where uos.unit_id = u.unit_id
							and coalesce(extract(year from uos.begin_date), 1900) <= avy.valid_year
							and coalesce(extract(year from uos.end_date), 9999) >= avy.valid_year
							and op_status = 'CAN') then 'CAN'
			when exists(select uos.uos_id 
						from camdsnap.unit_op_status_ss uos 
						where uos.unit_id = u.unit_id
							and coalesce(extract(year from uos.begin_date), 1900) <= avy.valid_year
							and coalesce(extract(year from uos.end_date), 9999) >= avy.valid_year
							and op_status = 'OPR') then 'OPR'
			when exists(select uos.uos_id 
						from camdsnap.unit_op_status_ss uos 
						where uos.unit_id = u.unit_id
							and coalesce(extract(year from uos.begin_date), 1900) <= avy.valid_year
							and coalesce(extract(year from uos.end_date), 9999) >= avy.valid_year) then
				(select uos.op_status 
						from camdsnap.unit_op_status_ss uos 
						where uos.unit_id = u.unit_id
							and coalesce(extract(year from uos.begin_date), 1900) <= avy.valid_year
							and coalesce(extract(year from uos.end_date), 9999) >= avy.valid_year
						order by uos.begin_date desc
						limit 1)
			when exists(select pyd.unit_id
						from camddmw.program_year_dim pyd
						where pyd.unit_id = u.unit_id
							and pyd.op_year = avy.valid_year) then 
				'IN'
			when date_trunc('day', u.add_date) > to_date('03/08/2003', 'MM/DD/YYYY') then 
				'IN'		
			else 'OUT'
		end <> 'OUT';

	-- add/update op_status_year_dim records
	insert into camddmw.op_status_year_dim_test(unit_id, op_year, op_status, op_status_description, data_source, userid, add_date, last_update_date)
	select 
		u.unit_id, 
		uf.op_year,
		case 
			when exists(select uos.uos_id 
						from camdsnap.unit_op_status_ss uos 
						where uos.unit_id = u.unit_id
							and coalesce(extract(year from uos.begin_date), 1900) <= uf.op_year
							and coalesce(extract(year from uos.end_date), 9999) >= uf.op_year
							and uos.op_status = 'CAN') then 'CAN'
			when exists(select uos.uos_id 
						from camdsnap.unit_op_status_ss uos 
						where uos.unit_id = u.unit_id
							and coalesce(extract(year from uos.begin_date), 1900) <= uf.op_year
							and coalesce(extract(year from uos.end_date), 9999) >= uf.op_year
							and uos.op_status = 'OPR') then 'OPR'
			when exists(select uos.uos_id 
						from camdsnap.unit_op_status_ss uos 
						where uos.unit_id = u.unit_id
							and coalesce(extract(year from uos.begin_date), 1900) <= uf.op_year
							and coalesce(extract(year from uos.end_date), 9999) >= uf.op_year) then
				(select uos.op_status 
						from camdsnap.unit_op_status_ss uos 
						where uos.unit_id = u.unit_id
							and coalesce(extract(year from uos.begin_date), 1900) <= uf.op_year
							and coalesce(extract(year from uos.end_date), 9999) >= uf.op_year
						order by uos.begin_date desc
						limit 1)
			when exists(select pyd.unit_id
						from camddmw.program_year_dim pyd
						where pyd.unit_id = u.unit_id
							and pyd.op_year = uf.op_year) then 
				null
			when date_trunc('day', u.add_date) > to_date('03/08/2003', 'MM/DD/YYYY') then 
				null		
			else 'OUT'
		end as op_status,
		osc.op_status_description,
		'CAMD' as data_source,
		'DMLOAD' as userid,
		now() as add_date,
		case 
			when exists(select uos.uos_id 
						from camdsnap.unit_op_status_ss uos 
						where uos.unit_id = u.unit_id
							and coalesce(extract(year from uos.begin_date), 1900) <= uf.op_year
							and coalesce(extract(year from uos.end_date), 9999) >= uf.op_year
							and uos.op_status = 'CAN') then 
				(select coalesce(uos.update_date, uos.add_date) 
						from camdsnap.unit_op_status_ss uos 
						where uos.unit_id = u.unit_id
							and coalesce(extract(year from uos.begin_date), 1900) <= uf.op_year
							and coalesce(extract(year from uos.end_date), 9999) >= uf.op_year
							and uos.op_status = 'CAN'
						order by uos.begin_date desc
						limit 1)
			when exists(select uos.uos_id 
						from camdsnap.unit_op_status_ss uos 
						where uos.unit_id = u.unit_id
							and coalesce(extract(year from uos.begin_date), 1900) <= uf.op_year
							and coalesce(extract(year from uos.end_date), 9999) >= uf.op_year
							and uos.op_status = 'OPR') then 
				(select coalesce(uos.update_date, uos.add_date) 
						from camdsnap.unit_op_status_ss uos 
						where uos.unit_id = u.unit_id
							and coalesce(extract(year from uos.begin_date), 1900) <= uf.op_year
							and coalesce(extract(year from uos.end_date), 9999) >= uf.op_year
							and uos.op_status = 'OPR'
						order by uos.begin_date desc
						limit 1)
			when exists(select uos.uos_id 
						from camdsnap.unit_op_status_ss uos 
						where uos.unit_id = u.unit_id
							and coalesce(extract(year from uos.begin_date), 1900) <= uf.op_year
							and coalesce(extract(year from uos.end_date), 9999) >= uf.op_year) then
				(select coalesce(uos.update_date, uos.add_date) 
						from camdsnap.unit_op_status_ss uos 
						where uos.unit_id = u.unit_id
							and coalesce(extract(year from uos.begin_date), 1900) <= uf.op_year
							and coalesce(extract(year from uos.end_date), 9999) >= uf.op_year
						order by uos.begin_date desc
						limit 1)
			when exists(select pyd.unit_id
						from camddmw.program_year_dim pyd
						where pyd.unit_id = u.unit_id
							and pyd.op_year = uf.op_year) then
				(select max(pyd.last_update_date)
						from camddmw.program_year_dim pyd
						where pyd.unit_id = u.unit_id
							and pyd.op_year = uf.op_year)
			when date_trunc('day', u.add_date) > to_date('03/08/2003', 'MM/DD/YYYY') then 
				coalesce(u.update_date, u.add_date)
			else coalesce(u.update_date, u.add_date)
		end as last_update_date
	from camdsnap.unit_ss u
	inner join camddmw.unit_fact_test uf 
		on u.unit_id = uf.unit_id
	left outer join camdmd.operating_status_code osc 
		on osc.op_status_cd = case 
			when exists(select uos.uos_id 
						from camdsnap.unit_op_status_ss uos 
						where uos.unit_id = u.unit_id
							and coalesce(extract(year from uos.begin_date), 1900) <= uf.op_year
							and coalesce(extract(year from uos.end_date), 9999) >= uf.op_year
							and uos.op_status = 'CAN') then 'CAN'
			when exists(select uos.uos_id 
						from camdsnap.unit_op_status_ss uos 
						where uos.unit_id = u.unit_id
							and coalesce(extract(year from uos.begin_date), 1900) <= uf.op_year
							and coalesce(extract(year from uos.end_date), 9999) >= uf.op_year
							and uos.op_status = 'OPR') then 'OPR'
			when exists(select uos.uos_id 
						from camdsnap.unit_op_status_ss uos 
						where uos.unit_id = u.unit_id
							and coalesce(extract(year from uos.begin_date), 1900) <= uf.op_year
							and coalesce(extract(year from uos.end_date), 9999) >= uf.op_year) then
				(select uos.op_status 
						from camdsnap.unit_op_status_ss uos 
						where uos.unit_id = u.unit_id
							and coalesce(extract(year from uos.begin_date), 1900) <= uf.op_year
							and coalesce(extract(year from uos.end_date), 9999) >= uf.op_year
						order by uos.begin_date desc
						limit 1)
			when exists(select pyd.unit_id
						from camddmw.program_year_dim pyd
						where pyd.unit_id = u.unit_id
							and pyd.op_year = uf.op_year) then 
				null
			when date_trunc('day', u.add_date) > to_date('03/08/2003', 'MM/DD/YYYY') then 
				null		
			else 'OUT'
		end
	on conflict (unit_id, op_year)
	do update set
		op_status = excluded.op_status,
		op_status_description = excluded.op_status_description,
		last_update_date = excluded.last_update_date
	where		
		coalesce(op_status_year_dim_test.op_status,'') <> coalesce(excluded.op_status,'')
		or coalesce(op_status_year_dim_test.op_status_description,'') <> coalesce(excluded.op_status_description,'')
		or op_status_year_dim_test.last_update_date <> excluded.last_update_date;

	-- update facility level data fields for unit_fact rows that were added
	-- 	(all newly added records will have a null value in op_status_info)
	update camddmw.unit_fact_test uf set
		county_code = f.county_cd,
		county = cc.county_name,
		fips_code = cc.county_number,
		source_cat = scc.source_category_description,
		state = f.state,
		state_name = sc.state_name,
		latitude = f.latitude,
		longitude = f.longitude,
		epa_region = sc.epa_region,
		epa_region_description = erc.epa_region_description,
		naics_code = u.naics_cd,
		naic_code_description = nc.naics_description,
		sic_code = f.sic_code,
		sic_code_description = sic.sic_code_description,
		nerc_region = f.nerc_region,
		nerc_description = nrc.nerc_region_description,
		last_update_date = greatest(uf.last_update_date, f.add_date, f.update_date, u.add_date, u.update_date)
	from camdsnap.unit_ss u
	inner join camdsnap.facility_ss f	
		on u.fac_id = f.fac_id
	left outer join camdmd.county_code cc
		on f.county_cd = cc.county_cd
	left outer join camdmd.state_code sc
		on f.state = sc.state_cd
	left outer join camdmd.epa_region_code erc
		on sc.epa_region = erc.epa_region_cd
	left outer join camdmd.sic_code sic
		on f.sic_code = sic.sic_code
	left outer join camdmd.nerc_region_code nrc
		on f.nerc_region = nrc.nerc_region_cd
	left outer join camdmd.source_category_code scc
		on u.source_category_cd = scc.source_category_cd
	left outer join camdmd.naics_code nc
		on u.naics_cd = nc.naics_cd
	where uf.unit_id = u.unit_id
		and uf.op_status_info is null;

	/*
	 - TODO uncomment after we have all of the underlying tables created and populated
	-- update facility level data fields for logiccally moved units
	update camddmw.unit_fact_test uf set
		county_code = f.county_cd,
		county = cc.county_name,
		fips_code = cc.county_number,
		source_cat = scc.source_category_description,
		state = f.state,
		state_name = sc.state_name,
		latitide = f.latitude,
		longitude = f.longitude,
		epa_region = sc.epa_region,
		epa_region_description = erc.epa_region_description,
		naics_code = u.naics_cd,
		naic_code_description = nc.naics_description,
		sic_code = f.sic_code,
		sic_code_description = sic.sic_code_description,
		nerc_region = f.nerc_region,
		nerc_description = nrc.nerc_region_description,
		last_update_date = greatest(uf.last_update_date, f.add_date, f.update_date, u.add_date, u.update_date)
	from camdsnap.unit_history_ss
	inner join camdsnap.facility_ss f	
		on uh.old_fac_id = f.fac_id
	left outer join camdmd.county_code cc
		on f.county_cd = cc.county_cd
	left outer join camdmd.state_code sc
		on f.state = sc.state_cd
	left outer join camdmd.epa_region_code erc
		on sc.epa_region = erc.epa_region_cd
	left outer join camdmd.sic_code sic
		on f.sic_code = sic.sic_code
	left outer join camdmd.nerc_region_code nrc
		on f.nerc_region = nrc.nerc_region_cd
	inner join camdsnap.unit_ss u
		on uf.unit_id = u.unit_id
	left outer join camdmd.source_category_code scc
		on u.source_category_cd = scc.source_category_cd
	left outer join camdmd.naics_code nc
		on u.naics_cd = nc.naics_cd
	where uf.unit_id = uh.unit_id
		and uh.unit_history_type_cd = 'LOGICAL'
		and uf.op_year <= (extract(year from uh.effective_date) - 1);*/

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

