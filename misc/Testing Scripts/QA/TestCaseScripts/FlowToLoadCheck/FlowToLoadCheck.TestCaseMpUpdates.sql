/* 
    Update ORIS 2442, unit "4", system "F43" to system type "CO2" 
*/

update  camdecmpswks.MONITOR_SYSTEM
   set  Sys_Type_Cd = 'CO2'
 where  Mon_Sys_Id = 'PC49096-AC84176C0E2A4211A5A5A9C9E4BCBAF3';

commit;
