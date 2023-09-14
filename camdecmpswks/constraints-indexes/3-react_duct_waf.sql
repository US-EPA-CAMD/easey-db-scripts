ALTER TABLE IF EXISTS camdecmpswks.rect_duct_waf
    ADD CONSTRAINT pk_rect_duct_waf PRIMARY KEY (rect_duct_waf_data_id),
    ADD CONSTRAINT fk_rect_duct_waf_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_rect_duct_waf_waf_method_code FOREIGN KEY (waf_method_cd)
        REFERENCES camdecmpsmd.waf_method_code (waf_method_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_rect_duct_waf_mon_loc_id
    ON camdecmpswks.rect_duct_waf USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_rect_duct_waf_waf_method_cd
    ON camdecmpswks.rect_duct_waf USING btree
    (waf_method_cd COLLATE pg_catalog."default" ASC NULLS LAST);
