/* 
    Update ORIS 991, unit "GT1", system "F43" to component identifier "C02" 
*/

update  camdecmpswks.COMPONENT
   set  Component_Type_Cd = 'BGFF'
 where  Component_Id = 'PEL-L3G357-747374435FB54CE7BF302036DF5AA8C6';

commit;
