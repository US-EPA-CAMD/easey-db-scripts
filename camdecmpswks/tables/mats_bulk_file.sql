CREATE TABLE IF NOT EXISTS camdecmpswks.mats_bulk_file
(
    mats_bulk_file_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    fac_id numeric(38,0) NOT NULL,
    oris_code numeric(6,0) NOT NULL,
    location character varying COLLATE pg_catalog."default" NOT NULL,
    test_type_code character varying COLLATE pg_catalog."default" NOT NULL,
    test_type_code_description character varying COLLATE pg_catalog."default" NOT NULL,
    facility_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_num character varying(18) COLLATE pg_catalog."default" NOT NULL,
    filename character varying(100) COLLATE pg_catalog."default" NOT NULL,
    last_updated timestamp without time zone,
    updated_status_flg character varying(1) COLLATE pg_catalog."default",
    submission_id numeric(38,0),
    submission_availability_cd character varying(7) COLLATE pg_catalog."default" DEFAULT 'REQUIRE'::character varying,
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    bucket_location character varying COLLATE pg_catalog."default",
    eval_status_cd character varying(7) COLLATE pg_catalog."default" DEFAULT 'PASS'::character varying
);