CREATE TABLE IF NOT EXISTS camdecmps.air_emission_testing
(
    air_emission_test_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    qi_last_name character varying(25) COLLATE pg_catalog."default" NOT NULL,
    qi_first_name character varying(25) COLLATE pg_catalog."default" NOT NULL,
    qi_middle_initial character varying(1) COLLATE pg_catalog."default",
    aetb_name character varying(50) COLLATE pg_catalog."default",
    aetb_phone_number character varying(18) COLLATE pg_catalog."default",
    aetb_email character varying(70) COLLATE pg_catalog."default",
    exam_date date,
    provider_name character varying(50) COLLATE pg_catalog."default",
    provider_email character varying(70) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    userid character varying(160) COLLATE pg_catalog."default"
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
