-- FUNCTION: camdecmpswks.monitor_qualification_percent_data(character varying)

DROP FUNCTION IF EXISTS camdecmpswks.monitor_qualification_percent_data(character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.monitor_qualification_percent_data(
	monplanid character varying)
    RETURNS TABLE(mon_loc_id character varying, mon_qual_id character varying, begin_date date, end_date date, qual_year numeric) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
BEGIN
 RETURN QUERY
select mpl.MON_LOC_ID,
         mql.MON_QUAL_ID,
         mql.BEGIN_DATE,
         mql.END_DATE,
         mqp.QUAL_YEAR
    from camdecmpswks.MONITOR_PLAN_LOCATION mpl
         join camdecmpswks.MONITOR_QUALIFICATION mql
           on mql.Mon_Loc_Id = mpl.Mon_Loc_Id
         join camdecmpswks.MONITOR_QUALIFICATION_PCT mqp
           on mqp.Mon_Qual_Id = mql.Mon_Qual_Id
 	WHERE (monplanid is null or mpl.MON_PLAN_ID = monplanid);
END;
$BODY$;
