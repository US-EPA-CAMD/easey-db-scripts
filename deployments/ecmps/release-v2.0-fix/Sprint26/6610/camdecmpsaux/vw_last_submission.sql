create or replace
view camdecmpsaux.vw_last_submission
as
select
	sq.submission_id,
	sq.completed_time,
	sq.status_cd,
	ss.mon_plan_id,
	sq.process_cd,
	sq.test_sum_id,
	sq.qa_cert_event_id,
	sq.test_extension_exemption_id,
	sq.rpt_period_id,
	sub_last.submission_id as last_submission_id
from
	camdecmpsaux.submission_set ss
join camdecmpsaux.submission_queue sq on
	ss.submission_set_id = sq.submission_set_id
left join (
	select
		sq_last.submission_id,
		ss_last.mon_plan_id,
		sq_last.process_cd,
		sq_last.test_sum_id,
		sq_last.qa_cert_event_id,
		sq_last.test_extension_exemption_id,
		sq_last.rpt_period_id,
		max(sq_last.completed_time) completed_time
	from
		camdecmpsaux.submission_set ss_last
	join camdecmpsaux.submission_queue sq_last on
			ss_last.submission_set_id = sq_last.submission_set_id
		and sq_last.status_cd = 'COMPLETE'
	group by
		sq_last.submission_id,
		ss_last.mon_plan_id,
		sq_last.process_cd,
		sq_last.test_sum_id,
		sq_last.qa_cert_event_id,
		sq_last.test_extension_exemption_id,
		sq_last.rpt_period_id) sub_last
on
	ss.mon_plan_id = sub_last.mon_plan_id
	and sq.process_cd = sub_last.process_cd
	and ((sq.process_cd = 'MP'
		and ss.mon_plan_id = sub_last.mon_plan_id)
	or (sq.process_cd = 'QA'
		and sq.test_sum_id = sub_last.test_sum_id)
	or (sq.process_cd = 'QA'
		and sq.qa_cert_event_id = sub_last.qa_cert_event_id)
	or (sq.process_cd = 'QA'
		and sq.test_extension_exemption_id = sub_last.test_extension_exemption_id)
	or (sq.process_cd = 'EM'
		and ss.mon_plan_id = sub_last.mon_plan_id
		and sq.rpt_period_id = sub_last.rpt_period_id))
	and sq.completed_time = sub_last.completed_time; 