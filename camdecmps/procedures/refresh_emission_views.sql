CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_views()
 LANGUAGE plpgsql
AS $procedure$
declare
	emission_rec record;
begin
	for emission_rec in 
		select mon_plan_id, rpt_period_id 
		from camdecmps.emission_evaluation a
		where not exists 
			(select 1
			from camdecmpsaux.emission_refresh_log b
			where a.mon_plan_id = b.mon_plan_id 
			and a.rpt_period_id = b.rpt_period_id)
		order by 1, 2
	loop 
		raise notice 'Working on mon_plan_id %; rpt_period_id %', 
			emission_rec.mon_plan_id, emission_rec.rpt_period_id;
		call camdecmps.refresh_emissions_views(emission_rec.mon_plan_id, emission_rec.rpt_period_id);
		insert into camdecmpsaux.emission_refresh_log (mon_plan_id, rpt_period_id)
		values (emission_rec.mon_plan_id, emission_rec.rpt_period_id);
		commit;
		raise notice '-------------------------------------------------------';
	end loop;
end $procedure$
