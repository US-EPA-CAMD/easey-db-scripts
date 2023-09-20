-- View: camdecmpswks.emission_view_dailybackstop

DROP VIEW IF EXISTS camdecmpswks.emission_view_dailybackstop;

CREATE OR REPLACE VIEW camdecmpswks.emission_view_dailybackstop
AS
SELECT mpl.mon_plan_id,
	mpl.mon_loc_id,
	rp.rpt_period_id,
	rp.begin_date,
	rp.end_date,
	rp.begin_date AS datehour,
  u.unit_id,
	u.unitid as "unit_name",
	bkstop.op_date,
	bkstop.daily_noxm,
	bkstop.daily_hit,
	bkstop.daily_avg_noxr,
	bkstop.daily_noxm_exceed,
	bkstop.cumulative_os_noxm_exceed
FROM camdecmpswks.daily_backstop bkstop
JOIN camd.unit u USING (unit_id)
JOIN camdecmpswks.monitor_plan_location mpl USING (mon_loc_id)
JOIN camdecmpsmd.reporting_period rp USING (rpt_period_id);
