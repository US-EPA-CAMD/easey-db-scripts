-- Table: camdecmpswks.ps11_run

-- DROP TABLE camdecmpswks.ps11_run;

CREATE TABLE IF NOT EXISTS camdecmpswks.ps11_run
(
    ps11_run_id character varying(45) NOT NULL,
    ps11_sum_id character varying(45) NOT NULL,
    run_num numeric(2,0) NOT NULL,
    begin_date date,
    begin_hour numeric(2,0),
    begin_min numeric(2,0),
    end_date date,
    end_hour numeric(2,0),
    end_min numeric(2,0),
    cem_value numeric(15,5),
    pm_ref_value numeric(15,1),
    gross_unit_load numeric(6,0),
    run_status_cd character varying(7),
    userid character varying(160),
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_ps11_run PRIMARY KEY (ps11_run_id),
    CONSTRAINT fk_ps11_run_ps11_summary FOREIGN KEY (ps11_sum_id)
        REFERENCES camdecmpswks.ps11_summary (ps11_sum_id) MATCH SIMPLE
        ON DELETE CASCADE,
    CONSTRAINT fk_ps11_run_ps11_run_status_code FOREIGN KEY (run_status_cd)
        REFERENCES camdecmpsmd.ps11_run_status_code (run_status_cd) MATCH SIMPLE
);
