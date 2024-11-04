-- FUNCTION: camdecmpswks.rpt_facility_information(numeric)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_facility_information(numeric) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_facility_information(
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

-- FUNCTION: camdecmpswks.rpt_facility_information(numeric, text, numeric, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_facility_information(numeric, text, numeric, numeric) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_facility_information(
	vfacilityid numeric,
	vmonplanid text,
	vyear numeric,
	vquarter numeric)
    RETURNS TABLE("facilityName" text, "orisCode" numeric, "locationInfo" text, "stateCode" text, "countyName" text, latitude numeric, longitude numeric, "yearQuarter" text, "totalOPTime" numeric) 
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
				FROM camdecmpswks.monitor_plan_location mpl
				JOIN camdecmpswks.monitor_location ml USING(mon_loc_id)
				LEFT JOIN camdecmpswks.stack_pipe sp USING(stack_pipe_id)
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
		( SELECT max(osd.Op_Value)
			FROM camdecmpswks.operating_supp_data osd
			JOIN camdecmpswks.monitor_plan_location mploc USING(mon_loc_id)
			WHERE mploc.mon_plan_id = vMonPlanId 
				AND osd.rpt_period_id = rp.rpt_period_id
				AND osd.op_type_cd = 'OPTIME'
				AND osd.fuel_cd IS NULL   
		) AS "totalOPTime"
	FROM camd.plant p
	JOIN camdmd.county_code cc USING(county_cd),
	camdecmpsmd.reporting_period rp
	WHERE p.oris_code = vFacilityId AND
	rp.calendar_year = vYear AND rp.quarter = vQuarter;
$BODY$;

-- FUNCTION: camdecmpswks.rpt_facility_information(numeric, text)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_facility_information(numeric, text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_facility_information(
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
      string_agg(
        coalesce(u.unitid, sp.stack_name), 
        ', ' 
        ORDER BY 
          u.unitid, 
          sp.stack_name
      ) 
    FROM 
      camdecmpswks.monitor_plan_location mpl 
      JOIN camdecmpswks.monitor_location ml USING(mon_loc_id) 
      LEFT JOIN camdecmpswks.stack_pipe sp USING(stack_pipe_id) 
      LEFT JOIN camd.unit u USING(unit_id) 
    WHERE 
      mpl.mon_plan_id = vmonplanid
  ) AS "locationInfo", 
  p.state AS "stateCode", 
  cc.county_name AS "countyName" 
FROM 
  camd.plant p 
  JOIN camdmd.county_code cc USING(county_cd) 
WHERE 
  p.oris_code = vfacilityid 
$BODY$;
