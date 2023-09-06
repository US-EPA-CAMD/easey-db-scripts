-- FUNCTION: camdecmpswks.rpt_em_sampling_train(text, numeric, numeric)

-- DROP FUNCTION camdecmpswks.rpt_em_sampling_train(text, numeric, numeric);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_em_sampling_train(
	monplanid text,
	vyear numeric,
	vquarter numeric)
    RETURNS TABLE(location character varying, "componentIdentifier" character varying, "sorbentTrapSerialNumber" character varying, "mainTrapHg" character varying, "breakthroughTrapHg" character varying, "spikeTrapHg" character varying, "spikeRefValue" character varying, "totalSampleVolume" numeric, "refFlowToSamplingRatio" numeric, "hgConcentration" character varying, "percentBreakthrough" numeric, "percentSpikeRecovery" numeric, "sampleDamageExplanation" character varying, "calcHgConcentration" character varying, "calcPercentBreakthrough" numeric, "calcPercentSpikeRecovery" numeric, "samplingRatioTestResultCode" character varying, "samplingRatioTestResultCodeGroup" text, "samplingRatioTestResultCodeDescription" character varying, "postLeakTestResultCode" character varying, "postLeakTestResultCodeGroup" text, "postLeakTestResultCodeDescription" character varying, "trainQaStatusCode" character varying, "trainQaStatusCodeGroup" text, "trainQaStatusCodeGroupDescription" character varying) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
DECLARE 
    monLocIds character varying[];
	rptperiodid numeric;
BEGIN

	SELECT rpt_period_id 
	INTO rptperiodid
	FROM camdecmpsmd.reporting_period
	WHERE calendar_year = vyear and quarter = vquarter;

    SELECT ARRAY(
        SELECT mon_loc_id
        FROM camdecmpswks.monitor_plan_location
        WHERE mon_plan_id = monplanid 
    ) INTO monLocIds;

    RETURN QUERY
    SELECT
        camdecmpswks.get_config_by_loc_id(st.mon_loc_id) as "location",
        c.component_identifier as "componentIdentifier",
        st.sorbent_trap_serial_number as "sorbentTrapSerialNumber",
        st.main_trap_hg as "mainTrapHg",
        st.breakthrough_trap_hg as "breakthroughTrapHg",
        st.spike_trap_hg as "spikeTrapHg",
        st.spike_ref_value as "spikeRefValue",
        st.total_sample_volume as "totalSampleVolume",
        st.ref_flow_to_sampling_ratio as "refFlowToSamplingRatio",
        st.hg_concentration as "hgConcentration",
        st.percent_breakthrough as "percentBreakthrough",
        st.percent_spike_recovery as "percentSpikeRecovery",
        st.sample_damage_explanation as "sampleDamageExplanation",
        st.calc_hg_concentration as "calcHgConcentration",
        st.calc_percent_breakthrough as "calcPercentBreakthrough",
        st.calc_percent_spike_recovery as "calcPercentSpikeRecovery",

        st.sampling_ratio_test_result_cd as "samplingRatioTestResultCode",
        'Sampling Ratio Test Result Codes' as "samplingRatioTestResultCodeGroup",
        trc.test_result_cd_description as "samplingRatioTestResultCodeDescription",

        st.post_leak_test_result_cd as "postLeakTestResultCode",
        'Post Leak Test Result Codes' as "postLeakTestResultCodeGroup",
        trc.test_result_cd_description as "postLeakTestResultCodeDescription",

         st.train_qa_status_cd as "trainQaStatusCode",
        'Train QA Status Codes' as "trainQaStatusCodeGroup",
        tqsc.train_qa_status_description as "trainQaStatusCodeGroupDescription"
       

		
    FROM camdecmpswks.sampling_train st
	left join camdecmpswks.component c using (component_id)
    left join camdecmpsmd.train_qa_status_code tqsc using (train_qa_status_cd)
    left join camdecmpsmd.test_result_code trc on trc.test_result_cd = st.sampling_ratio_test_result_cd
    WHERE st.mon_loc_id = ANY (monLocIds) and st.rpt_period_id = rptperiodid; 
END;
$BODY$;

ALTER FUNCTION camdecmpswks.rpt_em_sampling_train(text, numeric, numeric)
    OWNER TO "uImcwuf4K9dyaxeL";
