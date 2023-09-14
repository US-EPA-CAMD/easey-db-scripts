CREATE TABLE IF NOT EXISTS camdecmpswks.rata_run
(
    rata_run_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rata_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    gross_unit_load numeric(6,0),
    run_num numeric(2,0) NOT NULL,
    cem_value numeric(15,5),
    rata_ref_value numeric(15,5),
    calc_rata_ref_value numeric(15,5),
    run_status_cd character varying(7) COLLATE pg_catalog."default",
    begin_date date,
    begin_hour numeric(2,0),
    begin_min numeric(2,0),
    end_date date,
    end_hour numeric(2,0),
    end_min numeric(2,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);