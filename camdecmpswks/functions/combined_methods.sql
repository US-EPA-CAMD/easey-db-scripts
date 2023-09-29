-- FUNCTION: camdecmpswks.combined_methods(integer)

DROP FUNCTION IF EXISTS camdecmpswks.combined_methods(integer) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.combined_methods(
	p_facilityid integer)
    RETURNS TABLE(mon_method_id character varying, mon_loc_id character varying, parameter_cd character varying, sub_data_cd character varying, bypass_approach_cd character varying, method_cd character varying, begin_date date, begin_hour numeric, end_date date, end_hour numeric, stack_pipe_id character varying, unit_id numeric, stack_name character varying, unitid character varying, begin_datehour timestamp without time zone, end_datehour timestamp without time zone, crosscheck_parameter character varying) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
BEGIN

RETURN QUERY
	SELECT 
			m.MON_METHOD_ID, 
			ml.MON_LOC_ID, 
			m.PARAMETER_CD, 
			m.SUB_DATA_CD, 
			m.BYPASS_APPROACH_CD, 
			m.METHOD_CD, 
			m.BEGIN_DATE, 
			m.BEGIN_HOUR, 
			m.END_DATE, 
			m.END_HOUR, 
			ml.STACK_PIPE_ID, 
			ml.UNIT_ID,
			sp.STACK_NAME,
			u.UNITID,
			m.BEGIN_HOUR * INTERVAL '1 HOUR' + m.BEGIN_DATE BEGIN_DATEHOUR,
			m.END_HOUR * INTERVAL '1 HOUR' + m.END_DATE END_DATEHOUR,
			m.PARAMETER_CD CROSSCHECK_PARAMETER
	FROM camdecmpswks.MONITOR_METHOD m
	JOIN camdecmpswks.monitor_location ml ON m.mon_loc_id = ml.mon_loc_id
    LEFT JOIN camd.unit u ON ml.unit_id = u.unit_id
    LEFT JOIN camdecmpswks.stack_pipe sp ON ml.stack_pipe_id::text = sp.stack_pipe_id::text
    LEFT JOIN camd.plant p1 ON u.fac_id = p1.fac_id
    LEFT JOIN camd.plant p2 ON sp.fac_id = p2.fac_id
	WHERE (p_facilityid IS NULL OR p_facilityid=COALESCE(p1.fac_id, p2.fac_id))
UNION
	SELECT	
		mth.MATS_METHOD_DATA_ID, 
		mth.MON_LOC_ID,
		mth.MATS_METHOD_PARAMETER_CD PARAMETER_CD, 
		NULL AS SUB_DATA_CD, 
		NULL AS BYPASS_APPROACH_CD, 
		mth.MATS_METHOD_CD METHOD_CD,
		mth.BEGIN_DATE, 
		mth.BEGIN_HOUR, 
		mth.END_DATE, 
		mth.END_HOUR, 
		ml.STACK_PIPE_ID, 
		ml.UNIT_ID,
		sp.STACK_NAME,
		u.UNITID,
		mth.BEGIN_HOUR * INTERVAL '1 HOUR' + mth.BEGIN_DATE BEGIN_DATEHOUR,
		mth.END_HOUR * INTERVAL '1 HOUR' + mth.END_DATE END_DATEHOUR,
		'MATSSUP' CROSSCHECK_PARAMETER
	FROM camdecmpswks.MATS_METHOD_DATA mth 
	JOIN camdecmpswks.monitor_location ml ON mth.mon_loc_id = ml.mon_loc_id
    LEFT JOIN camd.unit u ON ml.unit_id = u.unit_id
    LEFT JOIN camdecmpswks.stack_pipe sp ON ml.stack_pipe_id::text = sp.stack_pipe_id::text
    LEFT JOIN camd.plant p1 ON u.fac_id = p1.fac_id
    LEFT JOIN camd.plant p2 ON sp.fac_id = p2.fac_id
	WHERE (p_facilityid IS NULL OR p_facilityid=COALESCE(p1.fac_id, p2.fac_id));
end;
$BODY$;
