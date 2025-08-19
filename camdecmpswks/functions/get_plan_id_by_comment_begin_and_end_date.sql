CREATE OR REPLACE FUNCTION camdecmpswks.get_plan_by_comment_begin_and_end_date(
	locationids character varying[],
    comment_begin_date date,
	comment_end_date date
    )
    RETURNS TABLE (mon_plan_id character varying)
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
BEGIN 
	RETURN QUERY SELECT DISTINCT
        mp.mon_plan_id
    FROM
    camdecmpswks.monitor_plan mp
    JOIN camdecmpswks.monitor_plan_location mpl USING (mon_plan_id)
    JOIN camdecmpsmd.reporting_period brp ON mp.begin_rpt_period_id = brp.rpt_period_id
    LEFT JOIN camdecmpsmd.reporting_period erp ON mp.end_rpt_period_id = erp.rpt_period_id
WHERE
    mpl.mon_loc_id = ANY(locationids)
    AND daterange(brp.begin_date, erp.end_date, '[]') && daterange(comment_begin_date, comment_end_date, '[]');
END
$BODY$;