/* 
    Update ORIS 991, unit "GT1", system "F43" to component identifier "C02" 
*/

update  camdecmpswks.COMPONENT
   set  Component_Type_Cd = 'CO2'
 where  Component_Id = 'CAMD-44B945E2D9254912A4821FB30AFEE006';

commit;
