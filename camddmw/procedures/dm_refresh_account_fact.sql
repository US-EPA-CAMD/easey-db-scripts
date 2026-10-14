-- DROP PROCEDURE camddmw.dm_refresh_account_fact(in bool, in date, out json, out bool);

CREATE OR REPLACE PROCEDURE camddmw.dm_refresh_account_fact(IN fullrefresh_in boolean, IN incrementalrefreshdate_in date, OUT errorjson_out json, OUT result_out boolean)
 LANGUAGE plpgsql
AS $procedure$
declare
    cProcedureName constant text := 'dm_refresh_account_fact';

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
	-- full refresh - load records for all account_ss and taccount records

	-- incremental refresh 
	-- 	load records for account_ss records where
	--	-- account_ss add_date is on or after the date to go back to OR
	--	-- account_ss update_date is on or after the date to go back to OR
	--	-- account_program_ss add_date is on or after the date to go back to OR
	--	-- account_program_ss update_date is on or after the date to go back to OR 
	--	-- unit_fact add_date is on or after the date to go back to (for UNIT and FACLTY accounts) OR
	--	-- unit_history_ss add_date is on or after the date to go back to (for UNIT accounts associated with logically moved units) OR
	--	-- unit_history_ss update_date is on or after the date to go back to (for UNIT accounts associated with logically moved units)
	-- 	load records for taccount records where
	--	-- taccount dateadd_dt is on or after the date to go back to OR
	--	-- taccount last_update_date in the details source table is on or after the date to go back to OR
	--	-- unit_fact add_date is on or after the date to go back to (for UA accounts) OR
	--	-- unit_history_ss add_date is on or after the date to go back to (for UA accounts associated with logically moved units) OR
	--	-- unit_history_ss update_date is on or after the date to go back to (for UA accounts associated with logically moved units)

	insert into camddmw.account_fact as af (account_number, prg_code, account_name, account_type_code, account_type, 
												 unit_id, unitid, epa_region, epa_region_description, state, state_name, source_cat, 
												 fac_id, facility_name, orispl_code, phase1_allocation, phase2a_allocation, phase2b_allocation, 
												 data_source, userid, add_date, nerc_region, nerc_description, last_update_date)
	select a.account_number,
		   ap.prg_cd as prg_code,
		   a.account_name,
		   a.account_type_cd as account_type_code,
		   atc.account_type_description as account_type,
		   uf.unit_id,
		   uf.unitid,
		   uf.epa_region,
		   uf.epa_region_description, 
		   uf.state,
		   uf.state_name,
		   uf.source_cat,
		   uf.fac_id,
		   uf.facility_name,
		   uf.orispl_code,
		   coalesce(oa.phase1_allocation, 0) as phase1_allocation,
		   coalesce(oa.phase2a_allocation, 0) as phase2a_allocation,
		   coalesce(oa.phase2b_allocation, 0) as phase2b_allocation,
		   'AMS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date,
		   uf.nerc_region,
		   uf.nerc_description,
		   greatest(a.add_date, a.update_date, ap.add_date, ap.update_date, uf.last_update_date) as last_update_date
	from camdsnap.account_ss a
		join camdsnap.account_program_ss ap 
			on a.account_id = ap.account_id
		join camdmd.account_type_code atc 
			on a.account_type_cd = atc.account_type_cd 
		join camdsnap.unit_ss u 
			on a.account_number = u.account
		join camddmw.unit_fact uf 
			on u.unit_id = uf.unit_id 
				and uf.op_year = (select max(ufm.op_year) from camddmw.unit_fact ufm where ufm.unit_id = u.unit_id)
		left join camdsnap.original_allocation_ss oa 
			on u.unit_id = oa.unit_id 
	where a.account_type_cd = 'UNIT'
		and (
			fullrefresh_in
			or date_trunc('day', a.add_date) >= incrementalrefreshdate_in
		    or date_trunc('day', a.update_date) >= incrementalrefreshdate_in
			or date_trunc('day', ap.add_date) >= incrementalrefreshdate_in
		    or date_trunc('day', ap.update_date) >= incrementalrefreshdate_in
		    or date_trunc('day', uf.add_date) >= incrementalrefreshdate_in
		)
	UNION ALL
	select a.account_number,
		   ap.prg_cd as prg_code,
		   a.account_name,
		   a.account_type_cd as account_type_code,
		   atc.account_type_description as account_type,
		   null as unit_id,
		   null as unitid,
		   f.epa_region,
		   er.epa_region_description, 
		   f.state,
		   sc.state_name,
		   null as source_cat,
		   f.fac_id,
		   f.facility_name,
		   f.oris_code as orispl_code,
		   null as phase1_allocation,
		   null as phase2a_allocation,
		   null as phase2b_allocation,
		   'AMS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date,
		   f.nerc_region,
		   nrc.nerc_region_description as nerc_description,
		   greatest(a.add_date, a.update_date, ap.add_date, ap.update_date, f.add_date, f.update_date) as last_update_date
	from camdsnap.account_ss a
		join camdsnap.account_program_ss ap 
			on a.account_id = ap.account_id
		join camdsnap.account_facility_ss af 
			on a.account_id = af.account_id
		join camdsnap.facility_ss f 
			on af.fac_id = f.fac_id
		join camdmd.account_type_code atc 
			on a.account_type_cd = atc.account_type_cd  
		join camdmd.epa_region_code er 
			on f.epa_region = er.epa_region_cd 
		join camdmd.state_code sc 
			on f.state = sc.state_cd 
		left join camdmd.nerc_region_code nrc 
			on f.nerc_region  = nrc.nerc_region_cd 
	where a.account_type_cd = 'FACLTY'
		and (
			fullrefresh_in
			or date_trunc('day', a.add_date) >= incrementalrefreshdate_in
		    or date_trunc('day', a.update_date) >= incrementalrefreshdate_in
			or date_trunc('day', ap.add_date) >= incrementalrefreshdate_in
		    or date_trunc('day', ap.update_date) >= incrementalrefreshdate_in
		    or date_trunc('day', f.add_date) >= incrementalrefreshdate_in
		    or date_trunc('day', f.update_date) >= incrementalrefreshdate_in
		)
	UNION ALL
	select a.account_number,
		   ap.prg_cd as prg_code,
		   a.account_name,
		   a.account_type_cd as account_type_code,
		   atc.account_type_description as account_type,
		   null as unit_id,
		   null as unitid,
		   null as epa_region,
		   null as epa_region_description, 
		   a.state,
		   case
			   when a.state is not null and atc.account_type_group_cd = 'RETIRE' then
			   	sc.state_name
			   else
			   	null		   
		   end as state_name,
		   null as source_cat,
		   null as fac_id,
		   null as facility_name,
		   null as orispl_code,
		   null as phase1_allocation,
		   null as phase2a_allocation,
		   null as phase2b_allocation,
		   'AMS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date,
		   null as nerc_region,
		   null as nerc_description,
		   greatest(a.add_date, a.update_date, ap.add_date, ap.update_date) as last_update_date
	from camdsnap.account_ss a
		join camdsnap.account_program_ss ap 
			on a.account_id = ap.account_id
		join camdmd.account_type_code atc 
			on a.account_type_cd = atc.account_type_cd  
		left join camdmd.state_code sc 
			on a.state = sc.state_cd 
	where a.account_type_cd not in ('UNIT', 'FACLTY')
		and (
			fullrefresh_in
			or date_trunc('day', a.add_date) >= incrementalrefreshdate_in
		    or date_trunc('day', a.update_date) >= incrementalrefreshdate_in
			or date_trunc('day', ap.add_date) >= incrementalrefreshdate_in
		    or date_trunc('day', ap.update_date) >= incrementalrefreshdate_in
		)
	UNION ALL
	-- taccount UA records for NBP
	select a.acctnum_id as account_number,
		   'NBP' as prg_code,
		   a.acctname_nme as account_name,
		   'UNIT' as account_type_code,
		   'Unit Account' as account_type,
		   uf.unit_id,
		   uf.unitid,
		   uf.epa_region,
		   uf.epa_region_description, 
		   uf.state,
		   uf.state_name,
		   uf.source_cat,
		   uf.fac_id,
		   uf.facility_name,
		   uf.orispl_code,
		   null::numeric as phase1_allocation,
		   null::numeric as phase2a_allocation,
		   null::numeric as phase2b_allocation,
		   'NATS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date,
		   uf.nerc_region,
		   uf.nerc_description,
		   greatest(to_date(a.dateadd_dt, 'YYYYMMDD'), a.last_update_date, uf.last_update_date) as last_update_date
	from camdnats.taccount a
		join camdsnap.unit_ss u 
			on a.acctnum_id = u.account
		join camddmw.unit_fact uf 
			on u.unit_id = uf.unit_id 
				and uf.op_year = (select max(ufm.op_year) from camddmw.unit_fact ufm where ufm.unit_id = u.unit_id) 
				and uf.state <> 'NH'
	where a.accttype_cd = 'UA'
		and (
			fullrefresh_in
			or date_trunc('day', to_date(a.dateadd_dt, 'YYYYMMDD')) >= incrementalrefreshdate_in
		    or date_trunc('day', a.last_update_date) >= incrementalrefreshdate_in
		    or date_trunc('day', uf.add_date) >= incrementalrefreshdate_in
		)
	UNION ALL
	-- taccount records for NBP that are not UA accounts
	select a.acctnum_id as account_number,
		   'NBP' as prg_code,
		   a.acctname_nme as account_name,
		   case
			when a.accttype_cd = 'OD' then 'OVERDF'
			else a.accttype_cd
		   end as account_type_code,
		   case 
		   	when a.accttype_cd = 'OD' then 'Overdraft Account'
		   	else atc.account_type_description 
		   end as account_type,
		   null as unit_id,
		   null as unitid,
		   f.epa_region,
		   erc.epa_region_description, 
		   case 
		   	when a.accttype_cd = 'OD' then f.state
		   	when a.accttype_cd = 'GA' or substr(a.acctnum_id, 1, 3) = 'OTC' then null
		   	else substr(a.acctnum_id, 1, 2)
		   end as state,
		   case 
		   	when a.accttype_cd = 'OD' then sc.state_name 
		   	when a.accttype_cd = 'GA' or substr(a.acctnum_id, 1, 3) = 'OTC' then null
		   	else sc.state_name
		   end as state_name,
		   null as source_cat,
		   f.fac_id,
		   f.facility_name,
		   f.oris_code as orispl_code,
		   null::numeric as phase1_allocation,
		   null::numeric as phase2a_allocation,
		   null::numeric as phase2b_allocation,
		   'NATS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date,
		   f.nerc_region,
		   nrc.nerc_region_description as nerc_description,
		   greatest(to_date(a.dateadd_dt, 'YYYYMMDD'), a.last_update_date) as last_update_date
	from camdnats.taccount a
		left join camdmd.account_type_code atc 
			on atc.account_type_cd = case
										when a.accttype_cd = 'GA' then 'GENERAL'
										when a.accttype_cd = 'SH' then 'SHOLD'
										when a.accttype_cd = 'SU' then 'SURR'
										when a.accttype_cd = 'EA' then 'SPRMRES'
										when a.accttype_cd IN ('GS', 'OA') then 'SGENRES'
										when a.accttype_cd = 'OI' then 'SOPTRES'
										when a.accttype_cd = 'ER' then 'SERDRES'
									 end
		left join camdsnap.facility_ss f 
			on case when a.accttype_cd = 'OD' 
				then substr(a.acctnum_id, 1, 6)::numeric = f.oris_code
				else false
			end
		left join camdmd.epa_region_code erc 
			on f.epa_region = erc.epa_region_cd 	
		left join camdmd.state_code sc 
			on f.state = sc.state_cd or substr(a.acctnum_id, 1, 2) = sc.state_cd
		left join camdmd.nerc_region_code nrc 
			on f.nerc_region = nrc.nerc_region_cd 
	where a.accttype_cd <> 'UA'
		and a.acctnum_id <> 'NH0000000300'
		and (
			fullrefresh_in
			or date_trunc('day', to_date(a.dateadd_dt, 'YYYYMMDD')) >= incrementalrefreshdate_in
		    or date_trunc('day', a.last_update_date) >= incrementalrefreshdate_in
		)
	UNION ALL
	-- taccount UA records for OTC
	select a.acctnum_id as account_number,
		   'OTC' as prg_code,
		   a.acctname_nme as account_name,
		   'UNIT' as account_type_code,
		   'Unit Account' as account_type,
		   uf.unit_id,
		   uf.unitid,
		   uf.epa_region,
		   uf.epa_region_description, 
		   uf.state,
		   uf.state_name,
		   uf.source_cat,
		   uf.fac_id,
		   uf.facility_name,
		   uf.orispl_code,
		   null::numeric as phase1_allocation,
		   null::numeric as phase2a_allocation,
		   null::numeric as phase2b_allocation,
		   'NATS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date,
		   uf.nerc_region,
		   uf.nerc_description,
		   greatest(to_date(a.dateadd_dt, 'YYYYMMDD'), a.last_update_date, uf.last_update_date) as last_update_date
	from camdnats.taccount a
		join camdsnap.unit_ss u 
			on a.acctnum_id = u.account
		join camddmw.unit_fact uf 
			on u.unit_id = uf.unit_id 
				and uf.op_year = (select max(ufm.op_year) from camddmw.unit_fact ufm where ufm.unit_id = u.unit_id) 
	where a.accttype_cd = 'UA'
		and exists(select tad.acctnum_id from camdnats.tars_allw_ded tad where tad.acctnum_id = a.acctnum_id and tad.compyear_dt::numeric <= 2002)
		and (
			fullrefresh_in
			or date_trunc('day', to_date(a.dateadd_dt, 'YYYYMMDD')) >= incrementalrefreshdate_in
		    or date_trunc('day', a.last_update_date) >= incrementalrefreshdate_in
		    or date_trunc('day', uf.add_date) >= incrementalrefreshdate_in
		)
	UNION ALL
	-- taccount OD records for OTC
	select a.acctnum_id as account_number,
		   'OTC' as prg_code,
		   a.acctname_nme as account_name,
		   'OVERDF' as account_type_code,
		   'Overdraft Account' as account_type,
		   null as unit_id,
		   null as unitid,
		   f.epa_region,
		   erc.epa_region_description, 
		   f.state,
		   sc.state_name,
		   null as source_cat,
		   f.fac_id,
		   f.facility_name,
		   f.oris_code as orispl_code,
		   null::numeric as phase1_allocation,
		   null::numeric as phase2a_allocation,
		   null::numeric as phase2b_allocation,
		   'NATS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date,
		   f.nerc_region,
		   nrc.nerc_region_description as nerc_description,
		   greatest(to_date(a.dateadd_dt, 'YYYYMMDD'), a.last_update_date) as last_update_date
	from camdnats.taccount a
		left join camdsnap.facility_ss f 
			on substr(a.acctnum_id, 1, 6)::numeric = f.oris_code
		left join camdmd.epa_region_code erc 
			on f.epa_region = erc.epa_region_cd 	
		left join camdmd.state_code sc 
			on f.state = sc.state_cd
		left join camdmd.nerc_region_code nrc 
			on f.nerc_region = nrc.nerc_region_cd 
	where a.accttype_cd = 'OD'
		and (select count(tad.acctnum_id) 
				from camdnats.tars_allw_ded tad 
				where tad.compyear_dt::integer <= 2002 
					and substr(a.acctnum_id, 1, 6) = substr(tad.acctnum_id, 1, 6)) > 1
		and (
			fullrefresh_in
			or date_trunc('day', to_date(a.dateadd_dt, 'YYYYMMDD')) >= incrementalrefreshdate_in
		    or date_trunc('day', a.last_update_date) >= incrementalrefreshdate_in
		)
	UNION ALL
	select a.account_number,
		   ap.prg_cd as prg_code,
		   a.account_name,
		   a.account_type_cd as account_type_code,
		   atc.account_type_description as account_type,
		   uf.unit_id,
		   uf.unitid,
		   uf.epa_region,
		   uf.epa_region_description, 
		   uf.state,
		   uf.state_name,
		   uf.source_cat,
		   uf.fac_id,
		   uf.facility_name,
		   uf.orispl_code,
		   coalesce(oa.phase1_allocation, 0) as phase1_allocation,
		   coalesce(oa.phase2a_allocation, 0) as phase2a_allocation,
		   coalesce(oa.phase2b_allocation, 0) as phase2b_allocation,
		   'AMS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date,
		   uf.nerc_region,
		   uf.nerc_description,
		   greatest(a.add_date, a.update_date, ap.add_date, ap.update_date, uh.add_date, uh.update_date, uf.last_update_date) as last_update_date
	from camdsnap.account_ss a
		join camdsnap.account_program_ss ap 
			on a.account_id = ap.account_id
		join camdmd.account_type_code atc 
			on a.account_type_cd = atc.account_type_cd 
		join camdsnap.unit_history_ss uh 
			on a.account_number = uh.old_account_number 
				and uh.unit_history_type_cd = 'LOGICAL'
		join camddmw.unit_fact uf 
			on uh.unit_id = uf.unit_id 
				and uf.op_year = (select max(ufm.op_year) from camddmw.unit_fact ufm where ufm.unit_id = uh.unit_id)
		left join camdsnap.original_allocation_ss oa 
			on uh.unit_id = oa.unit_id 
	where a.account_type_cd = 'UNIT'
		and (
			fullrefresh_in
			or date_trunc('day', a.add_date) >= incrementalrefreshdate_in
		    or date_trunc('day', a.update_date) >= incrementalrefreshdate_in
			or date_trunc('day', ap.add_date) >= incrementalrefreshdate_in
		    or date_trunc('day', ap.update_date) >= incrementalrefreshdate_in
			or date_trunc('day', uh.add_date) >= incrementalrefreshdate_in
		    or date_trunc('day', uh.update_date) >= incrementalrefreshdate_in
		    or date_trunc('day', uf.add_date) >= incrementalrefreshdate_in
		)
	UNION ALL
	select a.acctnum_id as account_number,
		   'NBP' as prg_code,
		   a.acctname_nme as account_name,
		   a.accttype_cd as account_type_code,
		   'Unit Account' as account_type,
		   uf.unit_id,
		   uf.unitid,
		   uf.epa_region,
		   uf.epa_region_description, 
		   uf.state,
		   uf.state_name,
		   uf.source_cat,
		   uf.fac_id,
		   uf.facility_name,
		   uf.orispl_code,
		   null as phase1_allocation,
		   null as phase2a_allocation,
		   null as phase2b_allocation,
		   'NATS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date,
		   uf.nerc_region,
		   uf.nerc_description,
		   greatest(to_date(a.dateadd_dt, 'YYYYMMDD'), a.last_update_date, uh.add_date, uh.update_date, uf.last_update_date) as last_update_date
	from camdnats.taccount a 
	join camdsnap.unit_history_ss uh 
		on a.acctnum_id = uh.old_account_number 
			and uh.unit_history_type_cd = 'LOGICAL'
	join camddmw.unit_fact uf 
		on uh.unit_id = uf.unit_id 
			and uf.op_year = (select max(ufm.op_year) from camddmw.unit_fact ufm where ufm.unit_id = uh.unit_id) 
			and uf.state <> 'NH'
	where a.accttype_cd = 'UA'
		and (
			fullrefresh_in
			or date_trunc('day', to_date(a.dateadd_dt, 'YYYYMMDD')) >= incrementalrefreshdate_in
		    or date_trunc('day', a.last_update_date) >= incrementalrefreshdate_in
			or date_trunc('day', uh.add_date) >= incrementalrefreshdate_in
		    or date_trunc('day', uh.update_date) >= incrementalrefreshdate_in
		    or date_trunc('day', uf.add_date) >= incrementalrefreshdate_in
		)
	UNION ALL
	select a.acctnum_id as account_number,
		   'OTC' as prg_code,
		   a.acctname_nme as account_name,
		   a.accttype_cd as account_type_code,
		   'Unit Account' as account_type,
		   uf.unit_id,
		   uf.unitid,
		   uf.epa_region,
		   uf.epa_region_description, 
		   uf.state,
		   uf.state_name,
		   uf.source_cat,
		   uf.fac_id,
		   uf.facility_name,
		   uf.orispl_code,
		   null as phase1_allocation,
		   null as phase2a_allocation,
		   null as phase2b_allocation,
		   'NATS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date,
		   uf.nerc_region,
		   uf.nerc_description,
		   greatest(to_date(a.dateadd_dt, 'YYYYMMDD'), a.last_update_date, uh.add_date, uh.update_date, uf.last_update_date) as last_update_date
	from camdnats.taccount a
	join camdsnap.unit_history_ss uh 
		on a.acctnum_id = uh.old_account_number 
			and uh.unit_history_type_cd = 'LOGICAL'
	join camddmw.unit_fact uf 
		on uh.unit_id = uf.unit_id 
			and uf.op_year = (select max(ufm.op_year) from camddmw.unit_fact ufm where ufm.unit_id = uh.unit_id) 
			and uf.state <> 'NH'
	and exists(select tad.acctnum_id from camdnats.tars_allw_ded tad where tad.acctnum_id = a.acctnum_id and tad.compyear_dt::numeric <= 2002)
	where a.accttype_cd = 'UA'
		and (
			fullrefresh_in
			or date_trunc('day', to_date(a.dateadd_dt, 'YYYYMMDD')) >= incrementalrefreshdate_in
		    or date_trunc('day', a.last_update_date) >= incrementalrefreshdate_in
			or date_trunc('day', uh.add_date) >= incrementalrefreshdate_in
		    or date_trunc('day', uh.update_date) >= incrementalrefreshdate_in
		    or date_trunc('day', uf.add_date) >= incrementalrefreshdate_in
		)
	on conflict (account_number, prg_code)
	do update set
		account_name           = excluded.account_name,
        account_type           = excluded.account_type,
        account_type_code      = excluded.account_type_code,
        unit_id                = excluded.unit_id,
        unitid                 = excluded.unitid,
        epa_region             = excluded.epa_region,
        epa_region_description = excluded.epa_region_description,
        state                  = excluded.state,
        state_name             = excluded.state_name,
        source_cat             = excluded.source_cat,
        fac_id                 = excluded.fac_id,
        facility_name          = excluded.facility_name,
        orispl_code            = excluded.orispl_code,
        phase1_allocation      = excluded.phase1_allocation,
        phase2a_allocation     = excluded.phase2a_allocation,
        phase2b_allocation     = excluded.phase2b_allocation,
        data_source            = excluded.data_source,
        userid                 = 'dmload',
        add_date               = now(),
        nerc_region            = excluded.nerc_region,
        nerc_description       = excluded.nerc_description,
        last_update_date       = excluded.last_update_date
	where
		coalesce(af.account_name, '')      	 	<> coalesce(excluded.account_name, '') or
        coalesce(af.account_type, '')      	 	<> coalesce(excluded.account_type, '') or
        coalesce(af.account_type_code, '') 	 	<> coalesce(excluded.account_type_code, '') or
        coalesce(af.unit_id, 0)              	<> coalesce(excluded.unit_id, 0) or 
        coalesce(af.unitid, '')            	 	<> coalesce(excluded.unitid, '') or
        coalesce(af.epa_region, 0)              <> coalesce(excluded.epa_region, 0) or 
        coalesce(af.epa_region_description, '') <> coalesce(excluded.epa_region_description, '') or
        coalesce(af.state, '')                  <> coalesce(excluded.state, '') or
        coalesce(af.state_name, '')             <> coalesce(excluded.state_name, '') or
        coalesce(af.source_cat, '')             <> coalesce(excluded.source_cat, '') or
        coalesce(af.fac_id, 0)                  <> coalesce(excluded.fac_id, 0) or 
        coalesce(af.facility_name, '')          <> coalesce(excluded.facility_name, '') or
        coalesce(af.orispl_code, 0)             <> coalesce(excluded.orispl_code, 0) or 
        coalesce(af.phase1_allocation, 0)       <> coalesce(excluded.phase1_allocation, 0) or
        coalesce(af.phase2a_allocation, 0)      <> coalesce(excluded.phase2a_allocation, 0) or 
        coalesce(af.phase2b_allocation, 0)      <> coalesce(excluded.phase2b_allocation, 0) or
        coalesce(af.nerc_region, '')         	<> coalesce(excluded.nerc_region, '') or
        coalesce(af.nerc_description, '')       <> coalesce(excluded.nerc_description, '') or
        coalesce(af.last_update_date, to_date('01/01/1900','mm/dd/yyyy')) <> coalesce(excluded.last_update_date, to_date('01/01/1900','mm/dd/yyyy'));
	
	
	-- update account_type values 
	--	these descriptions match what CAMPD is using for filters, 
	--	which are not the same descriptions found in camdmd.account_type_code
	update camddmw.account_fact
		set account_type = CASE
							WHEN account_type_code = 'UNIT' 
								or account_type_code = 'UA' THEN 'Unit Account'
							WHEN account_type_code = 'FACLTY' THEN 'Facility Account'
							WHEN account_type_code = 'OVERDF' 
								or account_type_code = 'OD' THEN 'Overdraft Account'
							WHEN account_type_code = 'GENERAL' 
								or account_type_code = 'GA' THEN 'General Account'
							WHEN account_type_code = 'SHOLD' 
								or account_type_code = 'SH' THEN 'State Holding Account'
							WHEN account_type_code = 'SURR' 
								or account_type_code = 'SU' 
								or account_type_code = 'ENFSURR' 
								or account_type_code = 'VOLSURR' 
								or account_type_code = 'CASURR' THEN 'Surrender Account'
							WHEN account_type_code = 'SPRMRES' 
								or account_type_code = 'EA' THEN 'State Primary Reserve'
							WHEN account_type_code = 'SGENRES' 
								or account_type_code = 'GS' 
								or account_type_code = 'OA' THEN 'State General Reserve'
							WHEN account_type_code = 'SOPTRES' 
								or account_type_code = 'OI' THEN 'State Opt-in Reserve'
							WHEN account_type_code = 'SNSARES' THEN 'New Unit Set Aside Reserve Account'
							WHEN account_type_code = 'SRETIRE' THEN 'State Retirement'
							WHEN account_type_code = 'SOTHRES' THEN 'State Other Reserve'
							WHEN account_type_code = 'SERDRES' 
								or account_type_code = 'ER' THEN 'Early Reduction Reserve'
							WHEN account_type_code = 'RESERVE' THEN 'EPA Reserve Account'
							ELSE NULL
						   END;

	-- update info fields for unit accounts

	-- op_status and op_status_info
    update camddmw.account_fact af
		set op_status = details.op_status,
			op_status_info = details.op_status_info
	from (select af.account_number, 
				 af.prg_code,
				 case 
				 	when exists(select uos.uos_id 
								from camdsnap.unit_op_status_ss uos 
								where uos.unit_id = u.unit_id
									and coalesce(extract(year from uos.begin_date), 1900) <= least(avy_max.op_year, uf_max.op_year)
									and coalesce(extract(year from uos.end_date), 9999) >= least(avy_max.op_year, uf_max.op_year)
									and op_status = 'CAN') then 'CAN'
					when exists(select uos.uos_id 
								from camdsnap.unit_op_status_ss uos 
								where uos.unit_id = u.unit_id
									and coalesce(extract(year from uos.begin_date), 1900) <= least(avy_max.op_year, uf_max.op_year)
									and coalesce(extract(year from uos.end_date), 9999) >= least(avy_max.op_year, uf_max.op_year)
									and op_status = 'OPR') then 'OPR'
					when exists(select uos.uos_id 
								from camdsnap.unit_op_status_ss uos 
								where uos.unit_id = u.unit_id
									and coalesce(extract(year from uos.begin_date), 1900) <= least(avy_max.op_year, uf_max.op_year)
									and coalesce(extract(year from uos.end_date), 9999) >= least(avy_max.op_year, uf_max.op_year)) then
						(select uos.op_status 
								from camdsnap.unit_op_status_ss uos 
								where uos.unit_id = u.unit_id
									and coalesce(extract(year from uos.begin_date), 1900) <= least(avy_max.op_year, uf_max.op_year)
									and coalesce(extract(year from uos.end_date), 9999) >= least(avy_max.op_year, uf_max.op_year)
								order by uos.begin_date desc
								limit 1)
					when exists(select pyd.unit_id
								from camddmw.program_year_dim pyd
								where pyd.unit_id = u.unit_id
									and pyd.op_year = least(avy_max.op_year, uf_max.op_year)) then 
						'IN'
					when date_trunc('day', u.add_date) > to_date('03/08/2003', 'MM/DD/YYYY') then 
						'IN'		
					else 'OUT'
				 end as op_status,
				 uf_op_status.op_status_info
		from camddmw.account_fact af
			join camdsnap.unit_ss u 
				on af.unit_id = u.unit_id
		left join lateral (select max(op_year) as op_year from camddmw.unit_fact uf where uf.unit_id = af.unit_id) uf_max on true 
		cross join (select max(valid_year) as op_year from camddmw.allowance_valid_year avy) as avy_max
		join camddmw.unit_fact uf_op_status 
			on af.unit_id = uf_op_status.unit_id 
				and uf_op_status.op_year = least(avy_max.op_year, uf_max.op_year)
		where af.account_type_code = 'UNIT') details
	where af.account_number = details.account_number 
		and af.prg_code = details.prg_code; 	

	-- primary_fuel_info
	update camddmw.account_fact af
		set primary_fuel_info = details.info
	from (select af.account_number, 
				 af.prg_code, 
		 	     string_agg(fyd.fuel_type_description, ', ' order by fuel_type_description) as info
		  from camddmw.account_fact af
			  inner join camddmw.fuel_year_dim fyd
				  on af.unit_id = fyd.unit_id 
					and fyd.op_year = (select max(valid_year) from camddmw.allowance_valid_year) 
					and fyd."indicator" = 'P'		
		  group by af.account_number, af.prg_code) details
	where af.account_number = details.account_number 
		and af.prg_code = details.prg_code; 	

	-- secondary_fuel_info
	update camddmw.account_fact af
		set secondary_fuel_info = details.info
	from (select af.account_number, 
				 af.prg_code, 
		 	     string_agg(fyd.fuel_type_description, ', ' order by fuel_type_description) as info
		  from camddmw.account_fact af
			  inner join camddmw.fuel_year_dim fyd
				  on af.unit_id = fyd.unit_id 
					and fyd.op_year = (select max(valid_year) from camddmw.allowance_valid_year) 
					and fyd."indicator" = 'S'		
		  group by af.account_number, af.prg_code) details
	where af.account_number = details.account_number 
		and af.prg_code = details.prg_code; 	

	-- unit_type_info
	update camddmw.account_fact af
		set unit_type_info = details.info
	from (select af.account_number, 
				 af.prg_code, 
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
							order by ubt.begin_date nulls first) as info
		  from camddmw.account_fact af
			  inner join camddmw.unit_type_year_dim utyd
				  on af.unit_id = utyd.unit_id 
					and utyd.op_year = (select max(valid_year) from camddmw.allowance_valid_year)
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
		  group by af.account_number, af.prg_code) details
	where af.account_number = details.account_number 
		and af.prg_code = details.prg_code; 	

	-- last_update_date
	update camddmw.account_fact af
		set last_update_date = greatest(details.info, af.last_update_date)
	from (select af.account_number, 
				 af.prg_code, 
		 	     uf.last_update_date as info
		  from camddmw.account_fact af
			  inner join camddmw.unit_fact uf
				  on af.unit_id = uf.unit_id 
					and uf.op_year = (select max(valid_year) from camddmw.allowance_valid_year)) details
	where af.account_number = details.account_number 
		and af.prg_code = details.prg_code; 	

	-- so2_control_info
	update camddmw.account_fact af
		set so2_control_info = details.info
	from (select af.account_number, 
				 af.prg_code, 
		 	     string_agg(case
								when (select max(valid_year) from camddmw.allowance_valid_year) = extract(year from coalesce(uc.install_date, uc.opt_date))
									and (
											extract(month from coalesce(uc.install_date, uc.opt_date)) <> 1 
											or extract(day from coalesce(uc.install_date, uc.opt_date)) <> 1
										) then
									cc.control_description || ' (Began ' || to_char(coalesce(uc.install_date, uc.opt_date), 'Mon DD, YYYY') || ')'
								when (select max(valid_year) from camddmw.allowance_valid_year) = extract(year from uc.retire_date)
									and (
											extract(month from uc.retire_date) <> 12 
											or extract(day from uc.retire_date) <> 31
										) then
									cc.control_description || ' (Retired ' || to_char(uc.retire_date, 'Mon DD, YYYY') || ')'
								else 
									cc.control_description
							end , '<br>' 
							order by coalesce(uc.install_date, uc.opt_date) nulls first) as info
		  from camddmw.account_fact af
			  inner join camdsnap.unit_control_ss uc
				  on af.unit_id = uc.unit_id and uc.ce_param = 'SO2'
				  	  and (
							  coalesce(uc.install_date, uc.opt_date) is null
							  or extract(year from coalesce(uc.install_date, uc.opt_date)) <= (select max(valid_year) from camddmw.allowance_valid_year)
						  )
				  	  and (
							  uc.retire_date is null
							  or extract(year from uc.retire_date) >= (select max(valid_year) from camddmw.allowance_valid_year)
						  )
			  inner join camdecmpsmd.control_code cc 
				 on uc.control_cd = cc.control_cd		
		  group by af.account_number, af.prg_code) details
	where af.account_number = details.account_number 
		and af.prg_code = details.prg_code;

	-- nox_control_info
	update camddmw.account_fact af
		set nox_control_info = details.info
	from (select af.account_number, 
				 af.prg_code, 
		 	     string_agg(case
								when (select max(valid_year) from camddmw.allowance_valid_year) = extract(year from coalesce(uc.install_date, uc.opt_date))
									and (
											extract(month from coalesce(uc.install_date, uc.opt_date)) <> 1 
											or extract(day from coalesce(uc.install_date, uc.opt_date)) <> 1
										) then
									cc.control_description || ' (Began ' || to_char(coalesce(uc.install_date, uc.opt_date), 'Mon DD, YYYY') || ')'
								when (select max(valid_year) from camddmw.allowance_valid_year) = extract(year from uc.retire_date)
									and (
											extract(month from uc.retire_date) <> 12 
											or extract(day from uc.retire_date) <> 31
										) then
									cc.control_description || ' (Retired ' || to_char(uc.retire_date, 'Mon DD, YYYY') || ')'
								else 
									cc.control_description
							end , '<br>' 
							order by coalesce(uc.install_date, uc.opt_date) nulls first) as info
		  from camddmw.account_fact af
			  inner join camdsnap.unit_control_ss uc
				  on af.unit_id = uc.unit_id and uc.ce_param = 'NOX'
				  	  and (
							  coalesce(uc.install_date, uc.opt_date) is null
							  or extract(year from coalesce(uc.install_date, uc.opt_date)) <= (select max(valid_year) from camddmw.allowance_valid_year)
						  )
				  	  and (
							  uc.retire_date is null
							  or extract(year from uc.retire_date) >= (select max(valid_year) from camddmw.allowance_valid_year)
						  )
			  inner join camdecmpsmd.control_code cc 
				 on uc.control_cd = cc.control_cd		
		  group by af.account_number, af.prg_code) details
	where af.account_number = details.account_number 
		and af.prg_code = details.prg_code;

	-- part_control_info
	update camddmw.account_fact af
		set part_control_info = details.info
	from (select af.account_number, 
				 af.prg_code, 
		 	     string_agg(case
								when (select max(valid_year) from camddmw.allowance_valid_year) = extract(year from coalesce(uc.install_date, uc.opt_date))
									and (
											extract(month from coalesce(uc.install_date, uc.opt_date)) <> 1 
											or extract(day from coalesce(uc.install_date, uc.opt_date)) <> 1
										) then
									cc.control_description || ' (Began ' || to_char(coalesce(uc.install_date, uc.opt_date), 'Mon DD, YYYY') || ')'
								when (select max(valid_year) from camddmw.allowance_valid_year) = extract(year from uc.retire_date)
									and (
											extract(month from uc.retire_date) <> 12 
											or extract(day from uc.retire_date) <> 31
										) then
									cc.control_description || ' (Retired ' || to_char(uc.retire_date, 'Mon DD, YYYY') || ')'
								else 
									cc.control_description
							end , '<br>' 
							order by coalesce(uc.install_date, uc.opt_date) nulls first) as info
		  from camddmw.account_fact af
			  inner join camdsnap.unit_control_ss uc
				  on af.unit_id = uc.unit_id and uc.ce_param = 'PART'
				  	  and (
							  coalesce(uc.install_date, uc.opt_date) is null
							  or extract(year from coalesce(uc.install_date, uc.opt_date)) <= (select max(valid_year) from camddmw.allowance_valid_year)
						  )
				  	  and (
							  uc.retire_date is null
							  or extract(year from uc.retire_date) >= (select max(valid_year) from camddmw.allowance_valid_year)
						  )
			  inner join camdecmpsmd.control_code cc 
				 on uc.control_cd = cc.control_cd		
		  group by af.account_number, af.prg_code) details
	where af.account_number = details.account_number 
		and af.prg_code = details.prg_code;

	-- hg_control_info
	update camddmw.account_fact af
		set hg_control_info = details.info
	from (select af.account_number, 
				 af.prg_code, 
		 	     string_agg(case
								when (select max(valid_year) from camddmw.allowance_valid_year) = extract(year from coalesce(uc.install_date, uc.opt_date))
									and (
											extract(month from coalesce(uc.install_date, uc.opt_date)) <> 1 
											or extract(day from coalesce(uc.install_date, uc.opt_date)) <> 1
										) then
									cc.control_description || ' (Began ' || to_char(coalesce(uc.install_date, uc.opt_date), 'Mon DD, YYYY') || ')'
								when (select max(valid_year) from camddmw.allowance_valid_year) = extract(year from uc.retire_date)
									and (
											extract(month from uc.retire_date) <> 12 
											or extract(day from uc.retire_date) <> 31
										) then
									cc.control_description || ' (Retired ' || to_char(uc.retire_date, 'Mon DD, YYYY') || ')'
								else 
									cc.control_description
							end , '<br>' 
							order by coalesce(uc.install_date, uc.opt_date) nulls first) as info
		  from camddmw.account_fact af
			  inner join camdsnap.unit_control_ss uc
				  on af.unit_id = uc.unit_id and uc.ce_param = 'HG'
				  	  and (
							  coalesce(uc.install_date, uc.opt_date) is null
							  or extract(year from coalesce(uc.install_date, uc.opt_date)) <= (select max(valid_year) from camddmw.allowance_valid_year)
						  )
				  	  and (
							  uc.retire_date is null
							  or extract(year from uc.retire_date) >= (select max(valid_year) from camddmw.allowance_valid_year)
						  )
			  inner join camdecmpsmd.control_code cc 
				 on uc.control_cd = cc.control_cd		
		  group by af.account_number, af.prg_code) details
	where af.account_number = details.account_number 
		and af.prg_code = details.prg_code;	

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
$procedure$
;
