create or replace procedure camdnats.update_account_number
(
    vFacId_in           in  numeric,
    vOldUnitName_in     in  text,
    vNewUnitName_in     in  text,
    vUserIdin           in  text
)
language 'plpgsql'
as
$body$
declare
    vNewAccountNumber   text;
    vOldAccountNumber   text;
    vOrisCode           numeric;
begin
    
    if ( vOldUnitName_in is not null ) and
       ( vNewUnitName_in is not null ) and
       exists( select 1 from camd.PLANT where fac_id = vFacId_in )
    then
        
        -----------------------------------------
        -- Get ORIS and Format Account Numbers --
        -----------------------------------------
        
        select  fac.oris_code,
                ( lpad( fac.oris_code, 6, '0' ) || lpad( replace( replace( vOldUnitName_in, '*', 'X' ), '-', 'Z' ), 6, '0' ) ) as old_account_number,
                ( lpad( fac.oris_code, 6, '0' ) || lpad( replace( replace( vNewUnitName_in, '*', 'X' ), '-', 'Z' ), 6, '0' ) ) as new_account_number
          into  vOrisCode,
                vOldAccountNumber,
                vNewAccountNumber
          from  camd.PLANT fac
                join camd.UNIT unt using ( fac_id )
         where  fac.fac_id = vFacId_in;
        
        
        ------------------------
        -- General Processing --
        ------------------------
        
        if ( vOrisCode is not null ) and
           ( vOldAccountNumber != vNewAccountNumber ) and
           exists( select 1 from camdnats.TACCOUNT where acctnum_id = vOldAccountNumber )
        then
            
            begin
                
                ---------------------------------
                -- Create New Account from Old --
                ---------------------------------
                
                insert
                  into  camdnats.TACCOUNT
                        (
                            acctnum_id,
                            accttype_cd,
                            acctname_nme,
                            nobroker_ind,
                            brkrtran_ind,
                            brkrhold_ind,
                            brkrother_ind,
                            utility_ind,
                            nonutil_ind,
                            coal_ind,
                            oil_ind,
                            gas_ind,
                            fuelothr_ind,
                            pollutn_ind,
                            consumer_ind,
                            environ_ind,
                            othpubl_ind,
                            other_ind,
                            boiler_ind,
                            userid_id,
                            dateadd_dt,
                            last_update_date
                        )
                select  vNewAccountNumber,
                        acc.accttype_cd,
                        acc.acctname_nme,
                        acc.nobroker_ind,
                        acc.brkrtran_ind,
                        acc.brkrhold_ind,
                        acc.brkrother_ind,
                        acc.utility_ind,
                        acc.nonutil_ind,
                        acc.coal_ind,
                        acc.oil_ind,
                        acc.gas_ind,
                        acc.fuelothr_ind,
                        acc.pollutn_ind,
                        acc.consumer_ind,
                        acc.environ_ind,
                        acc.othpubl_ind,
                        acc.other_ind,
                        acc.boiler_ind,
                        aubstr( USER, 1, 8 ),
                        acc.dateadd_dt,
                        now()
                  from  camdnats.TACCOUNT acc
                 where  acc.acctnum_id = vOldAccountNumber;
                
                
                ----------------------------------------
                -- Update Child Tables to New Account --
                ----------------------------------------
                
                update  camdnats.TACCTCHG
                   set  acctnum_id = vNewAccountNumber
                 where  acctnum_id = vOldAccountNumber;

                update  camdnats.TACCT_OWNER
                   set  acctnum_id = vNewAccountNumber
                 where  acctnum_id = vOldAccountNumber;

                update  camdnats.TACCT_REP
                   set  acctnum_id = vNewAccountNumber
                 where  acctnum_id = vOldAccountNumber;

                update  camdnats.TSERIAL
                   set  acctnum_id = vNewAccountNumber,
                        last_update_date = now()
                 where  acctnum_id = vOldAccountNumber;

                update  camdnats.TTOTALLOW
                   set  acctnum_id = vNewAccountNumber
                 where  acctnum_id = vOldAccountNumber;

                update  camdnats.TTRANSACT
                   set  SELLACCT_ID = vNewAccountNumber
                 where  SELLACCT_ID = vOldAccountNumber;

                update  camdnats.TTRANSACT
                   set  BUYACCT_ID = vNewAccountNumber
                 where  BUYACCT_ID = vOldAccountNumber;

                update  camdnats.TUNITDEDUCT
                   set  acctnum_id = vNewAccountNumber
                 where  acctnum_id = vOldAccountNumber;

                update  camdnats.TBAL_DED
                   set  acctnum_id = vNewAccountNumber
                 where  acctnum_id = vOldAccountNumber;

                update  camdnats.TOVDFT_DED
                   set  acctnum_id = vNewAccountNumber
                 where  acctnum_id = vOldAccountNumber;

                update  camdnats.TARS_ALLW_MSID
                   set  acctnum_id = vNewAccountNumber
                 where  acctnum_id = vOldAccountNumber;

                update  camdnats.TSTACK_CONFIG
                   set  unit_id = vNewUnitName_in
                 where  unit_id = vOldUnitName_in;

                update  camdnats.TARS_ALLW_DED
                   set  acctnum_id = vNewAccountNumber
                 where  acctnum_id = vOldAccountNumber;

                
                ------------------------
                -- Delete Old Account --
                ------------------------
                
                delete
                  from  camdnats.TACCOUNT
                 where  acctnum_id = vOldAccountNumber;
                
                
                -------------------------------------------------------
                -- Insert Row into TACCTCHG for Changed Account Info --
                -------------------------------------------------------
                
                begin
                    
                    insert
                      into  camdnats.TACCTCHG 
                            (
                                acctnum_id,
                                chgfield_nme,
                                date_dt,
                                time_tm,
                                oldvalue_nme,
                                newvalue_nme,
                                userid_id
                            )
                    values  (
                                vOldAccountNumber,
                                'ACCTNUM_ID',
                                to_char( now(), 'YYYYMMDD' ),
                                to_char( now(), 'HH24MISS' ),
                                vOldAccountNumber,
                                vNewAccountNumber,
                                substr ( USER, 1, 8 )
                            );
                    
                exception when others then
                    null;
                    /*
                    v_result := 'F';
                    v_error_msg := 'NTacctchg_Insert failed. The error returned is ' || to_char(SQLCODE) || ': ' || SQLERRM;
                    V_ERROR_MSG := 'SMS_CHANGE_UNIT_ID failed attempting to update ' || 'the account number in NATS.  ' || V_ERROR_MSG;
                    ROLLBACK;
                    RETURN;
                    */
                end;
            
            exception when others then
                null;
                /*
                V_RESULT := 'F';
                V_ERROR_MSG := 'SMS_CHANGE_UNIT_ID failed attempting to update ' || 'the account number in NATS.  ' || 'The error returned was ' || SQLCODE || ' - ' || SQLERRM;
                ROLLBACK;
                RETURN;
                */
            end;
            
        end if;
        
    end if;
    
    -- COMMIT;
    
exception when others then
    null;
    /*
    ROLLBACK;
    V_RESULT := 'F';
    V_ERROR_MSG := 'SMS_CHANGE_UNIT_ID failed.  The error returned was ' || SQLCODE || ' - ' || SQLERRM;
    */
end
$body$;
