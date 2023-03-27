-- FUNCTION: camdecmpswks.mats_sampling_train_record(character varying, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.mats_sampling_train_record(character varying, numeric);

CREATE OR REPLACE FUNCTION camdecmpswks.mats_sampling_train_record(
	monplanid character varying,
	rptperiodid numeric)
    RETURNS TABLE(location_name character varying, begin_datehour timestamp without time zone, end_datehour timestamp without time zone, component_identifier character varying, component_type_cd character varying, trap_modc_cd character varying, train_qa_status_cd character varying, ref_flow_to_sampling_ratio numeric, hg_concentration character varying, main_trap_hg character varying, breakthrough_trap_hg character varying, spike_trap_hg character varying, spike_ref_value character varying, total_sample_volume numeric, percent_breakthrough numeric, percent_spike_recovery numeric, sampling_ratio_test_result_cd character varying, post_leak_test_result_cd character varying, sample_damage_explanation character varying, sorbent_trap_serial_number character varying, rata_ind numeric, sorbent_trap_aps_cd character varying, sfsr_total_count numeric, sfsr_deviated_count numeric, gfm_total_count numeric, gfm_not_available_count numeric, description text, border_trap_ind integer, supp_data_ind integer, trap_train_id character varying, trap_id character varying, component_id character varying, mon_loc_id character varying, mon_plan_id character varying, rpt_period_id numeric) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
BEGIN
return query
 (with sel as
    (select  mpl.MON_PLAN_ID, prd.RPT_PERIOD_ID, mpl.MON_LOC_ID, prd.BEGIN_DATE, prd.END_DATE
          from  camdecmpswks.MONITOR_PLAN_LOCATION mpl,
                camdecmpsMD.REPORTING_PERIOD prd
         where  (monPlanId is null or mpl.MON_PLAN_ID = monPlanId)
           and  (rptPeriodId is null or prd.RPT_PERIOD_ID = rptPeriodId)
    )
select	COALESCE(unt.UNITID, stp.STACK_NAME) LOCATION_NAME,
			camdecmpswks.Format_Date_Time(dat.BEGIN_DATE, dat.BEGIN_HOUR, 0) BEGIN_DATEHOUR,
			camdecmpswks.Format_Date_Time(dat.END_DATE, dat.END_HOUR, 0) END_DATEHOUR,
            cmp.COMPONENT_IDENTIFIER,
            cmp.COMPONENT_TYPE_CD,
            dat.TRAP_MODC_CD,
            dat.TRAIN_QA_STATUS_CD,
            dat.REF_FLOW_TO_SAMPLING_RATIO,
            dat.HG_CONCENTRATION,
            dat.MAIN_TRAP_HG,
            dat.BREAKTHROUGH_TRAP_HG,
            dat.SPIKE_TRAP_HG,
            dat.SPIKE_REF_VALUE,
            dat.TOTAL_SAMPLE_VOLUME,
            dat.PERCENT_BREAKTHROUGH,
            dat.PERCENT_SPIKE_RECOVERY,
            dat.SAMPLING_RATIO_TEST_RESULT_CD,
            dat.POST_LEAK_TEST_RESULT_CD,
            dat.SAMPLE_DAMAGE_EXPLANATION,
            dat.SORBENT_TRAP_SERIAL_NUMBER,
            dat.RATA_IND,
            dat.SORBENT_TRAP_APS_CD,
            dat.SFSR_TOTAL_COUNT,
            dat.SFSR_DEVIATED_COUNT,
            dat.GFM_TOTAL_COUNT,
            dat.GFM_NOT_AVAILABLE_COUNT,
            (
            sys.SYSTEM_IDENTIFIER || '/' || cmp.COMPONENT_IDENTIFIER 
            || ' from ' ||date_part('month', dat.begin_date)||'/'||date_part('day', dat.begin_date)||'-'||(case when dat.begin_hour<10 then '0'||cast(dat.begin_hour as varchar) 
else cast(dat.begin_hour as varchar) end)
            || ' through ' ||date_part('month', dat.END_DATE)||'/'||date_part('day',  dat.END_DATE)||'-'||(case when  dat.END_hour<10 then '0'||cast(dat.END_hour as varchar) 
else cast(dat.END_hour as varchar) end)
			 ) DESCRIPTION,
            dat.BORDER_TRAP_IND,
            dat.SUPP_DATA_IND,
            dat.TRAP_TRAIN_ID,
            dat.TRAP_ID,
            dat.COMPONENT_ID,
            dat.MON_LOC_ID,
            dat.MON_PLAN_ID,
            dat.RPT_PERIOD_ID
      from  (
                -- Emission Report Train
                select  trn.TRAP_TRAIN_ID,
                        trn.TRAP_ID,
                        trp.MON_SYS_ID,
                        trn.COMPONENT_ID,
                        trp.BEGIN_DATE,
                        trp.BEGIN_HOUR,
                        trp.END_DATE,
                        trp.END_HOUR,
                        trp.MODC_CD TRAP_MODC_CD,
                        trn.TRAIN_QA_STATUS_CD,
                        trn.REF_FLOW_TO_SAMPLING_RATIO,
                        trn.SAMPLING_RATIO_TEST_RESULT_CD,
                        trn.HG_CONCENTRATION,
                        trn.MAIN_TRAP_HG,
                        trn.BREAKTHROUGH_TRAP_HG,
                        trn.SPIKE_TRAP_HG,
                        trn.SPIKE_REF_VALUE,
                        trn.TOTAL_SAMPLE_VOLUME,
                        trn.PERCENT_BREAKTHROUGH,
                        trn.PERCENT_SPIKE_RECOVERY,
                        trn.POST_LEAK_TEST_RESULT_CD,
                        trn.SAMPLE_DAMAGE_EXPLANATION,
                        trn.SORBENT_TRAP_SERIAL_NUMBER,
                        trp.RATA_IND,
                        trp.SORBENT_TRAP_APS_CD,
                        null SFSR_TOTAL_COUNT,
                        null SFSR_DEVIATED_COUNT,
                        null GFM_TOTAL_COUNT,
                        null GFM_NOT_AVAILABLE_COUNT,
                        case when sel.END_DATE < trp.END_DATE then 1 else 0 end BORDER_TRAP_IND,
                        0 SUPP_DATA_IND,
                        sel.MON_PLAN_ID,
                        sel.RPT_PERIOD_ID,
                        sel.MON_LOC_ID
                  from  sel
                        join camdecmpswks.SAMPLING_TRAIN trn on trn.MON_LOC_ID = sel.MON_LOC_ID and trn.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
                        join camdecmpswks.SORBENT_TRAP trp on trp.TRAP_ID = trn.TRAP_ID
                union   all
                -- Supplemental Train
                select  trn.TRAP_TRAIN_ID,
                        trn.TRAP_ID,
                        trp.MON_SYS_ID,
                        trn.COMPONENT_ID,
                        trp.BEGIN_DATE,
                        trp.BEGIN_HOUR,
                        trp.END_DATE,
                        trp.END_HOUR,
                        trp.MODC_CD TRAP_MODC_CD,
                        trn.TRAIN_QA_STATUS_CD,
                        trn.REF_FLOW_TO_SAMPLING_RATIO,
                        trn.SAMPLING_RATIO_TEST_RESULT_CD,
                        trn.HG_CONCENTRATION,
                        null MAIN_TRAP_HG,
                        null BREAKTHROUGH_TRAP_HG,
                        null SPIKE_TRAP_HG,
                        null SPIKE_REF_VALUE,
                        null TOTAL_SAMPLE_VOLUME,
                        null PERCENT_BREAKTHROUGH,
                        null PERCENT_SPIKE_RECOVERY,
                        null POST_LEAK_TEST_RESULT_CD,
                        null SAMPLE_DAMAGE_EXPLANATION,
                        null SORBENT_TRAP_SERIAL_NUMBER,
                        trp.RATA_IND,
                        trp.SORBENT_TRAP_APS_CD,
                        trn.SFSR_TOTAL_COUNT,
                        trn.SFSR_DEVIATED_COUNT,
                        trn.GFM_TOTAL_COUNT,
                        trn.GFM_NOT_AVAILABLE_COUNT,
                        1 BORDER_TRAP_IND,
                        1 SUPP_DATA_IND,
                        sel.MON_PLAN_ID,
                        trn.RPT_PERIOD_ID, -- Show the RPT_PERIOD_ID for the supplemental (border) data.
                        sel.MON_LOC_ID
                  from  sel
                        join camdecmpswks.SORBENT_TRAP_SUPP_DATA trp
                          on trp.MON_LOC_ID = sel.MON_LOC_ID
                         and trp.RPT_PERIOD_ID != sel.RPT_PERIOD_ID -- Only pull supplemental if it was not reported in the quarter of the current emissions report.
                         and trp.BEGIN_DATE < sel.BEGIN_DATE
                         and trp.END_DATE >= sel.BEGIN_DATE
                        join camdecmpswks.SAMPLING_TRAIN_SUPP_DATA trn on trn.TRAP_ID = trp.TRAP_ID
            ) dat
            join camdecmpswks.MONITOR_LOCATION loc on loc.MON_LOC_ID = dat.MON_LOC_ID
            left join camd.UNIT unt on unt.UNIT_ID = loc.UNIT_ID
            left join camdecmpswks.STACK_PIPE stp on stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
            left join camdecmpswks.COMPONENT cmp on cmp.COMPONENT_ID = dat.COMPONENT_ID
			join camdecmpswks.MONITOR_SYSTEM sys on sys.MON_SYS_ID = dat.MON_SYS_ID
);
end;
$BODY$;
