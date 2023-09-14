ALTER TABLE IF EXISTS camdecmpswks.monitor_qualification_lee
    ADD CONSTRAINT pk_monitor_qualification_lee PRIMARY KEY (mon_qual_lee_id),
    ADD CONSTRAINT fk_monitor_qualification_lee_monitor_qualification FOREIGN KEY (mon_qual_id)
        REFERENCES camdecmpswks.monitor_qualification (mon_qual_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_qualification_lee_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_qualification_lee_qual_test_type_code FOREIGN KEY (qual_lee_test_type_cd)
        REFERENCES camdecmpsmd.qual_lee_test_type_code (qual_lee_test_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_qualification_lee_units_of_measure_code FOREIGN KEY (emission_standard_uom)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_monitor_qualification_lee_emission_standard_uom
    ON camdecmpswks.monitor_qualification_lee USING btree
    (emission_standard_uom COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_qualification_lee_mon_qual_id
    ON camdecmpswks.monitor_qualification_lee USING btree
    (mon_qual_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_qualification_lee_parameter_cd
    ON camdecmpswks.monitor_qualification_lee USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_qualification_lee_qaul_lee_test_type_cd
    ON camdecmpswks.monitor_qualification_lee USING btree
    (qual_lee_test_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);
