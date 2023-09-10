CREATE TABLE IF NOT EXISTS camdecmpsmd.hbha_supp_data_xref
(
    hbha_sd_xref_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    hourly_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    moisture_basis character varying(1) COLLATE pg_catalog."default",
    primary_bypass_ind numeric(38,0) NOT NULL,
    derived_value_source character varying(1000) COLLATE pg_catalog."default",
    monitor_value_source character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT hbha_supp_data_xref_pk PRIMARY KEY (hbha_sd_xref_id),
    CONSTRAINT hbha_supp_data_xref_uq UNIQUE (hourly_type_cd, parameter_cd, moisture_basis),
    CONSTRAINT hbha_supp_data_xref_hrt_fk FOREIGN KEY (hourly_type_cd)
        REFERENCES camdecmpsmd.hourly_type_code (hourly_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT hbha_supp_data_xref_par_fk FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);