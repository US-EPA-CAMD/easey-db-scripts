DROP VIEW IF EXISTS camdecmpswks.emission_view_sumval;

CREATE OR REPLACE VIEW camdecmpswks.emission_view_sumval
AS
	SELECT DISTINCT mpl.mon_plan_id, rp.period_description, d.*
	FROM camdecmpswks.summary_value sv
	JOIN camdecmpswks.monitor_plan_location mpl USING(mon_loc_id)
	JOIN camdecmpsmd.reporting_period rp USING (rpt_period_id)
	JOIN camdecmpswks.get_summary_values(mpl.mon_loc_id, rp.rpt_period_id) d
		ON sv.mon_loc_id = d.mon_loc_id
		AND sv.rpt_period_id = d.rpt_period_id;
