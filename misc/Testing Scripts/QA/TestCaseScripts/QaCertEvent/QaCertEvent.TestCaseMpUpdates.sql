/* 
    End method for ORIS 3, unit "4", parameter "CO2", method "CEM" and beginning 2014-10-01 00
*/

update  camdecmpswks.MONITOR_METHOD
   set  End_Date = '2021-12-27',
        End_Hour = 0
 where  Mon_Method_Id = 'TWCORNEL5-8B65D19FAA38405EBEF2DF7D1EF1C724';

commit;
