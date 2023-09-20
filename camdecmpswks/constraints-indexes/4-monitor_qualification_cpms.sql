ALTER TABLE IF EXISTS camdecmpswks.monitor_qualification_cpms
    ADD CONSTRAINT pk_monitor_qualification_cpms PRIMARY KEY (mon_qual_cpms_id),
    ADD CONSTRAINT fk_monitor_qualification_cpms_monitor_qualification FOREIGN KEY (mon_qual_id)
        REFERENCES camdecmpswks.monitor_qualification (mon_qual_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_monitor_qualification_cpms_mon_qual_id
    ON camdecmpswks.monitor_qualification_cpms USING btree
    (mon_qual_id COLLATE pg_catalog."default" ASC NULLS LAST);
