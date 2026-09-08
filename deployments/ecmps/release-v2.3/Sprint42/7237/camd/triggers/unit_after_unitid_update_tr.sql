
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
        
        ---------------------
        -- CAMDAMS Account --
        ---------------------
        
        if ( new.unitid is not null ) and ( old.unitid is not null ) and ( new.unitid != old.unitid )
           and exists( select 1 from camd.PLANT where fac_id = new.fac_id and oris_code is not null )
           and exists( select 1 from camd.PLANT where fac_id = old.fac_id and oris_code is not null )
        then
            
            update  camdams.ACCOUNT
               set  account_number = ( select lpad( fac.oris_code, 6, '0' ) || lpad( replace( replace( new.unitid, '*', 'X' ), '-', 'Z' ), 6, '0' ) from camd.PLANT fac where fac.fac_id = new.fac_id ),
                    userid = new.userid,
                    update_date = now()
             where  account_number = ( select lpad( fac.oris_code, 6, '0' ) || lpad( replace( replace( old.unitid, '*', 'X' ), '-', 'Z' ), 6, '0' ) from camd.PLANT fac where fac.fac_id = old.fac_id )
               and  src.fac_id = new.fac_id;
            
        end if;
        
        ----------------------
        -- CAMDNATS Account --
        ----------------------
        
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