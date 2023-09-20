ALTER TABLE IF EXISTS camdecmps.mats_method_data
    ADD CONSTRAINT pk_mats_method_data PRIMARY KEY (mats_method_data_id),
    ADD CONSTRAINT fk_mats_method_data_mats_method_code FOREIGN KEY (mats_method_cd)
        REFERENCES camdecmpsmd.mats_method_code (mats_method_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_mats_method_data_mats_method_parameter_code FOREIGN KEY (mats_method_parameter_cd)
        REFERENCES camdecmpsmd.mats_method_parameter_code (mats_method_parameter_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_mats_method_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
		    ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_mats_method_data_mats_method_cd
    ON camdecmps.mats_method_data USING btree
    (mats_method_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_method_data_mon_loc_id
    ON camdecmps.mats_method_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_method_data_mats_method_parameter_cd
    ON camdecmps.mats_method_data USING btree
    (mats_method_parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);
