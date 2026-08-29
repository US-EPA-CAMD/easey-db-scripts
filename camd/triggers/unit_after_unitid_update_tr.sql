
---------------------------------
-- Trigger Function Definition --
---------------------------------

create or replace function camd.UNIT_AFTER_UNITID_UPDATE_TRIGGER()
    returns trigger
as
$UNIT_AFTER_UNITID_UPDATE_TR$
declare
begin

    if ( tg_op = 'UPDATE' ) then
    
        call camdnats.UPDATE_ACCOUNT_NUMBER( new.fac_id, old.unitid, new.unitid, new.userid );
    
    end if;
    
    return NULL;

end;
$UNIT_AFTER_UNITID_UPDATE_TR$
language plpgsql;


------------------------
-- Trigger Definition --
------------------------

create or replace trigger UNIT_AFTER_UNITID_UPDATE_TR
    after update
    of unitid
    on camd.UNIT
    for each row
    execute function camd.UNIT_AFTER_UNITID_UPDATE_TRIGGER();