/* 
    Update ORIS 56249, unit "ES1-A", system "01A" to system type "CO2" 
*/

update  camdecmpswks.MONITOR_SYSTEM
   set  Sys_Type_Cd = 'CO2'
 where  Mon_Sys_Id = 'CAMD-88D232A483124BF48AF75AB79D4B99B4';

commit;
