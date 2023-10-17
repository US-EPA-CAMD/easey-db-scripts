DROP VIEW IF EXISTS camdecmps.emission_view_sumval;

CREATE OR REPLACE VIEW camdecmps.emission_view_sumval
AS
	SELECT DISTINCT mpl.mon_plan_id, rp.period_description, d.*
	FROM camdecmps.summary_value sv
	JOIN camdecmps.monitor_plan_location mpl USING(mon_loc_id)
	JOIN camdecmpsmd.reporting_period rp USING (rpt_period_id)
	JOIN camdecmps.get_summary_values(mpl.mon_loc_id, rp.rpt_period_id) d
		ON sv.mon_loc_id = d.mon_loc_id
		AND sv.rpt_period_id = d.rpt_period_id;
