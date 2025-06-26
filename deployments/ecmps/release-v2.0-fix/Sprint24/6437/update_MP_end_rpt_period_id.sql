--update retired end_rpt_period_id for table monitor_plan
DECLARE
  cursor mp_cursor is  
  select mon_plan_id, first_retire_date, rpt_period_id, begin_date, end_date
   from (select  pln.Mon_Plan_Id,   
         (select  min ( cmb.Retire_Date )    
           from  (select  uos.Begin_Date as Retire_Date  from  MONITOR_PLAN_LOCATION mpl
              join MONITOR_LOCATION loc on loc.Mon_Loc_Id = mpl.Mon_Loc_Id
              join UNIT_OP_STATUS uos on uos.Unit_Id = loc.Unit_Id and uos.Op_Status_Cd='RET' and uos.End_Date is null
               where  mpl.Mon_Plan_Id = pln.Mon_Plan_Id
         union   all
          select stp.Retire_Date from  MONITOR_PLAN_LOCATION mpl
              join MONITOR_LOCATION loc on loc.Mon_Loc_Id = mpl.Mon_Loc_Id
              join STACK_PIPE stp on stp.Stack_Pipe_Id = loc.Stack_Pipe_Id  and stp.Retire_Date is not null
               where  mpl.Mon_Plan_Id = pln.Mon_Plan_Id
          ) cmb
         ) as First_Retire_Date                                   
     from  MONITOR_PLAN pln
     where pln.End_Rpt_Period_Id is null 
       and  (exists (select 1 from MONITOR_PLAN_LOCATION mpl 
                        join MONITOR_LOCATION loc on loc.Mon_Loc_Id = mpl.Mon_Loc_Id
                        join UNIT_OP_STATUS uos on uos.Unit_Id = loc.Unit_Id and uos.Op_Status_Cd = 'RET' and uos.End_Date is null
                        where  mpl.Mon_Plan_Id = pln.Mon_Plan_Id )
              or  exists(select 1 from  MONITOR_PLAN_LOCATION mpl 
                        join MONITOR_LOCATION loc on loc.Mon_Loc_Id = mpl.Mon_Loc_Id
                        join STACK_PIPE stp on stp.Stack_Pipe_Id = loc.Stack_Pipe_Id and stp.Retire_Date is not null
                        where  mpl.Mon_Plan_Id = pln.Mon_Plan_Id )    
              )
           ) dbset, REPORTING_PERIOD rp
     where dbset.first_retire_date between rp.begin_date and rp.end_date ;
              
BEGIN
   FOR mp_record IN mp_cursor
   LOOP
     case when mp_record.first_retire_date=mp_record.begin_date then
            update monitor_plan set end_rpt_period_id=(mp_record.rpt_period_id-1) 
                  where monitor_plan.MON_PLAN_ID=mp_record.MON_PLAN_ID;
         when mp_record.first_retire_date>mp_record.begin_date then
            update monitor_plan set end_rpt_period_id=(mp_record.rpt_period_id) 
                  where monitor_plan.MON_PLAN_ID=mp_record.MON_PLAN_ID;
     end case;
   END LOOP;
END;