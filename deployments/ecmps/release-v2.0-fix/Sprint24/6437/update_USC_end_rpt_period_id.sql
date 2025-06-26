--update retired end_rpt_period_id for table unit_stack_configuration

DECLARE
  cursor usc_cursor is  
   select config_id,(select  min ( cmb.Retire_Date ) -1
                     from  (
					         select uos.Begin_Date as Retire_Date from UNIT_OP_STATUS uos 
                              where uos.Op_Status_Cd = 'RET' and uos.End_Date is null 
                               and  uos.unit_id= usc.unit_id
                           union   all
                            select stp.Retire_Date  from  STACK_PIPE stp   
                              where stp.stack_pipe_id = usc.stack_pipe_id and stp.Retire_Date is not null
                                ) cmb 
				    ) as first_retire_date
   from UNIT_STACK_CONFIGURATION usc
    join stack_pipe sp on  sp.Stack_Pipe_Id = usc.Stack_Pipe_Id
    join UNIT_OP_STATUS  uos on uos.unit_id=usc.unit_id and OP_STATUS_CD= 'RET' and uos.END_DATE is null
      where usc.end_date is null; 

BEGIN
   FOR usc_record IN usc_cursor
    LOOP   
        update UNIT_STACK_CONFIGURATION set end_date = usc_record.first_retire_date
            where unit_stack_configuration.config_id = usc_record.config_id;
   END LOOP;
END;