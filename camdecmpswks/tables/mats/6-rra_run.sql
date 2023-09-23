-- Table: camdecmpswks.rra_run

-- DROP TABLE camdecmpswks.rra_run;

CREATE TABLE IF NOT EXISTS camdecmpswks.rra_run
(
    rra_run_id character varying(45) NOT NULL,
    rra_sum_id character varying(45) NOT NULL,
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
    userid character varying(160),
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_rra_run PRIMARY KEY (rra_run_id),
    CONSTRAINT fk_rra_run_rra_summary FOREIGN KEY (rra_sum_id)
        REFERENCES camdecmpswks.rra_summary (rra_sum_id) MATCH SIMPLE
        ON DELETE CASCADE,
    CONSTRAINT fk_rra_run_rra_run_status_code FOREIGN KEY (run_status_cd)
        REFERENCES camdecmpsmd.rra_run_status_code (run_status_cd) MATCH SIMPLE
);
