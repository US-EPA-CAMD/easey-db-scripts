--update retired end_rpt_period_id for table monitor_plan_reporting_freq

DECLARE
  cursor mprf_cursor is  
  select mon_plan_rf_id,  Mon_Plan_Id, First_Retire_Date,  begin_date, end_date, rpt_period_id
   from (
          select  frq.mon_plan_rf_id,  pln.Mon_Plan_Id,
                           ( select  min ( cmb.Retire_Date ) 
                            from  (select  uos.Begin_Date as Retire_Date
                                     from  MONITOR_PLAN_LOCATION mpl  
									 join  MONITOR_LOCATION loc on loc.Mon_Loc_Id = mpl.Mon_Loc_Id
                                     join  UNIT_OP_STATUS uos  on uos.Unit_Id = loc.Unit_Id  and uos.Op_Status_Cd = 'RET' and uos.End_Date is null
                                            where  mpl.Mon_Plan_Id = pln.Mon_Plan_Id
                                  union   all
                                   select  stp.Retire_Date
                                      from  MONITOR_PLAN_LOCATION mpl
                                      join  MONITOR_LOCATION loc  on loc.Mon_Loc_Id = mpl.Mon_Loc_Id
                                      join  STACK_PIPE stp  on stp.Stack_Pipe_Id = loc.Stack_Pipe_Id  and stp.Retire_Date is not null
                                     where  mpl.Mon_Plan_Id = pln.Mon_Plan_Id
                                ) cmb
                           ) as First_Retire_Date
       from  MONITOR_PLAN_REPORTING_FREQ frq
        join MONITOR_PLAN pln on pln.Mon_Plan_Id = frq.Mon_Plan_Id
        join PLANT fac on fac.Fac_Id = pln.Fac_Id
       where  frq.End_Rpt_Period_Id is null
   and  (  exists
                (select  1 from  MONITOR_PLAN_LOCATION mpl
                           join  MONITOR_LOCATION loc on loc.Mon_Loc_Id = mpl.Mon_Loc_Id
                           join  UNIT_OP_STATUS uos  on uos.Unit_Id = loc.Unit_Id  and uos.Op_Status_Cd = 'RET' and uos.End_Date is null
                            where  mpl.Mon_Plan_Id = pln.Mon_Plan_Id)
          or exists
                (select  1 from  MONITOR_PLAN_LOCATION mpl
                           join  MONITOR_LOCATION loc on loc.Mon_Loc_Id = mpl.Mon_Loc_Id
                           join  STACK_PIPE stp  on stp.Stack_Pipe_Id = loc.Stack_Pipe_Id  and stp.Retire_Date is not null
                    where  mpl.Mon_Plan_Id = pln.Mon_Plan_Id )        
        )) dbset, REPORTING_PERIOD rp
   where First_Retire_Date between begin_date and end_date;
   
BEGIN
   FOR mprf_record IN mprf_cursor
    LOOP   
     case when mprf_record.first_retire_date = mprf_record.begin_date then
            update monitor_plan_reporting_freq set end_rpt_period_id = (mprf_record.rpt_period_id-1) 
              where monitor_plan_reporting_freq.MON_PLAN_ID=mprf_record.MON_PLAN_ID and monitor_plan_reporting_freq.mon_plan_rf_id=mprf_record.mon_plan_rf_id;
         when mprf_record.first_retire_date > mprf_record.begin_date then
            update monitor_plan_reporting_freq set end_rpt_period_id = mprf_record.rpt_period_id
             where monitor_plan_reporting_freq.MON_PLAN_ID=mprf_record.MON_PLAN_ID and monitor_plan_reporting_freq.mon_plan_rf_id=mprf_record.mon_plan_rf_id;
       end case;
   END LOOP;
END;