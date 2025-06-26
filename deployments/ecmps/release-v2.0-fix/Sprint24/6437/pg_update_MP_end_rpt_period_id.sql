-- Update retired end_rpt_period_id for table monitor_plan 
DO $$
DECLARE
  mp_record RECORD;  
  mp_cursor cursor for
  select mon_plan_id, first_retire_date, rpt_period_id, begin_date, end_date
   from (select  pln.Mon_Plan_Id,   
         (select  min ( cmb.Retire_Date )    
           from  (select  uos.Begin_Date as Retire_Date  from  camdecmps.MONITOR_PLAN_LOCATION mpl
              join camdecmps.MONITOR_LOCATION loc on loc.Mon_Loc_Id = mpl.Mon_Loc_Id
              join camd.UNIT_OP_STATUS uos on uos.Unit_Id = loc.Unit_Id and uos.Op_Status_Cd='RET' and uos.End_Date is null
               where  mpl.Mon_Plan_Id = pln.Mon_Plan_Id
         union   all
          select stp.Retire_Date from  camdecmps.MONITOR_PLAN_LOCATION mpl
              join camdecmps.MONITOR_LOCATION loc on loc.Mon_Loc_Id = mpl.Mon_Loc_Id
              join camdecmps.STACK_PIPE stp on stp.Stack_Pipe_Id = loc.Stack_Pipe_Id  and stp.Retire_Date is not null
               where  mpl.Mon_Plan_Id = pln.Mon_Plan_Id
          ) cmb
         ) as First_Retire_Date                                   
     from  camdecmps.monitor_plan pln
     where pln.End_Rpt_Period_Id is null 
       and  (exists (select 1 from camdecmps.MONITOR_PLAN_LOCATION mpl 
                        join camdecmps.MONITOR_LOCATION loc on loc.Mon_Loc_Id = mpl.Mon_Loc_Id
                        join camd.UNIT_OP_STATUS uos on uos.Unit_Id = loc.Unit_Id and uos.Op_Status_Cd = 'RET' and uos.End_Date is null
                        where  mpl.Mon_Plan_Id = pln.Mon_Plan_Id )
              or  exists(select 1 from  camdecmps.MONITOR_PLAN_LOCATION mpl 
                        join camdecmps.MONITOR_LOCATION loc on loc.Mon_Loc_Id = mpl.Mon_Loc_Id
                        join camdecmps.STACK_PIPE stp on stp.Stack_Pipe_Id = loc.Stack_Pipe_Id and stp.Retire_Date is not null
                        where  mpl.Mon_Plan_Id = pln.Mon_Plan_Id )    
              )
           ) dbset, camdecmpsmd.REPORTING_PERIOD rp
     where dbset.first_retire_date between rp.begin_date and rp.end_date 
	 and mon_plan_id='MDC-A906E6963D474D838767CB78D131CE70'; 
  
BEGIN
    open mp_cursor;	
    LOOP
     fetch mp_cursor into mp_record; 
	  exit when not found;
       case when mp_record.first_retire_date = mp_record.begin_date then
            update camdecmps.monitor_plan mp set end_rpt_period_id=(mp_record.rpt_period_id-1) 
                  where mp.MON_PLAN_ID=mp_record.MON_PLAN_ID;
          when mp_record.first_retire_date > mp_record.begin_date then
            update camdecmps. monitor_plan mp set end_rpt_period_id=(mp_record.rpt_period_id) 
                  where mp.MON_PLAN_ID=mp_record.MON_PLAN_ID;
     end case;
    END LOOP;
   close mp_cursor;
END $$;            
