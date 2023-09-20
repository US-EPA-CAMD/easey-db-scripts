ALTER TABLE IF EXISTS camdecmps.unit_fuel
    ADD CONSTRAINT pk_unit_fuel PRIMARY KEY (uf_id),
    ADD CONSTRAINT uq_unit_fuel UNIQUE (unit_id, fuel_type, begin_date),
    ADD CONSTRAINT fk_unit_fuel_dem_method_code_gcv FOREIGN KEY (dem_gcv)
        REFERENCES camdecmpsmd.dem_method_code (dem_method_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_unit_fuel_dem_method_code_so2 FOREIGN KEY (dem_so2)
        REFERENCES camdecmpsmd.dem_method_code (dem_method_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_unit_fuel_fuel_indicator_code FOREIGN KEY (indicator_cd)
        REFERENCES camdecmpsmd.fuel_indicator_code (fuel_indicator_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_unit_fuel_fuel_type_code FOREIGN KEY (fuel_type)
        REFERENCES camdecmpsmd.fuel_type_code (fuel_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_unit_fuel_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE,
    ADD CONSTRAINT ck_unit_fuel_act_or_proj_cd CHECK (act_or_proj_cd::text = ANY (ARRAY['A'::character varying::text, 'P'::character varying::text, NULL::character varying::text]));

CREATE INDEX IF NOT EXISTS idx_unit_fuel_unit_id
    ON camdecmps.unit_fuel USING btree
    (unit_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_fuel_fuel_type
    ON camdecmps.unit_fuel USING btree
    (fuel_type COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_fuel_indicator_cd
    ON camdecmps.unit_fuel USING btree
    (indicator_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_fuel_dem_so2
    ON camdecmps.unit_fuel USING btree
    (dem_so2 COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_fuel_dem_gcv
    ON camdecmps.unit_fuel USING btree
    (dem_gcv COLLATE pg_catalog."default" ASC NULLS LAST);
