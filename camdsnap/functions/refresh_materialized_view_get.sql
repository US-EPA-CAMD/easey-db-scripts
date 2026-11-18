/******************************************************************************************************************************
    
    REFRESH_MATERIALIZED_VIEW_GET
    
    Returns the CAMDSNAP materialized views (MVW) with a schema column and adding a dependency level column.  The dependency
    level column will have a 0 for MVW columns that do not depend on other CAMDSNAP MVW.  Each additional level will only
    depend on previous levels with at least one dependency on the previous level.
    
    
    Maitnenance History:
    
    Date        Programmer      Ticket      Description
    ----------  --------------  ----------  -----------------------------------------------------------------------------------
    2026-07-24  Dwayne Whitten  #7238       Created
******************************************************************************************************************************/
create or replace function camdsnap.REFRESH_MATERIALIZED_VIEW_GET()
    
    returns table( materialized_view_schema text, materialized_view_name text, dependency_level integer )
    
    language 'plpgsql'
    
    cost 100
    volatile 
    rows 1000
    
as
$body$
declare
    vDependencyLevel integer := 0;
    vInsertRowCount integer;
begin
    
    ----------------------------------------------------------------------------------------------
    -- Create Dependency Leveled MVW Temp Table and Populate It  --
    ----------------------------------------------------------------------------------------------
    
    drop table if exists DEPENDENCY_LEVELED_MVW;
    
    create temp table DEPENDENCY_LEVELED_MVW on commit drop
    as
    select  distinct
            mvn.nspname::text as materialized_view_schema,
            mvc.relname::text as materialized_view_name,
            vDependencyLevel as dependency_level
      from  pg_catalog.PG_CLASS mvc
            join pg_catalog.PG_NAMESPACE mvn
              on mvn.oid = mvc.relnamespace
     where  mvc.relkind = 'm' -- Materialized View
       and  mvn.nspname = 'camdsnap'
            -- Enusre that no CAMDSNAP MVW dependencies exist.
       and  not exists
            (
                select  1
                  from  pg_catalog.PG_REWRITE rew
                        join pg_catalog.PG_DEPEND dep
                          on dep.objid = rew.oid
                        join pg_catalog.PG_CLASS tbc
                          on tbc.oid = dep.refobjid
                         and tbc.relkind = 'm' -- Materialized View
                         and tbc.relname != mvc.relname
                        join pg_catalog.PG_NAMESPACE tbn
                          on tbn.oid = tbc.relnamespace
                         and tbn.nspname = mvn.nspname 
                 where  rew.ev_class = mvc.oid
            );
    
    loop
        
        vDependencyLevel := vDependencyLevel + 1;
        
        insert
          into  DEPENDENCY_LEVELED_MVW
                (
                    materialized_view_schema,
                    materialized_view_name,
                    dependency_level
                )
        select  distinct
                mvn.nspname as materialized_view_schema,
                mvc.relname as materialized_view_name,
                vDependencyLevel as dependency_level
          from  pg_catalog.PG_CLASS mvc
                join pg_catalog.PG_NAMESPACE mvn
                  on mvn.oid = mvc.relnamespace
         where  mvc.relkind = 'm' -- Materialized View
           and  mvn.nspname = 'camdsnap'
                -- Exclude MVW that have already been included. 
           and  not exists
                (
                    select  1
                      from  DEPENDENCY_LEVELED_MVW exs
                     where  exs.materialized_view_schema = mvn.nspname
                       and  exs.materialized_view_name = mvc.relname
                )
                -- Enusre that any CAMDSNAP MVW dependencies only exist on already included MVW.
           and  not exists
                (
                    select  1
                      from  pg_catalog.PG_REWRITE rew
                            join pg_catalog.PG_DEPEND dep
                              on dep.objid = rew.oid
                            join pg_catalog.PG_CLASS tbc
                              on tbc.oid = dep.refobjid
                             and tbc.relkind = 'm' -- Materialized View
                             and tbc.relname != mvc.relname
                            join pg_catalog.PG_NAMESPACE tbn
                              on tbn.oid = tbc.relnamespace
                             and tbn.nspname = mvn.nspname 
                     where  rew.ev_class = mvc.oid
                            -- Exclude dependencies on MVW that are already included.
                       and  not exists
                            (
                                select  1
                                  from  DEPENDENCY_LEVELED_MVW exs
                                 where  exs.materialized_view_schema = tbn.nspname
                                   and  exs.materialized_view_name = tbc.relname
                            )
                );
        
        get diagnostics vInsertRowCount := row_count;
        

        -- Exit when no MVW are added to the temp table.
        if ( vInsertRowCount = 0 ) then
            exit;
        end if;
        
    end loop;
    
    
    ------------------------
    -- Return the Results --
    ------------------------
    
    return query
        select  mvw.materialized_view_schema,
                mvw.materialized_view_name,
                mvw.dependency_level
          from  DEPENDENCY_LEVELED_MVW mvw;
    
end;
$body$;
