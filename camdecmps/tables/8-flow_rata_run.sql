-- Table: camdecmps.flow_rata_run

-- DROP TABLE camdecmps.flow_rata_run;

CREATE TABLE IF NOT EXISTS camdecmps.flow_rata_run
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
    CONSTRAINT fk_rata_run_flow_rata_run FOREIGN KEY (rata_run_id)
        REFERENCES camdecmps.rata_run (rata_run_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.flow_rata_run
    IS 'Flow RATAs in which Method 2F and 2G is used.  Record Type 614.';

COMMENT ON COLUMN camdecmps.flow_rata_run.flow_rata_run_id
    IS 'Unique identifier of RATA run level record. ';

COMMENT ON COLUMN camdecmps.flow_rata_run.rata_run_id
    IS 'Unique identifier of a RATA run record. ';

COMMENT ON COLUMN camdecmps.flow_rata_run.num_traverse_point
    IS 'Number of traverse points. ';

COMMENT ON COLUMN camdecmps.flow_rata_run.barometric_pressure
    IS 'P-bar, barometric pressure, in Hg. ';

COMMENT ON COLUMN camdecmps.flow_rata_run.static_stack_pressure
    IS 'P(g), stack static pressure, in H2O. ';

COMMENT ON COLUMN camdecmps.flow_rata_run.percent_co2
    IS 'Percent CO2 in stack gas, dry basis ';

COMMENT ON COLUMN camdecmps.flow_rata_run.percent_o2
    IS 'Percent O2 in stack gas, dry basis. ';

COMMENT ON COLUMN camdecmps.flow_rata_run.percent_moisture
    IS 'Percent moisture in stack gas. ';

COMMENT ON COLUMN camdecmps.flow_rata_run.dry_molecular_weight
    IS 'Stack gas molecular weight, dry basis. ';

COMMENT ON COLUMN camdecmps.flow_rata_run.calc_dry_molecular_weight
    IS 'Stack gas molecular weight, dry basis. ';

COMMENT ON COLUMN camdecmps.flow_rata_run.wet_molecular_weight
    IS 'Stack gas molecular weight, wet basis. ';

COMMENT ON COLUMN camdecmps.flow_rata_run.calc_wet_molecular_weight
    IS 'Stack gas molecular weight, wet basis. ';

COMMENT ON COLUMN camdecmps.flow_rata_run.avg_vel_wo_wall
    IS 'Average velocity for run, not accounting for wall effects. ';

COMMENT ON COLUMN camdecmps.flow_rata_run.calc_avg_vel_wo_wall
    IS 'Average velocity for run, not accounting for wall effects. ';

COMMENT ON COLUMN camdecmps.flow_rata_run.avg_vel_w_wall
    IS 'Average velocity for run, accounting for wall effects. ';

COMMENT ON COLUMN camdecmps.flow_rata_run.calc_avg_vel_w_wall
    IS 'Average velocity for run, accounting for wall effects. ';

COMMENT ON COLUMN camdecmps.flow_rata_run.calc_waf
    IS 'Calculated wall effects adjustment factor (WAF) derived from this test run. ';

COMMENT ON COLUMN camdecmps.flow_rata_run.calc_calc_waf
    IS 'Calculated wall effects adjustment factor (WAF) derived from this test run. ';

COMMENT ON COLUMN camdecmps.flow_rata_run.avg_stack_flow_rate
    IS 'Average stack flow rate, wet basis, adjusted if applicable for wall effects. ';

COMMENT ON COLUMN camdecmps.flow_rata_run.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.flow_rata_run.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.flow_rata_run.add_date
    IS 'Date and time in which record was added. ';

-- Index: flow_rata_run_idx001

-- DROP INDEX camdecmps.flow_rata_run_idx001;

CREATE INDEX flow_rata_run_idx001
    ON camdecmps.flow_rata_run USING btree
    (rata_run_id COLLATE pg_catalog."default" ASC NULLS LAST);
