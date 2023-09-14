ALTER TABLE IF EXISTS camdmd.sic_code
    sic_code numeric(4,0) NOT NULL,
    sic_code_description character varying(50) COLLATE pg_catalog."default",
    ADD CONSTRAINT pk_sic_code PRIMARY KEY (sic_code),
    ADD CONSTRAINT uq_sic_code_description UNIQUE (sic_code_description);
