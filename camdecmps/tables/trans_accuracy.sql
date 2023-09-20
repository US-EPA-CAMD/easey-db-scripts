CREATE TABLE IF NOT EXISTS camdecmps.trans_accuracy
(
    trans_ac_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    low_level_accuracy numeric(5,1),
    mid_level_accuracy numeric(5,1),
    high_level_accuracy numeric(5,1),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    low_level_accuracy_spec_cd character varying(7) COLLATE pg_catalog."default",
    mid_level_accuracy_spec_cd character varying(7) COLLATE pg_catalog."default",
    high_level_accuracy_spec_cd character varying(7) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmps.trans_accuracy
    IS 'Transmitter and transducer accuracy tests.  Record Type 628.';

COMMENT ON COLUMN camdecmps.trans_accuracy.trans_ac_id
    IS 'Unique identifier of transmitter transducer accuracy record. ';

COMMENT ON COLUMN camdecmps.trans_accuracy.test_sum_id
    IS 'Unique identifier of a test summary record. ';

COMMENT ON COLUMN camdecmps.trans_accuracy.low_level_accuracy
    IS 'Accuracy determination at low level. ';

COMMENT ON COLUMN camdecmps.trans_accuracy.mid_level_accuracy
    IS 'Highest accuracy determination methodology for mid level. ';

COMMENT ON COLUMN camdecmps.trans_accuracy.high_level_accuracy
    IS 'Accuracy determination at high level. ';

COMMENT ON COLUMN camdecmps.trans_accuracy.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.trans_accuracy.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.trans_accuracy.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.trans_accuracy.low_level_accuracy_spec_cd
    IS 'Code used to determine the accuracy determination methodology for low level. ';

COMMENT ON COLUMN camdecmps.trans_accuracy.mid_level_accuracy_spec_cd
    IS 'Code used to identify the accuracy determination methodology for mid level. ';

COMMENT ON COLUMN camdecmps.trans_accuracy.high_level_accuracy_spec_cd
    IS 'Code used to identify the accuracy determination methodology for high level. ';
