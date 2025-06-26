-- Update retired end_rpt_period_id for table unit_stack_configuration
DO $$
DECLARE
  usc_record RECORD;  
  usc_cursor cursor for
 select config_id, (select  min ( cmb.Retire_Date ) -1
                     from  (select uos.Begin_Date as Retire_Date 
			      from camd.UNIT_OP_STATUS uos 
                              where uos.Op_Status_Cd = 'RET' and uos.End_Date is null 
                               and  uos.unit_id= usc.unit_id
                           union   all
                            select stp.Retire_Date  
   			      from  camdecmps.STACK_PIPE stp   
                              where stp.stack_pipe_id = usc.stack_pipe_id and stp.Retire_Date is not null
                                ) cmb 
		   ) as first_retire_date
   from camdecmps.UNIT_STACK_CONFIGURATION usc
    join camdecmps.stack_pipe sp on  sp.Stack_Pipe_Id = usc.Stack_Pipe_Id
    join camd.UNIT_OP_STATUS  uos on uos.unit_id=usc.unit_id and OP_STATUS_CD= 'RET' and uos.END_DATE is null
      where usc.end_date is null;	 

 BEGIN
    Open usc_cursor;	
    LOOP
     fetch usc_cursor into usc_record; 
	exit when not found;
         update camdecmps.UNIT_STACK_CONFIGURATION usc 
	   set end_date = usc_record.first_retire_date
            where usc.config_id = usc_record.config_id;
   END LOOP;
   close usc_cursor;
END $$;   

