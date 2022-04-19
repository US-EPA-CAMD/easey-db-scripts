-- ------------ Write CREATE-TABLE-stage scripts -----------

CREATE TABLE IF NOT EXISTS camdecmps.test_qualification(
    test_qualification_id CHARACTER VARYING(45) NOT NULL,
    test_sum_id CHARACTER VARYING(45) NOT NULL,
    test_claim_cd CHARACTER VARYING(7) NOT NULL,
    hi_load_pct NUMERIC(5,1),
    mid_load_pct NUMERIC(5,1),
    low_load_pct NUMERIC(5,1),
    begin_date DATE,
    end_date DATE,
    userid CHARACTER VARYING(8),
    add_date TIMESTAMP WITHOUT TIME ZONE,
    update_date TIMESTAMP WITHOUT TIME ZONE
)
        WITH (
        OIDS=FALSE
        );
COMMENT ON TABLE camdecmps.test_qualification
     IS 'Table supporting qualification to perform flow RATAs at single load.';
COMMENT ON COLUMN camdecmps.test_qualification.test_qualification_id
     IS 'Unique identifier of test qualification record. ';
COMMENT ON COLUMN camdecmps.test_qualification.test_sum_id
     IS 'Unique identifier of a test summary record. ';
COMMENT ON COLUMN camdecmps.test_qualification.test_claim_cd
     IS 'Code used to indicate the type of test claim (i.e., single load, normal load exemption or operating range exemption). ';
COMMENT ON COLUMN camdecmps.test_qualification.hi_load_pct
     IS 'Percentage of the time that the unit operated at high load. ';
COMMENT ON COLUMN camdecmps.test_qualification.mid_load_pct
     IS 'Percentage of the time that the unit operated at mid load. ';
COMMENT ON COLUMN camdecmps.test_qualification.low_load_pct
     IS 'Percentage of the time that the unit operated at low load. ';
COMMENT ON COLUMN camdecmps.test_qualification.begin_date
     IS 'Date in which information became effective or activity started. ';
COMMENT ON COLUMN camdecmps.test_qualification.end_date
     IS 'Last date in which information was effective or date in which activity ended. ';
COMMENT ON COLUMN camdecmps.test_qualification.userid
     IS 'User account or source of data that added or updated record. ';
COMMENT ON COLUMN camdecmps.test_qualification.add_date
     IS 'Date and time in which record was added. ';
COMMENT ON COLUMN camdecmps.test_qualification.update_date
     IS 'Date and time in which record was last updated. ';



-- ------------ Write CREATE-INDEX-stage scripts -----------

CREATE INDEX idx_test_qualificat_test_claim
ON camdecmps.test_qualification
USING BTREE (test_claim_cd ASC);



CREATE INDEX idx_test_qualification_001
ON camdecmps.test_qualification
USING BTREE (test_sum_id ASC);



-- ------------ Write CREATE-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.test_qualification
ADD CONSTRAINT pk_test_qualification PRIMARY KEY (test_qualification_id);



-- ------------ Write CREATE-FOREIGN-KEY-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.test_qualification
ADD CONSTRAINT fk_test_claim_co_test_qualific FOREIGN KEY (test_claim_cd) 
REFERENCES camdecmpsmd.test_claim_code (test_claim_cd)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.test_qualification
ADD CONSTRAINT fk_test_summary_test_qualific FOREIGN KEY (test_sum_id) 
REFERENCES camdecmps.test_summary (test_sum_id)
ON DELETE NO ACTION;
