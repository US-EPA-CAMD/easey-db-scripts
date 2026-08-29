create or replace function camdecmpsaux.PDEM_Update_Init_Get_Location_Info
(
    in vMonPlanId varchar
)
    returns table
            (
                Mon_Plan_Id varchar,
                Location_Name varchar,
                Mon_Loc_Id varchar,
                Unit_Id numeric
            )

language plpgsql

as $function$

declare
begin

    return query
        select  mpl.Mon_Plan_Id,
                coalesce( unt.Unitid, stp.Stack_Name ) as Location_Name,
                mpl.Mon_Loc_Id,
                unt.Unit_Id
          from  camdecmps.MONITOR_PLAN_LOCATION mpl
                join camdecmps.MONITOR_LOCATION loc
                  on loc.Mon_Loc_Id = mpl.Mon_Loc_Id
                left join camd.UNIT unt
                  on unt.Unit_Id = loc.Unit_Id
                left join camdecmps.STACK_PIPE stp
                  on stp.Stack_Pipe_Id = loc.Stack_Pipe_Id
                join camd.PLANT fac
                  on fac.Fac_Id in ( unt.Fac_Id, stp.Fac_Id )
         where  mpl.Mon_Plan_Id = vMonPlanId;

end;

$function$;
