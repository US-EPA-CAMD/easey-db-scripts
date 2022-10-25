CREATE TABLE IF NOT EXISTS camdecmpswks.EMISSION_VIEW_OTHERDAILY (
    em_other_daily_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
    mon_plan_id VARCHAR(45) NOT NULL,
    mon_loc_id VARCHAR(45) NOT NULL,
    rpt_period_id INTEGER NOT NULL,
    test_type_cd VARCHAR(7),
    system_component_identifier VARCHAR(3),
    system_component_type VARCHAR(7),
    span_scale_cd VARCHAR(7),
    date_hour character varying(25) COLLATE pg_catalog."default" NOT NULL,
    rpt_test_result VARCHAR(7) NOT NULL,
    error_codes VARCHAR(1000),
    calc_test_result_cd VARCHAR(7),
    test_sum_id VARCHAR(45)
);