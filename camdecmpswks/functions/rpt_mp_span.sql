-- FUNCTION: camdecmpswks.rpt_mp_span(character varying)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_mp_span(character varying) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_mp_span(
	monplanid character varying)
    RETURNS TABLE("unitStack" text, "componentTypeCode" text, "componentTypeCodeGroup" text, "componentTypeCodeDescription" text, "spanScaleLevel" text, "spanMethodCode" text, "spanMethodCodeGroup" text, "spanMethodCodeDescription" text, "mpcOrMpfValue" numeric, "mecValue" numeric, "spanValue" numeric, "fullScaleRange" numeric, "unitsOfMeasureCode" text, "unitsOfMeasureCodeGroup" text, "unitsOfMeasureCodeDescription" text, "scaleTransitionPoint" numeric, "defaultHighRange" numeric, "flowFullScaleRange" numeric, "flowSpanValue" numeric, "beginDateHour" text, "endDateHour" text) 
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
SELECT
		CASE
			WHEN ml.stack_pipe_id IS NOT NULL THEN sp.stack_name
			WHEN ml.unit_id IS NOT NULL THEN u.unitid
			ELSE '*'
		END AS "unitStack",
		ms.component_type_cd AS "componentTypeCode",
		'Component Type Codes' AS "componentTypeCodeGroup",
		ctc.component_type_cd_description AS "componentTypeCodeDescription",
		ssc.span_scale_cd_description AS "spanScale",
		ms.span_method_cd AS "spanMethodCode",
		'Span Method Codes' AS "spanMethodCodeGroup",
		smc.span_method_cd_description AS "spanMethodCodeDescription",
		COALESCE(ms.mpc_value, ms.mpf_value) AS "mpcOrMpfValue",
		ms.mec_value AS "mecValue",
		ms.span_value AS "spanValue",
		ms.full_scale_range AS "fullScaleRange",
		ms.span_uom_cd AS "unitsOfMeasureCode",
		'Units of Measure' AS "unitsOfMeasureCodeGroup",
		uom.uom_cd_description AS "unitsOfMeasureCodeDescription",
		ms.max_low_range AS "scaleTransitionPoint",
		ms.default_high_range AS "defaultHighRange",
		ms.flow_full_scale_range AS "flowFullScaleRange",
		ms.flow_span_value AS "flowSpanValue",
		camdecmpswks.format_date_hour(ms.begin_date, ms.begin_hour, null) AS "beginDateHour",
		camdecmpswks.format_date_hour(ms.end_date, ms.end_hour, null) AS "endDateHour"
	FROM camdecmpswks.monitor_span ms
	JOIN camdecmpswks.monitor_plan_location mpl USING(mon_loc_id)
	JOIN camdecmpswks.monitor_location ml USING(mon_loc_id)
	JOIN camdecmpsmd.component_type_code ctc USING(component_type_cd)
	LEFT JOIN camdecmpsmd.span_scale_code ssc USING(span_scale_cd)
	LEFT JOIN camdecmpsmd.span_method_code smc USING(span_method_cd)
	LEFT JOIN camdecmpsmd.units_of_measure_code uom ON ms.span_uom_cd = uom.uom_cd
	LEFT JOIN camdecmpswks.stack_pipe sp USING(stack_pipe_id)
    LEFT JOIN camd.unit u USING(unit_id)
	WHERE mpl.mon_plan_id = monPlanId
	ORDER BY u.unitid, sp.stack_name, ms.component_type_cd, ssc.span_scale_cd_description, ms.span_method_cd, ms.begin_date, ms.begin_hour;
$BODY$;
