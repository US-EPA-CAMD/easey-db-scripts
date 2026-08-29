ALTER TABLE IF EXISTS camdecmpswks.monitor_qualification_lme
    ADD CONSTRAINT pk_monitor_qualification_lme PRIMARY KEY (mon_lme_id),
    ADD CONSTRAINT fk_monitor_qualification_lme_monitor_qualification FOREIGN KEY (mon_qual_id)
        REFERENCES camdecmpswks.monitor_qualification (mon_qual_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT uq_monitor_qualification_lme_key
        UNIQUE (MON_QUAL_ID, QUAL_YEAR);

CREATE INDEX IF NOT EXISTS idx_monitor_qualification_lme_mon_qual_id
    ON camdecmpswks.monitor_qualification_lme USING btree
    (mon_qual_id COLLATE pg_catalog."default" ASC NULLS LAST);
