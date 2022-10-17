/* 
    Update ORIS 991, unit "GT1", system "F43" to component identifier "C02" 
*/

update  camdecmpswks.COMPONENT
   set  Component_Type_Cd = 'DL'
 where  Component_Id = 'PAULDESKTO-C76C5678040D4ECFA9067EE7AC337A7B';

commit;
