CREATE TABLE IF NOT EXISTS camdecmpswks.monitor_qualification_lee
(
    mon_qual_lee_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_qual_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    qual_test_date date NOT NULL,
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    qual_lee_test_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    potential_annual_emissions numeric(6,1),
    applicable_emission_standard numeric(9,4),
    emission_standard_uom character varying(7) COLLATE pg_catalog."default",
    emission_standard_pct numeric(5,1),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);
