create or replace procedure camddmw.dm_refresh_unit_compliance_dim
(
    in  fullRefresh_in              boolean,
    in  increamentalRefreshDate_in  date,
    out errorJson_out               json,
    out result_out                  boolean
)
as
$$
declare
    cProcedureName constant text := 'dm_refresh_unit_compliance_dim';

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
      into  camddmw.UNIT_COMPLIANCE_DIM
            ( 
                unit_id, op_year, opr_display, comp_plan_type_cd, avg_plan_id, in_compliance,
                emiss_limit, act_emiss_rate, avg_plan_emiss_limit, avg_plan_act_emiss_rate, penalty_amount, emiss_limit_display, excess_emiss,
                data_source, userid, add_date, last_update_date
            )
    select  ncp.unit_id,
            prv.vintage_year as op_year,
            odf.opr_display as opr_display,
            nct.comp_plan_type_cd_description as comp_plan_type_cd,
            case
                when ( ncp.comp_plan_type_cd = 'AVGPLAN' ) then
                (
                    select  max( uap.avg_plan_id )
                      from  camdsnap.NOX_UNIT_AVG_PLAN_SS uap
                     where  uap.unit_id = ncp.unit_id
                       and  uap.begin_date <= to_date( prv.vintage_year || '-01-01', 'yyyy-mm=dd' )
                       and  ( uap.end_date is null or uap.end_date >= to_date( prv.vintage_year || '-12-31', 'yyyy-mm=dd' ) )
                )
                else null
            end as avg_plan_id,
            case
                when ( ncr.excess_nox_mass is not null ) and ( ncr.excess_nox_mass > 0 )
                then 'NO'
                else 'YES'
            end as in_compliance,
            ncr.allw_nox_rate as emiss_limit,
            ncr.act_nox_rate as act_emiss_rate,
            case
                when ( ncp.comp_plan_type_cd = 'AVGPLAN' )
                then ncr.avg_plan_allw_nox_rate
                else null
            end as avg_plan_emiss_limit,
            case
                when ( ncp.comp_plan_type_cd = 'AVGPLAN' )
                then ncr.avg_plan_act_nox_rate
                else null
            end as avg_plan_act_emiss_rate,
            ncr.penalty_amount,
            case
                when ( ncp.comp_plan_type_cd = 'AVGPLAN' )
                then ncr.avg_plan_allw_nox_rate
                else ncr.allw_nox_rate
            end as emiss_limit_display,
            case
                when ( ncr.excess_nox_mass is not null ) and ( ncr.excess_nox_mass > 0 )
                then ncr.excess_nox_mass
                else null
            end as excess_emiss,
            'AMS' as data_source,
            'DMLOAD' as userid,
            now() as add_date,
            max( greatest( ncr.add_date, ncr.update_date, odf.last_update_date ) ) as last_update_date
      from  camdsnap.NOX_COMP_PLAN_SS ncp
            join camdmd.NOX_COMP_PLAN_TYPE_CODE nct using ( comp_plan_type_cd )
            join camdsnap.NOX_COMP_PLAN_RESULT_SS ncr using ( comp_plan_id )
            join camdsnap.COMPLIANCE_PERIOD_SS cmp using ( comp_period_id )
            join camdsnap.PROGRAM_VINTAGE_SS prv using ( prg_vintage_id )
            left join camddmw.OWNER_DISPLAY_FACT odf
              on odf.unit_id = ncp.unit_id
             and odf.op_year = prv.vintage_year
     where  ncr.final_ind = 1
       and  exists
            (
                select  1
                  from  camddmw.UNIT_FACT exs
                 where  exs.op_year = prv.vintage_year
                   and  exs.unit_id = ncp.unit_id
            )
       and  (
                fullRefresh_in
                or
                ncr.add_date >= increamentalRefreshDate_in
                or
                ncr.update_date >= increamentalRefreshDate_in
                or
                odf.last_update_date >= increamentalRefreshDate_in
            )
     group
        by  ncp.unit_id,
            prv.vintage_year,
            ncr.comp_period_id,
            odf.opr_display,
            ncp.comp_plan_type_cd,
            ncp.comp_plan_id,
            ncr.allw_nox_rate,
            ncr.avg_plan_allw_nox_rate,
            ncr.act_nox_rate,
            ncr.avg_plan_act_nox_rate,
            ncr.excess_nox_mass,
            nct.comp_plan_type_cd_description,
            ncr.penalty_amount
        on  conflict ( unit_id, op_year )
        do  update
               set  opr_display             = excluded.opr_display,
                    comp_plan_type_cd       = excluded.comp_plan_type_cd,
                    avg_plan_id             = excluded.avg_plan_id,
                    in_compliance           = excluded.in_compliance,
                    emiss_limit             = excluded.emiss_limit,
                    act_emiss_rate          = excluded.act_emiss_rate,
                    avg_plan_emiss_limit    = excluded.avg_plan_emiss_limit,
                    avg_plan_act_emiss_rate = excluded.avg_plan_act_emiss_rate,
                    penalty_amount          = excluded.penalty_amount,
                    emiss_limit_display     = excluded.emiss_limit_display,
                    excess_emiss            = excluded.excess_emiss,
                    data_source             = excluded.data_source,
                    userid                  = excluded.userid,
                    add_date                = excluded.add_date,
                    last_update_date        = excluded.last_update_date;
    
    
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
