-- DROP PROCEDURE camddmw.dm_refresh_account_rep_dim(out json, out bool);

CREATE OR REPLACE PROCEDURE camddmw.dm_refresh_account_rep_dim(OUT errorjson_out json, OUT result_out boolean)
 LANGUAGE plpgsql
AS $procedure$
declare
    cProcedureName constant text := 'dm_refresh_account_rep_dim';

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
	delete from camddmw.account_rep_dim;

	insert into camddmw.account_rep_dim (account_number, prg_code, unit_id, 
										 ppl_id, display_name, full_name, 
										 rep_code, data_source, userid, add_date)
	--AMS accounts that are not UNIT or FACLTY accounts
	select a.account_number,
		   aprg.prg_cd as prg_code,
		   null as unit_id,
		   appl.ppl_id,
		   appl.ppl_id as display_name,
		   appl.ppl_id as full_name,
		   appl.responsibility_id as rep_code,
		   'AMS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date
	from camdsnap.account_ss a
	join camdsnap.account_program_ss aprg
		on a.account_id = aprg.account_id
	join camdsnap.account_people_ss appl
		on a.account_id = appl.account_id
			and appl.end_date is null
	where a.account_type_cd not in ('UNIT', 'FACLTY')
	UNION ALL
	--AMS UNIT accounts
	select a.account_number,
		   aprg.prg_cd as prg_code,
		   u.unit_id,
		   fp.ppl_id,
		   fp.ppl_id as display_name,
		   fp.ppl_id as full_name,
		   fp.responsibility_id as rep_code,
		   'AMS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date
	from camdsnap.account_ss a
	join camdsnap.account_program_ss aprg
		on a.account_id = aprg.account_id
	join camdsnap.unit_ss u
		on a.account_number = u.account 
	join camdsnap.facility_people_ss fp
		on u.fac_id = fp.fac_id
			and fp.end_date is null
			and fp.responsibility_id in ('PRM','ALT')
			and (
				fp.prg_id is null 
				or exists (select p.prg_id 
							from camdsnap.program_ss p 
							where p.prg_id = fp.prg_id 
								and p.prg_code = 'ARP')
			)
	where a.account_type_cd = 'UNIT'
	UNION ALL
	--AMS UNIT accounts for moved units
	select a.account_number,
		   aprg.prg_cd as prg_code,
		   uh.unit_id,
		   fp.ppl_id,
		   fp.ppl_id as display_name,
		   fp.ppl_id as full_name,
		   fp.responsibility_id as rep_code,
		   'AMS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date
	from camdsnap.account_ss a
	join camdsnap.account_program_ss aprg
		on a.account_id = aprg.account_id
	join camdsnap.unit_history_ss uh
		on a.account_number = uh.old_account_number 
			and uh.unit_history_type_cd in ('LOGICAL','PHYSCAL')
	join camdsnap.facility_people_ss fp
		on uh.old_fac_id = fp.fac_id
			and fp.end_date is null
			and fp.responsibility_id in ('PRM','ALT')
			and exists (select p.prg_id 
							from camdsnap.program_ss p 
							where p.prg_id = fp.prg_id 
								and p.prg_code = 'ARP')
	where a.account_type_cd = 'UNIT'
	UNION ALL
	--AMS FACLTY accounts
	select a.account_number,
		   aprg.prg_cd as prg_code,
		   null as unit_id,
		   fp.ppl_id,
		   fp.ppl_id as display_name,
		   fp.ppl_id as full_name,
		   fp.responsibility_id as rep_code,
		   'AMS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date
	from camdsnap.account_ss a
	join camdsnap.account_program_ss aprg
		on a.account_id = aprg.account_id
	join camdsnap.account_facility_ss af
		on a.account_id = af.account_id  
	join camdsnap.facility_people_ss fp
		on af.fac_id = fp.fac_id
			and fp.end_date is null
			and fp.responsibility_id in ('PRM','ALT')
			and (
				fp.prg_id is null 
				or exists (select p.prg_id 
							from camdsnap.program_ss p 
							where p.prg_id = fp.prg_id 
								and p.prg_code not in ('OTC', 'NBP'))
			)
	where a.account_type_cd = 'FACLTY'
	on conflict do nothing;

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
