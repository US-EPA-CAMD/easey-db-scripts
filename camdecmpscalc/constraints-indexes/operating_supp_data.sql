ALTER TABLE IF EXISTS camdecmpscalc.operating_supp_data
    ADD CONSTRAINT pk_operating_supp_data PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_operating_supp_data_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_operating_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_operating_supp_data_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_operating_supp_data_fuel_code FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_operating_supp_data_operating_type_code FOREIGN KEY (op_type_cd)
        REFERENCES camdecmpsmd.operating_type_code (op_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_operating_supp_data_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_operating_supp_data_chk_session_id
    ON camdecmpscalc.operating_supp_data USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_operating_supp_data_parameter_cd
    ON camdecmpscalc.operating_supp_data USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_operating_supp_data_fuel_cd
    ON camdecmpscalc.operating_supp_data USING btree
    (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_operating_supp_data_mon_loc_id
    ON camdecmpscalc.operating_supp_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_operating_supp_data_op_type_cd
    ON camdecmpscalc.operating_supp_data USING btree
    (op_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_operating_supp_data_rpt_period_id
    ON camdecmpscalc.operating_supp_data USING btree
    (rpt_period_id ASC NULLS LAST);