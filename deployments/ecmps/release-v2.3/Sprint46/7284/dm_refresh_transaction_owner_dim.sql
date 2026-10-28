-- DROP PROCEDURE camddmw.dm_refresh_transaction_owner_dim(in bool, in date, out json, out bool);

CREATE OR REPLACE PROCEDURE camddmw.dm_refresh_transaction_owner_dim(IN fullrefresh_in boolean, IN incrementalrefreshdate_in date, OUT errorjson_out json, OUT result_out boolean)
 LANGUAGE plpgsql
AS $procedure$
declare
    cProcedureName constant text := 'dm_refresh_transaction_owner_dim';

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
	-- full refresh - load records for all transaction_fact records

	-- incremental refresh 
	-- 	load records for transaction_fact records where
	--	-- transaction_fact add_date is on or after the date to go back to AND either of the following conditions are met
	--	--	--	transaction_fact trans_date is on or before the date to go back to AND owner begin date is on or before the date to go back to AND owner end date is one or after the date to go back to OR
	--	--	--	owner begin date is on or before transaction_fact trans_date AND owner end date is one or after transaction_fact trans_date	
	
	insert into camddmw.transaction_owner_dim as tod (transaction_id, prg_code, account_number, own_type, own_display,
													  own_id, ppl_id, buy_or_sell, data_source, userid, add_date, last_update_date)
	-- records for buy account where buy account is a unit account (AMS and NATS)
	select tf.transaction_id,
		   tf.prg_code,
		   tf.buy_acct_number as account_number,
		   uo.ont_type_cd as own_type,
		   c.comp_name as own_display,
		   c.comp_id as own_id,
		   null::integer as ppl_id,
		   'BUY' as buy_or_sell,
		   case 
		   	when tf.prg_code in ('OTC','NBP') then 'NATS'
		   	else 'AMS'
		   end as data_source,
		   'DMLOAD' as userid,
		   now() as add_date,
		   greatest(max(uo.add_date), max(uo.update_date), max(c.add_date), max(c.update_date), tf.last_update_date) as last_update_date
	from camddmw.transaction_fact tf
	join camdsnap.unit_owner_ss uo
		on tf.buy_unit_id = uo.unit_id 
	join camdsnap.company_ss c 
		on uo.own_id = c.comp_id 
	where tf.buy_account_type_code in ('UA','UNIT')
		and not exists (select tod.transaction_id 
							from camddmw.transaction_owner_dim tod 
							where tod.transaction_id = tf.transaction_id
								and tod.prg_code = tf.prg_code)
		and (
			(
				fullrefresh_in
				and date_trunc('day', uo.begin_date) <= date_trunc('day', tf.transaction_date)
				and date_trunc('day', uo.end_date) >= date_trunc('day', tf.transaction_date)						
			)	
			or (
				date_trunc('day', tf.add_date) >= incrementalrefreshdate_in
				and (
					(date_trunc('day', tf.transaction_date) <= incrementalrefreshdate_in
						and date_trunc('day', uo.begin_date) <= incrementalrefreshdate_in
						and date_trunc('day', uo.end_date) >= incrementalrefreshdate_in)
					or (date_trunc('day', uo.begin_date) <= date_trunc('day', tf.transaction_date)
						and date_trunc('day', uo.end_date) >= date_trunc('day', tf.transaction_date))
				)		
			)
		)
	group by tf.transaction_id,
		     tf.prg_code,
		     c.comp_name, 
			 case 
		   		when tf.prg_code in ('OTC','NBP') then 'NATS'
		   		else 'AMS'
		   	 end,
			 c.comp_id,
			 tf.buy_acct_number,
	         uo.ont_type_cd
	union all
	-- records for sell account where sell account is a unit account (AMS and NATS)
	select tf.transaction_id,
		   tf.prg_code,
		   tf.sell_acct_number as account_number,
		   uo.ont_type_cd as own_type,
		   c.comp_name as own_display,
		   c.comp_id as own_id,
		   null::integer as ppl_id,
		   'SELL' as buy_or_sell,
		   case 
		   	when tf.prg_code in ('OTC','NBP') then 'NATS'
		   	else 'AMS'
		   end as data_source,
		   'DMLOAD' as userid,
		   now() as add_date,
		   greatest(max(uo.add_date), max(uo.update_date), max(c.add_date), max(c.update_date), tf.last_update_date) as last_update_date
	from camddmw.transaction_fact tf
	join camdsnap.unit_owner_ss uo
		on tf.sell_unit_id = uo.unit_id 
	join camdsnap.company_ss c 
		on uo.own_id = c.comp_id 
	where tf.sell_account_type_code in ('UA','UNIT')
		and not exists (select tod.transaction_id 
							from camddmw.transaction_owner_dim tod 
							where tod.transaction_id = tf.transaction_id
								and tod.prg_code = tf.prg_code)
		and (
			(
				fullrefresh_in
				and date_trunc('day', uo.begin_date) <= date_trunc('day', tf.transaction_date)
				and date_trunc('day', uo.end_date) >= date_trunc('day', tf.transaction_date)						
			)
			or (
				date_trunc('day', tf.add_date) >= incrementalrefreshdate_in
				and (
					(date_trunc('day', tf.transaction_date) <= incrementalrefreshdate_in
						and date_trunc('day', uo.begin_date) <= incrementalrefreshdate_in
						and date_trunc('day', uo.end_date) >= incrementalrefreshdate_in)
					or (date_trunc('day', uo.begin_date) <= date_trunc('day', tf.transaction_date)
						and date_trunc('day', uo.end_date) >= date_trunc('day', tf.transaction_date))
				)		
			)
		)
	group by tf.transaction_id,
		     tf.prg_code,
		     c.comp_name, 
			 case 
		   		when tf.prg_code in ('OTC','NBP') then 'NATS'
		   		else 'AMS'
		   	 end,
			 c.comp_id,
			 tf.sell_acct_number,
	         uo.ont_type_cd
	union all
	-- records for buy account where buy account is a facility account (AMS) 
	select tf.transaction_id,
		   tf.prg_code,
		   tf.buy_acct_number as account_number,
		   uo.ont_type_cd as own_type,
		   c.comp_name as own_display,
		   c.comp_id as own_id,
		   null::integer as ppl_id,
		   'BUY' as buy_or_sell,
		   'AMS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date,
		   greatest(max(uo.add_date), max(uo.update_date), max(c.add_date), max(c.update_date), tf.last_update_date) as last_update_date
	from camddmw.transaction_fact tf
	join camdsnap.account_ss a
		on tf.buy_acct_number = a.account_number 
	join camdsnap.account_facility_ss af
		on a.account_id = af.account_id 
	join camdsnap.unit_ss u
		on af.fac_id = u.fac_id
	join camdsnap.unit_owner_ss uo
		on u.unit_id = uo.unit_id 
	join camdsnap.company_ss c 
		on uo.own_id = c.comp_id 
	where tf.buy_account_type_code = 'FACLTY'
		and tf.prg_code not in ('OTC','NBP')
		and not exists (select tod.transaction_id 
							from camddmw.transaction_owner_dim tod 
							where tod.transaction_id = tf.transaction_id
								and tod.prg_code = tf.prg_code)
		and (
			(
				fullrefresh_in
				and date_trunc('day', uo.begin_date) <= date_trunc('day', tf.transaction_date)
				and date_trunc('day', uo.end_date) >= date_trunc('day', tf.transaction_date)						
			)
			or (
				date_trunc('day', tf.add_date) >= incrementalrefreshdate_in
				and (
					(date_trunc('day', tf.transaction_date) <= incrementalrefreshdate_in
						and date_trunc('day', uo.begin_date) <= incrementalrefreshdate_in
						and date_trunc('day', uo.end_date) >= incrementalrefreshdate_in)
					or (date_trunc('day', uo.begin_date) <= date_trunc('day', tf.transaction_date)
						and date_trunc('day', uo.end_date) >= date_trunc('day', tf.transaction_date))
				)		
			)
		)
	group by tf.transaction_id,
		     tf.prg_code,
		     c.comp_name, 
			 c.comp_id,
			 tf.buy_acct_number,
	         uo.ont_type_cd
	union all
	-- records for sell account where sell account is a facility account (AMS) 
	select tf.transaction_id,
		   tf.prg_code,
		   tf.sell_acct_number as account_number,
		   uo.ont_type_cd as own_type,
		   c.comp_name as own_display,
		   c.comp_id as own_id,
		   null::integer as ppl_id,
		   'SELL' as buy_or_sell,
		   'AMS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date,
		   greatest(max(uo.add_date), max(uo.update_date), max(c.add_date), max(c.update_date), tf.last_update_date) as last_update_date
	from camddmw.transaction_fact tf
	join camdsnap.account_ss a
		on tf.sell_acct_number = a.account_number 
	join camdsnap.account_facility_ss af
		on a.account_id = af.account_id 
	join camdsnap.unit_ss u
		on af.fac_id = u.fac_id
	join camdsnap.unit_owner_ss uo
		on u.unit_id = uo.unit_id 
	join camdsnap.company_ss c 
		on uo.own_id = c.comp_id 
	where tf.sell_account_type_code = 'FACLTY'
		and tf.prg_code not in ('OTC','NBP')
		and not exists (select tod.transaction_id 
							from camddmw.transaction_owner_dim tod 
							where tod.transaction_id = tf.transaction_id
								and tod.prg_code = tf.prg_code)
		and (
			(
				fullrefresh_in
				and date_trunc('day', uo.begin_date) <= date_trunc('day', tf.transaction_date)
				and date_trunc('day', uo.end_date) >= date_trunc('day', tf.transaction_date)						
			)
			or (
				date_trunc('day', tf.add_date) >= incrementalrefreshdate_in
				and (
					(date_trunc('day', tf.transaction_date) <= incrementalrefreshdate_in
						and date_trunc('day', uo.begin_date) <= incrementalrefreshdate_in
						and date_trunc('day', uo.end_date) >= incrementalrefreshdate_in)
					or (date_trunc('day', uo.begin_date) <= date_trunc('day', tf.transaction_date)
						and date_trunc('day', uo.end_date) >= date_trunc('day', tf.transaction_date))
				)		
			)
		)
	group by tf.transaction_id,
		     tf.prg_code,
		     c.comp_name,
			 c.comp_id,
			 tf.sell_acct_number,
	         uo.ont_type_cd
	union all
	-- records for buy account where buy account is not a unit or facility account (AMS) 
	select tf.transaction_id,
		   tf.prg_code,
		   tf.buy_acct_number as account_number,
		   'OWN' as own_type,
		   coalesce(cu.LAST_NAME || ', ' || cu.FIRST_NAME || CASE WHEN cu.MIDDLE_INITIAL IS NOT NULL THEN ' ' || cu.MIDDLE_INITIAL ELSE '' END || CASE WHEN cu.SUFFIX IS NOT NULL THEN ' ' || cu.SUFFIX ELSE '' end, 
		   			bpp.LAST_NAME || ', ' || bpp.FIRST_NAME || CASE WHEN bpp.MIDDLE_INITIAL IS NOT NULL THEN ' ' || bpp.MIDDLE_INITIAL ELSE '' END || CASE WHEN bpp.SUFFIX IS NOT NULL THEN ' ' || bpp.SUFFIX ELSE '' end, 
		   			c.comp_name) as own_display,
		   ao.comp_id as own_id,
		   ao.ppl_id as ppl_id,
		   'BUY' as buy_or_sell,
		   'AMS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date,
		   greatest(max(ao.add_date), max(ao.update_date), max(c.add_date), max(c.update_date), 
		   			max(bpp.add_date), max(bpp.update_date), max(cu.add_date), max(cu.update_date), tf.last_update_date) as last_update_date
	from camddmw.transaction_fact tf
	join camdsnap.account_ss a
		on tf.buy_acct_number = a.account_number 
	join camdsnap.account_owner_ss ao
		on a.account_id = ao.account_id 
			and coalesce(ao.comp_id, ao.ppl_id) is not null
	left join camdsnap.company_ss c 
		on ao.comp_id = c.comp_id 
	left join camdams.binding_party_person bpp  
		on ao.ppl_id = bpp.ppl_id  
	left join camd.cdx_user cu  
		on ao.ppl_id = cu.ppl_id
	where tf.buy_account_type_code not in ('UA','UNIT','FACLTY')
		and tf.prg_code not in ('OTC','NBP')
		and not exists (select tod.transaction_id 
							from camddmw.transaction_owner_dim tod 
							where tod.transaction_id = tf.transaction_id
								and tod.prg_code = tf.prg_code)
		and (
			(
				fullrefresh_in
				and date_trunc('day', ao.begin_date) <= date_trunc('day', tf.transaction_date)
				and date_trunc('day', ao.end_date) >= date_trunc('day', tf.transaction_date)						
			)
			or (
				date_trunc('day', tf.add_date) >= incrementalrefreshdate_in
				and (
					(date_trunc('day', tf.transaction_date) <= incrementalrefreshdate_in
						and date_trunc('day', ao.begin_date) <= incrementalrefreshdate_in
						and date_trunc('day', ao.end_date) >= incrementalrefreshdate_in)
					or (date_trunc('day', ao.begin_date) <= date_trunc('day', tf.transaction_date)
						and date_trunc('day', ao.end_date) >= date_trunc('day', tf.transaction_date))
				)		
			)
		)
	group by tf.transaction_id,
		     tf.prg_code,
		     coalesce(cu.LAST_NAME || ', ' || cu.FIRST_NAME || CASE WHEN cu.MIDDLE_INITIAL IS NOT NULL THEN ' ' || cu.MIDDLE_INITIAL ELSE '' END || CASE WHEN cu.SUFFIX IS NOT NULL THEN ' ' || cu.SUFFIX ELSE '' end, 
		   			bpp.LAST_NAME || ', ' || bpp.FIRST_NAME || CASE WHEN bpp.MIDDLE_INITIAL IS NOT NULL THEN ' ' || bpp.MIDDLE_INITIAL ELSE '' END || CASE WHEN bpp.SUFFIX IS NOT NULL THEN ' ' || bpp.SUFFIX ELSE '' end, 
		   			c.comp_name), 
			 ao.comp_id,
			 ao.ppl_id,
			 tf.buy_acct_number
	union all
	-- records for sell account where sell account is not a unit or facility account (AMS) 
	select tf.transaction_id,
		   tf.prg_code,
		   tf.sell_acct_number as account_number,
		   'OWN' as own_type,
		   coalesce(cu.LAST_NAME || ', ' || cu.FIRST_NAME || CASE WHEN cu.MIDDLE_INITIAL IS NOT NULL THEN ' ' || cu.MIDDLE_INITIAL ELSE '' END || CASE WHEN cu.SUFFIX IS NOT NULL THEN ' ' || cu.SUFFIX ELSE '' end, 
		   			bpp.LAST_NAME || ', ' || bpp.FIRST_NAME || CASE WHEN bpp.MIDDLE_INITIAL IS NOT NULL THEN ' ' || bpp.MIDDLE_INITIAL ELSE '' END || CASE WHEN bpp.SUFFIX IS NOT NULL THEN ' ' || bpp.SUFFIX ELSE '' end, 
		   			c.comp_name) as own_display,
		   ao.comp_id as own_id,
		   ao.ppl_id as ppl_id,
		   'SELL' as buy_or_sell,
		   'AMS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date,
		   greatest(max(ao.add_date), max(ao.update_date), max(c.add_date), max(c.update_date), 
		   			max(bpp.add_date), max(bpp.update_date), max(cu.add_date), max(cu.update_date), tf.last_update_date) as last_update_date
	from camddmw.transaction_fact tf
	join camdsnap.account_ss a
		on tf.sell_acct_number = a.account_number 
	join camdsnap.account_owner_ss ao
		on a.account_id = ao.account_id 
			and coalesce(ao.comp_id, ao.ppl_id) is not null
	left join camdsnap.company_ss c 
		on ao.comp_id = c.comp_id 
	left join camdams.binding_party_person bpp  
		on ao.ppl_id = bpp.ppl_id  
	left join camd.cdx_user cu  
		on ao.ppl_id = cu.ppl_id
	where tf.sell_account_type_code not in ('UA','UNIT','FACLTY')
		and tf.prg_code not in ('OTC','NBP')
		and not exists (select tod.transaction_id 
							from camddmw.transaction_owner_dim tod 
							where tod.transaction_id = tf.transaction_id
								and tod.prg_code = tf.prg_code)
		and (
			(
				fullrefresh_in
				and date_trunc('day', ao.begin_date) <= date_trunc('day', tf.transaction_date)
				and date_trunc('day', ao.end_date) >= date_trunc('day', tf.transaction_date)						
			)
			or (
				date_trunc('day', tf.add_date) >= incrementalrefreshdate_in
				and (
					(date_trunc('day', tf.transaction_date) <= incrementalrefreshdate_in
						and date_trunc('day', ao.begin_date) <= incrementalrefreshdate_in
						and date_trunc('day', ao.end_date) >= incrementalrefreshdate_in)
					or (date_trunc('day', ao.begin_date) <= date_trunc('day', tf.transaction_date)
						and date_trunc('day', ao.end_date) >= date_trunc('day', tf.transaction_date))
				)		
			)
		)
	group by tf.transaction_id,
		     tf.prg_code,
		     coalesce(cu.LAST_NAME || ', ' || cu.FIRST_NAME || CASE WHEN cu.MIDDLE_INITIAL IS NOT NULL THEN ' ' || cu.MIDDLE_INITIAL ELSE '' END || CASE WHEN cu.SUFFIX IS NOT NULL THEN ' ' || cu.SUFFIX ELSE '' end, 
		   			bpp.LAST_NAME || ', ' || bpp.FIRST_NAME || CASE WHEN bpp.MIDDLE_INITIAL IS NOT NULL THEN ' ' || bpp.MIDDLE_INITIAL ELSE '' END || CASE WHEN bpp.SUFFIX IS NOT NULL THEN ' ' || bpp.SUFFIX ELSE '' end, 
		   			c.comp_name), 
			 ao.comp_id,
			 ao.ppl_id,
			 tf.sell_acct_number
	union all
	-- records for buy account where buy account is not a unit account (NATS) 
	select tf.transaction_id,
		   tf.prg_code,
		   tf.buy_acct_number as account_number,
		   'OWN' as own_type,
		   coalesce(cu.LAST_NAME || ', ' || cu.FIRST_NAME || CASE WHEN cu.MIDDLE_INITIAL IS NOT NULL THEN ' ' || cu.MIDDLE_INITIAL ELSE '' END || CASE WHEN cu.SUFFIX IS NOT NULL THEN ' ' || cu.SUFFIX ELSE '' end, 
		   			bpp.LAST_NAME || ', ' || bpp.FIRST_NAME || CASE WHEN bpp.MIDDLE_INITIAL IS NOT NULL THEN ' ' || bpp.MIDDLE_INITIAL ELSE '' END || CASE WHEN bpp.SUFFIX IS NOT NULL THEN ' ' || bpp.SUFFIX ELSE '' end, 
		   			c.comp_name) as own_display,
		   ao.own_id as own_id,
		   ao.ppl_id as ppl_id,
		   'BUY' as buy_or_sell,
		   'NATS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date,
		   greatest(max(ao.update_date), max(c.add_date), max(c.update_date), 
		   			max(cu.add_date), max(cu.update_date), tf.last_update_date) as last_update_date
	from camddmw.transaction_fact tf 
	join camdnats.tacct_owner ao
		on tf.buy_acct_number = ao.acctnum_id 
			and coalesce(ao.own_id, ao.ppl_id) is not null
	left join camdsnap.company_ss c 
		on ao.own_id = c.comp_id 
	left join camdnats.tbinding_party_person bpp  
		on ao.ppl_id = bpp.ppl_id  
	left join camd.cdx_user cu  
		on ao.ppl_id = cu.ppl_id
	where tf.buy_account_type_code not in ('UA','UNIT')
		and tf.prg_code in ('OTC','NBP')
		and not exists (select tod.transaction_id 
							from camddmw.transaction_owner_dim tod 
							where tod.transaction_id = tf.transaction_id
								and tod.prg_code = tf.prg_code)
		and (
			(
				fullrefresh_in
				and date_trunc('day', ao.start_date) <= date_trunc('day', tf.transaction_date)
				and date_trunc('day', ao.end_date) >= date_trunc('day', tf.transaction_date)						
			)
			or (
				date_trunc('day', tf.add_date) >= incrementalrefreshdate_in
				and (
					(date_trunc('day', tf.transaction_date) <= incrementalrefreshdate_in
						and date_trunc('day', ao.start_date) <= incrementalrefreshdate_in
						and date_trunc('day', ao.end_date) >= incrementalrefreshdate_in)
					or (date_trunc('day', ao.start_date) <= date_trunc('day', tf.transaction_date)
						and date_trunc('day', ao.end_date) >= date_trunc('day', tf.transaction_date))
				)		
			)
		)
	group by tf.transaction_id,
		     tf.prg_code,
		     coalesce(cu.LAST_NAME || ', ' || cu.FIRST_NAME || CASE WHEN cu.MIDDLE_INITIAL IS NOT NULL THEN ' ' || cu.MIDDLE_INITIAL ELSE '' END || CASE WHEN cu.SUFFIX IS NOT NULL THEN ' ' || cu.SUFFIX ELSE '' end, 
		   			bpp.LAST_NAME || ', ' || bpp.FIRST_NAME || CASE WHEN bpp.MIDDLE_INITIAL IS NOT NULL THEN ' ' || bpp.MIDDLE_INITIAL ELSE '' END || CASE WHEN bpp.SUFFIX IS NOT NULL THEN ' ' || bpp.SUFFIX ELSE '' end, 
		   			c.comp_name), 
			 ao.own_id,
			 ao.ppl_id,
			 tf.buy_acct_number
	union all
	-- records for sell account where sell account is not a unit account (NATS)
	select tf.transaction_id,
		   tf.prg_code,
		   tf.sell_acct_number as account_number,
		   'OWN' as own_type,
		   coalesce(cu.LAST_NAME || ', ' || cu.FIRST_NAME || CASE WHEN cu.MIDDLE_INITIAL IS NOT NULL THEN ' ' || cu.MIDDLE_INITIAL ELSE '' END || CASE WHEN cu.SUFFIX IS NOT NULL THEN ' ' || cu.SUFFIX ELSE '' end, 
		   			bpp.LAST_NAME || ', ' || bpp.FIRST_NAME || CASE WHEN bpp.MIDDLE_INITIAL IS NOT NULL THEN ' ' || bpp.MIDDLE_INITIAL ELSE '' END || CASE WHEN bpp.SUFFIX IS NOT NULL THEN ' ' || bpp.SUFFIX ELSE '' end, 
		   			c.comp_name) as own_display,
		   ao.own_id as own_id,
		   ao.ppl_id as ppl_id,
		   'SELL' as buy_or_sell,
		   'NATS' as data_source,
		   'DMLOAD' as userid,
		   now() as add_date,
		   greatest(max(ao.update_date), max(c.add_date), max(c.update_date), 
		   			max(cu.add_date), max(cu.update_date), tf.last_update_date) as last_update_date
	from camddmw.transaction_fact tf 
	join camdnats.tacct_owner ao
		on tf.sell_acct_number = ao.acctnum_id 
			and coalesce(ao.own_id, ao.ppl_id) is not null
	left join camdsnap.company_ss c 
		on ao.own_id = c.comp_id 
	left join camdnats.tbinding_party_person bpp  
		on ao.ppl_id = bpp.ppl_id  
	left join camd.cdx_user cu  
		on ao.ppl_id = cu.ppl_id
	where tf.sell_account_type_code not in ('UA','UNIT')
		and tf.prg_code in ('OTC','NBP')
		and not exists (select tod.transaction_id 
							from camddmw.transaction_owner_dim tod 
							where tod.transaction_id = tf.transaction_id
								and tod.prg_code = tf.prg_code)
		and (
			(
				fullrefresh_in
				and date_trunc('day', ao.start_date) <= date_trunc('day', tf.transaction_date)
				and date_trunc('day', ao.end_date) >= date_trunc('day', tf.transaction_date)						
			)
			or (
				date_trunc('day', tf.add_date) >= incrementalrefreshdate_in
				and (
					(date_trunc('day', tf.transaction_date) <= incrementalrefreshdate_in
						and date_trunc('day', ao.start_date) <= incrementalrefreshdate_in
						and date_trunc('day', ao.end_date) >= incrementalrefreshdate_in)
					or (date_trunc('day', ao.start_date) <= date_trunc('day', tf.transaction_date)
						and date_trunc('day', ao.end_date) >= date_trunc('day', tf.transaction_date))
				)		
			)
		)
	group by tf.transaction_id,
		     tf.prg_code,
		     coalesce(cu.LAST_NAME || ', ' || cu.FIRST_NAME || CASE WHEN cu.MIDDLE_INITIAL IS NOT NULL THEN ' ' || cu.MIDDLE_INITIAL ELSE '' END || CASE WHEN cu.SUFFIX IS NOT NULL THEN ' ' || cu.SUFFIX ELSE '' end, 
		   			bpp.LAST_NAME || ', ' || bpp.FIRST_NAME || CASE WHEN bpp.MIDDLE_INITIAL IS NOT NULL THEN ' ' || bpp.MIDDLE_INITIAL ELSE '' END || CASE WHEN bpp.SUFFIX IS NOT NULL THEN ' ' || bpp.SUFFIX ELSE '' end, 
		   			c.comp_name), 
			 ao.own_id,
			 ao.ppl_id,
			 tf.sell_acct_number
	on conflict do nothing;
	
	-- update account_owner_id values
	if not fullrefresh_in then
		-- incremental refresh so use existing account_owner_id values when available
		update camddmw.transaction_owner_dim tod	
			set account_owner_id = tod_own.account_owner_id
		from (select own_id, max(account_owner_id) as account_owner_id from transaction_owner_dim where account_owner_id is not null) tod_own
		where tod.account_owner_id is null and tod_own.own_id = tod.own_id;	
		
		update camddmw.transaction_owner_dim tod	
			set account_owner_id = tod_ppl.account_owner_id
		from (select ppl_id, max(account_owner_id) as account_owner_id from transaction_owner_dim where account_owner_id is not null) tod_ppl
		where tod.account_owner_id is null and tod_ppl.ppl_id = tod.ppl_id;
	end if;	
	
	-- fill in remaining account_owner_id values using a sequence
	for vRecord in (select distinct own_id from camddmw.transaction_owner_dim order by own_id)
	loop
		with seq as (select nextval('camddmw.account_owner_dim_seq') as value)
		update camddmw.transaction_owner_dim tod
			set account_owner_id = seq.value
		from seq
		where tod.own_id = vRecord.own_id;
	end loop;

	for vRecord in (select distinct ppl_id from camddmw.transaction_owner_dim order by ppl_id)
	loop
		with seq as (select nextval('camddmw.account_owner_dim_seq') as value)
		update camddmw.transaction_owner_dim tod
			set account_owner_id = seq.value
		from seq
		where tod.ppl_id = vRecord.ppl_id;
	end loop;	
	
	--update transaction_fact own display columns
	with t_own_buy as (select tod.transaction_id, 
						      tod.prg_code, 
						      string_agg(distinct tod.own_display , '|' order by tod.own_display) as own_display
						from camddmw.transaction_owner_dim tod
						where tod.own_type in ('OWN','BTH')
							and tod.buy_or_sell = 'BUY'
						group by tod.transaction_id, tod.prg_code)
	update camddmw.transaction_fact tf
		set buy_own_display_name = t_own_buy.own_display
	from t_own_buy
	where tf.transaction_id = t_own_buy.transaction_id
		and tf.prg_code = t_own_buy.prg_code;
		
	with t_own_sell as (select tod.transaction_id, 
						       tod.prg_code, 
						       string_agg(distinct tod.own_display , '|' order by tod.own_display) as own_display
						 from camddmw.transaction_owner_dim tod
						 where tod.own_type in ('OWN','BTH')
							 and tod.buy_or_sell = 'SELL'
						 group by tod.transaction_id, tod.prg_code)
	update camddmw.transaction_fact tf
		set sell_own_display_name = t_own_sell.own_display
	from t_own_sell
	where tf.transaction_id = t_own_sell.transaction_id
		and tf.prg_code = t_own_sell.prg_code;
	
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
