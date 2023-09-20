ALTER TABLE IF EXISTS camdecmpsmd.cross_check_catalog
    ADD CONSTRAINT pk_cross_check_catalog PRIMARY KEY (cross_chk_catalog_id),
    ADD CONSTRAINT uq_cross_check_catalog_name UNIQUE (cross_chk_catalog_name),
    ADD CONSTRAINT fk_cross_check_catalog_field_type_cd1 FOREIGN KEY (field_type_cd1)
        REFERENCES camdecmpsmd.check_data_type_code (check_data_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_cross_check_catalog_field_type_cd2 FOREIGN KEY (field_type_cd2)
        REFERENCES camdecmpsmd.check_data_type_code (check_data_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_cross_check_catalog_field_type_cd3 FOREIGN KEY (field_type_cd3)
        REFERENCES camdecmpsmd.check_data_type_code (check_data_type_cd) MATCH SIMPLE;

CREATE INDEX idx_cross_check_catalog_field_type_cd1
    ON camdecmpsmd.cross_check_catalog USING btree
    (field_type_cd1 COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX idx_cross_check_catalog_field_type_cd2
    ON camdecmpsmd.cross_check_catalog USING btree
    (field_type_cd2 COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX idx_cross_check_catalog_field_type_cd3
    ON camdecmpsmd.cross_check_catalog USING btree
    (field_type_cd3 COLLATE pg_catalog."default" ASC NULLS LAST);
