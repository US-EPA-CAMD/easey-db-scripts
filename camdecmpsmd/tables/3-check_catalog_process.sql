CREATE TABLE IF NOT EXISTS camdecmpsmd.check_catalog_process(
	check_catalog_id numeric(38,0) NOT NULL,
	process_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
	CONSTRAINT pk_check_catalog_process PRIMARY KEY (check_catalog_id, process_cd)
);