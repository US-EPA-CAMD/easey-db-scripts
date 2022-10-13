/* 
    Update ORIS 56249, unit "ES1-A", system "01A" to system type "CO2" 
*/

update  camdecmpswks.MONITOR_SYSTEM
   set  Sys_Type_Cd = 'NOX'
 where  Mon_Sys_Id = 'CAMD-07BEC0123C004B979E23A3F694B29FD9';

update  camdecmpswks.MONITOR_DEFAULT
   set  End_Date = '2020-01-01',
   		End_Hour = 0
 where  MonDef_Id = 'L3FY699-FC5A0D4750CD4D7CADA7F6E19B28F122';

update  camdecmpswks.MONITOR_SYSTEM
   set  Sys_Type_Cd = 'OILV'
 where  Mon_Sys_Id = 'CAMD-CC26A6328B2948EA923EC1259C0C6201';

commit;
