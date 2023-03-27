-- FUNCTION: camdecmpswks.monitor_qualification_lee_parameter(character varying)

DROP FUNCTION IF EXISTS camdecmpswks.monitor_qualification_lee_parameter(character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.monitor_qualification_lee_parameter(
	monplanid character varying)
    RETURNS TABLE(mon_loc_id character varying, location_id character varying, oris_code numeric, fac_id numeric, qual_type_cd character varying, mon_qual_lee_id character varying, mon_qual_id character varying, applicable_emission_standard numeric, emission_standard_pct numeric, emission_standard_uom character varying, parameter_cd character varying, potential_annual_emissions numeric, qual_lee_test_type_cd character varying, qual_test_date date, mon_plan_id character varying) 
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
SELECT    ml.MON_LOC_ID, 
			COALESCE(sp.STACK_NAME,u.UNITID) AS LOCATION_ID, 
            COALESCE(f1.ORIS_CODE, f2.ORIS_CODE) as ORIS_CODE,
			COALESCE(f1.FAC_ID, f2.FAC_ID ) as FAC_ID, 
			mq.QUAL_TYPE_CD,
			lee.MON_QUAL_LEE_ID,
			lee.MON_QUAL_ID,
			lee.APPLICABLE_EMISSION_STANDARD,
			lee.EMISSION_STANDARD_PCT,
			lee.EMISSION_STANDARD_UOM,
			lee.PARAMETER_CD,
			lee.POTENTIAL_ANNUAL_EMISSIONS,
			lee.QUAL_LEE_TEST_TYPE_CD,
			lee.QUAL_TEST_DATE,
			mpl.mon_plan_id
FROM    camdecmpswks.MONITOR_QUALIFICATION mq
		join camdecmpswks.MONITOR_LOCATION ml ON mq.MON_LOC_ID = ml.MON_LOC_ID
        join camdecmpswks.MONITOR_PLAN_LOCATION mpl on mpl.MON_LOC_ID = ml.MON_LOC_ID
		JOIN camdecmpswks.MONITOR_QUALIFICATION_LEE lee ON mq.MON_QUAL_ID = lee.MON_QUAL_ID
		LEFT OUTER JOIN camd.UNIT u ON ml.UNIT_ID = u.UNIT_ID 
		LEFT OUTER JOIN camdecmpswks.STACK_PIPE sp ON ml.STACK_PIPE_ID = sp.STACK_PIPE_ID
		LEFT OUTER JOIN camd.plant f1 on u.FAC_ID = f1.FAC_ID 
		LEFT OUTER JOIN camd.plant f2 on sp.FAC_ID = f2.FAC_ID
 	WHERE (monplanid is null or mpl.MON_PLAN_ID = monplanid)
$BODY$;
