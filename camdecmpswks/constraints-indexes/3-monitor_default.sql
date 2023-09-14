ALTER TABLE IF EXISTS camdecmpswks.monitor_default
    ADD CONSTRAINT pk_monitor_default PRIMARY KEY (mondef_id),
    ADD CONSTRAINT fk_monitor_default_default_purpose_code FOREIGN KEY (default_purpose_cd)
        REFERENCES camdecmpsmd.default_purpose_code (default_purpose_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_default_default_source_code FOREIGN KEY (default_source_cd)
        REFERENCES camdecmpsmd.default_source_code (default_source_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_default_fuel_code FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_default_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_default_operating_condition_code FOREIGN KEY (operating_condition_cd)
        REFERENCES camdecmpsmd.operating_condition_code (operating_condition_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_default_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_default_units_of_measure_code FOREIGN KEY (default_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_monitor_default_default_purpose_cd
    ON camdecmpswks.monitor_default USING btree
    (default_purpose_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_default_default_source_cd
    ON camdecmpswks.monitor_default USING btree
    (default_source_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_default_default_uom_cd
    ON camdecmpswks.monitor_default USING btree
    (default_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_default_fuel_cd
    ON camdecmpswks.monitor_default USING btree
    (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_default_operating_condition_cd
    ON camdecmpswks.monitor_default USING btree
    (operating_condition_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_default_parameter_cd
    ON camdecmpswks.monitor_default USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_default_mon_loc_id
    ON camdecmpswks.monitor_default USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

/* WHY ???
CREATE INDEX IF NOT EXISTS idx_monitor_default_
    ON camdecmpswks.monitor_default USING btree
    (begin_date ASC NULLS LAST, begin_hour ASC NULLS LAST, parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_default_
    ON camdecmpswks.monitor_default USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST, default_purpose_cd COLLATE pg_catalog."default" ASC NULLS LAST);
*/
