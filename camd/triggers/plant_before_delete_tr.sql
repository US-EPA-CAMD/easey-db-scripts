
---------------------------------
-- Trigger Function Definition --
---------------------------------

create or replace function camd.PLANT_BEFORE_DELETE_TRIGGER()
    returns trigger
as
$PLANT_BEFORE_DELETE_TR$
declare
begin

    if ( tg_op = 'DELETE' ) then
    
        delete
          from  camdaux.INVENTORY_STATUS_LOG isl
         where  isl.fac_id = old.fac_id;
    
    end if;

end;
$PLANT_BEFORE_DELETE_TR$
language plpgsql;


------------------------
-- Trigger Definition --
------------------------

create or replace trigger camd.PLANT_BEFORE_DELETE_TR
    before delete
    on camd.PLANT
    for each row
    execute function camd.PLANT_BEFORE_DELETE_TRIGGER;