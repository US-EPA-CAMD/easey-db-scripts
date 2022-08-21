-- FUNCTION: camdecmpswks.rpt_mp_location_attribute(character varying)

-- DROP FUNCTION camdecmpswks.rpt_mp_location_attribute(character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_mp_location_attribute(
	monplanid character varying)
    RETURNS TABLE("unitStack" text, "ductIndicator" numeric, "groundElevation" numeric, "stackHeight" numeric, "crossAreaExit" numeric, "crossAreaFlow" numeric, "materialCode" character varying, "materialCodeDescription" character varying, "shapeCode" character varying, "shapeCodeDescription" character varying, "beginDate" text, "endDate" text) 
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
		mla.duct_ind AS "ductIndicator",
		mla.grd_elevation AS "groundElevation",
		mla.stack_height AS "stackHeight",
		mla.cross_area_exit AS "crossAreaExit",
		mla.cross_area_flow AS "crossAreaFlow",
		mla.material_cd AS "materialCode",
		mc.material_code_description AS "materialCodeDescription",
		mla.shape_cd AS "shapeCode",
		sc.shape_cd_description AS "ShapeCodeDescription",
		CAST(mla.begin_date AS text) AS "beginDate",
		CAST(mla.end_date AS text) AS "endDate"
	FROM camdecmpswks.monitor_location_attribute mla
	 JOIN camdecmpsmd.material_code mc USING(material_cd)
	 JOIN camdecmpsmd.shape_code sc USING(shape_cd)
	 JOIN camdecmpswks.monitor_plan_location mpl USING(mon_loc_id)
	 JOIN camdecmpswks.monitor_location ml USING(mon_loc_id)
	 LEFT JOIN camdecmpswks.stack_pipe sp USING(stack_pipe_id)
     LEFT JOIN camd.unit u USING(unit_id)
	WHERE mpl.mon_plan_id = monPlanId;
$BODY$;
