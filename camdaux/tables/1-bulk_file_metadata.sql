-- Table: camdaux.bulk_file_metadata

-- DROP TABLE camdaux.bulk_file_metadata;

CREATE TABLE IF NOT EXISTS camdaux.bulk_file_metadata
(
    file_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    s3_path character varying(500) COLLATE pg_catalog."default" NOT NULL,
    metadata character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    file_size bigint NOT NULL,
    add_date date NOT NULL DEFAULT CURRENT_DATE,
    last_update_date date NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT pk_bulk_file_metadata PRIMARY KEY (file_name),
    CONSTRAINT uq_bulk_file_metadata_s3_path UNIQUE (s3_path)
);
-- Index: idx_bulk_file_metadata_s3_path

-- DROP INDEX camdaux.idx_bulk_file_metadata_s3_path;

CREATE INDEX IF NOT EXISTS idx_bulk_file_metadata_s3_path
    ON camdaux.bulk_file_metadata USING btree
    (s3_path COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;