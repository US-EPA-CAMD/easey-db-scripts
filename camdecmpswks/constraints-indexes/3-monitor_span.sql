ALTER TABLE IF EXISTS camdecmpswks.monitor_span
    ADD CONSTRAINT pk_monitor_span PRIMARY KEY (span_id),
    ADD CONSTRAINT fk_monitor_span_component_type_code FOREIGN KEY (component_type_cd)
        REFERENCES camdecmpsmd.component_type_code (component_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_span_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_span_span_method_code FOREIGN KEY (span_method_cd)
        REFERENCES camdecmpsmd.span_method_code (span_method_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_span_span_scale_code FOREIGN KEY (span_scale_cd)
        REFERENCES camdecmpsmd.span_scale_code (span_scale_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_span_units_of_measure_code FOREIGN KEY (span_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_monitor_span_component_type_cd
    ON camdecmpswks.monitor_span USING btree
    (component_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_span_mon_loc_id
    ON camdecmpswks.monitor_span USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_span_span_method_cd
    ON camdecmpswks.monitor_span USING btree
    (span_method_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_span_span_scale_cd
    ON camdecmpswks.monitor_span USING btree
    (span_scale_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_span_span_uom_cd
    ON camdecmpswks.monitor_span USING btree
    (span_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);
