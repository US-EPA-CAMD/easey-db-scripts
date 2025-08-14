drop view if exists camdecmpsaux.vw_last_submission_in_window;

create or replace
view camdecmpsaux.vw_last_submission_in_window
as
select
	esa.mon_plan_id,
	esa.rpt_period_id,
	esa.access_begin_date,
	esa.access_end_date,
	sl.submission_id,
	sl.queued_time,
	sl.severity_cd,
	sl.submission_set_id,
	esa.em_sub_access_id,
	sl.user_id
from
	camdecmpsaux.em_submission_access esa
join (
	select
		ss.mon_plan_id,
		sq.rpt_period_id,
		sq.submission_id,
		sq.queued_time,
		sq.severity_cd,
		ss.submission_set_id,
		ss.user_id
	from
		camdecmpsaux.submission_queue sq
	join camdecmpsaux.submission_set ss on
		sq.submission_set_id = ss.submission_set_id
	where
		sq.process_cd = 'EM') sl 
on 
		esa.mon_plan_id = sl.mon_plan_id
	and esa.rpt_period_id = sl.rpt_period_id
	and sl.queued_time between esa.access_begin_date and esa.access_end_date
join (
	select
		ss.mon_plan_id,
		sq.rpt_period_id,
		max(sq.queued_time) as queued_time
	from
		camdecmpsaux.submission_queue sq
	join camdecmpsaux.submission_set ss on
		sq.submission_set_id = ss.submission_set_id
	where
		sq.process_cd = 'EM'
	group by
		ss.mon_plan_id,
		sq.rpt_period_id
		) sl_max 
on 
		sl.mon_plan_id = sl_max.mon_plan_id
	and sl.rpt_period_id = sl_max.rpt_period_id
	and sl.queued_time = sl_max.queued_time
where
	sl.submission_id is not null;
