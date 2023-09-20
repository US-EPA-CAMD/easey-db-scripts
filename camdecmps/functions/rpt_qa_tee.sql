CREATE OR REPLACE FUNCTION camdecmps.rpt_qa_tee(
	teeid text[])
    RETURNS TABLE("unitStack" text, "extensionExemptionType" text, "rptPeriodAbr" text, "systemIdentifier" text, "systemTypeCode" text, "componentIdentifier" text, "componentTypeCode" text, "spanScaleCd" text, "fuelCd" text, "hoursUsed" numeric, "submissionStatus" text) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
SELECT
		CASE
			WHEN ml.stack_pipe_id IS NOT NULL THEN sp.stack_name
			WHEN ml.unit_id IS NOT NULL THEN u.unitid
			ELSE '*'
		END AS "unitStack",
		tee.extens_exempt_cd as "extensionExemptionType",
		rp.period_abbreviation as "rptPeriodAbr",
		ms.system_identifier AS "systemIdentifier",
		ms.sys_type_cd AS "systemTypeCode",
		c.component_identifier AS "componentIdentifier",
		c.component_type_cd AS "componentTypeCode",
		tee.span_scale_cd as "spanScaleCd",
		tee.fuel_cd as "fuelCd",
		tee.hours_used as "hoursUsed",
		tee.submission_availability_cd AS "submissionStatus"
	FROM camdecmps.test_extension_exemption tee
	JOIN camdecmpsmd.reporting_period rp USING(rpt_period_id)
	JOIN camdecmps.monitor_location ml USING(mon_loc_id)
	LEFT JOIN camdecmps.monitor_system ms USING(mon_sys_id)
	LEFT JOIN camdecmps.component c USING(component_id)
	LEFT JOIN camdecmps.stack_pipe sp USING(stack_pipe_id)
	LEFT JOIN camd.unit u USING(unit_id)
	WHERE tee.test_extension_exemption_id = ANY(teeid);
$BODY$;