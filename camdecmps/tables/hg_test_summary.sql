CREATE TABLE IF NOT EXISTS camdecmps.hg_test_summary
(
    hg_test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    gas_level_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    mean_measured_value numeric(13,3),
    mean_ref_value numeric(13,3),
    percent_error numeric(5,1),
    aps_ind numeric(38,0),
    calc_mean_measured_value numeric(13,3),
    calc_mean_ref_value numeric(13,3),
    calc_percent_error numeric(5,1),
    calc_aps_ind numeric(38,0),
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);

COMMENT ON TABLE camdecmps.hg_test_summary
    IS 'HG Linearity or HGSI3 check data and results summary.  Record Type 602.';

COMMENT ON COLUMN camdecmps.hg_test_summary.hg_test_sum_id
    IS 'Unique identifier of a HG Linearity or HGSI3 summary record. ';

COMMENT ON COLUMN camdecmps.hg_test_summary.test_sum_id
    IS 'Unique identifier of a test summary record. ';

COMMENT ON COLUMN camdecmps.hg_test_summary.gas_level_cd
    IS 'Code used to identify calibration gas level. ';

COMMENT ON COLUMN camdecmps.hg_test_summary.mean_measured_value
    IS 'Reported mean of measured values. ';

COMMENT ON COLUMN camdecmps.hg_test_summary.mean_ref_value
    IS 'Reported mean of referenced values. ';

COMMENT ON COLUMN camdecmps.hg_test_summary.percent_error
    IS 'Reported percentage of error. ';

COMMENT ON COLUMN camdecmps.hg_test_summary.aps_ind
    IS 'Used to indicate if the alternative performance specification (APS) is used. ';

COMMENT ON COLUMN camdecmps.hg_test_summary.calc_mean_measured_value
    IS 'Calculated mean of measured values. ';

COMMENT ON COLUMN camdecmps.hg_test_summary.calc_mean_ref_value
    IS 'Calculated mean of referenced values. ';

COMMENT ON COLUMN camdecmps.hg_test_summary.calc_percent_error
    IS 'Calculated percentage of error. ';

COMMENT ON COLUMN camdecmps.hg_test_summary.calc_aps_ind
    IS 'Used to indicate if the alternative performance specification (APS) is used. ';

COMMENT ON COLUMN camdecmps.hg_test_summary.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.hg_test_summary.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.hg_test_summary.update_date
    IS 'Date and time in which record was last updated. ';
