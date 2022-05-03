-- Table: camdecmpswks.flow_rata_run

-- DROP TABLE camdecmpswks.flow_rata_run;

CREATE TABLE IF NOT EXISTS camdecmpswks.flow_rata_run
(
    flow_rata_run_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rata_run_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    num_traverse_point numeric(2,0),
    barometric_pressure numeric(5,2),
    static_stack_pressure numeric(5,2),
    percent_co2 numeric(5,1),
    percent_o2 numeric(5,1),
    percent_moisture numeric(5,1),
    dry_molecular_weight numeric(5,2),
    calc_dry_molecular_weight numeric(5,2),
    wet_molecular_weight numeric(5,2),
    calc_wet_molecular_weight numeric(5,2),
    avg_vel_wo_wall numeric(6,2),
    calc_avg_vel_wo_wall numeric(6,2),
    avg_vel_w_wall numeric(6,2),
    calc_avg_vel_w_wall numeric(6,2),
    calc_waf numeric(6,4),
    calc_calc_waf numeric(6,4),
    avg_stack_flow_rate numeric(10,0),
    userid character varying(25) COLLATE pg_catalog."default",
    update_date timestamp without time zone,
    add_date timestamp without time zone,
    CONSTRAINT pk_flow_rata_run PRIMARY KEY (flow_rata_run_id),
    CONSTRAINT fk_flow_rata_run_rata_run FOREIGN KEY (rata_run_id)
        REFERENCES camdecmpswks.rata_run (rata_run_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- -- Index: flow_rata_run_idx001

-- -- DROP INDEX camdecmpswks.flow_rata_run_idx001;

-- CREATE INDEX flow_rata_run_idx001
--     ON camdecmpswks.flow_rata_run USING btree
--     (rata_run_id COLLATE pg_catalog."default" ASC NULLS LAST);
