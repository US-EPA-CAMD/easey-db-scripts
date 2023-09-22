ALTER TABLE IF EXISTS camdecmpsaux.check_log
	  ADD CONSTRAINT pk_check_log PRIMARY KEY (chk_log_id),
    ADD CONSTRAINT fk_check_log_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpsaux.check_session (chk_session_id) MATCH SIMPLE
		    ON DELETE CASCADE,
    --ADD CONSTRAINT fk_check_log_rule_check FOREIGN KEY (rule_check_id)
    --    REFERENCES camdecmpsmd.rule_check (rule_check_id) MATCH SIMPLE,
    --ADD CONSTRAINT fk_check_log_check_catalog_result FOREIGN KEY (check_catalog_result_id)
    --    REFERENCES camdecmpsmd.check_catalog_result (check_catalog_result_id) MATCH SIMPLE,
	  ADD CONSTRAINT fk_check_log_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
		    ON DELETE CASCADE,
	  --ADD CONSTRAINT fk_check_log_test_summary FOREIGN KEY (test_sum_id)
    --    REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
		--    ON DELETE CASCADE,
    ADD CONSTRAINT fk_check_log_severity_code FOREIGN KEY (severity_cd)
        REFERENCES camdecmpsmd.severity_code (severity_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_check_log_severity_code_suppressed FOREIGN KEY (suppressed_severity_cd)
        REFERENCES camdecmpsmd.severity_code (severity_cd) MATCH SIMPLE;
    --NOT THE SAME DATATYPE
    --ADD CONSTRAINT fk_check_log_es_spec FOREIGN KEY (error_suppress_id)
    --    REFERENCES camdecmpsaux.es_spec (es_spec_id) MATCH SIMPLE

CREATE INDEX IF NOT EXISTS idx_check_log_chk_session_id
    ON camdecmpsaux.check_log USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_log_rule_check_id
    ON camdecmpsaux.check_log USING btree
    (rule_check_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_log_check_catalog_result_id
    ON camdecmpsaux.check_log USING btree
    (check_catalog_result_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_log_mon_loc_id
    ON camdecmpsaux.check_log USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_log_test_sum_id
    ON camdecmpsaux.check_log USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_log_check_result
    ON camdecmpsaux.check_log USING btree
    (check_result COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_log_severity_cd
    ON camdecmpsaux.check_log USING btree
    (severity_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_log_suppressed_severity_cd
    ON camdecmpsaux.check_log USING btree
    (suppressed_severity_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_log_check_cd
    ON camdecmpsaux.check_log USING btree
    (check_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_log_error_suppress_id
    ON camdecmpsaux.check_log USING btree
    (error_suppress_id ASC NULLS LAST);
