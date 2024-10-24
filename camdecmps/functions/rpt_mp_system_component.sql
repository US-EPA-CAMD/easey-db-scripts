-- FUNCTION: camdecmps.rpt_mp_system_component(character varying)

DROP FUNCTION IF EXISTS camdecmps.rpt_mp_system_component(character varying) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.rpt_mp_system_component(
	monplanid character varying)
    RETURNS TABLE("unitStack" text, "systemIdentifier" text, "systemTypeCode" text, "systemTypeCodeGroup" text, "systemTypeCodeDescription" text, "systemDesignation" text, "systemBeginDateHour" text, "systemEndDateHour" text, "componentIdentifier" text, "componentTypeCode" text, "componentTypeCodeGroup" text, "componentTypeCodeDescription" text, "acquisitionMethodCode" text, "acquisitionMethodCodeGroup" text, "acquisitionMethodCodeDescription" text, basis text, manufacturer text, "modelVersion" text, "serialNumber" text, "componentBeginDateHour" text, "componentEndDateHour" text, "hgConverterIndicator" text) 
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
		ms.system_identifier AS "systemIdentifier",
		ms.sys_type_cd AS "systemTypeCode",
		'System Type Codes' AS "systemTypeCodeGroup",
		stc.sys_type_description AS "systemTypeCodeDescription",
		ms.sys_designation_cd || ' - ' || sdc.sys_designation_cd_description AS "systemDesignation",
		camdecmps.format_date_hour(ms.begin_date, ms.begin_hour, null) AS "systemBeginDateHour",
		camdecmps.format_date_hour(ms.end_date, ms.end_hour, null) AS "systemEndDateHour",
		c.component_identifier AS "componentIdentifier",
		c.component_type_cd AS "componentTypeCode",
		'Component Type Codes' AS "componentTypeCodeGroup",
		ctc.component_type_cd_description AS "componentTypeCodeDescription",
		c.acq_cd AS "acquisitionMethodCode",
		'Acquisition Method Codes' AS "acquisitionMethodCodeGroup",
		amc.acq_cd_description AS "acquisitionMethodCodeDescription",
		c.basis_cd || ' - ' || bc.basis_cd_description AS "basis",
		c.manufacturer AS "manufacturer",
		c.model_version AS "modelVersion",
		c.serial_number AS "serialNumber",
		camdecmps.format_date_hour(msc.begin_date, msc.begin_hour, null) AS "componentBeginDateHour",
		camdecmps.format_date_hour(msc.end_date, msc.end_hour, null) AS "componentEndDateHour",
		camdecmps.format_indicator(c.hg_converter_ind, true) AS "hgConverterIndicator"
	FROM camdecmps.monitor_system ms
	JOIN camdecmps.monitor_plan_location mpl ON ms.mon_loc_id = mpl.mon_loc_id
	JOIN camdecmps.monitor_location ml ON mpl.mon_loc_id = ml.mon_loc_id
	JOIN camdecmps.monitor_system_component msc USING(mon_sys_id)
	JOIN camdecmps.component c USING(component_id)
	JOIN camdecmpsmd.system_type_code stc USING(sys_type_cd)
	JOIN camdecmpsmd.component_type_code ctc USING(component_type_cd)
	LEFT JOIN camdecmpsmd.system_designation_code sdc USING(sys_designation_cd)
	LEFT JOIN camdecmpsmd.acquisition_method_code amc USING(acq_cd)
	LEFT JOIN camdecmpsmd.basis_code bc USING(basis_cd)
	LEFT JOIN camdecmps.stack_pipe sp USING(stack_pipe_id)
    LEFT JOIN camd.unit u USING(unit_id)
	WHERE mpl.mon_plan_id = monPlanId
	ORDER BY u.unitid, sp.stack_name, ms.system_identifier, c.component_identifier;
$BODY$;
