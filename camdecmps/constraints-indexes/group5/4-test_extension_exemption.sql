ALTER TABLE IF EXISTS camdecmps.test_extension_exemption
    ADD CONSTRAINT pk_test_extension_exemption PRIMARY KEY (test_extension_exemption_id),
    ADD CONSTRAINT fk_test_extension_exemption_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_test_extension_exemption_extension_exemption_code FOREIGN KEY (extens_exempt_cd)
        REFERENCES camdecmpsmd.extension_exemption_code (extens_exempt_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_test_extension_exemption_fuel_code FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_test_extension_exemption_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_test_extension_exemption_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_test_extension_exemption_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_test_extension_exemption_span_scale_code FOREIGN KEY (span_scale_cd)
        REFERENCES camdecmpsmd.span_scale_code (span_scale_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_test_extension_exemption_submission_availability_code FOREIGN KEY (submission_availability_cd)
        REFERENCES camdecmpsmd.submission_availability_code (submission_availability_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_test_extension_exemption_chk_session_id
    ON camdecmps.test_extension_exemption USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_extension_exemption_submission_id
    ON camdecmps.test_extension_exemption USING btree
    (submission_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_extension_exemption_component_id
    ON camdecmps.test_extension_exemption USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_extension_exemption_extens_exempt_cd
    ON camdecmps.test_extension_exemption USING btree
    (extens_exempt_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_extension_exemption_fuel_cd
    ON camdecmps.test_extension_exemption USING btree
    (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_extension_exemption_mon_loc_id
    ON camdecmps.test_extension_exemption USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_extension_exemption_mon_sys_id
    ON camdecmps.test_extension_exemption USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_extension_exemption_span_scale_cd
    ON camdecmps.test_extension_exemption USING btree
    (span_scale_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_extension_exemption_submission_availability_cd
    ON camdecmps.test_extension_exemption USING btree
    (submission_availability_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_extension_exemption_rpt_period_id
    ON camdecmps.test_extension_exemption USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_extension_exemption_rpt_period_id_mon_loc_id
    ON camdecmps.test_extension_exemption USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
