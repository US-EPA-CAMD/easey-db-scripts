-- FUNCTION: camdecmpswks.rpt_mp_unit_fuel(character varying)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_mp_unit_fuel(character varying) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_mp_unit_fuel(
	monplanid character varying)
    RETURNS TABLE("unitIdentifier" text, "fuelTypeCode" text, "fuelTypeCodeGroup" text, "fuelTypeCodeDescription" text, "fuelIndicator" text, "gcvDemMethodCode" text, "gcvDemMethodCodeGroup" text, "gcvDemMethodCodeDescription" text, "so2DemMethodCode" text, "so2DemMethodCodeGroup" text, "so2DemMethodCodeDescription" text, "ozoneSeasonIndicator" text, "beginDate" text, "endDate" text) 
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
SELECT
		u.unitid AS "unitIdentifier",
		uf.fuel_type AS "fuelTypeCode",
		'Fuel Type Codes' AS "fuelTypeCodeGroup",
		ftc.fuel_type_description AS "fuelTypeCodeDescription",
		uf.indicator_cd || ' - ' || fic.fuel_indicator_description AS "fuelIndicator",
		uf.dem_gcv AS "gcvDemMethodCode",
		'Dem Method Codes' AS "gcvDemMethodCodeGroup",
		dmc1.dem_method_description AS "gcvDemMethodCodeDescription",
		uf.dem_so2 AS "so2DemMethodCode",
		'Dem Method Codes' AS "so2DemMethodCodeGroup",
		dmc2.dem_method_description AS "so2DemMethodCodeDescription",
		camdecmpswks.format_indicator(uf.ozone_seas_ind, true) AS "ozoneSeasonIndicator",
		camdecmpswks.format_date_hour(uf.begin_date, null, null) AS "beginDate",
		camdecmpswks.format_date_hour(uf.end_date, null, null) AS "beginDate"
	FROM camdecmpswks.unit_fuel uf
	JOIN camd.unit u USING(unit_id)
	JOIN camdecmpswks.monitor_location ml USING(unit_id)
	JOIN camdecmpswks.monitor_plan_location mpl USING(mon_loc_id)
	JOIN camdecmpsmd.fuel_type_code ftc on uf.fuel_type = ftc.fuel_type_cd
	LEFT JOIN camdecmpsmd.fuel_indicator_code fic ON uf.indicator_cd = fic.fuel_indicator_cd
	LEFT JOIN camdecmpsmd.dem_method_code dmc1 ON uf.dem_gcv = dmc1.dem_method_cd
	LEFT JOIN camdecmpsmd.dem_method_code dmc2 ON uf.dem_so2 = dmc2.dem_method_cd
	WHERE mpl.mon_plan_id = monPlanId
	ORDER BY u.unitid, uf.begin_date;
$BODY$;
