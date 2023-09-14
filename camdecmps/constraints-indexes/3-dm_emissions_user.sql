ALTER TABLE IF EXISTS camdecmps.dm_emissions_user
	  ADD CONSTRAINT pk_dm_emissions_user PRIMARY KEY (dm_emissions_user_id),
    ADD CONSTRAINT uq_dm_emissions_user UNIQUE (dm_emissions_id, dm_emissions_user_cd),
    ADD CONSTRAINT fk_dm_emissions_user_dm_emissions FOREIGN KEY (dm_emissions_id)
        REFERENCES camdecmps.dm_emissions (dm_emissions_id) MATCH SIMPLE
        ON DELETE CASCADE,
	  ADD CONSTRAINT fk_dm_emissions_user_dm_emissions_user_code FOREIGN KEY (dm_emissions_user_cd)
        REFERENCES camdecmpsmd.dm_emissions_user_code (dm_emissions_user_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_dm_emissions_dm_emissions_id
    ON camdecmps.dm_emissions_user USING btree
    (dm_emissions_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_dm_emissions_dm_emissions_user_cd
    ON camdecmps.dm_emissions_user USING btree
    (dm_emissions_user_cd COLLATE pg_catalog."default" ASC NULLS LAST);