ALTER TABLE IF EXISTS camdecmpswks.hrly_op_data
    ADD CONSTRAINT pk_hrly_op_data PRIMARY KEY (hour_id),
    ADD CONSTRAINT fk_hrly_op_data_fuel_code FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_hrly_op_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_hrly_op_data_operating_condition_code FOREIGN KEY (operating_condition_cd)
        REFERENCES camdecmpsmd.operating_condition_code (operating_condition_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_hrly_op_data_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_hrly_op_data_units_of_measure_code FOREIGN KEY (load_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE,
    ADD CONSTRAINT hrly_op_data_begin_date_check CHECK (begin_date IS NOT NULL),
    ADD CONSTRAINT hrly_op_data_begin_hour_check CHECK (begin_hour IS NOT NULL),
    ADD CONSTRAINT hrly_op_data_hour_id_check CHECK (hour_id IS NOT NULL),
    ADD CONSTRAINT hrly_op_data_mon_loc_id_check CHECK (mon_loc_id IS NOT NULL),
    ADD CONSTRAINT hrly_op_data_rpt_period_id_check CHECK (rpt_period_id IS NOT NULL);

CREATE INDEX IF NOT EXISTS idx_hrly_op_data_mon_loc_id
    ON camdecmpswks.hrly_op_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_op_data_rpt_period_id
    ON camdecmpswks.hrly_op_data USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_op_data_fuel_cd
    ON camdecmpswks.hrly_op_data USING btree
    (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_op_data_load_uom_cd
    ON camdecmpswks.hrly_op_data USING btree
    (load_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_op_data_operating_condition_cd
    ON camdecmpswks.hrly_op_data USING btree
    (operating_condition_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_op_data_rpt_period_id_mon_loc_id
    ON camdecmpswks.hrly_op_data USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
