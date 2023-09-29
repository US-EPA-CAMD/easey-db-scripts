-- FUNCTION: camdecmpswks.get_certification_statements(text[])

DROP FUNCTION IF EXISTS camdecmpswks.get_certification_statements(text[]) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.get_certification_statements(
	vmonplanids text[])
    RETURNS TABLE(prg_cd text, oris_code numeric, facility_name text, unit_info text) 
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
SELECT d.prg_cd, d.oris_code, d.facility_name,
		string_agg(d.unitid, ', ') AS unit_info
	FROM (
		SELECT cs.prg_cd, oris_code, facility_name, unitid
		FROM camd.plant p
		JOIN camd.unit u USING(fac_id)
		JOIN camd.unit_program up USING (unit_id)
		JOIN camdecmpswks.monitor_location ml USING (unit_id)
		JOIN camdecmpswks.monitor_plan_location mpl USING (mon_loc_id)
		JOIN camdecmpswks.monitor_plan mp USING (mon_plan_id)
		LEFT JOIN camdecmpswks.certification_statement cs USING (prg_cd)
		WHERE mon_plan_id = ANY(vmonplanids)
		GROUP BY cs.prg_cd, oris_code, facility_name, unitid
		ORDER BY cs.prg_cd DESC, oris_code, facility_name, unitid
	) AS d
	GROUP BY d.prg_cd, d.oris_code, d.facility_name
	ORDER BY d.prg_cd DESC, d.oris_code, d.facility_name
$BODY$;
