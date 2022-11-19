/* 
    Update ORIS 991, unit "GT1", system "F43" to component identifier "C02" 
*/

update  camdecmpswks.COMPONENT
   set  Component_Type_Cd = 'H2O'
 where  Component_Id = 'CAMD-B4CFA6FD6B3349C483B7DA9D3FCEFE7D';

commit;
