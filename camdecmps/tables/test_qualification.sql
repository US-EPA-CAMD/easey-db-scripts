CREATE TABLE IF NOT EXISTS camdecmps.test_qualification
(
    test_qualification_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_claim_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    hi_load_pct numeric(5,1),
    mid_load_pct numeric(5,1),
    low_load_pct numeric(5,1),
    begin_date date,
    end_date date,
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
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
