-- ------------ Write CREATE-TABLE-stage scripts -----------

CREATE TABLE IF NOT EXISTS camdecmps.air_emission_testing(
    air_emission_test_id CHARACTER VARYING(45) NOT NULL,
    test_sum_id CHARACTER VARYING(45) NOT NULL,
    qi_last_name CHARACTER VARYING(25) NOT NULL,
    qi_first_name CHARACTER VARYING(25) NOT NULL,
    qi_middle_initial CHARACTER VARYING(1),
    aetb_name CHARACTER VARYING(50),
    aetb_phone_number CHARACTER VARYING(18),
    aetb_email CHARACTER VARYING(70),
    exam_date TIMESTAMP WITHOUT TIME ZONE,
    provider_name CHARACTER VARYING(50),
    provider_email CHARACTER VARYING(70),
    add_date TIMESTAMP WITHOUT TIME ZONE,
    update_date TIMESTAMP WITHOUT TIME ZONE,
    userid CHARACTER VARYING(8)
)
        WITH (
        OIDS=FALSE
        );
COMMENT ON TABLE camdecmps.air_emission_testing
     IS ' Qualification data for stack testers who perform RATAs, Appendix E, and LME Unit Default Tests.';
COMMENT ON COLUMN camdecmps.air_emission_testing.air_emission_test_id
     IS 'Unique identifier of a AET record.';
COMMENT ON COLUMN camdecmps.air_emission_testing.test_sum_id
     IS 'Unique identifier of the parent Test Summary record';
COMMENT ON COLUMN camdecmps.air_emission_testing.qi_last_name
     IS 'Last name of the Qualified Individual tester';
COMMENT ON COLUMN camdecmps.air_emission_testing.qi_first_name
     IS 'The first name of the Qualified Individual tester';
COMMENT ON COLUMN camdecmps.air_emission_testing.qi_middle_initial
     IS 'Middle Initial if the Qualified Individual tester';
COMMENT ON COLUMN camdecmps.air_emission_testing.aetb_name
     IS 'Name of Air Emission Testing Body';
COMMENT ON COLUMN camdecmps.air_emission_testing.aetb_phone_number
     IS 'Phone number for the Air Emission Testing Body';
COMMENT ON COLUMN camdecmps.air_emission_testing.aetb_email
     IS 'Email address for Air Emission Testing Body.';
COMMENT ON COLUMN camdecmps.air_emission_testing.exam_date
     IS 'Date of Exam taken by stack tester applicable the test method';
COMMENT ON COLUMN camdecmps.air_emission_testing.provider_name
     IS 'Name of the Exam Provider.';
COMMENT ON COLUMN camdecmps.air_emission_testing.provider_email
     IS 'Email address of the Exam Provider.';
COMMENT ON COLUMN camdecmps.air_emission_testing.add_date
     IS 'Date the record was created.';
COMMENT ON COLUMN camdecmps.air_emission_testing.update_date
     IS 'Date record was updated.';
COMMENT ON COLUMN camdecmps.air_emission_testing.userid
     IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';



-- ------------ Write CREATE-INDEX-stage scripts -----------

CREATE INDEX idx_aet_testsumid
ON camdecmps.air_emission_testing
USING BTREE (test_sum_id ASC);



-- ------------ Write CREATE-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.air_emission_testing
ADD CONSTRAINT pk_air_emission_testing PRIMARY KEY (air_emission_test_id);



-- ------------ Write CREATE-FOREIGN-KEY-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.air_emission_testing
ADD CONSTRAINT fk_test_summary_aet FOREIGN KEY (test_sum_id) 
REFERENCES camdecmps.test_summary (test_sum_id)
ON DELETE NO ACTION;
