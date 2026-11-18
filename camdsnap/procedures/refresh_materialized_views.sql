/******************************************************************************************************************************
    
    REFRESH_MATERIALIZED_VIEWS
    
    Refreshes and analyzes the CAMDSNAP materialized views (MVW), starting with those that do not depend on CAMDSNAP MVWs, and
    then sucessively handling MVW that only depend on MVW that have already been processed.
    
    Note a Vaccum is not need since Concurrency is not used in the refresh.
    
    
    Maitnenance History:
    
    Date        Programmer      Ticket      Description
    ----------  --------------  ----------  -----------------------------------------------------------------------------------
    2026-07-24  Dwayne Whitten  #7238       Created
******************************************************************************************************************************/
create or replace procedure camdsnap.REFRESH_MATERIALIZED_VIEWS()
language plpgsql
as
$$
declare
    vMaterializedView record;
begin
    
    for vMaterializedView in
    (
        select  mvw.materialized_view_schema,
                mvw.materialized_view_name
          from  camdsnap.REFRESH_MATERIALIZED_VIEW_GET() mvw
         order
            by  mvw.dependency_level,
                mvw.materialized_view_schema,
                mvw.materialized_view_name
    )
    loop
        
        execute format( 'refresh materialized view %I.%I', vMaterializedView.materialized_view_schema, vMaterializedView.materialized_view_name );
        execute format( 'analyze %I.%I', vMaterializedView.materialized_view_schema, vMaterializedView.materialized_view_name );
        
    end loop;
    
end;
$$;