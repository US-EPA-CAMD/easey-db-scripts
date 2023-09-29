-- FUNCTION: camdecmps.rpt_em_daily_calibration(text, numeric, numeric)

DROP FUNCTION IF EXISTS camdecmps.rpt_em_daily_calibration(text, numeric, numeric) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.rpt_em_daily_calibration(
	monplanid text,
	vyear numeric,
	vquarter numeric)
    RETURNS TABLE(location character varying, "onlineOfflineInd" numeric, "calcOnlineOfflineInd" numeric, "zeroInjectionDate" date, "zeroInjectionHour" numeric, "zeroInjectionMin" numeric, "upscaleInjectionDate" date, "upscaleInjectionHour" numeric, "upscaleInjectionMin" numeric, "zeroMeasuredValue" numeric, "upscaleMeasuredValue" numeric, "zeroApsInd" numeric, "calcZeroApsInd" numeric, "upscaleApsInd" numeric, "calcUpscaleApsInd" numeric, "zeroCalError" numeric, "calcZeroCalError" numeric, "upscaleCalError" numeric, "calcUpscaleCalError" numeric, "zeroRefValue" numeric, "upscaleRefValue" numeric, "vendorId" character varying, "cylinderIdentifier" character varying, "expirationDate" date, "upscaleGasTypeCode" character varying, "upscaleGasLevelCode" character varying, "upscaleGasLevelCodeGroup" text, "upscaleGasLevelCodeDescription" character varying, "injectionProtocolCode" character varying, "injectionProtocolCodeGroup" text, "injectionPorotcolCodeDescription" character varying) 
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
        FROM camdecmps.monitor_plan_location
        WHERE mon_plan_id = monplanid 
    ) INTO monLocIds;

    RETURN QUERY
    SELECT
        camdecmps.get_config_by_loc_id(dts.mon_loc_id) as "location",
		dc.online_offline_ind as "onlineOfflineInd",
		dc.calc_online_offline_ind as "calcOnlineOfflineInd",
		dc.zero_injection_date as "zeroInjectionDate",
		dc.zero_injection_hour as "zeroInjectionHour",
		dc.zero_injection_min as "zeroInjectionMin",
		dc.upscale_injection_date as "upscaleInjectionDate",
		dc.upscale_injection_hour as "upscaleInjectionHour",
		dc.upscale_injection_min as "upscaleInjectionMin",
		dc.zero_measured_value as "zeroMeasuredValue",
		dc.upscale_measured_value as "upscaleMeasuredValue",
		dc.zero_aps_ind as "zeroApsInd",
		dc.calc_zero_aps_ind as "calcZeroApsInd",
		dc.upscale_aps_ind as "upscaleApsInd",
		dc.calc_upscale_aps_ind as "calcUpscaleApsInd",
		dc.zero_cal_error as "zeroCalError",
		dc.calc_zero_cal_error as "calcZeroCalError",
		dc.upscale_cal_error as "upscaleCalError",
		dc.calc_upscale_cal_error as "calcUpscaleCalError",
		dc.zero_ref_value as "zeroRefValue",
		dc.upscale_ref_value as "upscaleRefValue",
		dc.vendor_id as "vendorId",
		dc.cylinder_identifier as "cylinderIdentifier",
		dc.expiration_date as "expirationDate",
		dc.upscale_gas_type_cd as "upscaleGasTypeCode",

		dc.upscale_gas_level_cd as "upscaleGasLevelCode",
		'Upscale Gas Level Codes' as "upscaleGasLevelCodeGroup",
		glc.gas_level_description as "upscaleGasLevelCodeDescription",
		
		dc.injection_protocol_cd as "injectionProtocolCode",
		'Injection Protocol Codes' as "injectionProtocolCodeGroup",
		ipc.injection_protocol_description as "injectionPorotcolCodeDescription"
		
    FROM camdecmps.daily_calibration dc
	join camdecmps.daily_test_summary dts using (daily_test_sum_id)
	left join camdecmpsmd.gas_level_code glc ON glc.gas_level_cd = dc.upscale_gas_level_cd
	left join camdecmpsmd.injection_protocol_code ipc using (injection_protocol_cd)
	WHERE dts.mon_loc_id = ANY (monLocIds) and dc.rpt_period_id = rptperiodid; 
END;
$BODY$;
