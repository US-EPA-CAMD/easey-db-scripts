-- FUNCTION: camdecmps.rpt_mp_location_attribute(character varying)

DROP FUNCTION IF EXISTS camdecmps.rpt_mp_location_attribute(character varying) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.rpt_mp_location_attribute(
	monplanid character varying)
    RETURNS TABLE("unitStack" text, "ductIndicator" text, "groundElevation" numeric, "stackHeight" numeric, "crossAreaExit" numeric, "crossAreaFlow" numeric, "materialCode" text, "materialCodeGroup" text, "materialCodeDescription" text, "shapeCode" text, "shapeCodeGroup" text, "shapeCodeDescription" text, "beginDate" text, "endDate" text) 
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
SELECT
		CASE
			WHEN ml.unit_id IS NULL THEN sp.stack_name
			ELSE u.unitid
		END AS "unitStack",
		camdecmps.format_indicator(mla.duct_ind, true) AS "ductIndicator",
		mla.grd_elevation AS "groundElevation",
		mla.stack_height AS "stackHeight",
		mla.cross_area_exit AS "crossAreaExit",
		mla.cross_area_flow AS "crossAreaFlow",
		mla.material_cd AS "materialCode",
		'Material Codes' AS "materialCodeGroup",
		mc.material_code_description AS "materialCodeDescription",
		mla.shape_cd AS "shapeCode",
		'Shape Codes' AS "shapeCodeGroup",
		sc.shape_cd_description AS "ShapeCodeDescription",
		camdecmps.format_date_hour(mla.begin_date, null, null) AS "beginDate",
		camdecmps.format_date_hour(mla.end_date, null, null) AS "endDate"
	FROM camdecmps.monitor_location_attribute mla
	JOIN camdecmps.monitor_plan_location mpl USING(mon_loc_id)
  	JOIN camdecmps.monitor_location ml USING(mon_loc_id)
	LEFT JOIN camdecmpsmd.material_code mc USING(material_cd)
	LEFT JOIN camdecmpsmd.shape_code sc USING(shape_cd)
	LEFT JOIN camdecmps.stack_pipe sp USING(stack_pipe_id)
  	LEFT JOIN camd.unit u USING(unit_id)
	WHERE mpl.mon_plan_id = monPlanId
	ORDER BY u.unitid, sp.stack_name, mla.begin_date;
$BODY$;
