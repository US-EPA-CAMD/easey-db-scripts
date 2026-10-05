DROP view IF EXISTS camdecmps.vw_em_reporting_status CASCADE;

create or replace
view camdecmps.vw_em_reporting_status
as
select
	up.unit_id,
	up.prg_cd,
	up.unit_monitor_cert_begin_date,
	up.emissions_recording_begin_date,
	ml.mon_loc_id,
	uos.end_date as retire_date,
	cc.affected_ind,
	rp.rpt_period_id,
	rp.calendar_year,
	rp.quarter,
	case
		when (up.emissions_recording_begin_date is not null
		and up.emissions_recording_begin_date <= rp.end_date)
		or (up.emissions_recording_begin_date is null
		and up.unit_monitor_cert_begin_date + 180 <= rp.end_date) then 'REQUIRE'
		when (up.emissions_recording_begin_date is null) then 'GRANTED'
		else null
	end as em_reporting_status,
	case
		when ml.mon_loc_id is null then 'Missing Monitor Location'
		when count(active_mp.mon_plan_id) = 0
		and cc.affected_ind = 0 then null
		when count(active_mp.mon_plan_id) = 0
		and cc.affected_ind = 1 then 'No Active Monitoring Plan'
		when count(distinct active_mp.mon_plan_id) > 1 then 'Multiple Monitoring Plans'
		when rp.quarter = 3 then max(active_mp.mon_plan_id)
		when max(active_mp.report_freq_cd) is null then 'Missing Reporting Frequency'
		when count(distinct active_mp.report_freq_cd) > 1 then 'Multiple Reporting Frequencies'
		when rp.quarter in (1, 4) then
			case
				when max(active_mp.report_freq_cd) = 'OS' then null
			else max(active_mp.mon_plan_id)
		end
		when rp.quarter in (2, 3) then
			case
				when max(active_mp.report_freq_cd) = 'OS'
			and uos.end_date is not null
			and extract(year from uos.end_date) = rp.calendar_year
			and extract(month from uos.end_date) = 4 then null
			else max(active_mp.mon_plan_id)
		end
	end as mon_plan_id,
	u.fac_id
from
	camd.unit u
cross join camdecmpsmd.reporting_period rp
join camd.unit_op_status uos on
	u.unit_id = uos.unit_id
	and uos.op_status_cd = 'OPR'
	and uos.begin_date <= rp.end_date
	and (uos.end_date is null or uos.end_date >= rp.begin_date)
join camd.unit_program up on
	u.unit_id = up.unit_id
	and up.unit_monitor_cert_begin_date <= rp.end_date
	and (up.end_date is null
		or up.end_date >= rp.begin_date)
join camdmd.class_code cc on
	up.class_cd = cc.class_cd
left join camd.unit_program otc on
	otc.unit_id = u.unit_id
	and otc.prg_cd = 'OTC'
join camd.program p on
	up.prg_id = p.prg_id
join camd.program_phase pp on
	up.prg_id = pp.prg_id
	and pp.phase_monitor_cert_deadline <= rp.end_date
	and case 
			when pp.phase is not null then pp.phase
			when p.prg_cd in ('NBP', 'NHNOX') then 'NON-OTC'
			else 'NULL'
		end	=
		case 
			when up.prg_cd = 'ARP' then up.class_cd
			when up.prg_cd in ('NBP', 'NHNOX') and otc.unit_id is not null then 'OTC'
			when up.prg_cd in ('NBP', 'NHNOX') and otc.unit_id is null then 'NON-OTC'
			else 'NULL'
		end
left join camdecmps.monitor_location ml on
	up.unit_id = ml.unit_id
left join (
	select
		mp.mon_plan_id,
		mpl.mon_loc_id,
		mp_brp.calendar_year as mp_begin_year,
		mp_brp.quarter as mp_begin_quarter,
		mp_erp.calendar_year as mp_end_year,
		mp_erp.quarter as mp_end_quarter,
		mprf.report_freq_cd,
		mprf_brp.calendar_year as mprf_begin_year,
		mprf_brp.quarter as mprf_begin_quarter,
		mprf_erp.calendar_year as mprf_end_year,
		mprf_erp.quarter as mprf_end_quarter
	from
		camdecmps.monitor_plan_location mpl
	join camdecmps.monitor_plan mp on
		mpl.mon_plan_id = mp.mon_plan_id
	join camdecmpsmd.reporting_period mp_brp on
		mp.begin_rpt_period_id = mp_brp.rpt_period_id
	left join camdecmpsmd.reporting_period mp_erp on
		mp.end_rpt_period_id = mp_erp.rpt_period_id
	left join camdecmps.monitor_plan_reporting_freq mprf
	on
		mp.mon_plan_id = mprf.mon_plan_id
	left join camdecmpsmd.reporting_period mprf_brp on
		mprf.begin_rpt_period_id = mprf_brp.rpt_period_id
	left join camdecmpsmd.reporting_period mprf_erp on
		mprf.end_rpt_period_id = mprf_erp.rpt_period_id) active_mp on
	ml.mon_loc_id = active_mp.mon_loc_id
	and (active_mp.mp_begin_year < rp.calendar_year
		or (active_mp.mp_begin_year = rp.calendar_year
			and active_mp.mp_begin_quarter <= rp.quarter))
	and (active_mp.mp_end_year is null
		or active_mp.mp_end_year > rp.calendar_year
		or (active_mp.mp_end_year = rp.calendar_year
			and active_mp.mp_end_quarter >= rp.quarter))
	and (active_mp.mprf_begin_year < rp.calendar_year
		or (active_mp.mprf_begin_year = rp.calendar_year
			and active_mp.mprf_begin_quarter <= rp.quarter))
	and (active_mp.mprf_end_year is null
		or active_mp.mprf_end_year > rp.calendar_year
		or (active_mp.mprf_end_year = rp.calendar_year
			and active_mp.mprf_end_quarter >= rp.quarter))
where
	not exists (
	select
		up2.up_id
	from
		camd.unit_exemption ue
	inner join camd.unit_program up2 on
		ue.unit_id = up2.unit_id
		and up2.up_id = up.up_id
	inner join camdmd.program_exemption pe on
		up2.prg_cd = pe.prg_cd
		and ue.exemption_type_cd = pe.exemption_type_cd
	where
		ue.begin_date <= rp.begin_date
		and (ue.end_date is null
			or ue.end_date >= rp.end_date)
		and ue.unit_id = up.unit_id
           )
group by
	up.unit_id,
	up.prg_cd,
	up.unit_monitor_cert_begin_date,
	up.emissions_recording_begin_date,
	ml.mon_loc_id,
	uos.end_date,
	cc.affected_ind,
	rp.rpt_period_id,
	rp.calendar_year,
	rp.quarter,
	case
		when (up.emissions_recording_begin_date is not null
			and up.emissions_recording_begin_date <= rp.end_date)
		or (up.emissions_recording_begin_date is null
			and up.unit_monitor_cert_begin_date + 180 <= rp.end_date) then 'REQUIRE'
		when (up.emissions_recording_begin_date is null) then 'GRANTED'
		else null
	end,
	u.fac_id