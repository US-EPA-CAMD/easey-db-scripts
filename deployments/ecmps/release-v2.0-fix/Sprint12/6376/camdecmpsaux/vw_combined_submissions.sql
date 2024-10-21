
CREATE OR REPLACE VIEW camdecmpsaux.vw_combined_submissions
 AS
 SELECT sq.submission_id,
    sq.process_cd,
    sq.severity_cd,
    ss.fac_id,
    ss.mon_plan_id,
    sq.rpt_period_id,
    ss.submission_set_id,
    sq.queued_time AS submitted_on,
    ss.user_id,
    CASE
        WHEN ss.status_cd = 'WIP' THEN ss.started_time
        WHEN ss.status_cd = 'COMPLETE' THEN ss.completed_time
        ELSE NULL
    END AS submission_end_stage_time,
	ss.status_cd
   FROM camdecmpsaux.submission_set ss
     JOIN camdecmpsaux.submission_queue sq USING (submission_set_id);
