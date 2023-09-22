ALTER TABLE IF EXISTS camdecmpswks.rata_traverse
    ADD CONSTRAINT pk_rata_traverse PRIMARY KEY (rata_traverse_id),
    ADD CONSTRAINT fk_rata_traverse_flow_rata_run FOREIGN KEY (flow_rata_run_id)
        REFERENCES camdecmpswks.flow_rata_run (flow_rata_run_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_rata_traverse_pressure_measure_code FOREIGN KEY (pressure_meas_cd)
        REFERENCES camdecmpsmd.pressure_measure_code (pressure_meas_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_rata_traverse_probe_type_code FOREIGN KEY (probe_type_cd)
        REFERENCES camdecmpsmd.probe_type_code (probe_type_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_rata_traverse_flow_rata_run_id
    ON camdecmpswks.rata_traverse USING btree
    (flow_rata_run_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_rata_traverse_pressure_meas_cd
    ON camdecmpswks.rata_traverse USING btree
    (pressure_meas_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_rata_traverse_probe_type_cd
    ON camdecmpswks.rata_traverse USING btree
    (probe_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);
