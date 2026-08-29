
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
                lpad( fac.oris_code, 6, '0' ) as account_number
          into  vOrisCode,
                vAccountNumber
          from  camd.PLANT fac
                join camd.UNIT unt using ( fac_id )
         where  fac.fac_id = vFacId_in;

        ----------------------------------------------------------------
        -- Update if ORIS Code Is Not Null and Account Number Matches --
        ----------------------------------------------------------------
        
        if ( vOrisCode is not null )
        then
            
            update  TACCOUNT
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