create or replace procedure camddmw.dm_refresh_control_year_dim
(
    in  fullRefresh_in              boolean,
    in  increamentalRefreshDate_in  date,
    out errorJson_out               json,
    out result_out                  boolean
)
as
$$
declare
    cProcedureName constant text := 'dm_refresh_control_year_dim';

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
      into  camddmw.CONTROL_YEAR_DIM
            ( op_year, unit_id, parameter, control_code, control_description, indicator, data_source, userid, add_date, last_update_date )
    select  oyr.op_year,
            unc.unit_id,
            unc.ce_param as parameter,
            unc.control_cd as control_code,
            cnc.control_description,
            min( unc.indicator_cd ) as indicator, -- 'P if any 'P', otherwise 'S' if any 'S', otherwise null.  Assumes only 'P', 'S' and null will occurr.
            'CAMD' as data_source,
            'DMLOAD' as userid,
            max( now() ) as add_date,
            max
            (
                greatest
                (
                    unc.add_date, unc.update_date, unt.add_date, unt.update_date,
                    ( select max( greatest( add_date, update_date ) ) from camdsnap.UNIT_OP_STATUS_SS uos where uos.unit_id = unc.unit_id and uos.end_date is null )
                )
            ) as last_update_date
      from  (
                select  op_year,
                        op_year_min
                  from  (
                            select  min( unf.op_year ) as op_year_min,
                                    max( unf.op_year ) as op_year_max
                              from  camddmw.UNIT_FACT unf
                        ) rng,
                        generate_series( rng.op_year_min, rng.op_year_max ) as op_year
            ) oyr
            join camdsnap.UNIT_CONTROL_SS unc
              on case
                    when ( unc.install_date is not null )
                    then ( extract( year from unc.install_date ) <= oyr.op_year )
                    when ( unc.opt_date is not null )
                    then ( extract( year from unc.opt_date ) <= oyr.op_year )
                    else true -- Later checking will determine whether the op_year applies to the UNIT_CONTROL_SS row.
                 end
             and ( ( unc.retire_date is null ) or ( extract( year from unc.retire_date ) >= oyr.op_year ) )
            join camdsnap.UNIT_SS unt
              on unt.unit_id = unc.unit_id
             and case
                    when ( ( unc.install_date is not null ) or ( unc.opt_date is not null ) )
                    then true -- Earlier checking determined whether the op_year applies to the UNIT_CONTROL_SS row.
                    when ( ( unc.orig_cd = '1' ) and ( coalesce( unt.comm_op_date, unt.comr_op_date ) is not null ) )
                    then ( extract( year from coalesce( unt.comm_op_date, unt.comr_op_date ) ) <= oyr.op_year )
                    else true -- Later checking will determine whether the op_year applies to the UNIT_CONTROL_SS row.
                 end
            join camddmw.UNIT_FACT unf 
              on unf.op_year = oyr.op_year
             and unf.unit_id = unt.unit_id
            join camdecmpsmd.CONTROL_CODE cnc using ( control_cd )
     where  (
                -- Earlier checking determined whether the op_year applies to the UNIT_CONTROL_SS row.
                ( ( unc.install_date is not null ) or ( unc.opt_date is not null ) )
                or
                ( ( unc.orig_cd = '1' ) and ( coalesce( unt.comm_op_date, unt.comr_op_date ) is not null ) )
                or
                -- Unit Status determines whether the op_year applies to the UNIT_CONTROL_SS row if above checking has not.
                exists
                (
                    select  1
                      from  camdsnap.UNIT_OP_STATUS_SS exs
                     where  exs.unit_id = unt.unit_id
                       and  exs.end_date is null
                       and  case
                                when exs.op_status in ( 'LTCS', 'RET' )
                                then oyr.op_year_min <= oyr.op_year
                                when exs.op_status in ( 'FUT', 'OPR' )
                                then extract( year from unt.add_date ) <= oyr.op_year
                                else false
                            end
                )
            )
       and  ( fullRefresh_in or ( greatest( unc.add_date, unc.update_date, unf.add_date ) >= increamentalRefreshDate_in ) )
     group
        by  oyr.op_year,
            unc.unit_id,
            unc.ce_param,
            unc.control_cd,
            cnc.control_description
        on  conflict( op_year, unit_id, parameter, control_code )
        do  update
               set  control_description     = excluded.control_description,
                    indicator               = excluded.indicator,
                    data_source             = excluded.data_source,
                    userid                  = excluded.userid,
                    add_date                = excluded.add_date,
                    last_update_date        = excluded.last_update_date
             where  (
                        ( coalesce( excluded.control_description, '' ) != coalesce( control_year_dim.control_description, '' ) )
                        or
                        ( coalesce( excluded.indicator, '' ) != coalesce( control_year_dim.indicator, '' ) )
                        or
                        ( excluded.last_update_date != control_year_dim.last_update_date )
                    );
    
    
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