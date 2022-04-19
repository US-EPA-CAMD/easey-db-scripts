-- ------------ Write CREATE-TABLE-stage scripts -----------

CREATE TABLE IF NOT EXISTS camdecmps.hg_test_injection(
    hg_test_inj_id CHARACTER VARYING(45) NOT NULL,
    hg_test_sum_id CHARACTER VARYING(45) NOT NULL,
    injection_date DATE NOT NULL,
    injection_hour NUMERIC(2,0),
    injection_min NUMERIC(2,0),
    measured_value NUMERIC(13,3),
    ref_value NUMERIC(13,3),
    userid CHARACTER VARYING(8),
    add_date TIMESTAMP WITHOUT TIME ZONE,
    update_date TIMESTAMP WITHOUT TIME ZONE
)
        WITH (
        OIDS=FALSE
        );
COMMENT ON TABLE camdecmps.hg_test_injection
     IS 'HG Linearity or HGSI3 check data and results for one injection.  Record Type 601.';
COMMENT ON COLUMN camdecmps.hg_test_injection.hg_test_inj_id
     IS 'Unique identifier of a HG Linearity or HGSI3 injection record. ';
COMMENT ON COLUMN camdecmps.hg_test_injection.hg_test_sum_id
     IS 'Unique identifier of a HG Linearity or HGSI3 summary record. ';
COMMENT ON COLUMN camdecmps.hg_test_injection.injection_date
     IS 'Date on which injection occurred. ';
COMMENT ON COLUMN camdecmps.hg_test_injection.injection_hour
     IS 'Hour in which injection occurred. ';
COMMENT ON COLUMN camdecmps.hg_test_injection.injection_min
     IS 'Minute in which injection occurred. ';
COMMENT ON COLUMN camdecmps.hg_test_injection.measured_value
     IS 'Measured value. ';
COMMENT ON COLUMN camdecmps.hg_test_injection.ref_value
     IS 'Reference value. ';
COMMENT ON COLUMN camdecmps.hg_test_injection.userid
     IS 'User account or source of data that added or updated record. ';
COMMENT ON COLUMN camdecmps.hg_test_injection.add_date
     IS 'Date and time in which record was added. ';
COMMENT ON COLUMN camdecmps.hg_test_injection.update_date
     IS 'Date and time in which record was last updated. ';



-- ------------ Write CREATE-INDEX-stage scripts -----------

CREATE INDEX hg_test_injection_idx001
ON camdecmps.hg_test_injection
USING BTREE (hg_test_sum_id ASC);



-- ------------ Write CREATE-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.hg_test_injection
ADD CONSTRAINT pk_hg_test_injection PRIMARY KEY (hg_test_inj_id);



-- ------------ Write CREATE-FOREIGN-KEY-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.hg_test_injection
ADD CONSTRAINT fk_hg_test_inj_hg_test_sum_id FOREIGN KEY (hg_test_sum_id) 
REFERENCES camdecmps.hg_test_summary (hg_test_sum_id)
ON DELETE NO ACTION;
