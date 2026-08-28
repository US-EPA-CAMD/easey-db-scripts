DECLARE
    V_UNIT_ID           NUMBER;
    V_OPR_BEGIN_DATE    DATE;
    
    V_CURRENT_OP_STATUS VARCHAR2(7);
    
    V_RESULT    VARCHAR2(1) := 'T';
    V_ERROR_MSG VARCHAR2(4000) := '';
BEGIN
    FOR unit_to_update IN (SELECT 0 as ORIS_CODE, -- replace with Oris Code
                                  '' as UNITID, --replace with Unit Name
                                  TO_DATE('??/??/??', 'MM/DD/YYYY') as new_co_date, -- replace with new CO date (or NULL if applicable)
                                  TO_DATE('??/??/??', 'MM/DD/YYYY') as new_cco_date, -- replace with new CCO date
                                  'RT86648' as USERID -- replace with RT number
                            FROM DUAL
                            --UNION ALL -- uncomment and add select(s) for additional units as needed
    )
    LOOP
        BEGIN    
            --get the unit_id
            SELECT U.UNIT_ID INTO V_UNIT_ID 
                FROM UNIT U 
                    INNER JOIN PLANT PL 
                        ON U.FAC_ID = PL.FAC_ID AND PL.ORIS_CODE = unit_to_update.ORIS_CODE 
                WHERE U.UNITID = unit_to_update.UNITID;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20001, 
                                        'Unable to determine unit_id for Oris Code ' || 
                                        unit_to_update.ORIS_CODE || ' Unit ' || unit_to_update.UNITID || '.');
        END;        
        
        V_OPR_BEGIN_DATE := NVL(unit_to_update.NEW_CO_DATE, unit_to_update.NEW_CCO_DATE);
    
        -- confirm that the unit is currently marked as Future
        V_CURRENT_OP_STATUS := '';
        BEGIN
            SELECT UOS.OP_STATUS_CD INTO V_CURRENT_OP_STATUS  
                FROM UNIT_OP_STATUS UOS
                WHERE UOS.UNIT_ID = V_UNIT_ID 
                    AND UOS.END_DATE IS NULL;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20002, 
                                        'Unable to determine current op status for Oris Code ' || 
                                        unit_to_update.ORIS_CODE || ' Unit ' || unit_to_update.UNITID || '.');
        END;
                
        IF V_CURRENT_OP_STATUS <> 'FUT' THEN
            RAISE_APPLICATION_ERROR(-20003, 
                                    'Oris Code ' || unit_to_update.ORIS_CODE || 
                                    ' Unit ' || unit_to_update.UNITID || ' is not currently marked as Future.');
        END IF;
            
        -- end the FUT operating status if the FUT record begins before the OPR begin date
        UPDATE UNIT_OP_STATUS
            SET END_DATE = V_OPR_BEGIN_DATE - 1,
                USERID = unit_to_update.USERID,
                UPDATE_DATE = SYSDATE
            WHERE UNIT_ID = V_UNIT_ID 
                AND OP_STATUS_CD = 'FUT' 
                AND END_DATE IS NULL 
                AND BEGIN_DATE < V_OPR_BEGIN_DATE;
            
        -- delete the FUT operating status if the FUT record begins on or after the OPR begin date
        DELETE FROM UNIT_OP_STATUS
            WHERE UNIT_ID = V_UNIT_ID 
                AND OP_STATUS_CD = 'FUT' 
                AND END_DATE IS NULL 
                AND BEGIN_DATE >= V_OPR_BEGIN_DATE;
            
        -- add an OPR record    
        INSERT INTO UNIT_OP_STATUS (UNIT_OP_STATUS_ID, 
                                    UNIT_ID,
                                    OP_STATUS_CD, 
                                    BEGIN_DATE, 
                                    USERID, 
                                    ADD_DATE)
            VALUES (S_UNIT_OP_STATUS.NEXTVAL, 
                    V_UNIT_ID, 
                    'OPR', 
                    V_OPR_BEGIN_DATE, 
                    unit_to_update.USERID, 
                    SYSDATE);
            
        -- update unit op dates and codes
        UPDATE UNIT
            SET COMM_OP_DATE = unit_to_update.NEW_CO_DATE,
                COMM_OP_DATE_CD = CASE 
                                    WHEN unit_to_update.NEW_CO_DATE IS NOT NULL THEN 'A' 
                                    ELSE NULL 
                                  END,
                COMR_OP_DATE = unit_to_update.NEW_CCO_DATE,
                COMR_OP_DATE_CD = CASE 
                                    WHEN unit_to_update.NEW_CCO_DATE IS NOT NULL THEN
                                        CASE 
                                            WHEN unit_to_update.NEW_CCO_DATE <= TRUNC(SYSDATE) THEN 'A'
                                            ELSE 'P'
                                        END                                    
                                    ELSE NULL
                                  END,
                USERID = unit_to_update.USERID,
                UPDATE_DATE = SYSDATE
            WHERE UNIT_ID = V_UNIT_ID;    
        
        -- update the unit type begin date (if an active record exists)
        UPDATE UNIT_BOILER_TYPE 
            SET BEGIN_DATE = V_OPR_BEGIN_DATE,
                USERID = unit_to_update.USERID,
                UPDATE_DATE = SYSDATE
            WHERE UNIT_ID = V_UNIT_ID 
                AND END_DATE IS NULL;    
            
        -- update unit program dates (normal logic - further ERBD updates should be made via CBS)
        CBS_WORKSPACE.UNIT_PROGRAM_DATES (V_UNIT_ID, 
                                          NULL, 
                                          NULL, 
                                          'Y', 
                                          unit_to_update.USERID, 
                                          V_RESULT, 
                                          V_ERROR_MSG);
        IF V_RESULT = 'F' THEN
            RAISE_APPLICATION_ERROR(-20004, 
                                    'Failed to update unit program dates for ' || 
                                    unit_to_update.ORIS_CODE || ' Unit ' || unit_to_update.UNITID || 
                                    '.  Error is: ' || V_ERROR_MSG);
        END IF;
        
        -- add records to inventory_status_log
        CBS_UTILITY.UPDATE_INVENTORY_STATUS_LOG (NULL, 
                                                 V_UNIT_ID, 
                                                 'INVENTORY', 
                                                 unit_to_update.USERID, 
                                                 V_RESULT, 
                                                 V_ERROR_MSG);
        IF V_RESULT = 'F' THEN
            RAISE_APPLICATION_ERROR(-20005, 
                                    'Failed to update inventory_status_log - INVENTORY for ' || 
                                    unit_to_update.ORIS_CODE || ' Unit ' || unit_to_update.UNITID || 
                                    '.  Error is: ' || V_ERROR_MSG);
        END IF;
        
        CBS_UTILITY.UPDATE_INVENTORY_STATUS_LOG (NULL, 
                                                 V_UNIT_ID, 
                                                 'UNIT_PROGRAM', 
                                                 unit_to_update.USERID, 
                                                 V_RESULT, 
                                                 V_ERROR_MSG);
        IF V_RESULT = 'F' THEN
            RAISE_APPLICATION_ERROR(-20006, 
                                    'Failed to update inventory_status_log - UNIT_PROGRAM for ' || 
                                    unit_to_update.ORIS_CODE || ' Unit ' || unit_to_update.UNITID || 
                                    '.  Error is: ' || V_ERROR_MSG);
        END IF;
    END LOOP;    
    
    --COMMIT;
    ROLLBACK;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/
