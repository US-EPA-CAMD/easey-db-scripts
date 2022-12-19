-- Table: camdmd.class_code

-- DROP TABLE camdmd.class_code;

CREATE TABLE IF NOT EXISTS camdmd.class_code
(
    class_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    class_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    affected_ind numeric(1,0) NOT NULL DEFAULT 0,
    CONSTRAINT pk_class_code PRIMARY KEY (class_cd)
);

COMMENT ON TABLE camdmd.class_code
    IS 'Look up table for program classification.';

COMMENT ON COLUMN camdmd.class_code.class_cd
    IS 'Code indicating the program class.';

COMMENT ON COLUMN camdmd.class_code.class_description
    IS 'Description of the program class.';

COMMENT ON COLUMN camdmd.class_code.affected_ind
    IS 'Indicates if the class indicates an affected status.';

-- Index: idx_class_code_affected

-- DROP INDEX camdmd.idx_class_code_affected;

CREATE INDEX IF NOT EXISTS idx_class_code_affected
    ON camdmd.class_code USING btree
    (affected_ind ASC NULLS LAST);