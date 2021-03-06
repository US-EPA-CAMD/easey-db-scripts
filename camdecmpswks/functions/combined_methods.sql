-- FUNCTION: camdecmpswks.combined_methods(integer)

-- DROP FUNCTION camdecmpswks.combined_methods(integer);

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
			l.MON_LOC_ID, 
			m.PARAMETER_CD, 
			m.SUB_DATA_CD, 
			m.BYPASS_APPROACH_CD, 
			m.METHOD_CD, 
			m.BEGIN_DATE, 
			m.BEGIN_HOUR, 
			m.END_DATE, 
			m.END_HOUR, 
			l.STACK_PIPE_ID, 
			l.UNIT_ID,
			CASE WHEN l.STACK_PIPE_ID IS NULL THEN NULL ELSE l.LOCATION_IDENTIFIER END AS STACK_NAME,
			CASE WHEN l.UNIT_ID IS NULL THEN NULL ELSE l.LOCATION_IDENTIFIER END AS UNITID,
			m.BEGIN_HOUR * INTERVAL '1 HOUR' + m.BEGIN_DATE BEGIN_DATEHOUR,
			m.END_HOUR * INTERVAL '1 HOUR' + m.END_DATE END_DATEHOUR,
			m.PARAMETER_CD CROSSCHECK_PARAMETER
	FROM camdecmpswks.MONITOR_METHOD m
	INNER JOIN camdecmpswks.VW_MONITOR_LOCATION l ON m.MON_LOC_ID = l.MON_LOC_ID
	INNER JOIN camdecmpswks.MONITOR_PLAN_LOCATION mpl ON mpl.MON_LOC_ID = l.MON_LOC_ID
	WHERE (p_facilityid IS NULL OR FAC_ID=p_facilityid)
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
		l.STACK_PIPE_ID, 
		l.UNIT_ID,
		CASE WHEN l.STACK_PIPE_ID IS NULL THEN NULL ELSE l.LOCATION_IDENTIFIER END AS STACK_NAME,
		CASE WHEN l.UNIT_ID IS NULL THEN NULL ELSE l.LOCATION_IDENTIFIER END AS UNITID,
		mth.BEGIN_HOUR * INTERVAL '1 HOUR' + mth.BEGIN_DATE BEGIN_DATEHOUR,
		mth.END_HOUR * INTERVAL '1 HOUR' + mth.END_DATE END_DATEHOUR,
		'MATSSUP' CROSSCHECK_PARAMETER
	FROM camdecmpswks.MATS_METHOD_DATA mth 
	INNER JOIN	camdecmpswks.MONITOR_PLAN_LOCATION mpl	ON	mth.MON_LOC_ID = mpl.MON_LOC_ID
	INNER JOIN camdecmpswks.VW_MONITOR_LOCATION l ON mpl.MON_LOC_ID = l.MON_LOC_ID
	WHERE (p_facilityid IS NULL OR FAC_ID=p_facilityid);
end;
$BODY$;
