-- DROP PROCEDURE camddmw.dm_refresh_account_owner_dim(out json, out bool);

CREATE OR REPLACE PROCEDURE camddmw.dm_refresh_account_owner_dim(OUT errorjson_out json, OUT result_out boolean)
 LANGUAGE plpgsql
AS $procedure$
declare
    cProcedureName constant text := 'dm_refresh_account_owner_dim';

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

	vRecord						record;
begin
	delete from camddmw.account_owner_dim;

	insert into camddmw.account_owner_dim (account_number, prg_code, unit_id, ppl_id, 
										   own_id, own_type, own_display,
										   data_source, userid, add_date, last_update_date)
	--AMS UNIT accounts
	select a.account_number,
		   ap.prg_cd as prg_code,
		   u.unit_id,
		   null::integer as ppl_id,
		   c.comp_id as own_id,
		   uo.ont_type_cd as own_type,
		   c.comp_name as own_display,
		   'AMS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date,
		   greatest(a.add_date, a.update_date, ap.add_date, ap.update_date, 
		   			uo.add_date, uo.update_date, c.add_date, c.update_date) as last_update_date
	from camdsnap.account_ss a
	join camdsnap.account_program_ss ap
		on a.account_id = ap.account_id
	join camdsnap.unit_ss u
		on a.account_number = u.account 
	join camdsnap.unit_owner_ss uo
		on u.unit_id = uo.unit_id
			and uo.end_date is null	
	join camdsnap.company_ss c
		on uo.own_id = c.comp_id 
	where a.account_type_cd = 'UNIT'
	UNION ALL
	--NATS UNIT accounts for NBP
	select a.acctnum_id as account_number,
		   'NBP' as prg_code,
		   u.unit_id,
		   null::integer as ppl_id,
		   c.comp_id as own_id,
		   uo.ont_type_cd as own_type,
		   c.comp_name as own_display,
		   'NATS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date,
		   greatest(to_date(a.dateadd_dt, 'YYYYMMDD'), a.last_update_date, 
		   			uo.add_date, uo.update_date, c.add_date, c.update_date) as last_update_date
	from camdnats.taccount a
	join camdsnap.unit_ss u
		on a.acctnum_id = u.account 
	join camdsnap.unit_owner_ss uo
		on u.unit_id = uo.unit_id
			and uo.end_date is null	
	join camdsnap.company_ss c
		on uo.own_id = c.comp_id
	where a.accttype_cd = 'UA'
	UNION ALL
	--AMS FACLTY accounts
	select a.account_number,
		   ap.prg_cd as prg_code,
		   null::integer as unit_id,
		   null::integer as ppl_id,
		   c.comp_id as own_id,
		   uo.ont_type_cd as own_type,
		   c.comp_name as own_display,
		   'AMS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date,
		   greatest(max(a.add_date), max(a.update_date), max(ap.add_date), max(ap.update_date), 
		   			max(uo.add_date), max(uo.update_date), max(c.add_date), max(c.update_date)) as last_update_date
	from camdsnap.account_ss a
	join camdsnap.account_program_ss ap
		on a.account_id = ap.account_id
			and ap.account_status_cd <> 'CLOSED'
	join camdsnap.account_facility_ss af
		on a.account_id = af.account_id
	join camdsnap.unit_ss u
		on af.fac_id = u.fac_id 
	join camdsnap.unit_owner_ss uo
		on u.unit_id = uo.unit_id
			and uo.end_date is null	
	join camdsnap.company_ss c
		on uo.own_id = c.comp_id 
	where a.account_type_cd = 'FACLTY'
	group by a.account_number, 
			 ap.prg_cd,
			 c.comp_id,
		     uo.ont_type_cd,
		     c.comp_name
	UNION ALL
	--AMS accounts that are not UNIT or FACLTY accounts
	select a.account_number,
		   ap.prg_cd as prg_code,
		   null::integer as unit_id,
		   ao.ppl_id as ppl_id,
		   c.comp_id as own_id,
		   'OWN' as own_type,
		   coalesce(cu.LAST_NAME || ', ' || cu.FIRST_NAME || CASE WHEN cu.MIDDLE_INITIAL IS NOT NULL THEN ' ' || cu.MIDDLE_INITIAL ELSE '' END || CASE WHEN cu.SUFFIX IS NOT NULL THEN ' ' || cu.SUFFIX ELSE '' end, 
		   			bpp.LAST_NAME || ', ' || bpp.FIRST_NAME || CASE WHEN bpp.MIDDLE_INITIAL IS NOT NULL THEN ' ' || bpp.MIDDLE_INITIAL ELSE '' END || CASE WHEN bpp.SUFFIX IS NOT NULL THEN ' ' || bpp.SUFFIX ELSE '' end, 
		   			c.comp_name, 
		   			agy.agency_name) as own_display,
		   'AMS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date,
		   greatest(a.add_date, a.update_date, ap.add_date, ap.update_date, 
		   			ao.add_date, ao.update_date, c.add_date, c.update_date, 
		   			cu.add_date, cu.update_date, bpp.add_date, bpp.update_date, 
		   			agy.add_date, agy.update_date) as last_update_date
	from camdsnap.account_ss a
	join camdsnap.account_program_ss ap
		on a.account_id = ap.account_id 
	join camdsnap.account_owner_ss ao
		on a.account_id = ao.account_id 
			and ao.end_date is null	
	left join camdsnap.company_ss c
		on ao.comp_id = c.comp_id  
	left join camd.cdx_user cu
		on ao.ppl_id = cu.ppl_id
	left join camdams.binding_party_person bpp
		on ao.ppl_id = bpp.ppl_id  
	left join camdsnap.agency_ss agy
		on ao.agency_id = agy.agy_id 	
	where a.account_type_cd not in ('UNIT', 'FACLTY')
	UNION ALL
	--NATS accounts that are not UNIT accounts
	select a.acctnum_id as account_number,
		   'NBP' as prg_code,
		   null::integer as unit_id,
		   ao.ppl_id,
		   c.comp_id as own_id,
		   'OWN' as own_type,
		   coalesce(cu.LAST_NAME || ', ' || cu.FIRST_NAME || CASE WHEN cu.MIDDLE_INITIAL IS NOT NULL THEN ' ' || cu.MIDDLE_INITIAL ELSE '' END || CASE WHEN cu.SUFFIX IS NOT NULL THEN ' ' || cu.SUFFIX ELSE '' end, 
		   			bpp.LAST_NAME || ', ' || bpp.FIRST_NAME || CASE WHEN bpp.MIDDLE_INITIAL IS NOT NULL THEN ' ' || bpp.MIDDLE_INITIAL ELSE '' END || CASE WHEN bpp.SUFFIX IS NOT NULL THEN ' ' || bpp.SUFFIX ELSE '' end, 
		   			c.comp_name) as own_display,
		   'NATS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date,
		   greatest(to_date(a.dateadd_dt, 'YYYYMMDD'), a.last_update_date, 
		   			ao.update_date, c.add_date, c.update_date, 
		   			cu.add_date, cu.update_date) as last_update_date
	from camdnats.taccount a 
	join camdnats.tacct_owner ao
		on a.acctnum_id = ao.acctnum_id 
			and ao.end_date is null	
	left join camdsnap.company_ss c
		on ao.own_id = c.comp_id   
	left join camd.cdx_user cu
		on ao.ppl_id = cu.ppl_id
	left join camdnats.tbinding_party_person bpp
		on ao.ppl_id = bpp.ppl_id  
	where a.accttype_cd <> 'UA'	
	UNION ALL
	--AMS UNIT accounts for moved units
	select a.account_number,
		   ap.prg_cd as prg_code,
		   uh.unit_id,
		   null::integer as ppl_id,
		   c.comp_id as own_id,
		   uo.ont_type_cd as own_type,
		   c.comp_name as own_display,
		   'AMS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date,
		   greatest(a.add_date, a.update_date, ap.add_date, ap.update_date, 
		   			uo.add_date, uo.update_date, c.add_date, c.update_date, 
		   			uh.add_date, uh.update_date) as last_update_date
	from camdsnap.account_ss a
	join camdsnap.account_program_ss ap
		on a.account_id = ap.account_id
	join camdsnap.unit_history_ss uh
		on a.account_number = uh.new_account_number 
			and uh.unit_history_type_cd = 'LOGICAL'
	join camdsnap.unit_owner_ss uo
		on uh.unit_id = uo.unit_id
			and uo.end_date is null	
	join camdsnap.company_ss c
		on uo.own_id = c.comp_id 
	where a.account_type_cd = 'UNIT'
	UNION ALL
	--NATS UNIT accounts for moved units
	select a.acctnum_id as account_number,
		   'NBP' as prg_code,
		   uh.unit_id,
		   null::integer as ppl_id,
		   c.comp_id as own_id,
		   uo.ont_type_cd as own_type,
		   c.comp_name as own_display,
		   'NATS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date,
		   greatest(to_date(a.dateadd_dt, 'YYYYMMDD'), a.last_update_date, 
		   			uo.add_date, uo.update_date, c.add_date, c.update_date, 
		   			uh.add_date, uh.update_date) as last_update_date
	from camdnats.taccount a
	join camdsnap.unit_history_ss uh
		on a.acctnum_id = uh.new_account_number 
			and uh.unit_history_type_cd = 'LOGICAL'
	join camdsnap.unit_owner_ss uo
		on uh.unit_id = uo.unit_id
			and uo.end_date is null	
	join camdsnap.company_ss c
		on uo.own_id = c.comp_id
	where a.accttype_cd = 'UA'
	on conflict do nothing;

	--update account_owner_dim account_owner_id column
	for vRecord in (select distinct own_id from camddmw.account_owner_dim order by own_id)
	loop
		with seq as (select nextval('camddmw.account_owner_dim_seq') as value)
		update camddmw.account_owner_dim aod
			set account_owner_id = seq.value
		from seq
		where aod.own_id = vRecord.own_id;
	end loop;

	for vRecord in (select distinct ppl_id from camddmw.account_owner_dim order by ppl_id)
	loop
		with seq as (select nextval('camddmw.account_owner_dim_seq') as value)
		update camddmw.account_owner_dim aod
			set account_owner_id = seq.value
		from seq
		where aod.ppl_id = vRecord.ppl_id;
	end loop;

	--update account_fact own display column
	with ao as (select aod.account_number, 
							   aod.prg_code, 
							   string_agg(distinct aod.own_display || '(' || otc.owner_type_description || ')' , '|' 
							   				order by aod.own_display || '(' || otc.owner_type_description || ')') as own_display
							from camddmw.account_owner_dim aod
								join camdmd.owner_type_code otc on aod.own_type = otc.owner_type_cd
						group by aod.account_number, aod.prg_code)
	update camddmw.account_fact af
		set own_display = ao.own_display
	from ao
	where af.account_number = ao.account_number
		and af.prg_code = ao.prg_code;
	

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
