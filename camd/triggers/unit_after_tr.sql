
---------------------------------
-- Trigger Function Definition --
---------------------------------

create or replace function camd.UNIT_AFTER_TRIGGER()
    returns trigger
as
$UNIT_AFTER_TR$
declare
begin

    if ( tg_op in ( 'INSERT', 'UPDATE' ) then
    
         merge
          into  camdecmpswks.UNIT snk
         using  (
                    select  new.unit_id,
                            new.fac_id,
                            new.unitid,
                            new.unit_description,
                            new.indian_country_ind,
                            new.stateid,
                            new.boiler_sequence_number,
                            new.comm_op_date,
                            new.comm_op_date_cd,
                            new.comr_op_date,
                            new.comr_op_date_cd,
                            new.source_category_cd,
                            new.naics_cd,
                            new.no_active_gen_ind,
                            -- non_load_based_ind not included
                            new.actual_90th_op_date,
                            new.moved_ind,
                            new.userid,
                            new.add_date,
                            new.update_date
                ) src
            on  ( snk.unit_id = src.unit_id )
          when  matched then
                    update
                       set  unit_id                = src.unit_id,
                            fac_id                 = src.fac_id,
                            unitid                 = src.unitid,
                            unit_description       = src.unit_description,
                            indian_country_ind     = src.indian_country_ind,
                            stateid                = src.stateid,
                            boiler_sequence_number = src.boiler_sequence_number,
                            comm_op_date           = src.comm_op_date,
                            comm_op_date_cd        = src.comm_op_date_cd,
                            comr_op_date           = src.comr_op_date,
                            comr_op_date_cd        = src.comr_op_date_cd,
                            source_category_cd     = src.source_category_cd,
                            naics_cd               = src.naics_cd,
                            no_active_gen_ind      = src.no_active_gen_ind,
                            -- non_load_based_ind not included
                            actual_90th_op_date    = src.actual_90th_op_date,
                            moved_ind              = src.moved_ind,
                            userid                 = src.userid,
                            add_date               = src.add_date,
                            update_date            = src.update_date
          when  not matched then
                    insert  (
                                unit_id,
                                fac_id,
                                unitid,
                                unit_description,
                                indian_country_ind,
                                stateid,
                                boiler_sequence_number,
                                comm_op_date,
                                comm_op_date_cd,
                                comr_op_date,
                                comr_op_date_cd,
                                source_category_cd,
                                naics_cd,
                                no_active_gen_ind,
                                -- non_load_based_ind set to default, presumbed 0 (zero).
                                actual_90th_op_date,
                                moved_ind,
                                userid,
                                add_date,
                                update_date
                            )
                    values  (
                                src.unit_id,
                                src.fac_id,
                                src.unitid,
                                src.unit_description,
                                src.indian_country_ind,
                                src.stateid,
                                src.boiler_sequence_number,
                                src.comm_op_date,
                                src.comm_op_date_cd,
                                src.comr_op_date,
                                src.comr_op_date_cd,
                                src.source_category_cd,
                                src.naics_cd,
                                src.no_active_gen_ind,
                                -- non_load_based_ind set to default, presumbed 0 (zero).
                                src.actual_90th_op_date,
                                src.moved_ind,
                                src.userid,
                                src.add_date,
                                src.update_date
                            );
    
    elsif ( tg_op = 'DELETE' ) then
    
        delete
          from  camdecmpswks.UNIT unt
         where  unt.unit_id = old.unit_id;
    
    end if;

end;
$UNIT_AFTER_TR$
language plpgsql;


------------------------
-- Trigger Definition --
------------------------

create or replace trigger camd.UNIT_AFTER_TR
    after insert or update or delete
    on camd.UNIT
    for each row
    execute function camd.UNIT_AFTER_TRIGGER;