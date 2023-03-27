-- Table: camdecmpswks.rca_run

-- DROP TABLE camdecmpswks.rca_run;

CREATE TABLE IF NOT EXISTS camdecmpswks.rca_run
(
    rca_run_id character varying(45) NOT NULL,
    rca_sum_id character varying(45) NOT NULL,
    run_num numeric(2,0) NOT NULL,
    begin_date date,
    begin_hour numeric(2,0),
    begin_min numeric(2,0),
    end_date date,
    end_hour numeric(2,0),
    end_min numeric(2,0),
    cem_value numeric(15,5),
    ref_value numeric(15,1),
    gross_unit_load numeric(6,0),    
    run_status_cd character varying(7),
    userid character varying(25),
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_rca_run PRIMARY KEY (rca_run_id),
    CONSTRAINT fk_rca_run_rca_summary FOREIGN KEY (rca_sum_id)
        REFERENCES camdecmpswks.rca_summary (rca_sum_id) MATCH SIMPLE
        ON DELETE CASCADE,
    CONSTRAINT fk_rca_run_rca_run_status_code FOREIGN KEY (run_status_cd)
        REFERENCES camdecmpsmd.rca_run_status_code (run_status_cd) MATCH SIMPLE
);
