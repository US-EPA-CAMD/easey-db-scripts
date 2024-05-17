DROP FUNCTION IF EXISTS camdecmps.get_summary_values_pivoted(text, character varying, numeric) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.get_summary_values_pivoted(
	vtypecode text,
	vmonlocid character varying,
	vrptperiodid numeric
)
RETURNS TABLE(mon_loc_id character varying, rpt_period_id numeric, row_num integer, row_name text, op_hours numeric, op_time numeric, heat_input numeric, so2_mass numeric, co2_mass numeric, nox_rate numeric, nox_mass numeric)
LANGUAGE 'sql'
AS $BODY$
	SELECT DISTINCT
		sv.mon_loc_id,
		sv.rpt_period_id,
		CASE
			WHEN vtypecode = 'QTRRPT'	THEN 1
			WHEN vtypecode = 'QTRCALC'	THEN 2
			WHEN vtypecode = 'YEARRPT'	THEN 3
			WHEN vtypecode = 'YEARCALC'	THEN 4
			WHEN vtypecode = 'OSRPT'	THEN 5
			WHEN vtypecode = 'OSCALC'	THEN 6
			ELSE null
		END AS row_num,    
		CASE
			WHEN vtypecode = 'QTRRPT'	THEN 'Quarterly Reported'
			WHEN vtypecode = 'QTRCALC'	THEN 'Quarterly Calculated'
			WHEN vtypecode = 'YEARRPT'	THEN 'Year to Date Reported'
			WHEN vtypecode = 'YEARCALC'	THEN 'Year to Date Calculated'
			WHEN vtypecode = 'OSRPT'	THEN 'Ozone Season Reported'
			WHEN vtypecode = 'OSCALC'	THEN 'Ozone Season Calculated'
			ELSE null
		END AS row_name,
		ophr.summary_value AS op_hours,
		optm.summary_value AS op_time,
		hit.summary_value AS heat_input,
		so2m.summary_value AS so2_mass,
		co2m.summary_value AS co2_mass,
		noxr.summary_value AS nox_rate,
		noxm.summary_value AS nox_mass
	FROM camdecmps.summary_value sv
	LEFT JOIN camdecmps.get_summary_values(vtypecode, sv.mon_loc_id, sv.rpt_period_id) ophr
		ON sv.mon_loc_id = ophr.mon_loc_id
		AND sv.rpt_period_id = ophr.rpt_period_id
		AND ophr.parameter_cd = 'OPHOURS'
	LEFT JOIN camdecmps.get_summary_values(vtypecode, sv.mon_loc_id, sv.rpt_period_id) optm
		ON sv.mon_loc_id = optm.mon_loc_id
		AND sv.rpt_period_id = optm.rpt_period_id
		AND optm.parameter_cd = 'OPTIME'
	LEFT JOIN camdecmps.get_summary_values(vtypecode, sv.mon_loc_id, sv.rpt_period_id) hit
		ON sv.mon_loc_id = hit.mon_loc_id
		AND sv.rpt_period_id = hit.rpt_period_id
		AND hit.parameter_cd = 'HIT'
	LEFT JOIN camdecmps.get_summary_values(vtypecode, sv.mon_loc_id, sv.rpt_period_id) so2m
		ON sv.mon_loc_id = so2m.mon_loc_id
		AND sv.rpt_period_id = so2m.rpt_period_id
		AND so2m.parameter_cd = 'SO2M'
	LEFT JOIN camdecmps.get_summary_values(vtypecode, sv.mon_loc_id, sv.rpt_period_id) co2m
		ON sv.mon_loc_id = co2m.mon_loc_id
		AND sv.rpt_period_id = co2m.rpt_period_id
		AND co2m.parameter_cd = 'CO2M'
	LEFT JOIN camdecmps.get_summary_values(vtypecode, sv.mon_loc_id, sv.rpt_period_id) noxr
		ON sv.mon_loc_id = noxr.mon_loc_id
		AND sv.rpt_period_id = noxr.rpt_period_id
		AND noxr.parameter_cd = 'NOXR'
	LEFT JOIN camdecmps.get_summary_values(vtypecode, sv.mon_loc_id, sv.rpt_period_id) noxm
		ON sv.mon_loc_id = noxm.mon_loc_id
		AND sv.rpt_period_id = noxm.rpt_period_id
		AND noxm.parameter_cd = 'NOXM'
	WHERE sv.mon_loc_id = vmonlocid AND sv.rpt_period_id = vrptperiodid;
$BODY$;

-------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS camdecmps.get_summary_values(character varying, numeric) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.get_summary_values(
	vmonlocid character varying,
	vrptperiodid numeric
)
RETURNS TABLE(mon_loc_id character varying, rpt_period_id numeric, row_num integer, row_name text, op_hours numeric, op_time numeric, heat_input numeric, so2_mass numeric, co2_mass numeric, nox_rate numeric, nox_mass numeric)
LANGUAGE 'sql'
AS $BODY$
	SELECT * FROM camdecmps.get_summary_values_pivoted('QTRRPT', vmonlocid, vrptperiodid)
	UNION ALL
	SELECT * FROM camdecmps.get_summary_values_pivoted('QTRCALC', vmonlocid, vrptperiodid)
	UNION ALL
	SELECT * FROM camdecmps.get_summary_values_pivoted('YEARRPT', vmonlocid, vrptperiodid)
	UNION ALL
	SELECT * FROM camdecmps.get_summary_values_pivoted('YEARCALC', vmonlocid, vrptperiodid)
	UNION ALL
	SELECT * FROM camdecmps.get_summary_values_pivoted('OSRPT', vmonlocid, vrptperiodid)
	UNION ALL
	SELECT * FROM camdecmps.get_summary_values_pivoted('OSCALC', vmonlocid, vrptperiodid)
	ORDER BY mon_loc_id, rpt_period_id, row_num
$BODY$;
