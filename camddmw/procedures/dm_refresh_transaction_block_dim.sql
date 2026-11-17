-- DROP PROCEDURE camddmw.dm_refresh_transaction_block_dim(in bool, in date, out json, out bool);

CREATE OR REPLACE PROCEDURE camddmw.dm_refresh_transaction_block_dim(IN fullrefresh_in boolean, IN incrementalrefreshdate_in date, OUT errorjson_out json, OUT result_out boolean)
 LANGUAGE plpgsql
AS $procedure$
declare
    cProcedureName constant text := 'dm_refresh_transaction_block_dim';

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
	-- full refresh - load records for all transaction_block_ss and tallow records

	-- incremental refresh 
	-- 	load records for transaction_block_ss and tallow records where
	--	-- associated transaction_fact add_date is on or after the date to go back to
	
	insert into camddmw.transaction_block_dim as tb (transaction_id, prg_code, start_block, end_block, vintage_year, total_block, 
													 data_source, block_prg_code, allowance_type_code, allowance_type, last_update_date)
	-- transaction_block_ss records
	select tf.transaction_id,
		   tf.prg_code,
		   tb.begin_number as start_block,
		   tb.end_number as end_block,
		   pv.vintage_year,
		   (tb.end_number - tb.begin_number + 1) as total_block,
		   'AMS' as data_source,
		   pv.prg_cd as block_prg_code,
		   null as allowance_type_code,
		   null as allowance_type,
		   tf.last_update_date
	from camdsnap.transaction_block_ss tb
	join camdsnap.transaction_ss t
		on tb.trans_id = t.trans_id 
	join camddmw.transaction_fact tf
		on t.trans_number = tf.transaction_id
			and t.prg_cd = tf.prg_code
			and (
				fullrefresh_in
				or date_trunc('day', tf.add_date) >= incrementalrefreshdate_in
			) 
	join camdsnap.program_vintage_ss pv
		on tb.prg_vintage_id = pv.prg_vintage_id 
	where not exists (select tbd.transaction_id 
						from camddmw.transaction_block_dim tbd 
						where tbd.transaction_id = tf.transaction_id 
							and tbd.prg_code = tf.prg_code)
	UNION ALL
	-- tallow records for OTC
	select tf.transaction_id,
		   tf.prg_code,
		   tb.serstart_cnt as start_block,
		   tb.serend_cnt as end_block,
		   tb.allwyear_dt as vintage_year,
		   (tb.serend_cnt - tb.serstart_cnt + 1) as total_block,
		   'NATS' as data_source,
		   'OTC' as block_prg_code,
		   case 
		   	when allb.allwtype_cd = 'RC' then 'RC'
		   	else null
		   end as allowance_type_code,
		   case 
		   	when allb.allwtype_cd = 'RC' then 'Early Reduction Allocation'
		   	else null
		   end as allowance_type,
		   tf.last_update_date
	from camdnats.tallow tb
	join camdnats.tserial allb
		on tb.allwyear_dt = allb.allwyear_dt 
			and tb.serstart_cnt = allb.serstart_cnt 
	join camddmw.transaction_fact tf
		on tb.tranevnt_cnt = tf.transaction_id
			and tf.prg_code in ('OTC','NBP')  
			and (
				fullrefresh_in
				or date_trunc('day', tf.add_date) >= incrementalrefreshdate_in
			)
	where tb.allwyear_dt <= 2002
		and not exists (select tbd.transaction_id 
							from camddmw.transaction_block_dim tbd 
							where tbd.transaction_id = tf.transaction_id 
								and tbd.prg_code = tf.prg_code)
	UNION ALL
	-- tallow records for NBP		
	select tf.transaction_id,
		   tf.prg_code,
		   tb.serstart_cnt as start_block,
		   tb.serend_cnt as end_block,
		   tb.allwyear_dt as vintage_year,
		   (tb.serend_cnt - tb.serstart_cnt + 1) as total_block,
		   'NATS' as data_source,
		   'NBP' as block_prg_code,
		   case 
		   	when allb.allwtype_cd = 'RC' then 'RC'
		   	else null
		   end as allowance_type_code,
		   case 
		   	when allb.allwtype_cd = 'RC' then 'Early Reduction Allocation'
		   	else null
		   end as allowance_type,
		   tf.last_update_date
	from camdnats.tallow tb
	join camdnats.tserial allb
		on tb.allwyear_dt = allb.allwyear_dt 
			and tb.serstart_cnt = allb.serstart_cnt 
	join camddmw.transaction_fact tf
		on tb.tranevnt_cnt = tf.transaction_id
			and tf.prg_code in ('OTC','NBP')  
			and (
				fullrefresh_in
				or date_trunc('day', tf.add_date) >= incrementalrefreshdate_in
			)
	where tb.allwyear_dt >= 2003
		and not exists (select tbd.transaction_id 
							from camddmw.transaction_block_dim tbd 
							where tbd.transaction_id = tf.transaction_id 
								and tbd.prg_code = tf.prg_code)
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
