CREATE TABLE IF NOT EXISTS camdecmpswks.emission_view_mats_weekly(
    em_mats_weekly_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
    mon_plan_id VARCHAR(45) NOT NULL,
    mon_loc_id VARCHAR(45) NOT NULL,
    rpt_period_id INTEGER NOT NULL,
    weekly_test_sum_id VARCHAR(45) NOT NULL,
    system_component_identifier VARCHAR(3),
    system_component_type VARCHAR(1000),
    date_hour varchar(25) NOT NULL,
    test_type VARCHAR(7),
    test_result VARCHAR(7),
    span_scale VARCHAR(7),
    gas_level VARCHAR(7),
    ref_value NUMERIC(13,2),
    measured_value NUMERIC(13,3),
    system_integrity_error NUMERIC(5,1),
    error_codes VARCHAR(1000)
)