DO $$
DECLARE
	opDate record;
	mpdata record;
	rptdata record;
	qtr integer := 2;
	year integer := 2023;
	userid text := 'jwhitehead';
	monPlanId text := 'TWCORNEL5-C0E3879920A14159BAA98E03F1980A7A';
BEGIN
	for rptdata in
		select * from camdecmpsmd.reporting_period
		where (calendar_year = year and qtr = 0)
		or (calendar_year = year and quarter = qtr)
	loop
		for mpdata in 
			select unit_id, mon_loc_id
			from camdecmps.monitor_plan_location mpl
			join camdecmps.monitor_location ml using(mon_loc_id)
			join camd.unit u using(unit_id)
			where mon_plan_id = monPlanId
		loop
			delete from camdecmps.daily_backstop
			where mon_loc_id = mpdata.mon_loc_id
			and rpt_period_id = rptdata.rpt_period_id;

			FOR opDate IN SELECT generate_series(rptdata.begin_date, rptdata.end_date, '1 day'::interval)
			LOOP
				INSERT INTO camdecmps.daily_backstop(
					unit_id, op_date, daily_noxm, daily_hit, daily_avg_noxr, daily_noxm_exceed, cumulative_os_noxm_exceed, mon_loc_id, rpt_period_id, userid, add_date, update_date
				)
				VALUES (mpdata.unit_id, opDate.generate_series, random() * 100000000 + 1, random() * 100000000 + 1, random() * 1000 + 1, random() * 100000000 + 1, random() * 100000000000 + 1, mpdata.mon_loc_id, rptdata.rpt_period_id, userid, current_timestamp, current_timestamp);
			END LOOP;
		end loop;
	end loop;
	
	CALL camdecmps.refresh_emission_view_count();
END $$;
