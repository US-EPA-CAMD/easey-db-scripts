/* 
    End method for ORIS 3, unit "2", parameter "HI", method "AD" and beginning 2019-07-01 00
*/

update  camdecmpswks.MONITOR_METHOD
   set  End_Date = '2021-12-22',
        End_Hour = 0
 where  Mon_Method_Id = 'TWCORNEL5-3FE30C47D5E64BDCA54F368732C92EF5';

commit;
