DROP FUNCTION IF EXISTS camdecmpswks.get_summary_values(character varying, numeric) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.get_summary_values(
	vmonlocid character varying,
	vrptperiodid numeric
)
RETURNS TABLE(mon_loc_id character varying, rpt_period_id numeric, row_num integer, row_name text, op_hours numeric, op_time numeric, heat_input numeric, so2_mass numeric, co2_mass numeric, nox_rate numeric)
LANGUAGE 'sql'
AS $BODY$
	SELECT * FROM camdecmpswks.get_summary_values_pivoted('QTRRPT', vmonlocid, vrptperiodid)
	UNION ALL
	SELECT * FROM camdecmpswks.get_summary_values_pivoted('QTRCALC', vmonlocid, vrptperiodid)
	UNION ALL
	SELECT * FROM camdecmpswks.get_summary_values_pivoted('YEARRPT', vmonlocid, vrptperiodid)
	UNION ALL
	SELECT * FROM camdecmpswks.get_summary_values_pivoted('YEARCALC', vmonlocid, vrptperiodid)
	UNION ALL
	SELECT * FROM camdecmpswks.get_summary_values_pivoted('OSRPT', vmonlocid, vrptperiodid)
	UNION ALL
	SELECT * FROM camdecmpswks.get_summary_values_pivoted('OSCALC', vmonlocid, vrptperiodid)
	ORDER BY mon_loc_id, rpt_period_id, row_num
$BODY$;
