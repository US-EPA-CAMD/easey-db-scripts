-- ------------ Write CREATE-TABLE-stage scripts -----------

CREATE TABLE IF NOT EXISTS camdecmps.cycle_time_injection(
    cycle_time_inj_id CHARACTER VARYING(45) NOT NULL,
    cycle_time_sum_id CHARACTER VARYING(45) NOT NULL,
    begin_monitor_value NUMERIC(13,3),
    end_monitor_value NUMERIC(13,3),
    begin_date DATE,
    begin_hour NUMERIC(2,0),
    begin_min NUMERIC(2,0),
    end_date DATE,
    end_hour NUMERIC(2,0),
    end_min NUMERIC(2,0),
    gas_level_cd CHARACTER VARYING(7) NOT NULL,
    cal_gas_value NUMERIC(13,3),
    userid CHARACTER VARYING(8),
    add_date TIMESTAMP WITHOUT TIME ZONE,
    update_date TIMESTAMP WITHOUT TIME ZONE,
    injection_cycle_time NUMERIC(2,0),
    calc_injection_cycle_time NUMERIC(2,0)
)
        WITH (
        OIDS=FALSE
        );
COMMENT ON TABLE camdecmps.cycle_time_injection
     IS 'Cycle time test data and results.  Record Type 621.';
COMMENT ON COLUMN camdecmps.cycle_time_injection.cycle_time_inj_id
     IS 'Unique identifier of a cycle time injection record. ';
COMMENT ON COLUMN camdecmps.cycle_time_injection.cycle_time_sum_id
     IS 'Unique identifier of a cycle time summary record. ';
COMMENT ON COLUMN camdecmps.cycle_time_injection.begin_monitor_value
     IS 'Stable analyzer response at the start of the cycle time test. ';
COMMENT ON COLUMN camdecmps.cycle_time_injection.end_monitor_value
     IS 'Stable analyzer response at the end of the cycle time test. ';
COMMENT ON COLUMN camdecmps.cycle_time_injection.begin_date
     IS 'Date of the cycle time injection. ';
COMMENT ON COLUMN camdecmps.cycle_time_injection.begin_hour
     IS 'Hour in which information became effective or activity started. ';
COMMENT ON COLUMN camdecmps.cycle_time_injection.begin_min
     IS 'Minute in which the cycle time injection began. ';
COMMENT ON COLUMN camdecmps.cycle_time_injection.end_date
     IS 'Last date in which information was effective or date in which activity ended. ';
COMMENT ON COLUMN camdecmps.cycle_time_injection.end_hour
     IS 'Last hour in which information was effective or hour in which activity ended. ';
COMMENT ON COLUMN camdecmps.cycle_time_injection.end_min
     IS 'Last minute in which information was effective or minute in which activity ended. ';
COMMENT ON COLUMN camdecmps.cycle_time_injection.gas_level_cd
     IS 'Code used to identify calibration gas level. ';
COMMENT ON COLUMN camdecmps.cycle_time_injection.cal_gas_value
     IS 'Calibration gas value. ';
COMMENT ON COLUMN camdecmps.cycle_time_injection.userid
     IS 'User account or source of data that added or updated record. ';
COMMENT ON COLUMN camdecmps.cycle_time_injection.add_date
     IS 'Date and time in which record was added. ';
COMMENT ON COLUMN camdecmps.cycle_time_injection.update_date
     IS 'Date and time in which record was last updated. ';
COMMENT ON COLUMN camdecmps.cycle_time_injection.injection_cycle_time
     IS 'Component cycle time. ';
COMMENT ON COLUMN camdecmps.cycle_time_injection.calc_injection_cycle_time
     IS 'Component cycle time. ';



-- ------------ Write CREATE-INDEX-stage scripts -----------

CREATE INDEX cycle_time_injection_idx001
ON camdecmps.cycle_time_injection
USING BTREE (cycle_time_sum_id ASC);



CREATE INDEX idx_cycle_time_inje_gas_level
ON camdecmps.cycle_time_injection
USING BTREE (gas_level_cd ASC);



-- ------------ Write CREATE-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.cycle_time_injection
ADD CONSTRAINT pk_cycle_time_injection PRIMARY KEY (cycle_time_inj_id);



-- ------------ Write CREATE-FOREIGN-KEY-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.cycle_time_injection
ADD CONSTRAINT fk_cycle_time_su_cycle_time_in FOREIGN KEY (cycle_time_sum_id) 
REFERENCES camdecmps.cycle_time_summary (cycle_time_sum_id)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.cycle_time_injection
ADD CONSTRAINT fk_gas_level_cod_cycle_time_in FOREIGN KEY (gas_level_cd) 
REFERENCES camdecmpsmd.gas_level_code (gas_level_cd)
ON DELETE NO ACTION;
