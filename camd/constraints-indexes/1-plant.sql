ALTER TABLE IF EXISTS camd.plant
    ADD CONSTRAINT pk_plant PRIMARY KEY (fac_id),
    ADD CONSTRAINT uq_plant_oris_code UNIQUE (oris_code),
    ADD CONSTRAINT uq_plant_name_by_state UNIQUE (facility_name, state),
    ADD CONSTRAINT fk_plant_county_code FOREIGN KEY (county_cd)
        REFERENCES camdmd.county_code (county_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_plant_epa_region_code FOREIGN KEY (epa_region)
        REFERENCES camdmd.epa_region_code (epa_region_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_plant_nerc_region_code FOREIGN KEY (nerc_region)
        REFERENCES camdmd.nerc_region_code (nerc_region_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_plant_sic_code FOREIGN KEY (sic_code)
        REFERENCES camdmd.sic_code (sic_code) MATCH SIMPLE,
    ADD CONSTRAINT fk_plant_state_code FOREIGN KEY (state)
        REFERENCES camdmd.state_code (state_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_plant_tribal_land_code FOREIGN KEY (tribal_land_cd)
        REFERENCES camdmd.tribal_land_code (tribal_land_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_plant_county_cd
    ON camd.plant USING btree
    (county_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_plant_epa_region_cd
    ON camd.plant USING btree
    (epa_region ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_plant_nerc_region_cd
    ON camd.plant USING btree
    (nerc_region COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_plant_sic_cd
    ON camd.plant USING btree
    (sic_code ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_plant_state_cd
    ON camd.plant USING btree
    (state COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_plant_tribal_land_cd
    ON camd.plant USING btree
    (tribal_land_cd COLLATE pg_catalog."default" ASC NULLS LAST);

/* WHY ???
CREATE INDEX IF NOT EXISTS idx_plant_epa_id_oris_name
    ON camd.plant USING btree
    (epa_region ASC NULLS LAST, fac_id ASC NULLS LAST, oris_code ASC NULLS LAST, facility_name COLLATE pg_catalog."default" ASC NULLS LAST);
*/
