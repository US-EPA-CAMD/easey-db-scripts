ALTER TABLE IF EXISTS camdmd.responsibility
    ADD CONSTRAINT pk_responsibility PRIMARY KEY (responsibility_id),
    ADD CONSTRAINT uq_responsibility_description UNIQUE (responsibility_description);

CREATE INDEX IF NOT EXISTS idx_responsibility_group_type_cd
    ON camdmd.responsibility USING btree
    (group_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);