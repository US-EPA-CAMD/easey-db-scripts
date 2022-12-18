CREATE OR REPLACE FUNCTION camdecmpswks.mats_hourly_gas_flow_meter_record(
	monplanid character varying,
	rptperiodid numeric)
    RETURNS TABLE(location_name character varying, begin_datehour timestamp without time zone, component_identifier character varying, component_type_cd character varying, begin_end_hour_flg character varying, gfm_reading numeric, avg_sampling_rate numeric, sampling_rate_uom character varying, flow_to_sampling_ratio numeric, hrly_gas_flow_meter_id character varying, hour_id character varying, component_id character varying, mon_loc_id character varying, mon_plan_id character varying, rpt_period_id numeric) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
 RETURN QUERY
select	COALESCE(unt.UNITID, stp.STACK_NAME) LOCATION_NAME,
			camdecmpswks.Format_Date_Time(hod.BEGIN_DATE, hod.BEGIN_HOUR, 0) BEGIN_DATEHOUR,
			cmp.COMPONENT_IDENTIFIER,
			cmp.COMPONENT_TYPE_CD,
			gfm.BEGIN_END_HOUR_FLG,
			gfm.GFM_READING,
			gfm.AVG_SAMPLING_RATE,
			gfm.SAMPLING_RATE_UOM,
			gfm.FLOW_TO_SAMPLING_RATIO,
			gfm.HRLY_GAS_FLOW_METER_ID,
			gfm.HOUR_ID,
			gfm.COMPONENT_ID,
			mpl.MON_LOC_ID,
			ems.MON_PLAN_ID,
			ems.RPT_PERIOD_ID
		from	camdecmpswks.EMISSION_EVALUATION ems
				join camdecmpsmd.REPORTING_PERIOD prd 	on	prd.RPT_PERIOD_ID = ems.RPT_PERIOD_ID
				join camdecmpswks.MONITOR_PLAN_LOCATION mpl on	mpl.MON_PLAN_ID = ems.MON_PLAN_ID
				join camdecmpswks.MONITOR_LOCATION loc 	on	loc.MON_LOC_ID = mpl.MON_LOC_ID
				left join camd.UNIT unt 	on	unt.UNIT_ID = loc.UNIT_ID
				left join camdecmpswks.STACK_PIPE stp on	stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
				join camdecmpswks.HRLY_GAS_FLOW_METER gfm on gfm.MON_LOC_ID = mpl.MON_LOC_ID
						and gfm.RPT_PERIOD_ID = prd.RPT_PERIOD_ID
				join camdecmpswks.HRLY_OP_DATA hod	on	hod.HOUR_ID = gfm.HOUR_ID
				left join camdecmpswks.COMPONENT cmp on	cmp.COMPONENT_ID = gfm.COMPONENT_ID;
END;
$BODY$;