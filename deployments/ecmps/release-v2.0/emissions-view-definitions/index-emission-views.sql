DO $$
DECLARE
	dataset record;
	sqlStatement text;
BEGIN
	FOR dataset IN SELECT * FROM camdaux.dataset WHERE group_cd = 'EMVIEW' AND dataset_cd NOT IN ('LTFF', 'NSPS4T', 'DAILYBACKSTOP', 'COUNTS')
	LOOP
		sqlStatement := format('
			CREATE INDEX IF NOT EXISTS idx_emission_view_%s_mon_plan_id
				ON camdecmps.emission_view_%s USING btree
				(mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);
			CREATE INDEX IF NOT EXISTS idx_emission_view_%s_mon_loc_id
				ON camdecmps.emission_view_%s USING btree
				(mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
			CREATE INDEX IF NOT EXISTS idx_emission_view_%s_rpt_period_id
				ON camdecmps.emission_view_%s USING btree
				(rpt_period_id ASC NULLS LAST);
			CREATE INDEX IF NOT EXISTS idx_emission_view_%s_rpt_period_id_mon_loc_id
				ON camdecmps.emission_view_%s USING btree
				(rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
			CREATE INDEX IF NOT EXISTS idx_emission_view_%s_mon_plan_id
				ON camdecmpswks.emission_view_%s USING btree
				(mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);
			CREATE INDEX IF NOT EXISTS idx_emission_view_%s_mon_loc_id
				ON camdecmpswks.emission_view_%s USING btree
				(mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
			CREATE INDEX IF NOT EXISTS idx_emission_view_%s_rpt_period_id
				ON camdecmpswks.emission_view_%s USING btree
				(rpt_period_id ASC NULLS LAST);
			CREATE INDEX IF NOT EXISTS idx_emission_view_%s_rpt_period_id_mon_loc_id
				ON camdecmpswks.emission_view_%s USING btree
				(rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
	    ', lower(dataset.dataset_cd), lower(dataset.dataset_cd), lower(dataset.dataset_cd), lower(dataset.dataset_cd), lower(dataset.dataset_cd), lower(dataset.dataset_cd), lower(dataset.dataset_cd), lower(dataset.dataset_cd)
	  	 , lower(dataset.dataset_cd), lower(dataset.dataset_cd), lower(dataset.dataset_cd), lower(dataset.dataset_cd), lower(dataset.dataset_cd), lower(dataset.dataset_cd), lower(dataset.dataset_cd), lower(dataset.dataset_cd)
		);
		RAISE NOTICE 'Executing...%', sqlStatement;
		EXECUTE sqlStatement;
		CREATE INDEX IF NOT EXISTS idx_emission_view_count_mon_plan_id
			ON camdecmps.emission_view_count USING btree
			(mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);
		CREATE INDEX IF NOT EXISTS idx_emission_view_count_mon_loc_id
			ON camdecmps.emission_view_count USING btree
			(mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
		CREATE INDEX IF NOT EXISTS idx_emission_view_count_dataset_cd
			ON camdecmps.emission_view_count USING btree
			(dataset_cd COLLATE pg_catalog."default" ASC NULLS LAST);
		CREATE INDEX IF NOT EXISTS idx_emission_view_count_rpt_period_id
			ON camdecmps.emission_view_count USING btree
			(rpt_period_id ASC NULLS LAST);
		CREATE INDEX IF NOT EXISTS idx_emission_view_count_rpt_period_id_mon_loc_id
			ON camdecmps.emission_view_count USING btree
			(rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
		CREATE INDEX IF NOT EXISTS idx_emission_view_count_mon_plan_id
			ON camdecmpswks.emission_view_count USING btree
			(mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);
		CREATE INDEX IF NOT EXISTS idx_emission_view_count_mon_loc_id
			ON camdecmpswks.emission_view_count USING btree
			(mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
		CREATE INDEX IF NOT EXISTS idx_emission_view_count_dataset_cd
			ON camdecmpswks.emission_view_count USING btree
			(dataset_cd COLLATE pg_catalog."default" ASC NULLS LAST);
		CREATE INDEX IF NOT EXISTS idx_emission_view_count_rpt_period_id
			ON camdecmpswks.emission_view_count USING btree
			(rpt_period_id ASC NULLS LAST);
		CREATE INDEX IF NOT EXISTS idx_emission_view_count_rpt_period_id_mon_loc_id
			ON camdecmpswks.emission_view_count USING btree
			(rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
	END LOOP;
END $$;
