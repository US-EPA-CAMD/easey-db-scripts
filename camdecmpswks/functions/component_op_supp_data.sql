-- FUNCTION: camdecmpswks.component_op_supp_data(character varying)

DROP FUNCTION IF EXISTS camdecmpswks.component_op_supp_data(character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.component_op_supp_data(
	monplanid character varying)
    RETURNS TABLE(mon_plan_id character varying, comp_op_supp_data_id character varying, mon_loc_id character varying, component_id character varying, rpt_period_id numeric, calendar_year numeric, quarter numeric, op_supp_data_type_cd character varying, days numeric, hours numeric) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
BEGIN  
     RETURN QUERY
	select  mpl.MON_PLAN_ID,
            sup.COMP_OP_SUPP_DATA_ID,
            sup.MON_LOC_ID,
            sup.COMPONENT_ID,
            sup.RPT_PERIOD_ID,
            prd.CALENDAR_YEAR,
            prd.QUARTER,
            sup.OP_SUPP_DATA_TYPE_CD,
            sup.DAYS,
            sup.HOURS
      from  camdecmpswks.MONITOR_PLAN_LOCATION mpl
            join camdecmps.COMPONENT_OP_SUPP_DATA sup on sup.MON_LOC_ID = mpl.MON_LOC_ID
            join camdecmpsmd.REPORTING_PERIOD prd on prd.RPT_PERIOD_ID = sup.RPT_PERIOD_ID
       where sup.OP_SUPP_DATA_TYPE_CD in ( 'OP', 'OPMJ' )
	        and  ( monplanid is null or mpl.MON_PLAN_ID = monplanid );
END;
$BODY$;
