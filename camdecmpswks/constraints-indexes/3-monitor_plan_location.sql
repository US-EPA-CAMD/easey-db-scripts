ALTER TABLE IF EXISTS camdecmpswks.monitor_plan_location
    ADD CONSTRAINT pk_monitor_plan_location PRIMARY KEY (monitor_plan_location_id),
    ADD CONSTRAINT uq_monitor_plan_location UNIQUE (mon_plan_id, mon_loc_id),
    ADD CONSTRAINT fk_monitor_plan_location_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_plan_location_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmpswks.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_monitor_plan_location_mon_plan_id
    ON camdecmpswks.monitor_plan_location USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_plan_location_mon_loc_id
    ON camdecmpswks.monitor_plan_location USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_plan_location_mon_plan_id_mon_loc_id
    ON camdecmpswks.monitor_plan_location USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
