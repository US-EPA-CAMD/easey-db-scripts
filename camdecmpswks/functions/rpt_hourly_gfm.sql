-- FUNCTION: camdecmpswks.rpt_em_hourly_gas_flow_meter(text, numeric, numeric)

-- DROP FUNCTION camdecmpswks.rpt_em_hourly_gas_flow_meter(text, numeric, numeric);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_em_hourly_gas_flow_meter(
	monplanid text,
	vyear numeric,
	vquarter numeric)
    RETURNS TABLE(location character varying, "componentIdentifier" character varying, "beginEndHourFlg" character varying, "gfmReading" numeric, "avgSamplingRate" numeric, "flowToSamplingRatio" numeric, "calcFlowToSamplingRatio" numeric, "calcFlowToSamplingMult" numeric, "samplingRateUomCode" character varying, "samplingRateUomCodeGroup" text, "samplingRateUomCodeDescription" character varying) 
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
        camdecmpswks.get_config_by_loc_id(hgfm.mon_loc_id) as "location",
        c.component_identifier as "componentIdentifier",
        hgfm.begin_end_hour_flg as "beginEndHourFlg",
        hgfm.gfm_reading as "gfmReading",
        hgfm.avg_sampling_rate as "avgSamplingRate",
        hgfm.flow_to_sampling_ratio as "flowToSamplingRatio",
        hgfm.calc_flow_to_sampling_ratio as "calcFlowToSamplingRatio",
        hgfm.calc_flow_to_sampling_mult as "calcFlowToSamplingMult",

        hgfm.sampling_rate_uom as "samplingRateUomCode",
        'Sampling Rate Unit of Measure Codes' as "samplingRateUomCodeGroup",
        uomc.uom_cd_description as "samplingRateUomCodeDescription"
		
    FROM camdecmpswks.hrly_gas_flow_meter hgfm
	left join camdecmpswks.component c using (component_id)
    left join camdecmpsmd.units_of_measure_code uomc on uomc.uom_cd = hgfm.sampling_rate_uom
    WHERE hgfm.mon_loc_id = ANY (monLocIds) and hgfm.rpt_period_id = rptperiodid; 
END;
$BODY$;

ALTER FUNCTION camdecmpswks.rpt_em_hourly_gas_flow_meter(text, numeric, numeric)
    OWNER TO "uImcwuf4K9dyaxeL";
