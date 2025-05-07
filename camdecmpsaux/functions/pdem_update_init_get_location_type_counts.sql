create or replace function camdecmpsaux.PDEM_Update_Init_Get_Location_Type_Counts
(
    in vMonPlanId varchar
)
    returns table
            (
                Cs integer,
                Ms integer,
                Cp integer,
                Mp integer,
                Un integer
            )

language plpgsql

as $function$

declare
begin

    return query
        select  sum( case when loc.Unit_Id is null and stp.Stack_Name like 'CS%' then 1 else 0 end )::integer as Cs,
                sum( case when loc.Unit_Id is null and stp.Stack_Name like 'MS%' then 1 else 0 end )::integer as Ms,
                sum( case when loc.Unit_Id is null and stp.Stack_Name like 'CP%' then 1 else 0 end )::integer as Cp,
                sum( case when loc.Unit_Id is null and stp.Stack_Name like 'MP%' then 1 else 0 end )::integer as Mp,
                sum( case when loc.Unit_Id is not null then 1 else 0 end )::integer as Un
          from  camdecmps.MONITOR_PLAN_LOCATION mpl
                join camdecmps.MONITOR_LOCATION loc
                  on loc.Mon_Loc_Id = mpl.Mon_Loc_Id
                left join camd.UNIT unt
                  on unt.Unit_Id = loc.Unit_Id
                left join camdecmps.STACK_PIPE stp
                  on stp.Stack_Pipe_Id = loc.Stack_Pipe_Id
         where  mpl.Mon_Plan_Id = vMonPlanId;

end;

$function$;
