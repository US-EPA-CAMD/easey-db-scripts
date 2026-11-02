create or replace procedure camddmw.dm_refresh_rep_year_dim
(
    in  fullRefresh_in              boolean,
    in  increamentalRefreshDate_in  date,
    out errorJson_out               json,
    out result_out                  boolean
)
as
$$
declare
    cProcedureName constant text := 'dm_refresh_rep_year_dim';

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
    
    -----------------------
    -- Create Temp Table --
    -----------------------
    raise notice 'Create Temp Table';
    
    create temp table REP_YEAR_DIM_TEMP
    (
        unit_id                 numeric(12)     null,
        op_year                 numeric(4)      null,
        ppl_id                  numeric(12)     null,
        prg_code                varchar(8)      null,
        is_program_specific     boolean         null,
        rep_code                varchar(6)      null,
        begin_date              timestamp(0)    null,
        end_date                timestamp(0)    null,
        data_source             varchar(35)     null,
        userid                  varchar(160)    null,
        add_date                timestamp(0)    null,
        constraint REP_YEAR_DIM_TEMP_UQ unique ( unit_id, op_year, ppl_id, prg_code, is_program_specific, rep_code, begin_date )
    ) on commit preserve rows;
    
    -------------------------
    -- Create Temp Indexes --
    -------------------------
    raise notice 'Create Temp Indexes';
        
    /*
        Creating index used for updating non-program-specific rows where the begin and end dates
        span December 8, 2017, the date on which program-specific rep rows were replaced by
        non-program-specific (NPS) rows.  Those NPS rows contain the earliest begin date for the
        combination of identifying columns instead of the begin date for the program-specifc
        row that was ended on December 8, 2017 and replaced by the NPS row.
        
        This index will identify the NPS rows in REP_YEAR_DIM_TEMP that may need to be updates.
    */
    create index REP_YEAR_DIM_TEMP_NPS_IX
              on REP_YEAR_DIM_TEMP ( unit_id, op_year, ppl_id, prg_code, rep_code )
           where not is_program_specific
             and begin_date::date <= '2017-12-08'
             and ( end_date is null or end_date::date >= '2017-12-08' );
    
    
    ---------------------------------------------
    -- Generate Ended Program Specific Records --
    ---------------------------------------------
    raise notice 'Generate Ended Program Specific Records';
    
    insert
      into  REP_YEAR_DIM_TEMP
            ( unit_id, op_year, ppl_id, prg_code, is_program_specific, rep_code, begin_date, end_date, data_source, userid, add_date )
    select  cmb.unit_id,
            cmb.op_year,
            cmb.ppl_id,
            cmb.prg_code,
            cmb.is_program_specific,
            cmb.rep_code,
            cmb.begin_date,
            cmb.end_date,
            cmb.data_source,
            'DMLOAD' as userid,
            now() as add_date
      from  (
                select  unp.unit_id,
                        unf.op_year,
                        unp.ppl_id,
                        prg.prg_code,
                        unp.responsibility_id as rep_code,
                        unp.begin_date,
                        max( unp.end_date ) as end_date,
                        true as is_program_specific,
                        'CAMD_OLD' as data_source
                  from  camdsnap.UNIT_PEOPLE_SS unp
                        join camddmw.UNIT_FACT unf
                          on unf.op_year >= extract( year from unp.begin_date )
                         and ( unp.end_date is null or unf.op_year <= extract( year from unp.end_date ) )
                         and unf.unit_id = unp.unit_id
                        join camdsnap.PROGRAM_SS prg using ( prg_id )
                 where  unp.prg_id is not null
                   and  unp.end_date is not null
                   and  unp.end_date::date != '2017-12-08'::date
                   and  unp.responsibility_id in ( 'PRM', 'ALT' )
                 group
                    by  unf.op_year,
                        unp.unit_id,
                        unp.ppl_id,
                        prg.prg_code,
                        unp.responsibility_id,
                        unp.begin_date
            ) cmb
        on  conflict ( unit_id, op_year, ppl_id, prg_code, is_program_specific, rep_code, begin_date )
        do  update
               set  end_date        = excluded.end_date,
                    data_source     = excluded.data_source, --? Check this
                    userid          = excluded.userid,
                    add_date        = excluded.add_date
             where  ( excluded.end_date is null or excluded.end_date > rep_year_dim_temp.end_date ); --? Check this.
    
    
    -----------------------------------------------
    -- Generate Active Facility Specific Records --
    -----------------------------------------------
    raise notice 'Generate Active Facility Specific Records';
    
    insert
      into  REP_YEAR_DIM_TEMP
            ( unit_id, op_year, ppl_id, prg_code, is_program_specific, rep_code, begin_date, end_date, data_source, userid, add_date )
    select  cmb.unit_id,
            cmb.op_year,
            cmb.ppl_id,
            cmb.prg_code,
            cmb.is_program_specific,
            cmb.rep_code,
            cmb.begin_date,
            cmb.end_date,
            cmb.data_source,
            'DMLOAD' as userid,
            now() as add_date
      from  (
                select  pyd.unit_id,
                        pyd.op_year,
                        fcp.ppl_id,
                        pyd.prg_code, --? Apparently null in existing code
                        fcp.responsibility_id as rep_code,
                        fcp.begin_date,
                        max( fcp.end_date ) as end_date,
                        false as is_program_specific,
                        'CAMD_NULL' as data_source
                  from  camdsnap.FACILITY_PEOPLE_SS fcp
                        join camdsnap.UNIT_SS unt using ( fac_id )
                        join camddmw.UNIT_FACT unf
                          on unf.op_year >= extract( year from fcp.begin_date )
                         and ( fcp.end_date is null or unf.op_year <= extract( year from fcp.end_date ) )
                         and unf.unit_id = unt.unit_id
                        join camddmw.PROGRAM_YEAR_DIM pyd
                          on pyd.op_year = unf.op_year
                         and pyd.unit_id = unf.unit_id
                 where  fcp.prg_id is null
                   and  fcp.end_date is null
                   and  fcp.responsibility_id in ( 'PRM', 'ALT' )
                 group
                    by  pyd.op_year,
                        pyd.unit_id,
                        fcp.ppl_id,
                        pyd.prg_code, --? Not included in the requirements but strangly included in the old code
                        fcp.responsibility_id,
                        fcp.begin_date
            ) cmb
        on  conflict ( unit_id, op_year, ppl_id, prg_code, is_program_specific, rep_code, begin_date )
        do  update
               set  end_date        = excluded.end_date,
                    data_source     = excluded.data_source, --? Check this
                    userid          = excluded.userid,
                    add_date        = excluded.add_date
             where  ( excluded.end_date is null or excluded.end_date > rep_year_dim_temp.end_date ); --? Check this.
    
    
    --------------------------------------
    -- Generate Remaining Ended Records --
    --------------------------------------
    raise notice 'Generate Remaining Ended Records';
    
    insert
      into  REP_YEAR_DIM_TEMP
            ( unit_id, op_year, ppl_id, prg_code, is_program_specific, rep_code, begin_date, end_date, data_source, userid, add_date )
    select  cmb.unit_id,
            cmb.op_year,
            cmb.ppl_id,
            cmb.prg_code,
            cmb.is_program_specific,
            cmb.rep_code,
            cmb.begin_date,
            cmb.end_date,
            cmb.data_source,
            'DMLOAD' as userid,
            now() as add_date
      from  (
                select  pyd.unit_id,
                        pyd.op_year,
                        fcp.ppl_id,
                        pyd.prg_code,
                        fcp.responsibility_id as rep_code,
                        fcp.begin_date,
                        max( fcp.end_date ) as end_date,
                        ( fcp.prg_id is not null ) as is_program_specific,
                        'CAMD' as data_source
                  from  camdsnap.FACILITY_PEOPLE_SS fcp
                        join camdsnap.UNIT_SS unt using ( fac_id )
                        join camddmw.UNIT_FACT unf
                          on unf.op_year >= extract( year from fcp.begin_date )
                         and ( fcp.end_date is null or unf.op_year <= extract( year from fcp.end_date ) )
                         and unf.unit_id = unt.unit_id
                        join camdsnap.UNIT_PROGRAM_SS unp
                          on unp.unit_id = unf.unit_id
                         and ( fcp.prg_id is null or unp.prg_id = fcp.prg_id )
                        join camddmw.PROGRAM_YEAR_DIM pyd
                          on pyd.op_year = unf.op_year
                         and pyd.unit_id = unf.unit_id
                         and pyd.prg_code = unp.prg_code
                 where  fcp.end_date is not null
                   and  fcp.end_date::date != '2017-12-08'::date
                   and  fcp.responsibility_id in ( 'PRM', 'ALT' )
                 group  --? Group by is under end_date in the requirements
                    by  pyd.op_year,
                        pyd.unit_id,
                        fcp.ppl_id,
                        pyd.prg_code, --? Not included in the requirements
                        fcp.responsibility_id,
                        fcp.begin_date,
                        ( fcp.prg_id is not null )
            ) cmb
        on  conflict ( unit_id, op_year, ppl_id, prg_code, is_program_specific, rep_code, begin_date )
        do  update
               set  end_date        = excluded.end_date,
                    data_source     = excluded.data_source, --? Check this
                    userid          = excluded.userid,
                    add_date        = excluded.add_date
             where  rep_year_dim_temp.end_date is null; --or excluded.end_date > rep_year_dim_temp.end_date ); --? Check this.
    
    
    -------------------------------------------------------------------------
    -- Generate Program-Specific Replacements w/o Program Year Dim Records --
    -------------------------------------------------------------------------
    raise notice 'Generate Program-Specific Replacements w/o Program Year Dim Records';
    
    insert
      into  REP_YEAR_DIM_TEMP
            ( unit_id, op_year, ppl_id, prg_code, is_program_specific, rep_code, begin_date, end_date, data_source, userid, add_date )
    select  cmb.unit_id,
            cmb.op_year,
            cmb.ppl_id,
            cmb.prg_code,
            cmb.is_program_specific,
            cmb.rep_code,
            cmb.begin_date,
            fcp.end_date,
            cmb.data_source,
            'DMLOAD' as userid,
            now() as add_date
      from  (
                select  unp.unit_id,
                        unf.op_year,
                        unp.ppl_id,
                        prg.prg_code,
                        unp.responsibility_id as rep_code,
                        unp.begin_date,
                        max( unp.end_date ) as end_date,
                        true as is_program_specific,
                        'REPLACE' as data_source,
                        unf.fac_id
                  from  camdsnap.UNIT_PEOPLE_SS unp
                        join camddmw.UNIT_FACT unf
                          on unf.op_year >= extract( year from unp.begin_date )
                         and ( unp.end_date is null or unf.op_year <= extract( year from unp.end_date ) )
                         and unf.unit_id = unp.unit_id
                        join camdsnap.PROGRAM_SS prg using ( prg_id )
                 where  unp.prg_id is not null
                   and  unp.end_date is not null
                   and  unp.end_date::date = '2017-12-08'::date
                   and  unp.responsibility_id in ( 'PRM', 'ALT' )
                 group
                    by  unf.op_year,
                        unp.unit_id,
                        unp.ppl_id,
                        prg.prg_code,
                        unp.responsibility_id,
                        unp.begin_date,
                        unf.fac_id
            ) cmb
            left join camdsnap.FACILITY_PEOPLE_SS fcp
              on fcp.fac_id = cmb.fac_id
             and extract( year from fcp.begin_date ) <= cmb.op_year
             and ( fcp.end_date is null or extract( year from fcp.end_date ) >= cmb.op_year )
             and fcp.ppl_id = cmb.ppl_id
             and fcp.responsibility_id = cmb.rep_code
             and fcp.prg_id is null
             and fcp.begin_date::date <= '2017-12-08'
             and ( fcp.end_date is null or fcp.end_date > '2017-12-08' )
     where  not exists
            (
                select  1
                  from  camddmw.PROGRAM_YEAR_DIM pyd
                 where  pyd.unit_id = cmb.unit_id
                   and  pyd.op_year = cmb.op_year
                   and  pyd.prg_code = cmb.prg_code
            )
        on  conflict ( unit_id, op_year, ppl_id, prg_code, is_program_specific, rep_code, begin_date )
        do  update
               set  end_date        = excluded.end_date,
                    data_source     = excluded.data_source, --? Check this
                    userid          = excluded.userid,
                    add_date        = excluded.add_date
             where  ( excluded.end_date is null or excluded.end_date > rep_year_dim_temp.end_date ); --? Check this.
    
    
    ----------------------------
    -- Analyze the Temp Table --
    ----------------------------
    raise notice 'Analyze the Temp Table';
    
    analyze REP_YEAR_DIM_TEMP;
    
    
    --------------------------------------------------------------------------------------------------
    -- Update Begin Dates for Non-Program-Specific Temp Tables Rows Replacing Program-Specific Rows --
    --------------------------------------------------------------------------------------------------
    raise notice 'Update Begin Dates for Non-Program-Specific Temp Tables Rows Replacing Program-Specific Rows';
    
    update  REP_YEAR_DIM_TEMP tmp
       set  begin_date = unp.begin_date
      from  camdsnap.UNIT_PEOPLE_SS unp
            join camdsnap.PROGRAM_SS prg using ( prg_id )
     where  -- REP_YEAR_DIM_TEMP rows are not program-specific and begin and end date range span 2017-12-08.
            not tmp.is_program_specific
       and  tmp.begin_date::date <= '2017-12-08'
       and  ( tmp.end_date is null or tmp.end_date::date > '2017-12-08' )
            -- UNIT_PEOPLE_SS/PROGRAM_SS join conditions
       and  unp.unit_id = tmp.unit_id
       and  extract( year from unp.begin_date ) <= tmp.op_year
       and  ( unp.end_date is null or extract( year from unp.end_date ) >= tmp.op_year )
       and  unp.ppl_id = tmp.ppl_id
       and  prg.prg_code = tmp.prg_code
       and  unp.responsibility_id = tmp.rep_code
            -- UNIT_PEOPLE_SS rows are program-specific, have an end date of December 8, 2017, and are for Primary or Alt Reps.
       and  unp.prg_id is not null
       and  unp.end_date is not null
       and  unp.end_date::date = '2017-12-08'::date
       and  unp.responsibility_id in ( 'PRM', 'ALT' );
    
    
    -----------------------------------
    -- Refresh Program Specific Data --
    -----------------------------------
    raise notice 'Refresh Program Specific Data';
    
    insert
      into  camddmw.REP_YEAR_DIM
            ( 
                unit_id, op_year, ppl_id, prg_code, rep_code, begin_date, end_date,
                data_source, userid, add_date
            )
    select  tmp.unit_id,
            tmp.op_year,
            tmp.ppl_id,
            tmp.prg_code,
            tmp.rep_code,
            tmp.begin_date,
            tmp.end_date,
            ( tmp.data_source || ' Insert B' ) as data_source,
            tmp.userid,
            tmp.add_date
      from  REP_YEAR_DIM_TEMP tmp
     where  tmp.is_program_specific
       and  (
                -- unit_id, op_year, prg_code, ppl_id, and rep_code combination does not exist.
                not exists
                (
                    select  1
                      from  camddmw.REP_YEAR_DIM exs
                     where  exs.unit_id = tmp.unit_id
                       and  exs.op_year = tmp.op_year
                       and  exs.prg_code = tmp.prg_code
                       and  exs.ppl_id = tmp.ppl_id
                       and  exs.rep_code = tmp.rep_code
                )
                or
                -- unit_id, op_year, prg_code, ppl_id, and rep_code combination does not exist
                -- for active rows where begin_date falls inclusively between the temp begin date and end date.
                not exists
                (
                    select  1
                      from  camddmw.REP_YEAR_DIM exs
                     where  exs.unit_id = tmp.unit_id
                       and  exs.op_year = tmp.op_year
                       and  exs.prg_code = tmp.prg_code
                       and  exs.ppl_id = tmp.ppl_id
                       and  exs.rep_code = tmp.rep_code
                       and  exs.end_date is null --? Not in old code(?)
                       and  exs.begin_date between tmp.begin_date and tmp.end_date --? What if the END_SATE is null?
                )
            )
        on  conflict ( unit_id, op_year, prg_code, ppl_id, rep_code, begin_date )
            --? Should there also be a new row that begins after the end_date with a null end_date?
        do  update
               set  begin_date      = excluded.begin_date,
                    end_date        = excluded.end_date,
                    ppl_id          = excluded.ppl_id,
                    data_source     = 'CAMD_UP_B'
             where  excluded.end_date is null;
    
    ---------------------------------------
    -- Refresh Non-Program Specific Data --
    ---------------------------------------
    raise notice 'Refresh Non-Program Specific Data';
    
    insert
      into  camddmw.REP_YEAR_DIM
            ( 
                unit_id, op_year, ppl_id, prg_code, rep_code, begin_date, end_date,
                data_source, userid, add_date
            )
    select  tmp.unit_id,
            tmp.op_year,
            tmp.ppl_id,
            tmp.prg_code,
            tmp.rep_code,
            tmp.begin_date,
            tmp.end_date,
            ( tmp.data_source || 'Insert A' ) as data_source,
            tmp.userid,
            tmp.add_date
      from  REP_YEAR_DIM_TEMP tmp
     where  not tmp.is_program_specific
       --and  tmp.end_date is null -- Should be null if prg_code is null
       and  -- unit_id, op_year, prg_code, ppl_id, and rep_code combination does not exist.
            not exists
            (
                select  1
                  from  camddmw.REP_YEAR_DIM exs
                 where  exs.unit_id = tmp.unit_id
                   and  exs.op_year = tmp.op_year
                   and  exs.prg_code = tmp.prg_code
                   and  exs.ppl_id = tmp.ppl_id
                   and  exs.rep_code = tmp.rep_code
            )
        on  -- end_date should (will) be null.
            -- ppl_id should be the same value when the other conflict columns are the same.
            conflict ( unit_id, op_year, prg_code, ppl_id, rep_code, begin_date )
        do  update
               set  begin_date      = excluded.begin_date,
                    end_date        = excluded.end_date,
                    ppl_id          = excluded.ppl_id,
                    data_source     = 'CAMD_UP_A'
             where  rep_year_dim.begin_date <= excluded.begin_date;
    
    ------------------------------------
    -- Refresh for Units without Reps --
    ------------------------------------
    raise notice 'Refresh for Units without Reps';
    
    insert
      into  camddmw.REP_YEAR_DIM
            ( 
                unit_id, op_year, prg_code,
                data_source, userid, add_date
            )
    select  pyd.unit_id,
            pyd.op_year,
            pyd.prg_code,
            'NO_REP_INFO' as data_source,
            'DMLOAD' as userid,
            now() as add_date
      from  camddmw.PROGRAM_YEAR_DIM pyd
     where  --? Ensuring that unit and year exist in UNIT_FACT
            exists
            (
                select  1
                  from  camddmw.UNIT_FACT unf
                 where  unf.unit_id = pyd.unit_id
                   and  unf.op_year = pyd.op_year
            )
       and  not exists
            (
                select  1
                  from  camddmw.REP_YEAR_DIM ryd
                 where  ryd.unit_id = pyd.unit_id
                   and  ryd.op_year = pyd.op_year
                   and  ryd.prg_code = pyd.prg_code
            );
    
    
    ---------------------
    -- Drop Temp Table --
    ---------------------
    raise notice 'Drop Temp Table';
    
    drop table if exists REP_YEAR_DIM_TEMP;    
    
    raise notice 'Done';
    
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
