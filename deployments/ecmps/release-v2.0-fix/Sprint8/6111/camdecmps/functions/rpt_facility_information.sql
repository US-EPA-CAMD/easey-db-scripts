-- FUNCTION: camdecmps.rpt_facility_information(numeric)

DROP FUNCTION IF EXISTS camdecmps.rpt_facility_information(numeric) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.rpt_facility_information(
	vfacilityid numeric)
    RETURNS TABLE("facilityName" text, "orisCode" numeric, "stateCode" text, "countyName" text, latitude numeric, longitude numeric) 
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
SELECT
		p.facility_name AS "facilityName",
		p.oris_code AS "orisCode",
		p.state AS "stateCode",
		cc.county_name AS "countyName",
		p.latitude AS "latitude",
		p.longitude AS "longitude"
	FROM camd.plant p
	JOIN camdmd.county_code cc USING(county_cd)
	WHERE p.oris_code = vFacilityId;
$BODY$;

-- FUNCTION: camdecmps.rpt_facility_information(numeric, text, numeric, numeric)

DROP FUNCTION IF EXISTS camdecmps.rpt_facility_information(numeric, text, numeric, numeric) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.rpt_facility_information(
	vfacilityid numeric,
	vmonplanid text,
	vyear numeric,
	vquarter numeric)
    RETURNS TABLE("facilityName" text, "orisCode" numeric, "locationInfo" text, "stateCode" text, "countyName" text, latitude numeric, longitude numeric, "yearQuarter" text, "totalHours" numeric) 
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
SELECT
		p.facility_name AS "facilityName",
		p.oris_code AS "orisCode",
		(
			SELECT
				string_agg(coalesce(unitid, stack_name), ', ')
			FROM (
				SELECT
					u.unitid,
					sp.stack_name
				FROM camdecmps.monitor_plan_location mpl
				JOIN camdecmps.monitor_location ml USING(mon_loc_id)
				LEFT JOIN camdecmps.stack_pipe sp USING(stack_pipe_id)
				LEFT JOIN camd.unit u USING(unit_id)
				WHERE mon_plan_id = vMonPlanId
				GROUP BY u.unitid, sp.stack_name
				ORDER BY u.unitid, sp.stack_name
			) d
		) AS "locationInfo",
		p.state AS "stateCode",
		cc.county_name AS "countyName",
		p.latitude AS "latitude",
		p.longitude AS "longitude",
		rp.period_abbreviation AS "yearQuarter",
		((end_date + 1) - begin_date) * 24::numeric AS "totalHours"
	FROM camd.plant p
	JOIN camdmd.county_code cc USING(county_cd),
	camdecmpsmd.reporting_period rp
	WHERE p.oris_code = vFacilityId AND
	rp.calendar_year = vYear AND rp.quarter = vQuarter;
$BODY$;

-- FUNCTION: camdecmps.rpt_facility_information(numeric, text)

DROP FUNCTION IF EXISTS camdecmps.rpt_facility_information(numeric, text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.rpt_facility_information(
	vfacilityid numeric,
	vmonplanid text)
    RETURNS TABLE("facilityName" text, "orisCode" numeric, "locationInfo" text, "stateCode" text, "countyName" text) 
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
SELECT
		p.facility_name AS "facilityName",
		p.oris_code AS "orisCode",
		(
			SELECT
				string_agg(coalesce(unitid, stack_name), ', ')
			FROM (
				SELECT
					u.unitid,
					sp.stack_name
				FROM camdecmps.monitor_plan_location mpl
				JOIN camdecmps.monitor_location ml USING(mon_loc_id)
				LEFT JOIN camdecmps.stack_pipe sp USING(stack_pipe_id)
				LEFT JOIN camd.unit u USING(unit_id)
				WHERE mon_plan_id = vmonplanid
				GROUP BY u.unitid, sp.stack_name
				ORDER BY u.unitid, sp.stack_name
			) d
		) AS "locationInfo",
		p.state AS "stateCode",
		cc.county_name AS "countyName"
	FROM camd.plant p
	JOIN camdmd.county_code cc USING(county_cd)
	WHERE p.oris_code = vfacilityid 
$BODY$;
