CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_matssorbent
(
    IN vmonplanid character varying, 
    IN vrptperiodid numeric
)
 LANGUAGE plpgsql
AS $procedure$
BEGIN
    DELETE
      FROM  camdecmps.EMISSION_VIEW_MATSSORBENT
     WHERE  MON_PLAN_ID = vmonplanid
       AND  RPT_PERIOD_ID = vrptperiodid;    
    INSERT
      INTO  camdecmps.EMISSION_VIEW_MATSSORBENT
            (                MON_PLAN_ID,                MON_LOC_ID,                RPT_PERIOD_ID,                SYSTEM_IDENTIFIER,                date_hour,                end_date_time,                PAIRED_TRAP_AGREEMENT,                ABSOLUTE_DIFFERENCE_IND,                MODC_CD,                HG_CONCENTRATION,                RATA_IND,                SORBENT_TRAP_APS_CD,
                -- Sampling Train A                A_COMPONENT_ID,                A_SORBENT_TRAP_SERIAL_NUMBER,                A_MAIN_TRAP_HG,                A_BREAKTHROUGH_TRAP_HG,                A_SPIKE_TRAP_HG,                A_SPIKE_REF_VALUE,                A_TOTAL_SAMPLE_VOLUME,                A_REF_FLOW_TO_SAMPLING_RATIO,                A_HG_CONCENTRATION,                A_PERCENT_BREAKTHROUGH,                A_PERCENT_SPIKE_RECOVERY,                A_SAMPLING_RATIO_TEST_RESULT_CD,                A_POST_LEAK_TEST_RESULT_CD,                A_TRAIN_QA_STATUS_CD,                A_SAMPLE_DAMAGE_EXPLANATION,
                -- Sampling Train B                B_COMPONENT_ID,                B_SORBENT_TRAP_SERIAL_NUMBER,                B_MAIN_TRAP_HG,                B_BREAKTHROUGH_TRAP_HG,                B_SPIKE_TRAP_HG,                B_SPIKE_REF_VALUE,                B_TOTAL_SAMPLE_VOLUME,                B_REF_FLOW_TO_SAMPLING_RATIO,                B_HG_CONCENTRATION,                B_PERCENT_BREAKTHROUGH,                B_PERCENT_SPIKE_RECOVERY,                B_SAMPLING_RATIO_TEST_RESULT_CD,                B_POST_LEAK_TEST_RESULT_CD,                B_TRAIN_QA_STATUS_CD,                B_SAMPLE_DAMAGE_EXPLANATION,                ERROR_CODES            )    SELECT  lst.Mon_Plan_Id,
            lst.Mon_Loc_Id,
            lst.Rpt_Period_Id,
            lst.System_Identifier,
            lst.Date_Hour,
            lst.End_Date_Hour,
            lst.Paired_Trap_Agreement,
            lst.Absolute_Difference_Ind,
            lst.Modc_Cd,
            lst.Hg_Concentration,
            lst.Rata_Ind,
            lst.Sorbent_Trap_Aps_Cd,
            -- Sampling Train A
            cpa.Component_Identifier AS A_Component_Id,
            tra.Sorbent_Trap_Serial_Number AS A_Sorbent_Trap_Serial_Number,
            tra.Main_Trap_Hg AS A_Main_Trap_Hg,
            tra.Breakthrough_Trap_Hg AS A_Breakthrough_Trap_Hg,
            tra.Spike_Trap_Hg AS A_Spike_Trap_Hg,
            tra.Spike_Ref_Value AS A_Spike_Ref_Value,
            tra.Total_Sample_Volume AS A_Total_Sample_Volume,
            tra.Ref_Flow_To_Sampling_Ratio AS A_Ref_Flow_To_Sampling_Ratio,
            tra.Hg_Concentration AS A_Hg_Concentration,
            tra.Percent_Breakthrough AS A_Percent_Breakthrough,
            tra.Percent_Spike_Recovery AS A_Percent_Spike_Recovery,
            tra.Sampling_Ratio_Test_Result_Cd AS A_Sampling_Ratio_Test_Result_Cd,
            tra.Post_Leak_Test_Result_Cd AS A_Post_Leak_Test_Result_Cd,
            tra.Train_Qa_Status_Cd AS A_Train_Qa_Status_Cd,
            tra.Sample_Damage_Explanation AS A_Sample_Damage_Explanation,
            -- Sampling Train B
            cpb.Component_Identifier AS B_Component_Id,
            trb.Sorbent_Trap_Serial_Number AS B_Sorbent_Trap_Serial_Number,
            trb.Main_Trap_Hg AS B_Main_Trap_Hg,
            trb.Breakthrough_Trap_Hg AS B_Breakthrough_Trap_Hg,
            trb.Spike_Trap_Hg AS B_Spike_Trap_Hg,
            trb.Spike_Ref_Value AS B_Spike_Ref_Value,
            trb.Total_Sample_Volume AS B_Total_Sample_Volume,
            trb.Ref_Flow_To_Sampling_Ratio AS B_Ref_Flow_To_Sampling_Ratio,
            trb.Hg_Concentration AS B_Hg_Concentration,
            trb.Percent_Breakthrough AS B_Percent_Breakthrough,
            trb.Percent_Spike_Recovery AS B_Percent_Spike_Recovery,
            trb.Sampling_Ratio_Test_Result_Cd AS B_Sampling_Ratio_Test_Result_Cd,
            trb.Post_Leak_Test_Result_Cd AS B_Post_Leak_Test_Result_Cd,
            trb.Train_Qa_Status_Cd AS B_Train_Qa_Status_Cd,
            trb.Sample_Damage_Explanation AS B_Sample_Damage_Explanation,
            lst.Error_Codes
      FROM  (
                SELECT  sel.Mon_Plan_Id,
                        sel.Rpt_Period_Id,
                        sel.Mon_Loc_Id,
                        sys.System_Identifier,
                        camdecmps.FORMAT_DATE_HOUR( trp.Begin_Date, trp.Begin_Hour, null ) AS Date_Hour,
                        camdecmps.FORMAT_DATE_HOUR( trp.End_Date, trp.End_Hour, null ) AS End_Date_Hour,
                        trp.Paired_Trap_Agreement,
                        trp.Absolute_Difference_Ind,
                        trp.Modc_Cd,
                        trp.Hg_Concentration,
                        trp.Rata_Ind,
                        trp.Sorbent_Trap_Aps_Cd,
                        (
                            SELECT  trn.Trap_Train_Id
                              FROM  (
                                        SELECT  sbt.Trap_Id,
                                                min( sbc.Component_Identifier ) as Component_Identifier
                                          FROM  camdecmps.SAMPLING_TRAIN sbt
                                                JOIN CAMDECMPS.COMPONENT sbc
                                                  ON sbc.Component_Id = sbt.Component_Id
                                         WHERE  sbt.Rpt_Period_Id = sel.Rpt_Period_Id
                                           AND  sbt.Trap_Id = trp.Trap_Id
                                         GROUP
                                            BY  sbt.Trap_Id
                                    ) sub
                                    JOIN camdecmps.SAMPLING_TRAIN trn
                                      ON trn.Rpt_Period_Id = sel.Rpt_Period_Id
                                     AND trn.Trap_Id = sub.Trap_Id
                                    JOIN camdecmps.COMPONENT cmp
                                      ON cmp.Component_Id = trn.Component_Id
                                     AND cmp.Component_Identifier = sub.Component_Identifier
                        ) as Min_Trap_Train_Id,
                        (
                            SELECT  trn.Trap_Train_Id
                              FROM  (
                                        SELECT  sbt.Trap_Id,
                                                max( sbc.Component_Identifier ) as Component_Identifier
                                          FROM  camdecmps.SAMPLING_TRAIN sbt
                                                JOIN CAMDECMPS.COMPONENT sbc
                                                  ON sbc.Component_Id = sbt.Component_Id
                                         WHERE  sbt.Rpt_Period_Id = sel.Rpt_Period_Id
                                           AND  sbt.Trap_Id = trp.Trap_Id
                                         GROUP
                                            BY  sbt.Trap_Id
                                    ) sub
                                    JOIN camdecmps.SAMPLING_TRAIN trn
                                      ON trn.Rpt_Period_Id = sel.Rpt_Period_Id
                                     AND trn.Trap_Id = sub.Trap_Id
                                    JOIN camdecmps.COMPONENT cmp
                                      ON cmp.Component_Id = trn.Component_Id
                                     AND cmp.Component_Identifier = sub.Component_Identifier
                        ) as Max_Trap_Train_Id,
                        (
                            SELECT  CASE WHEN max( coalesce( sev.Severity_Level, 0 ) ) > 0 THEN 'Y' ELSE null END
                              FROM  camdecmps.EMISSION_EVALUATION ems
                                    JOIN camdecmpsaux.CHECK_LOG chl
                                      ON chl.Chk_Session_Id = ems.Chk_Session_Id
                                     AND chl.Mon_Loc_Id = sel.Mon_Loc_Id
                                     -- Overlaps Trap
                                     AND ( chl.Op_Begin_Date < trp.End_Date or chl.Op_Begin_Date = trp.End_Date AND chl.Op_Begin_Hour <= trp.End_Hour )
                                     AND ( chl.Op_End_Date > trp.Begin_Date or chl.Op_End_Date = trp.Begin_Date AND chl.Op_End_Hour >= trp.Begin_Hour )
                                    JOIN camdecmpsmd.RULE_CHECK rul
                                      ON rul.Rule_Check_Id = chl.Rule_Check_Id
                                     AND rul.Category_Cd like 'ST%'
                                    LEFT JOIN camdecmpsmd.SEVERITY_CODE sev
                                      ON sev.Severity_Cd = chl.Severity_Cd
                             WHERE  ems.Mon_Plan_Id = sel.Mon_Plan_Id
                               AND  ems.Rpt_Period_Id = sel.Rpt_Period_Id
                        ) as Error_Codes
                  FROM  (
                            SELECT  mpl.Mon_Plan_Id,
                                    prd.Rpt_Period_Id,
                                    mpl.Mon_Loc_Id
                              FROM  camdecmps.MONITOR_PLAN_LOCATION mpl,
                                    camdecmpsmd.REPORTING_PERIOD prd
                             WHERE  mpl.Mon_Plan_Id = vmonplanid        --PARAMETER
                               AND  prd.Rpt_Period_Id = vrptperiodid    --PARAMETER
                        ) sel
                        JOIN camdecmps.SORBENT_TRAP trp
                          ON trp.Rpt_Period_Id = sel.Rpt_Period_Id
                         AND trp.Mon_Loc_Id = sel.Mon_Loc_Id
                        JOIN camdecmps.MONITOR_SYSTEM sys
                          ON sys.Mon_Sys_Id = trp.Mon_Sys_Id
            ) lst
            LEFT JOIN camdecmps.SAMPLING_TRAIN tra
              ON tra.Rpt_Period_Id = lst.Rpt_Period_Id
             AND tra.Trap_Train_Id = lst.Min_Trap_Train_Id
            LEFT JOIN camdecmps.COMPONENT cpa
              ON cpa.Component_Id = tra.Component_Id
            LEFT JOIN camdecmps.SAMPLING_TRAIN trb
              ON trb.Rpt_Period_Id = lst.Rpt_Period_Id
             AND trb.Trap_Train_Id = lst.Max_Trap_Train_Id
            LEFT JOIN camdecmps.COMPONENT cpb
              ON cpb.Component_Id = trb.Component_Id;
  CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'MATSSORBENT');
END
$procedure$
