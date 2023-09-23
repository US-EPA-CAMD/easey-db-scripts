-- Table: camdecmpswks.sva_run

-- DROP TABLE camdecmpswks.sva_run;

CREATE TABLE IF NOT EXISTS camdecmpswks.sva_run
(
    sva_run_id character varying(45) NOT NULL,
    sva_sum_id character varying(45) NOT NULL,
    run_num numeric(2,0) NOT NULL,
    begin_date date,
    begin_hour numeric(2,0),
    begin_min numeric(2,0),
    end_date date,
    end_hour numeric(2,0),
    end_min numeric(2,0),
    cems_sample_volume numeric(15,5),
    ref_sample_volume numeric(15,5),
    percent_error numeric(5,1),
    userid character varying(160),
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_sva_run PRIMARY KEY (sva_run_id),
    CONSTRAINT fk_sva_run_sva_summary FOREIGN KEY (sva_sum_id)
        REFERENCES camdecmpswks.sva_summary (sva_sum_id) MATCH SIMPLE
        ON DELETE CASCADE
);
