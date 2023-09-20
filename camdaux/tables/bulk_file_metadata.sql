CREATE TABLE IF NOT EXISTS camdaux.bulk_file_metadata
(
    file_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    s3_path character varying(500) COLLATE pg_catalog."default" NOT NULL,
    metadata character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    file_size bigint NOT NULL,
    add_date date NOT NULL DEFAULT CURRENT_DATE,
    last_update_date date NOT NULL DEFAULT CURRENT_DATE
);
