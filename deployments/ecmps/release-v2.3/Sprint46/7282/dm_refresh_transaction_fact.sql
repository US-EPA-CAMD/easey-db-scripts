-- DROP PROCEDURE camddmw.dm_refresh_account_fact(in bool, in date, out json, out bool);

CREATE OR REPLACE PROCEDURE camddmw.dm_refresh_transaction_fact(IN fullrefresh_in boolean, IN incrementalrefreshdate_in date, OUT errorjson_out json, OUT result_out boolean)
 LANGUAGE plpgsql
AS $procedure$
declare
    cProcedureName constant text := 'dm_refresh_transaction_fact';

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
	-- full refresh - load records for all transaction_ss and ttransact records

	-- incremental refresh 
	-- 	load records for transaction_ss records where
	--	-- transaction_ss trans_date is on or after the date to go back to OR
	--	-- account_fact add_date (for the buy or sell account) is on or after the date to go back to OR
	--	-- a separate transaction_ss record exists where 
	--		--	trans_date is on or after the date to go back to AND 
	--		--	changed_trans_id matches this trans_id 	
	-- 	load records for taccount records where
	--	-- ttransact cnfrmdte_dt is on or after the date to go back to OR
	--	-- account_fact add_date (for the buy or sell account) is on or after the date to go back to OR
	--	-- a separate ttransact record exists where
	--		--	cnfrmdte_dt is on or after the date to go back to AND
	--		--	chgdtran_cnt matches this tranevnt_cnt AND
	--		--	trantype_cd is EC or ER AND
	--		--	buyacct_id matches this buyacct_id AND
	--		--	this trantype_cd is TE, TB, or PE 
	--	-- a separate ttransact record exists where
	--		--	cnfrmdte_dt is on or after the date to go back to AND 
	--		--	chgdtran_cnt matches this tranevnt_cnt AND
	--		--	trantype_cd is EC or ER AND
	--		--	sellacct_id matches this sellacct_id AND
	--		--	this trantype_cd is TE, TB, or PE
	
	with upsert_tf as (
		insert into camddmw.transaction_fact as tf (transaction_id, prg_code, transaction_date, transaction_type_code, transaction_type, transaction_total, 
														 buy_acct_number, buy_ppl_id, buy_display_name, buy_display_block, buy_full_name,  
														 buy_acct_name, buy_account_type, buy_account_type_code, buy_source_cat, buy_epa_region, 
														 buy_state, buy_orispl_code, buy_facility_name, buy_fac_id, buy_nerc_region, buy_unit_id,
														 sell_acct_number, sell_ppl_id, sell_display_name, sell_display_block, sell_full_name,  
														 sell_acct_name, sell_account_type, sell_account_type_code, sell_source_cat, sell_epa_region, 
														 sell_state, sell_orispl_code, sell_facility_name, sell_fac_id, sell_nerc_region, sell_unit_id,
														 data_source, last_update_date)
		-- transaction_ss records
		select 
			t.trans_number as transaction_id,
			t.prg_cd as prg_code,
			date_trunc('day', t.trans_date) as transaction_date,
			t.trans_type_cd as transaction_type_code,
			ttc.trans_type_description as transaction_type,
			tb.transaction_total,
			a_buy.account_number as buy_acct_number,
			t.buy_ppl_id,
			t.buy_ppl_id as buy_display_name,
			t.buy_ppl_id as buy_display_block,
			t.buy_ppl_id as buy_full_name,
			af_buy.account_name as buy_acct_name,
			af_buy.account_type as buy_account_type,
			af_buy.account_type_code as buy_account_type_code,
			af_buy.source_cat as buy_source_cat,
			af_buy.epa_region as buy_epa_region,
			af_buy.state as buy_state,
			af_buy.orispl_code as buy_orispl_code,
			af_buy.facility_name as buy_facility_name,
			af_buy.fac_id as buy_fac_id,
			af_buy.nerc_region as buy_nerc_region,
			af_buy.unit_id as buy_unit_id,
			a_sell.account_number as sell_acct_number,
			t.sell_ppl_id,
			t.sell_ppl_id as sell_display_name,
			t.sell_ppl_id as sell_display_block,
			t.sell_ppl_id as sell_full_name,
			af_sell.account_name as sell_acct_name,
			af_sell.account_type as sell_account_type,
			af_sell.account_type_code as sell_account_type_code,
			af_sell.source_cat as sell_source_cat,
			af_sell.epa_region as sell_epa_region,
			af_sell.state as sell_state,
			af_sell.orispl_code as sell_orispl_code,
			af_sell.facility_name as sell_facility_name,
			af_sell.fac_id as sell_fac_id,
			af_sell.nerc_region as sell_nerc_region,
			af_sell.unit_id as sell_unit_id,
			'AMS' as data_source,
			greatest(date_trunc('day', t.trans_date), t.update_date, af_buy.last_update_date, af_sell.last_update_date) as last_update_date
		from camdsnap.transaction_ss t
		join camdmd.transaction_type_code ttc on t.trans_type_cd = ttc.trans_type_cd
		join (select trans_id, sum(end_number - begin_number + 1) as transaction_total 
				from camdsnap.transaction_block_ss 
				group by trans_id) tb on t.trans_id = tb.trans_id
		join camdsnap.account_ss a_buy on t.buy_account_id = a_buy.account_id 
		join camddmw.account_fact af_buy
			on (
				(a_buy.account_number = af_buy.account_number and t.prg_cd = af_buy.prg_code)
				or (not exists (select af_buy_arp.account_number 
									from camddmw.account_fact af_buy_arp 
									where af_buy_arp.account_number = a_buy.account_number 
									and af_buy_arp.prg_code = 'ARP') 
					and a_buy.account_number = af_buy.account_number 
					and t.prg_cd = 'ARP' 
					and af_buy.prg_code = 'CAIRSO2')
			) 
		join camdsnap.account_ss a_sell on t.sell_account_id = a_sell.account_id 
		join camddmw.account_fact af_sell 
			on (
				(a_sell.account_number = af_sell.account_number and t.prg_cd = af_sell.prg_code)
				or (not exists (select af_sell_arp.account_number 
									from camddmw.account_fact af_sell_arp 
									where af_sell_arp.account_number = a_sell.account_number 
									and af_sell_arp.prg_code = 'ARP') 
					and a_sell.account_number = af_sell.account_number 
					and t.prg_cd = 'ARP' 
					and af_sell.prg_code = 'CAIRSO2')
			) 
		where t.trans_type_cd not in ('AD', 'INTOESC', 'OUTESC', 'TD')
			and t.TRANS_STATUS_CD NOT IN ('CANCEL', 'REJECT', 'PENDING')
			and (
				fullrefresh_in
				or date_trunc('day', t.trans_date) >= incrementalrefreshdate_in
			    or date_trunc('day', af_buy.add_date) >= incrementalrefreshdate_in
			    or date_trunc('day', af_sell.add_date) >= incrementalrefreshdate_in
				or exists (select tc.trans_id 
							from camdsnap.transaction_ss tc 
							where tc.changed_trans_id = t.trans_id 
								and date_trunc('day', tc.trans_date) >= incrementalrefreshdate_in)
			)
		UNION ALL
		-- ttransact records for OTC
		select 
			t.tranevnt_cnt as transaction_id,
			'OTC' as prg_code,
			to_date(t.cnfrmdte_dt, 'YYYYMMDD') as transaction_date,
			t.trantype_cd  as transaction_type_code,
			ttc.trans_type_description as transaction_type,
			t.numtrans_tot as transaction_total,
			t.buyacct_id as buy_acct_number,
			t.buyrep_id as buy_ppl_id,
			t.buyrep_id as buy_display_name,
			t.buyrep_id as buy_display_block,
			t.buyrep_id as buy_full_name,
			af_buy.account_name as buy_acct_name,
			af_buy.account_type as buy_account_type,
			af_buy.account_type_code as buy_account_type_code,
			af_buy.source_cat as buy_source_cat,
			af_buy.epa_region as buy_epa_region,
			af_buy.state as buy_state,
			af_buy.orispl_code as buy_orispl_code,
			af_buy.facility_name as buy_facility_name,
			af_buy.fac_id as buy_fac_id,
			af_buy.nerc_region as buy_nerc_region,
			af_buy.unit_id as buy_unit_id,
			t.sellacct_id as sell_acct_number,
			t.sellrep_id as sell_ppl_id,
			t.sellrep_id as sell_display_name,
			t.sellrep_id as sell_display_block,
			t.sellrep_id as sell_full_name,
			af_sell.account_name as sell_acct_name,
			af_sell.account_type as sell_account_type,
			af_sell.account_type_code as sell_account_type_code,
			af_sell.source_cat as sell_source_cat,
			af_sell.epa_region as sell_epa_region,
			af_sell.state as sell_state,
			af_sell.orispl_code as sell_orispl_code,
			af_sell.facility_name as sell_facility_name,
			af_sell.fac_id as sell_fac_id,
			af_sell.nerc_region as sell_nerc_region,
			af_sell.unit_id as sell_unit_id,
			'NATS' as data_source,
			greatest(to_date(t.cnfrmdte_dt, 'YYYYMMDD'), af_buy.last_update_date, af_sell.last_update_date) as last_update_date
		from camdnats.ttransact t
		join camdmd.transaction_type_code ttc 
			on (
				t.trantype_cd = 'RC' and ttc.trans_type_cd = 'ERLYRED'
				or t.trantype_cd = 'TE' and ttc.trans_type_cd = 'EMISS'
				or t.trantype_cd = 'EC' and ttc.trans_type_cd = 'ERRCORR'
				or t.trantype_cd = 'ER' and ttc.trans_type_cd = 'ERRREV'
				or t.trantype_cd = 'IA' and ttc.trans_type_cd = 'INITALL'
				or t.trantype_cd = 'OI' and ttc.trans_type_cd = 'OPTALL'
				or t.trantype_cd = 'PE' and ttc.trans_type_cd = 'OFFPEN'
				or t.trantype_cd = 'TR' and ttc.trans_type_cd = 'PRIVATE'
				or t.trantype_cd = 'SA' and ttc.trans_type_cd = 'STATE'
				or t.trantype_cd = 'TN' and ttc.trans_type_cd = 'TN'
			) 
		join camddmw.account_fact af_buy 
			on (
				(t.buyacct_id = af_buy.account_number and 'OTC' = af_buy.prg_code)
				or (not exists (select af_buy_otc.account_number 
									from camddmw.account_fact af_buy_otc 
									where af_buy_otc.account_number = t.buyacct_id 
									and af_buy_otc.prg_code = 'OTC') 
					and t.buyacct_id = af_buy.account_number
					and af_buy.prg_code = 'NBP')
			)  
		join camddmw.account_fact af_sell 
			on (
				(t.sellacct_id = af_sell.account_number and 'OTC' = af_sell.prg_code)
				or (not exists (select af_sell_otc.account_number 
									from camddmw.account_fact af_sell_otc 
									where af_sell_otc.account_number = t.sellacct_id 
									and af_sell_otc.prg_code = 'OTC') 
					and t.sellacct_id = af_sell.account_number
					and af_sell.prg_code = 'NBP')
			) 
		where t.trantype_cd not in ('AD', 'DS', 'IE', 'OE', 'TD')
			and t.transtat_cd not in ('CA', 'RJ', 'PN')
			and	(
				exists (select a.tranevnt_cnt from camdnats.tallow a where a.tranevnt_cnt = t.tranevnt_cnt and a.allwyear_dt <= 2002)
				or not exists (select a.tranevnt_cnt from camdnats.tallow a where a.tranevnt_cnt = t.tranevnt_cnt)
			)
			and (
				fullrefresh_in
			    or date_trunc('day', af_buy.add_date) >= incrementalrefreshdate_in
			    or date_trunc('day', af_sell.add_date) >= incrementalrefreshdate_in
			)
		UNION ALL
		-- ttransact records for NBP		
		select 
			t.tranevnt_cnt as transaction_id,
			'NBP' as prg_code,
			to_date(t.cnfrmdte_dt, 'YYYYMMDD') as transaction_date,
			t.trantype_cd  as transaction_type_code,
			ttc.trans_type_description as transaction_type,
			t.numtrans_tot as transaction_total,
			t.buyacct_id as buy_acct_number,
			t.buyrep_id as buy_ppl_id,
			t.buyrep_id as buy_display_name,
			t.buyrep_id as buy_display_block,
			t.buyrep_id as buy_full_name,
			af_buy.account_name as buy_acct_name,
			af_buy.account_type as buy_account_type,
			af_buy.account_type_code as buy_account_type_code,
			af_buy.source_cat as buy_source_cat,
			af_buy.epa_region as buy_epa_region,
			af_buy.state as buy_state,
			af_buy.orispl_code as buy_orispl_code,
			af_buy.facility_name as buy_facility_name,
			af_buy.fac_id as buy_fac_id,
			af_buy.nerc_region as buy_nerc_region,
			af_buy.unit_id as buy_unit_id,
			t.sellacct_id as sell_acct_number,
			t.sellrep_id as sell_ppl_id,
			t.sellrep_id as sell_display_name,
			t.sellrep_id as sell_display_block,
			t.sellrep_id as sell_full_name,
			af_sell.account_name as sell_acct_name,
			af_sell.account_type as sell_account_type,
			af_sell.account_type_code as sell_account_type_code,
			af_sell.source_cat as sell_source_cat,
			af_sell.epa_region as sell_epa_region,
			af_sell.state as sell_state,
			af_sell.orispl_code as sell_orispl_code,
			af_sell.facility_name as sell_facility_name,
			af_sell.fac_id as sell_fac_id,
			af_sell.nerc_region as sell_nerc_region,
			af_sell.unit_id as sell_unit_id,
			'NATS' as data_source,
			greatest(to_date(t.cnfrmdte_dt, 'YYYYMMDD'), af_buy.last_update_date, af_sell.last_update_date) as last_update_date
		from camdnats.ttransact t
		join camdmd.transaction_type_code ttc 
			on (
				t.trantype_cd = 'RC' and ttc.trans_type_cd = 'ERLYRED'
				or t.trantype_cd = 'TE' and ttc.trans_type_cd = 'EMISS'
				or t.trantype_cd = 'EC' and ttc.trans_type_cd = 'ERRCORR'
				or t.trantype_cd = 'ER' and ttc.trans_type_cd = 'ERRREV'
				or t.trantype_cd = 'IA' and ttc.trans_type_cd = 'INITALL'
				or t.trantype_cd = 'OI' and ttc.trans_type_cd = 'OPTALL'
				or t.trantype_cd = 'PE' and ttc.trans_type_cd = 'OFFPEN'
				or t.trantype_cd = 'TR' and ttc.trans_type_cd = 'PRIVATE'
				or t.trantype_cd = 'SA' and ttc.trans_type_cd = 'STATE'
				or t.trantype_cd = 'TB' and ttc.trans_type_cd = 'TAKEBCK'
				or t.trantype_cd = 'TN' and ttc.trans_type_cd = 'TN'
				or t.trantype_cd = 'TC' and ttc.trans_type_cd = 'TC'
				or t.trantype_cd = 'NC' and ttc.trans_type_cd = 'NC'
			) 
		join camddmw.account_fact af_buy 
			on t.buyacct_id = af_buy.account_number and 'NBP' = af_buy.prg_code
		join camddmw.account_fact af_sell 
			on t.sellacct_id = af_sell.account_number and 'NBP' = af_sell.prg_code
		where t.trantype_cd not in ('AD', 'DS', 'IE', 'OE', 'TD')
			and t.transtat_cd not in ('CA', 'RJ', 'PN')
			and exists (select a.tranevnt_cnt from camdnats.tallow a where a.tranevnt_cnt = t.tranevnt_cnt and a.allwyear_dt >= 2003)
			and (
				fullrefresh_in
			    or date_trunc('day', af_buy.add_date) >= incrementalrefreshdate_in
			    or date_trunc('day', af_sell.add_date) >= incrementalrefreshdate_in
			)
		on conflict (transaction_id, prg_code)
		do update set
			transaction_date = excluded.transaction_date,
			transaction_type_code = excluded.transaction_type_code,
			transaction_type = excluded.transaction_type,
			transaction_total = excluded.transaction_total,
			buy_acct_number = excluded.buy_acct_number,
			buy_ppl_id = excluded.buy_ppl_id,
			buy_source_cat = excluded.buy_source_cat,
			buy_epa_region = excluded.buy_epa_region,
			buy_state = excluded.buy_state,
			buy_orispl_code = excluded.buy_orispl_code,
			buy_facility_name = excluded.buy_facility_name,
			buy_fac_id = excluded.buy_fac_id,
			buy_acct_name = excluded.buy_acct_name,
			sell_acct_number = excluded.sell_acct_number,
			sell_ppl_id = excluded.sell_ppl_id,
			sell_source_cat = excluded.sell_source_cat,
			sell_epa_region = excluded.sell_epa_region,
			sell_state = excluded.sell_state,
			sell_orispl_code = excluded.sell_orispl_code,
			sell_facility_name = excluded.sell_facility_name,
			sell_fac_id = excluded.sell_fac_id,
			sell_acct_name = excluded.sell_acct_name,
			buy_nerc_region = excluded.buy_nerc_region,
			sell_nerc_region = excluded.sell_nerc_region,
			buy_account_type = excluded.buy_account_type,
			sell_account_type = excluded.sell_account_type,
			buy_account_type_code = excluded.buy_account_type_code,
			sell_account_type_code = excluded.sell_account_type_code,
			buy_full_name = excluded.buy_full_name,
			buy_display_name = excluded.buy_display_name,
			buy_display_block = excluded.buy_display_block,
			sell_full_name = excluded.sell_full_name,
			sell_display_name = excluded.sell_display_name,
			sell_display_block = excluded.sell_display_block,
			buy_unit_id = excluded.buy_unit_id,
			sell_unit_id = excluded.sell_unit_id,
			data_source = excluded.data_source,
			userid = 'DMLOAD',
			add_date = now(),
			last_update_date = excluded.last_update_date
		where
			coalesce(tf.transaction_date, to_date('01/01/1900','mm/dd/yyyy')) <> coalesce(excluded.transaction_date, to_date('01/01/1900','mm/dd/yyyy')) or
			coalesce(tf.transaction_type_code, '') <> coalesce(excluded.transaction_type_code, '') or
			coalesce(tf.transaction_type, '') <> coalesce(excluded.transaction_type, '') or
			coalesce(tf.transaction_total, 0) <> coalesce(excluded.transaction_total, 0) or
			coalesce(tf.buy_acct_number, '') <> coalesce(excluded.buy_acct_number, '') or
			coalesce(tf.buy_ppl_id, 0) <> coalesce(excluded.buy_ppl_id, 0) or
			coalesce(tf.buy_source_cat, '') <> coalesce(excluded.buy_source_cat, '') or
			coalesce(tf.buy_epa_region, 0) <> coalesce(excluded.buy_epa_region, 0) or
			coalesce(tf.buy_state, '') <> coalesce(excluded.buy_state, '') or
			coalesce(tf.buy_orispl_code, 0) <> coalesce(excluded.buy_orispl_code, 0) or 
			coalesce(tf.buy_facility_name, '') <> coalesce(excluded.buy_facility_name, '') or 
			coalesce(tf.buy_fac_id, 0) <> coalesce(excluded.buy_fac_id, 0) or
			coalesce(tf.buy_acct_name, '') <> coalesce(excluded.buy_acct_name, '') or 
			coalesce(tf.sell_acct_number, '') <> coalesce(excluded.sell_acct_number, '') or 
			coalesce(tf.sell_ppl_id, 0) <> coalesce(excluded.sell_ppl_id, 0) or
			coalesce(tf.sell_source_cat, '') <> coalesce(excluded.sell_source_cat, '') or 
			coalesce(tf.sell_epa_region, 0) <> coalesce(excluded.sell_epa_region, 0) or
			coalesce(tf.sell_state, '') <> coalesce(excluded.sell_state, '') or
			coalesce(tf.sell_orispl_code, 0) <> coalesce(excluded.sell_orispl_code, 0) or 
			coalesce(tf.sell_facility_name, '') <> coalesce(excluded.sell_facility_name, '') or 
			coalesce(tf.sell_fac_id, 0) <> coalesce(excluded.sell_fac_id, 0) or
			coalesce(tf.sell_acct_name, '') <> coalesce(excluded.sell_acct_name, '') or 
			coalesce(tf.buy_nerc_region, '') <> coalesce(excluded.buy_nerc_region, '') or
			coalesce(tf.sell_nerc_region, '') <> coalesce(excluded.sell_nerc_region, '') or
			coalesce(tf.buy_account_type, '') <> coalesce(excluded.buy_account_type, '') or
			coalesce(tf.sell_account_type, '') <> coalesce(excluded.sell_account_type, '') or
			coalesce(tf.buy_account_type_code, '') <> coalesce(excluded.buy_account_type_code, '') or 
			coalesce(tf.sell_account_type_code, '') <> coalesce(excluded.sell_account_type_code, '') or
			coalesce(tf.buy_full_name, '') <> coalesce(excluded.buy_full_name, '') or
			coalesce(tf.buy_display_name, '') <> coalesce(excluded.buy_display_name, '') or 
			coalesce(tf.buy_display_block, '') <> coalesce(excluded.buy_display_block, '') or
			coalesce(tf.sell_full_name, '') <> coalesce(excluded.sell_full_name, '') or
			coalesce(tf.sell_display_name, '') <> coalesce(excluded.sell_display_name, '') or 
			coalesce(tf.sell_display_block, '') <> coalesce(excluded.sell_display_block, '') or
			coalesce(tf.buy_unit_id, 0) <> coalesce(excluded.buy_unit_id, 0) or
			coalesce(tf.sell_unit_id, 0) <> coalesce(excluded.sell_unit_id, 0) or
			coalesce(tf.data_source, '') <> coalesce(excluded.data_source, '') or
			coalesce(tf.last_update_date, to_date('01/01/1900','mm/dd/yyyy')) <> coalesce(excluded.last_update_date, to_date('01/01/1900','mm/dd/yyyy'))
		returning transaction_id, prg_code
	),
	delete_tbm as (DELETE FROM camddmw.transaction_block_dim WHERE (transaction_id, prg_code) IN (select transaction_id, prg_code from upsert_tf))
	DELETE FROM camddmw.transaction_owner_dim WHERE (transaction_id, prg_code) IN (select transaction_id, prg_code from upsert_tf);

	DELETE FROM camddmw.account_fact
	WHERE (
		(prg_code = 'NBP' and state in ('ME', 'VT')) 
		or (prg_code = 'NBP' and state = 'NH' and account_number <> 'NH0000000300')
	);

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
