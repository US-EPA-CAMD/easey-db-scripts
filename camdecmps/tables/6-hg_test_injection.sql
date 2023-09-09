CREATE TABLE IF NOT EXISTS camdecmps.hg_test_injection
(
    hg_test_inj_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    hg_test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    injection_date date NOT NULL,
    injection_hour numeric(2,0),
    injection_min numeric(2,0),
    measured_value numeric(13,3),
    ref_value numeric(13,3),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_hg_test_injection PRIMARY KEY (hg_test_inj_id),
    CONSTRAINT fk_hg_test_injection_hg_test_summary FOREIGN KEY (hg_test_sum_id)
        REFERENCES camdecmps.hg_test_summary (hg_test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE
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
