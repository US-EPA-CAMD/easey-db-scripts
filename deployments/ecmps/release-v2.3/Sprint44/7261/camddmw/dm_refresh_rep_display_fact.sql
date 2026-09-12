create or replace procedure camddmw.dm_refresh_rep_display_fact
(
    in  fullRefresh_in              boolean,
    in  increamentalRefreshDate_in  date,
    out errorJson_out               json,
    out result_out                  boolean
)
as
$$
declare
    cProcedureName constant text := 'dm_refresh_rep_display_fact';

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
    
    ------------------
    -- Refresh Data --
    ------------------
    
    insert
      into  camddmw.REP_DISPLAY_FACT
            ( 
                op_year, unit_id, prg_code, account_number,
                prm_display_name, prm_display_block, alt_display_name, alt_display_block,
                data_source, userid, add_date 
            )
    select  unf.op_year,
            unf.unit_id,
            prc.prg_cd as prg_code,
            unt.account as account_number,
            prm.display_info as prm_display_name,
            prm.display_info as prm_display_block,
            alt.display_info as alt_display_name,
            alt.display_info as alt_display_block,
            'CAMD' as data_source,
            'DMLOAD' as userid,
            now() as add_date
      from  camddmw.UNIT_FACT unf
            join camdsnap.UNIT_SS unt using ( unit_id )
            join camdmd.program_code prc on true
            left join lateral
            (
                select  string_agg
                        (
                            case
                                when ( unf.op_year = extract( year from ryd.begin_date ) ) and ( unf.op_year = extract( year from ryd.end_date ) )
                                then ( ryd.ppl_id || ' (Started ' || to_char( ryd.begin_date, 'Mon dd, yyyy' ) || ') (Ended ' || to_char( ryd.end_date, 'Mon dd, yyyy' ) || ')' )
                                when ( unf.op_year = extract( year from ryd.begin_date ) )
                                then ( ryd.ppl_id || ' (Started ' || to_char( ryd.begin_date, 'Mon dd, yyyy' ) || ')' )
                                when ( unf.op_year = extract( year from ryd.end_date ) )
                                then ( ryd.ppl_id || ' (Ended ' || to_char( ryd.end_date, 'Mon dd, yyyy' ) || ')' )
                                else  ryd.ppl_id::text
                            end,
                            '<br>' order by ryd.begin_date, ryd.end_date
                        ) as display_info
                  from  camddmw.REP_YEAR_DIM ryd
                 where  ryd.op_year = unf.op_year
                   and  ryd.unit_id = unf.unit_id
                   and  ryd.prg_code = prc.prg_cd
                   and  ryd.rep_code = 'PRM'
            ) prm
              on true
            left join lateral
            (
                select  string_agg
                        (
                            case
                                when ( unf.op_year = extract( year from ryd.begin_date ) ) and ( unf.op_year = extract( year from ryd.end_date ) )
                                then ( ryd.ppl_id || ' (Started ' || to_char( ryd.begin_date, 'Mon dd, yyyy' ) || ') (Ended ' || to_char( ryd.end_date, 'Mon dd, yyyy' ) || ')' )
                                when ( unf.op_year = extract( year from ryd.begin_date ) )
                                then ( ryd.ppl_id || ' (Started ' || to_char( ryd.begin_date, 'Mon dd, yyyy' ) || ')' )
                                when ( unf.op_year = extract( year from ryd.end_date ) )
                                then ( ryd.ppl_id || ' (Ended ' || to_char( ryd.end_date, 'Mon dd, yyyy' ) || ')' )
                                else  ryd.ppl_id::text
                            end,
                            '<br>' order by ryd.begin_date, ryd.end_date
                        ) as display_info
                  from  camddmw.REP_YEAR_DIM ryd
                 where  ryd.op_year = unf.op_year
                   and  ryd.unit_id = unf.unit_id
                   and  ryd.prg_code = prc.prg_cd
                   and  ryd.rep_code = 'ALT'
            ) alt
              on true
     where  exists
            (
                select  1
                  from  camddmw.REP_YEAR_DIM exs
                 where  exs.op_year = unf.op_year
                   and  exs.unit_id = unf.unit_id
                   and  exs.prg_code = prc.prg_cd
            )
        on  conflict ( op_year, unit_id, prg_code )
        do  update
               set  prm_display_name     = excluded.prm_display_name,
                    prm_display_block   = excluded.prm_display_block,
                    alt_display_name     = excluded.alt_display_name,
                    alt_display_block   = excluded.alt_display_block,
                    data_source          = excluded.data_source,
                    userid               = excluded.userid,
                    add_date             = excluded.add_date;
    
    
    -- Return Values
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
