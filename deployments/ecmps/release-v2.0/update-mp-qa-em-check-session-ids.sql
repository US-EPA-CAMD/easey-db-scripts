update camdecmps.monitor_plan as mp
set chk_session_id = t.Chk_Session_Id
from (
	select
		chs.Mon_Plan_Id,
		chs.Chk_Session_Id
	from (
		select
			chs.Mon_Plan_Id,
			max(chs.Session_Begin_Date) as Session_Begin_Date
		from camdecmpsaux.CHECK_SESSION chs
		where chs.Process_Cd = 'MP'
		group by chs.Mon_Plan_Id
	) sel
	join camdecmpsaux.CHECK_SESSION chs
		on chs.Mon_Plan_Id = sel.Mon_Plan_Id
		and chs.Process_Cd = 'MP'
		and chs.Session_Begin_Date = sel.Session_Begin_Date
) t
where mp.mon_plan_id = t.Mon_Plan_Id
and mp.chk_session_id is null;

update camdecmps.test_summary as ts
set chk_session_id = t.Chk_Session_Id
from (
	select
		chs.test_sum_id,
		chs.Chk_Session_Id
	from (
		select
			chs.test_sum_id,
			max(chs.Session_Begin_Date) as Session_Begin_Date
		from camdecmpsaux.CHECK_SESSION chs
		where chs.Process_Cd = 'TEST'
		group by chs.test_sum_id
	) sel
	join camdecmpsaux.CHECK_SESSION chs
		on chs.test_sum_id = sel.test_sum_id
		and chs.Process_Cd = 'TEST'
		and chs.Session_Begin_Date = sel.Session_Begin_Date
) t
where ts.test_sum_id = t.test_sum_id
and ts.chk_session_id is null;

update camdecmps.qa_cert_event as qce
set chk_session_id = t.Chk_Session_Id
from (
	select
		chs.qa_cert_event_id,
		chs.Chk_Session_Id
	from (
		select
			chs.qa_cert_event_id,
			max(chs.Session_Begin_Date) as Session_Begin_Date
		from camdecmpsaux.CHECK_SESSION chs
		where chs.Process_Cd = 'OTHERQA'
		group by chs.qa_cert_event_id
	) sel
	join camdecmpsaux.CHECK_SESSION chs
		on chs.qa_cert_event_id = sel.qa_cert_event_id
		and chs.Process_Cd = 'OTHERQA'
		and chs.Session_Begin_Date = sel.Session_Begin_Date
) t
where qce.qa_cert_event_id = t.qa_cert_event_id
and qce.chk_session_id is null;

update camdecmps.test_extension_exemption as tee
set chk_session_id = t.Chk_Session_Id
from (
	select
		chs.test_extension_exemption_id,
		chs.Chk_Session_Id
	from (
		select
			chs.test_extension_exemption_id,
			max(chs.Session_Begin_Date) as Session_Begin_Date
		from camdecmpsaux.CHECK_SESSION chs
		where chs.Process_Cd = 'OTHERQA'
		group by chs.test_extension_exemption_id
	) sel
	join camdecmpsaux.CHECK_SESSION chs
		on chs.test_extension_exemption_id = sel.test_extension_exemption_id
		and chs.Process_Cd = 'OTHERQA'
		and chs.Session_Begin_Date = sel.Session_Begin_Date
) t
where tee.test_extension_exemption_id = t.test_extension_exemption_id
and tee.chk_session_id is null;

update camdecmps.emission_evaluation as evl
set chk_session_id = t.Chk_Session_Id
from (
	select
		chs.Mon_Plan_Id,
		chs.Rpt_Period_Id,
		chs.Chk_Session_Id
	from (
		select
			chs.Mon_Plan_Id,
			chs.Rpt_Period_Id,
			max(chs.Session_Begin_Date) as Session_Begin_Date
		from camdecmpsaux.CHECK_SESSION chs
		where chs.Process_Cd = 'HOURLY'
		group by chs.Mon_Plan_Id, chs.Rpt_Period_Id
	) sel
	join camdecmpsaux.CHECK_SESSION chs
		on chs.Mon_Plan_Id = sel.Mon_Plan_Id
		and chs.Rpt_period_Id = sel.Rpt_Period_Id
		and chs.Process_Cd = 'HOURLY'
		and chs.Session_Begin_Date = sel.Session_Begin_Date
) t
where evl.mon_plan_id = t.Mon_Plan_Id
and evl.rpt_period_id = t.Rpt_Period_Id
and evl.chk_session_id is null;
