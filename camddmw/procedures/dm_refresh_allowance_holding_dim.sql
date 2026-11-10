-- DROP PROCEDURE camddmw.dm_refresh_allowance_holding_dim(out json, out bool);

CREATE OR REPLACE PROCEDURE camddmw.dm_refresh_allowance_holding_dim(OUT errorjson_out json, OUT result_out boolean)
 LANGUAGE plpgsql
AS $procedure$
declare
    cProcedureName constant text := 'dm_refresh_allowance_holding_dim';

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
	delete from camddmw.allowance_holding_dim;

	insert into camddmw.allowance_holding_dim (account_number, prg_code, start_block, end_block, vintage_year, total_block, 
											   allowance_type_code, allowance_type, account_name, data_source, userid, add_date, last_update_date)
	--AMS allowance holdings
	select af.account_number,
		   pv.prg_cd as prg_code,
		   allb.begin_number as start_block,
		   allb.end_number as end_block,
		   pv.vintage_year,
		   (allb.end_number - allb.begin_number + 1) as total_block,
		   null as allowance_type_code,
		   null as allowance_type,
		   af.account_name,
		   'AMS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date,
		   greatest(allb.add_date, allb.update_date, ab.acquisition_date, af.last_update_date) as last_update_date
	from camdsnap.allowance_block_ss allb
	join camdsnap.program_vintage_ss pv 
		on allb.prg_vintage_id = pv.prg_vintage_id
	join camdsnap.account_block_ss ab
		on allb.allow_block_id = ab.allow_block_id 
	join camdsnap.account_ss a
		on ab.account_id = a.account_id 
	join camddmw.account_fact af
		on a.account_number = af.account_number 
		and (
			af.prg_code = pv.prg_cd 
			or (
				af.prg_code = 'CAIRSO2' 
				and pv.prg_cd = 'ARP'
				and not exists (select af_arp.account_number 
									from camddmw.account_fact af_arp 
									where af_arp.account_number = af.account_number 
										and af_arp.prg_code = 'ARP')			
			)	
		)
	UNION ALL
	--NATS allowance holdings
	select af.account_number,
		   af.prg_code,
		   allb.serstart_cnt as start_block,
		   allb.serend_cnt as end_block,
		   allb.allwyear_dt as vintage_year,
		   (allb.serend_cnt - allb.serstart_cnt + 1) as total_block,
		   case when allb.allwtype_cd = 'RC' then 'RC' else null end as allowance_type_code,
		   case when allb.allwtype_cd = 'RC' then 'Early Reduction Allocation' else null end as allowance_type,
		   af.account_name,
		   'NATS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date,
		   greatest(allb.last_update_date, af.last_update_date) as last_update_date
	from camdnats.tserial allb 
	join camddmw.account_fact af
		on allb.acctnum_id = af.account_number 
		and af.prg_code = 'NBP'
	where allb.allwyear_dt >= 2003
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
