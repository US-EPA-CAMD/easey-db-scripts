-- Table: camdecmpswks.mats_bulk_file

-- DROP TABLE camdecmpswks.mats_bulk_file;

CREATE TABLE IF NOT EXISTS camdecmpswks.mats_bulk_file
(
    mats_bulk_file_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 ),
    fac_id numeric(38,0) NOT NULL,
    oris_code numeric(6,0) NOT NULL,
    facility_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_num character varying(18) COLLATE pg_catalog."default" NOT NULL,
    filename character varying(100) COLLATE pg_catalog."default" NOT NULL,
    last_updated timestamp without time zone,
    updated_status_flg character varying(1) COLLATE pg_catalog."default",
    submission_id numeric(38,0),
    submission_availability_cd character varying(7) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    CONSTRAINT pk_mats_bulk_file PRIMARY KEY (mats_bulk_file_id),
    CONSTRAINT fk_mats_bulk_file_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmpswks.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_mats_bulk_file_submission_availability_code FOREIGN KEY (submission_availability_cd)
        REFERENCES camdecmpsmd.submission_availability_code (submission_availability_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_mats_bulk_file_plant FOREIGN KEY (fac_id)
        REFERENCES camd.plant (fac_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
