
---------------------------------
-- Trigger Function Definition --
---------------------------------

create or replace function camd.UNIT_BEFORE_DELETE_TRIGGER()
    returns trigger
as
$UNIT_BEFORE_DELETE_TR$
declare
begin

    if ( tg_op = 'DELETE' ) then
    
        delete
          from  camdaux.INVENTORY_STATUS_LOG isl
         where  isl.unit_id = old.unit_id;
    
    end if;

end;
$UNIT_BEFORE_DELETE_TR$
language plpgsql;


------------------------
-- Trigger Definition --
------------------------

create or replace trigger camd.UNIT_BEFORE_DELETE_TR
    before delete
    on camd.UNIT
    for each row
    execute function camd.UNIT_BEFORE_DELETE_TRIGGER;