ALTER TABLE IF EXISTS camdecmps.daily_test_supp_data
    ADD CONSTRAINT pk_daily_test_supp_data PRIMARY KEY (daily_test_supp_data_id),
    ADD CONSTRAINT fk_daily_test_supp_data_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_daily_test_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_daily_test_supp_data_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_test_supp_data_test_result_code FOREIGN KEY (test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_test_supp_data_test_type_code FOREIGN KEY (test_type_cd)
        REFERENCES camdecmpsmd.test_type_code (test_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT ck_daily_test_supp_data_cmp CHECK (COALESCE(delete_ind, 0::numeric) <> 1::numeric AND component_id IS NOT NULL OR COALESCE(delete_ind, 0::numeric) = 1::numeric AND component_id IS NULL),
    ADD CONSTRAINT ck_daily_test_supp_data_dti CHECK (COALESCE(delete_ind, 0::numeric) <> 1::numeric AND daily_test_sum_id IS NOT NULL OR COALESCE(delete_ind, 0::numeric) = 1::numeric AND daily_test_sum_id IS NULL),
    ADD CONSTRAINT ck_daily_test_supp_data_dtt CHECK (COALESCE(delete_ind, 0::numeric) <> 1::numeric AND daily_test_datehourmin IS NOT NULL OR COALESCE(delete_ind, 0::numeric) = 1::numeric AND daily_test_datehourmin IS NULL),
    ADD CONSTRAINT ck_daily_test_supp_data_ohc CHECK (COALESCE(delete_ind, 0::numeric) <> 1::numeric AND op_hour_cnt IS NOT NULL OR COALESCE(delete_ind, 0::numeric) = 1::numeric AND op_hour_cnt IS NULL),
    ADD CONSTRAINT ck_daily_test_supp_data_ssc CHECK (span_scale_cd::text = ANY (ARRAY['H'::character varying, 'L'::character varying, 'N'::character varying]::text[])),
    ADD CONSTRAINT ck_daily_test_supp_data_stt CHECK (COALESCE(delete_ind, 0::numeric) <> 1::numeric AND sort_daily_test_datehourmin IS NOT NULL OR COALESCE(delete_ind, 0::numeric) = 1::numeric AND sort_daily_test_datehourmin IS NULL),
    ADD CONSTRAINT ck_daily_test_supp_data_trs CHECK (COALESCE(delete_ind, 0::numeric) <> 1::numeric AND test_result_cd IS NOT NULL OR COALESCE(delete_ind, 0::numeric) = 1::numeric AND test_result_cd IS NULL);

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_component_id
    ON camdecmps.daily_test_supp_data USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_daily_test_sum_id
    ON camdecmps.daily_test_supp_data USING btree
    (daily_test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_key_online_ind
    ON camdecmps.daily_test_supp_data USING btree
    (key_online_ind ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_key_valid_ind
    ON camdecmps.daily_test_supp_data USING btree
    (key_valid_ind ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_online_offline_ind
    ON camdecmps.daily_test_supp_data USING btree
    (online_offline_ind ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_rpt_period_id
    ON camdecmps.daily_test_supp_data USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_span_scale_cd
    ON camdecmps.daily_test_supp_data USING btree
    (span_scale_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_test_result_cd
    ON camdecmps.daily_test_supp_data USING btree
    (test_result_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_test_type_cd
    ON camdecmps.daily_test_supp_data USING btree
    (test_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_mon_loc_id
    ON camdecmps.daily_test_supp_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_rpt_period_id_mon_loc_id
    ON camdecmps.daily_test_supp_data USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
