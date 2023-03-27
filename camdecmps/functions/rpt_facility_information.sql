-- FUNCTION: camdecmps.rpt_facility_information(text)

DROP FUNCTION IF EXISTS camdecmps.rpt_facility_information(text);

CREATE OR REPLACE FUNCTION camdecmps.rpt_facility_information(
	facilityid text)
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
	WHERE p.oris_code = facilityId::numeric;
$BODY$;
