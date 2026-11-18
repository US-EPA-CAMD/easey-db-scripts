create materialized view camdsnap.UNIT_HISTORY_SS 
as 
select  unh.unit_id,
        unh.effective_date,
        unh.old_unitid,
        unh.new_unitid,
        unh.old_oris_code,
        unh.new_oris_code,
        unh.old_fac_id,
        unh.new_fac_id,
        unh.unit_history_type_cd,
        unh.unit_history_comment,
        unh.userid,
        unh.add_date,
        unh.update_date,
        unh.old_account_number,
        unh.new_account_number,
        now() as refresh_time
  from  (
            select  una.userid,
                    una.add_date,
                    null as update_date,
                    una.unit_id,
                    una.alias_date as effective_date,
                    una.old_unitid,
                    unt.unitid as new_unitid,
                    fac.oris_code as old_oris_code,
                    fac.oris_code as new_oris_code,
                    unt.fac_id as old_fac_id,
                    unt.fac_id as new_fac_id,
                    'ALIAS' as unit_history_type_cd,
                    'Unit ID change from ' || una.old_unitid || ' to ' || unt.unitid as unit_history_comment,
                    null as new_account_number,
                    null as old_account_number
              from  camd.UNIT_ALIAS una,
                    camd.PLANT fac,
                    camd.UNIT unt
             where  una.unit_id = unt.unit_id and fac.fac_id = unt.fac_id
            union   all
            select  unl.userid,
                    unl.add_date,
                    unl.update_date,
                    unl.unit_id,
                    unl.effective_date,
                    unl.old_unitid,
                    unt.unitid as new_unitid,
                    fco.oris_code as old_oris_code,
                    fcn.oris_code as new_oris_code,
                    unl.old_fac_id,
                    unt.fac_id as new_fac_id,
                    'LOGICAL' as unit_history_type_cd,
                    'ORIS ' || fcn.oris_code || ' Unit ' || unt.unitid || ' (previously ORIS ' || fco.oris_code || ' Unit ' || unl.old_unitid || ') ' || unt.unit_description as unit_history_comment,
                    aun.account_number as new_account_number,
                    trim( to_char( fco.oris_code, '000000' ) || lpad( replace( unl.old_unitid, '-', 'Z' ), 6, '0' ) ) as  old_account_number
              from  camd.UNIT_LOGICAL_MOVE  unl
                    join camd.UNIT unt on unl.unit_id = unt.unit_id
                    join camd.PLANT fco on unl.old_fac_id = fco.fac_id
                    left join camdams.ACCOUNT_UNIT aun on unt.unit_id = aun.unit_id
                    join camd.PLANT fcn on unt.fac_id = fcn.fac_id
            union   all
            select  upm.userid,
                    upm.add_date,
                    upm.update_date,
                    upm.unit_id,
                    upm.effective_date,
                    uno.unitid as old_unitid,
                    unn.unitid as new_unitid,
                    fco.oris_code as old_oris_code,
                    fcn.oris_code as new_oris_code,
                    uno.fac_id as old_fac_id,
                    unn.fac_id as new_fac_id,
                    'PHYSCAL' as unit_history_type_cd,
                    'ORIS ' || fcn.oris_code || ' Unit ' || unn.unitid || ' (previously ORIS ' || fco.oris_code || ' Unit ' || uno.unitid || ') ' || unn.unit_description as unit_history_comment,
                    null as new_account_number,
                    auo.account_number as old_account_number
              from  camd.UNIT_PHYSICAL_MOVE upm
                    join camd.UNIT uno
                      on upm.unit_id = uno.unit_id
                    join camd.UNIT unn
                      on upm.new_unit_id = unn.unit_id
                    join camd.PLANT fco
                      on uno.fac_id = fco.fac_id
                    left join camdams.ACCOUNT_UNIT aun
                      on unn.unit_id = aun.unit_id
                    join camd.PLANT fcn
                      on unn.fac_id = fcn.fac_id
                    left join camdams.ACCOUNT_UNIT auo
                      on uno.unit_id = auo.unit_id
        ) unh;


comment on materialized view camdsnap.UNIT_HISTORY_SS is 'snapshot table for snapshot CAMDSNAP.UNIT_HISTORY_SS';
