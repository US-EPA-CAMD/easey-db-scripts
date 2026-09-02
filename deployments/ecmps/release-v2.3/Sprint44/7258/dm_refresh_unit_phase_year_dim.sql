create or replace procedure camddmw.dm_refresh_unit_phase_year_dim
(
    out errorJson_out             	json,
    out result_out                	boolean
)
as
$$
declare
    cProcedureName constant text := 'dm_refresh_unit_phase_year_dim';

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
	create temp table IF NOT EXISTS unit_phase_year_dim_temp (
		unit_id numeric(12) NOT NULL,
		phase varchar(25) NULL,
		op_year numeric(4) NOT NULL,
		data_source varchar(35) NOT NULL DEFAULT 'CAMD',
		userid varchar(160) NOT NULL DEFAULT 'DMLOAD',
		add_date timestamp NOT NULL DEFAULT now(),
		prg_code varchar(3) NULL DEFAULT 'ARP',
		"parameter" varchar(10) NOT NULL,
		last_update_date timestamp NULL,
		PRIMARY KEY (unit_id, op_year, "parameter")
	) ON COMMIT DROP;

	delete from unit_phase_year_dim_temp;

	-- add ARP SO2 records
	insert into unit_phase_year_dim_temp (unit_id, op_year, phase, "parameter", last_update_date)
	select
		pyd.unit_id,
		pyd.op_year,
		CASE
			WHEN up.optin_ind = 1 
				THEN 'Opt-In'
			WHEN pyd.op_year between 1995 and 1999
				AND up."class" = 'P2'
				AND EXISTS (select upp.up_id 
								from camdsnap.unit_program_phase_ss upp
								where upp.up_id = up.up_id 
									and upp.phase = 'COMPENSATING'
									and upp.begin_year <= pyd.op_year
									and (upp.end_year is null or upp.end_year >= pyd.op_year))
				THEN 'Compensating'
			WHEN pyd.op_year between 1995 and 1999
				AND up."class" = 'P2'
				AND EXISTS (select upp.up_id 
								from camdsnap.unit_program_phase_ss upp
								where upp.up_id = up.up_id 
									and upp.phase = 'SUBSTITUTION'
									and upp.begin_year <= pyd.op_year
									and (upp.end_year is null or upp.end_year >= pyd.op_year))
				THEN 'Substitution'
			WHEN EXISTS (select upp.up_id 
							from camdsnap.unit_program_phase_ss upp
							where upp.up_id = up.up_id 
								and upp.phase = 'OPTIN'
								and upp.begin_year <= pyd.op_year
								and (upp.end_year is null or upp.end_year >= pyd.op_year))
				THEN 'Opt-In'
			WHEN EXISTS (select upp.up_id 
							from camdsnap.unit_program_phase_ss upp
							where upp.up_id = up.up_id 
								and upp.phase = 'COMPENSATING'
								and upp.begin_year <= pyd.op_year
								and (upp.end_year is null or upp.end_year >= pyd.op_year))
				THEN 'Compensating'
			WHEN EXISTS (select upp.up_id 
							from camdsnap.unit_program_phase_ss upp
							where upp.up_id = up.up_id 
								and upp.phase = 'SUBSTITUTION'
								and upp.begin_year <= pyd.op_year
								and (upp.end_year is null or upp.end_year >= pyd.op_year))
				THEN 'Substitution'
			WHEN up."class" = 'P1'
				THEN 'Table 1'
			WHEN up."class" = 'P2'
				THEN 'Phase 2'
			ELSE
				NULL			 
		END as phase,
		'SO2' as "parameter",
		greatest(up.add_date, up.update_date, pyd.last_update_date) as last_update_date
	from
		camddmw.program_year_dim pyd	
	inner join camdsnap.unit_program_ss up on
		pyd.unit_id = up.unit_id
		and pyd.prg_code = up.prg_code
	where pyd.prg_code = 'ARP';

	-- add ARP NOx records
	insert into unit_phase_year_dim_temp (unit_id, op_year, phase, "parameter", last_update_date)
	select
		pyd.unit_id,
		pyd.op_year,
		CASE
			WHEN up.ee_ind = 1 
				THEN 'Early Election'
			WHEN up.nox_group = 2 
				THEN 'Phase 2 Group 2'
			WHEN up.nox_group = 1 
				AND up.nox_phase = 1  
				THEN 'Phase 1 Group 1'
			WHEN up.nox_group = 1 
				AND up.nox_phase = 2 
				THEN 'Phase 2 Group 1'			 
		END as phase,
		'NOX' as "parameter",
		greatest(up.add_date, up.update_date, pyd.last_update_date) as last_update_date
	from
		camddmw.program_year_dim pyd	
	inner join camdsnap.unit_program_ss up on
		pyd.unit_id = up.unit_id
		and pyd.prg_code = up.prg_code
	where pyd.prg_code = 'ARP'
		and up.nox_year is not null
		and up.nox_year <= pyd.op_year;

	-- delete records from unit_phase_dim that are not in unit_phase_year_dim_temp
	delete from camddmw.unit_phase_year_dim upyd
		where not exists (select unit_id 
							from unit_phase_year_dim_temp upydt 
							where upydt.unit_id = upyd.unit_id
								and upydt.op_year = upyd.op_year  
								and upydt."parameter" = upyd."parameter");

	-- update records in unit_phase_year_dim where data is different in unit_phase_year_dim_temp
	-- insert records into unit_phase_year_dim that are in unit_phase_year_dim_temp that are not in unit_phase_year_dim
	insert into camddmw.unit_phase_year_dim 
		(unit_id, op_year, phase, prg_code, "parameter", last_update_date, data_source, userid, add_date)
	select unit_id, op_year, phase, prg_code, "parameter", last_update_date, data_source, userid, add_date
		from unit_phase_year_dim_temp
	on conflict (unit_id, op_year, "parameter")
	do update set 
		phase = excluded.phase,
		prg_code = excluded.prg_code,
		last_update_date = excluded.last_update_date,
		data_source = excluded.data_source,
		userid = excluded.userid,
		add_date = excluded.add_date
	where unit_phase_year_dim.phase <> excluded.phase
		or unit_phase_year_dim.prg_code <> excluded.prg_code
		or unit_phase_year_dim.last_update_date <> excluded.last_update_date
		or unit_phase_year_dim.data_source <> excluded.data_source
		or unit_phase_year_dim.userid <> excluded.userid
		or unit_phase_year_dim.add_date <> excluded.add_date;

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

