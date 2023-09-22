ALTER TABLE IF EXISTS camdmd.class_code
    ADD CONSTRAINT pk_class_code PRIMARY KEY (class_cd);

/*
CREATE INDEX idx_class_code_affected
    ON camdmd.class_code USING btree
    (affected_ind ASC NULLS LAST);
*/