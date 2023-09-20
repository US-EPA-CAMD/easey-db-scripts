ALTER TABLE IF EXISTS camdecmpsmd.hbha_supp_data_xref
    ADD CONSTRAINT pk_hbha_supp_data_xref PRIMARY KEY (hbha_sd_xref_id),
    ADD CONSTRAINT uq_hbha_supp_data_xref UNIQUE (hourly_type_cd, parameter_cd, moisture_basis),
    ADD CONSTRAINT fk_hbha_supp_data_xref_hourly_type_code FOREIGN KEY (hourly_type_cd)
        REFERENCES camdecmpsmd.hourly_type_code (hourly_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_hbha_supp_data_xref_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_hbha_supp_data_xref_hourly_type_cd
    ON camdecmpsmd.hbha_supp_data_xref USING btree
    (hourly_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hbha_supp_data_xref_parameter_cd
    ON camdecmpsmd.hbha_supp_data_xref USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);
