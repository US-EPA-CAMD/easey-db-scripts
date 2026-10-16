create or replace procedure camddmw.dm_refresh_owner_display_fact
(
    in  fullRefresh_in              boolean,
    in  increamentalRefreshDate_in  date,
    out errorJson_out               json,
    out result_out                  boolean
)
as
$$
declare
    cProcedureName constant text := 'dm_refresh_owner_display_fact';

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
      into  camddmw.OWNER_DISPLAY_FACT
            ( 
                unit_id, op_year, own_display, opr_display,
                data_source, userid, add_date, last_update_date
            )
    select  unf.unit_id,
            unf.op_year,
            string_agg
            (
                case 
                    when own.ont_type_cd in ( 'OWN', 'BTH' ) then
                        cmp.comp_name || ' (' || otc.owner_type_description || ')' ||
                        case
                            when ( unf.op_year > 2003 ) and 
                                 ( extract( year from own.begin_date ) = unf.op_year ) and
                                 ( extract( month from own.begin_date ) != 1 or extract( day from own.begin_date ) != 1 )
                            then ' (Started ' || to_char( own.begin_date, 'Mon dd, yyyy' ) || ')'
                            else ''
                        end ||
                        case
                            when ( extract( year from own.end_date ) = unf.op_year ) and
                                 ( extract( month from own.end_date ) != 12 or extract( day from own.end_date ) != 31 )
                            then ' (Ended ' || to_char( own.end_date, 'Mon dd, yyyy' ) || ')'
                            else ''
                        end
                end,
                '|' order by own.begin_date, own.own_id
            ) as own_display,
            string_agg
            (
                case 
                    when own.ont_type_cd in ( 'OPR', 'BTH' ) then
                        cmp.comp_name || ' (' || otc.owner_type_description || ')' ||
                        case
                            when ( unf.op_year > 2003 ) and 
                                 ( extract( year from own.begin_date ) = unf.op_year ) and
                                 ( extract( month from own.begin_date ) != 1 or extract( day from own.begin_date ) != 1 )
                            then ' (Started ' || to_char( own.begin_date, 'Mon dd, yyyy' ) || ')'
                            else ''
                        end ||
                        case
                            when ( extract( year from own.end_date ) = unf.op_year ) and
                                 ( extract( month from own.end_date ) != 12 or extract( day from own.end_date ) != 31 )
                            then ' (Ended ' || to_char( own.end_date, 'Mon dd, yyyy' ) || ')'
                            else ''
                        end
                end,
                '|' order by own.begin_date, own.own_id
            ) as opr_display,
            'CAMD' as data_source,
            'DMLOAD' as userid,
            now() as add_date,
            (
                select  max( oyd.last_update_date )
                  from  camddmw.OWNER_YEAR_DIM oyd
                 where  oyd.unit_id = unf.unit_id
                   and  oyd.op_year = unf.op_year
            ) as last_update_date
      from  camddmw.UNIT_FACT unf
            join camdsnap.UNIT_OWNER_SS own
              on own.unit_id = unf.unit_id
             and extract( year from own.begin_date ) <= unf.op_year
             and ( own.end_date is null or extract( year from own.end_date ) >= unf.op_year )
            join camdsnap.COMPANY_SS cmp
              on cmp.comp_id = own.own_id
            join camdmd.OWNER_TYPE_CODE otc
              on otc.owner_type_cd = own.ont_type_cd
     where  exists
            (
                select  1
                  from  camddmw.OWNER_YEAR_DIM oyd
                 where  oyd.unit_id = unf.unit_id
                   and  oyd.op_year = unf.op_year
            )
     group
        by  unf.unit_id,
            unf.op_year
        on  conflict ( unit_id, op_year )
        do  update
               set  own_display         = excluded.own_display,
                    opr_display         = excluded.opr_display,
                    data_source         = excluded.data_source,
                    userid              = excluded.userid,
                    add_date            = excluded.add_date,
                    last_update_date    = excluded.last_update_date;
    
    
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
