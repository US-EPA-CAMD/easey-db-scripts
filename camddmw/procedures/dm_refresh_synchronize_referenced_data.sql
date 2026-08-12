create or replace function camddmw.dm_refresh_update_supporting_data
(
    out errorJson_out   json,
    out result_out      boolean
)
as
$$
declare
    cProcedureName constant text := 'dm_refresh_update_supporting_data';

    vCurrentDate    date        := current_date;
    
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
    
    -- Insert a new VALID_YEAR row for the previous quarter if it does not exist.
    insert
      into  camddmw.VALID_YEAR
            ( valid_year, op_quarter, data_status, hrly, enabled )
    select  prv.year as valid_year,
            prv.quarter as op_quarter,
            'P' as data_status,
            'T' as hrly,
            '1' as enabled
      from  (
              -- Determine the first day of the current quarter then the last day of the previous quarter,
              -- and get the year and quarter of that quarter
              select  extract( year from ( date_trunc('quarter', vCurrentDate)::date - 1 ) ) as year, -- Get year of previous quarter.
                      extract( quarter from ( date_trunc('quarter', vCurrentDate)::date - 1 ) ) as quarter -- Get quarter of previous quarter.
            ) prv
     where  -- Only insert if row does not already exist.
            not exists
            (
                select  1
                  from  camddmw.VALID_YEAR exs
                 where  exs.valid_year = prv.year
                   and  exs.op_quarter = prv.quarter
            );
    
    -- Insert a new VALID_YEAR row for the current quarter if it is the first quarter and does not exist.
    insert
      into  camddmw.VALID_YEAR
            ( valid_year, op_quarter, data_status, hrly, enabled )
    select  cur.year as valid_year,
            cur.quarter as op_quarter,
            'P' as data_status,
            'T' as hrly,
            '1' as enabled
      from  (
              -- Determine the first day of the current quarter then the last day of the previous quarter,
              -- and get the year and quarter of that quarter
              select  extract( year from vCurrentDate ) as year, -- Get year of previous quarter.
                      extract( quarter from vCurrentDate ) as quarter -- Get quarter of previous quarter.
            ) cur
     where  cur.quarter = 1
            -- Only insert if row does not already exist.
       and  not exists
            (
                select  1
                  from  camddmw.VALID_YEAR exs
                 where  exs.valid_year = cur.year
                   and  exs.op_quarter = cur.quarter
            );
    
    
    -- Add VALID_YEAR to ALLOWANCE_VALID_YEAR that do not exist but exist in VALID_YEAR.
    insert
      into  camddmw.ALLOWANCE_VALID_YEAR
            ( valid_year )
    select  distinct
            vyr.VALID_YEAR
      from  camddmw.VALID_YEAR vyr
     where  not exists
            (
                select  1
                  from  camddmw.ALLOWANCE_VALID_YEAR exs
                 where  exs.valid_year = vyr.valid_year
            );
    
    
    -- Repopulate STATE_ALTERNATE_OZONE_BEGAN from PROGRAM_SS
    delete
      from  camddmw.STATE_ALTERNATE_OZONE_BEGAN;
    
    insert
      into  camddmw.STATE_ALTERNATE_OZONE_BEGAN
            ( state, year, date_began )
    select  prg.state,
            extract( year from prg.begin_date ) as year,
            prg.begin_date
      from  camdsnap.PROGRAM_SS prg
     where  extract( year from prg.begin_date ) = 2004;
    
    
    -- Return Value
    errorJson_out := null;
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