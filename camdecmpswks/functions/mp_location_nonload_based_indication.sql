-- FUNCTION: camdecmpswks.mp_location_nonload_based_indication(character varying)

DROP FUNCTION IF EXISTS camdecmpswks.mp_location_nonload_based_indication(character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.mp_location_nonload_based_indication(
	monplanid character varying)
    RETURNS TABLE(mon_loc_id character varying, oris_code numeric, location_name character varying, non_load_based_ind numeric, mon_plan_id character varying) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
BEGIN
 RETURN QUERY
select mpl.Mon_Loc_Id,
       fac.Oris_Code,
           case
             when usc.Stack_Pipe_Id is not null then stp.Stack_Name
             else unt.Unitid
           end Location_Name,
           COALESCE(max(unt.Non_Load_Based_Ind), 0) Non_Load_Based_Ind,
           mpl.Mon_Plan_Id
      from camdecmpswks.MONITOR_PLAN_LOCATION mpl
           join camdecmpswks.MONITOR_LOCATION loc
             on loc.Mon_Loc_Id = mpl.Mon_Loc_Id
           left join camdecmpswks.UNIT_STACK_CONFIGURATION usc
             on usc.Stack_Pipe_Id = loc.Stack_Pipe_Id
                and usc.Unit_id 
                      in (select slc.Unit_Id 
                            from camdecmpswks.MONITOR_PLAN_LOCATION smp 
                                 join camdecmpswks.MONITOR_LOCATION slc 
                                   on slc.Mon_Loc_Id = smp.Mon_Loc_Id
                                      and slc.Unit_Id is not null 
                            where smp.Mon_Plan_Id = mpl.Mon_Plan_Id)
           join camd.UNIT unt  on unt.Unit_Id in (loc.Unit_Id, usc.Unit_Id)
           join camd.plant fac  on fac.Fac_Id = unt.Fac_id
           left join camdecmpswks.STACK_PIPE stp on stp.Stack_Pipe_Id = usc.Stack_Pipe_Id
      where (monPlanid is null or mpl.Mon_Plan_Id = monPlanid)
      group by mpl.Mon_Loc_Id, fac.Oris_Code,
               case 
                 when usc.Stack_Pipe_Id is not null then stp.Stack_Name
                 else unt.Unitid
               end,
               mpl.Mon_Plan_Id;

END;
$BODY$;
