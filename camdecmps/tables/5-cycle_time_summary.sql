-- ------------ Write CREATE-TABLE-stage scripts -----------

CREATE TABLE IF NOT EXISTS camdecmps.cycle_time_summary(
    cycle_time_sum_id CHARACTER VARYING(45) NOT NULL,
    test_sum_id CHARACTER VARYING(45) NOT NULL,
    total_time NUMERIC(2,0),
    calc_total_time NUMERIC(2,0),
    userid CHARACTER VARYING(8),
    add_date TIMESTAMP WITHOUT TIME ZONE,
    update_date TIMESTAMP WITHOUT TIME ZONE
)
        WITH (
        OIDS=FALSE
        );
COMMENT ON TABLE camdecmps.cycle_time_summary
     IS 'Cycle time test summary data.  Record Type 621.';
COMMENT ON COLUMN camdecmps.cycle_time_summary.cycle_time_sum_id
     IS 'Unique identifier of cycle time summary record. ';
COMMENT ON COLUMN camdecmps.cycle_time_summary.test_sum_id
     IS 'Unique identifier of a test summary record. ';
COMMENT ON COLUMN camdecmps.cycle_time_summary.total_time
     IS 'Reported time. ';
COMMENT ON COLUMN camdecmps.cycle_time_summary.calc_total_time
     IS 'Reported time. ';
COMMENT ON COLUMN camdecmps.cycle_time_summary.userid
     IS 'User account or source of data that added or updated record. ';
COMMENT ON COLUMN camdecmps.cycle_time_summary.add_date
     IS 'Date and time in which record was added. ';
COMMENT ON COLUMN camdecmps.cycle_time_summary.update_date
     IS 'Date and time in which record was last updated. ';



-- ------------ Write CREATE-INDEX-stage scripts -----------

CREATE INDEX idx_cycle_time_summary_001
ON camdecmps.cycle_time_summary
USING BTREE (test_sum_id ASC);



-- ------------ Write CREATE-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.cycle_time_summary
ADD CONSTRAINT pk_cycle_time_summary PRIMARY KEY (cycle_time_sum_id);



-- ------------ Write CREATE-FOREIGN-KEY-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.cycle_time_summary
ADD CONSTRAINT fk_test_summary_cycle_time_su FOREIGN KEY (test_sum_id) 
REFERENCES camdecmps.test_summary (test_sum_id)
ON DELETE NO ACTION;
