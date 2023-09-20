ALTER TABLE IF EXISTS camdecmpswks.monitor_qualification
    ADD CONSTRAINT pk_monitor_qualification PRIMARY KEY (mon_qual_id),
    ADD CONSTRAINT fk_monitor_qualification_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_qualification_qual_type_code FOREIGN KEY (qual_type_cd)
        REFERENCES camdecmpsmd.qual_type_code (qual_type_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_monitor_qualification_mon_loc_id
    ON camdecmpswks.monitor_qualification USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_qualification_qual_type_cd
    ON camdecmpswks.monitor_qualification USING btree
    (qual_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);
