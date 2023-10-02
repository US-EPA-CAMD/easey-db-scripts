
CREATE OR REPLACE VIEW camdecmpsaux.vw_combined_submissions
 AS
 SELECT sq.submission_id,
    sq.process_cd,
    sq.severity_cd,
    ss.fac_id,
    ss.mon_plan_id,
    sq.rpt_period_id,
    ss.submission_set_id,
    sq.submitted_on,
    ss.user_id,
    ss.submission_end_stage_time,
	  ss.status_cd
   FROM camdecmpsaux.submission_set ss
     JOIN camdecmpsaux.submission_queue sq USING (submission_set_id);
