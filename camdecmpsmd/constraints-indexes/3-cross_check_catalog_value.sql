ALTER TABLE IF EXISTS camdecmpsmd.cross_check_catalog_value
    ADD CONSTRAINT pk_cross_check_catalog_value PRIMARY KEY (cross_chk_catalog_value_id),
    ADD CONSTRAINT fk_cross_check_catalog_value_cross_check_catalog FOREIGN KEY (cross_chk_catalog_id)
        REFERENCES camdecmpsmd.cross_check_catalog (cross_chk_catalog_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_cross_check_catalog_value_cross_chk_catalog_id
    ON camdecmpsmd.cross_check_catalog_value USING btree
    (cross_chk_catalog_id ASC NULLS LAST);