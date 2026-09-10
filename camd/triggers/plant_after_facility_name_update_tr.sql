
---------------------------------
-- Trigger Function Definition --
---------------------------------

create or replace function camd.PLANT_AFTER_FACILITY_NAME_UPDATE_TRIGGER()
    returns trigger
as
$PLANT_AFTER_FACILITY_NAME_UPDATE_TR$
declare
    vAccountNumber  text;
    vOrisCode       numeric;
begin

    if ( tg_op = 'UPDATE' )
    then
        
        -----------------------------------------
        -- Get ORIS and Format Account Numbers --
        -----------------------------------------
        
        select  fac.oris_code,
                lpad( fac.oris_code::text, 6, '0' ) as account_number
          into  vOrisCode,
                vAccountNumber
          from  camd.PLANT fac
         where  fac.fac_id = new.fac_id;

        ----------------------------------------------------------------
        -- Update if ORIS Code Is Not Null and Account Number Matches --
        ----------------------------------------------------------------
        
        if ( vOrisCode is not null )
        then
            
            update  camdams.ACCOUNT
               set  account_name = new.facility_name,
                    userid = new.userid,
                    update_date = now()
             where  account_type_cd in ( 'FACLTY', 'UNIT' )
               and  substr( account_number, 1, 6 ) = vAccountNumber;
            
            update  camdnats.TACCOUNT
               set  acctname_nme = new.facility_name,
                    userid_id = new.userid,
                    last_update_date = now()
             where  accttype_cd in ( 'UA', 'OD' )
               and  substr( acctnum_id, 1, 6 ) = vAccountNumber;
            
        end if;
        
    end if;
    
    return NULL;

end;
$PLANT_AFTER_FACILITY_NAME_UPDATE_TR$
language plpgsql;


------------------------
-- Trigger Definition --
------------------------

create or replace trigger PLANT_AFTER_FACILITY_NAME_UPDATE_TR
    after update
    of facility_name
    on camd.PLANT
    for each row
    execute function camd.PLANT_AFTER_FACILITY_NAME_UPDATE_TRIGGER();