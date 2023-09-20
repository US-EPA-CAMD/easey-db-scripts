ALTER TABLE IF EXISTS camdecmpsmd.dem_method_code
    ADD CONSTRAINT pk_dem_method_code PRIMARY KEY (dem_method_cd),
    ADD CONSTRAINT uq_dem_method_code_description UNIQUE (dem_method_cd, dem_method_description),
    ADD CONSTRAINT ck_dem_method_code_dem_parameter CHECK (dem_parameter::text = ANY (ARRAY['GCV'::character varying, 'SULFUR'::character varying]::text[]));
