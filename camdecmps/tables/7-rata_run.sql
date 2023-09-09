CREATE TABLE IF NOT EXISTS camdecmps.rata_run
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
    update_date timestamp without time zone,
    CONSTRAINT pk_rata_run PRIMARY KEY (rata_run_id),
    CONSTRAINT fk_rata_run_rata_summary FOREIGN KEY (rata_sum_id)
        REFERENCES camdecmps.rata_summary (rata_sum_id) MATCH SIMPLE
        ON DELETE CASCADE,
    CONSTRAINT fk_rata_run_run_status_code FOREIGN KEY (run_status_cd)
        REFERENCES camdecmpsmd.run_status_code (run_status_cd) MATCH SIMPLE
);

COMMENT ON TABLE camdecmps.rata_run
    IS 'Relative Accuracy Test Audit (RATA) and bias test data for one RATA run.  Record Type 610.';

COMMENT ON COLUMN camdecmps.rata_run.rata_run_id
    IS 'Unique identifier of a RATA run record. ';

COMMENT ON COLUMN camdecmps.rata_run.rata_sum_id
    IS 'Unique identifier of a RATA summary record. ';

COMMENT ON COLUMN camdecmps.rata_run.gross_unit_load
    IS 'Gross unit load or average velocity at operating level. ';

COMMENT ON COLUMN camdecmps.rata_run.run_num
    IS 'Run number. ';

COMMENT ON COLUMN camdecmps.rata_run.cem_value
    IS 'Value from CEM system being tested. ';

COMMENT ON COLUMN camdecmps.rata_run.rata_ref_value
    IS 'Value from reference method, adjusted as necessary for moisture and/or calibration bias. ';

COMMENT ON COLUMN camdecmps.rata_run.calc_rata_ref_value
    IS 'Value from reference method, adjusted as necessary for moisture and/or calibration bias. ';

COMMENT ON COLUMN camdecmps.rata_run.run_status_cd
    IS 'Code used to identify run status. ';

COMMENT ON COLUMN camdecmps.rata_run.begin_date
    IS 'Date in which information became effective or activity started. ';

COMMENT ON COLUMN camdecmps.rata_run.begin_hour
    IS 'Hour in which information became effective or activity started. ';

COMMENT ON COLUMN camdecmps.rata_run.begin_min
    IS 'Minute in which the RATA run began. ';

COMMENT ON COLUMN camdecmps.rata_run.end_date
    IS 'Last date in which information was effective or date in which activity ended. ';

COMMENT ON COLUMN camdecmps.rata_run.end_hour
    IS 'Last hour in which information was effective or hour in which activity ended. ';

COMMENT ON COLUMN camdecmps.rata_run.end_min
    IS 'Last minute in which information was effective or minute in which activity ended. ';

COMMENT ON COLUMN camdecmps.rata_run.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.rata_run.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.rata_run.update_date
    IS 'Date and time in which record was last updated. ';
