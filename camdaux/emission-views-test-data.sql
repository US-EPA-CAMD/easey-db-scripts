--https://usepa.sharepoint.com/:x:/r/sites/CAMDCVPTeam/_layouts/15/Doc.aspx?sourcedoc=%7B49345505-5203-44D5-9B43-DF26BD6AC27C%7D&file=EmissionsModuleViews_ORISExamples.xlsx&action=default&mobileredirect=true
DO $$
DECLARE
	monPlanId text;
	quarter integer := 1;
	year integer := 2021;
	--orisCodes integer[] := ARRAY[3, 60, 643, 703, 976, 1571, 1733, 7203, 10378, 54304, 55286, 55439];
	orisCodes integer[] := ARRAY[3];
BEGIN
	FOR monPlanId IN (
		SELECT mp.mon_plan_id
		FROM camdecmps.monitor_plan mp
		JOIN camd.plant p USING(fac_id)
		WHERE p.oris_code = ANY(orisCodes) AND mp.end_rpt_period_id IS NULL
	)
	LOOP
		RAISE NOTICE 'Loading emissions data for %', monPlanId;
		--CALL camdecmpswks.load_emissions_workspace(monPlanId, year, quarter);
		--CALL camdecmpswks.refresh_emissions_views(monPlanId, year, quarter);
	END LOOP;

END $$;

/*
select * from camdecmpswks.emission_view_all
select * from camdecmpswks.emission_view_co2appd
select * from camdecmpswks.emission_view_co2cems
select * from camdecmpswks.emission_view_dailycal
select * from camdecmpswks.emission_view_hiappd
select * from camdecmpswks.emission_view_hicems
select * from camdecmpswks.emission_view_hiunitstack
select * from camdecmpswks.emission_view_noxappemixedfuel
select * from camdecmpswks.emission_view_noxappesinglefuel
select * from camdecmpswks.emission_view_noxmasscems
select * from camdecmpswks.emission_view_noxratecems
select * from camdecmpswks.emission_view_so2appd
select * from camdecmpswks.emission_view_so2cems
*/

/*
delete from camdaux.dataset where template_cd = 'EMVIEW'
select * from camdaux.dataset where template_cd = 'EMVIEW' order by sort_order
*/