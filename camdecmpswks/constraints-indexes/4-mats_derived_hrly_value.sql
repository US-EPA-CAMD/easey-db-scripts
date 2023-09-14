ALTER TABLE IF EXISTS camdecmpswks.mats_derived_hrly_value
    ADD CONSTRAINT pk_mats_derived_hrly_value PRIMARY KEY (mats_dhv_id),
    ADD CONSTRAINT fk_mats_derived_hrly_value_hrly_op_data FOREIGN KEY (hour_id)
        REFERENCES camdecmpswks.hrly_op_data (hour_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_mats_derived_hrly_value_modc_code FOREIGN KEY (modc_cd)
        REFERENCES camdecmpsmd.modc_code (modc_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_mats_derived_hrly_value_monitor_formula FOREIGN KEY (mon_form_id)
        REFERENCES camdecmpswks.monitor_formula (mon_form_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_mats_derived_hrly_value_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_mats_derived_hrly_value_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_mats_derived_hrly_value_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_mats_derived_hrly_value_hour_id
    ON camdecmpswks.mats_derived_hrly_value USING btree
    (hour_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_derived_hrly_value_mon_form_id
    ON camdecmpswks.mats_derived_hrly_value USING btree
    (mon_form_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_derived_hrly_value_parameter_cd
    ON camdecmpswks.mats_derived_hrly_value USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_derived_hrly_value_modc_cd
    ON camdecmpswks.mats_derived_hrly_value USING btree
    (modc_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_derived_hrly_value_rpt_period_id
    ON camdecmpswks.mats_derived_hrly_value USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_derived_hrly_value_mon_loc_id
    ON camdecmpswks.mats_derived_hrly_value USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_derived_hrly_value_rpt_period_id_mon_loc_id
    ON camdecmpswks.mats_derived_hrly_value USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

/* WHY ???
CREATE INDEX IF NOT EXISTS idx_mats_derived_hrly_value_
    ON camdecmpswks.mats_derived_hrly_value USING btree
    (modc_cd COLLATE pg_catalog."default" ASC NULLS LAST, unadjusted_hrly_value COLLATE pg_catalog."default" ASC NULLS LAST, parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST, hour_id COLLATE pg_catalog."default" ASC NULLS LAST);
*/
