CREATE TABLE IF NOT EXISTS camdecmps.rata_summary
(
    rata_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rata_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    relative_accuracy numeric(5,2),
    calc_relative_accuracy numeric(5,2),
    bias_adj_factor numeric(5,3),
    calc_bias_adj_factor numeric(5,3),
    mean_cem_value numeric(15,5),
    calc_mean_cem_value numeric(15,5),
    mean_rata_ref_value numeric(15,5),
    calc_mean_rata_ref_value numeric(15,5),
    op_level_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    mean_diff numeric(15,5),
    calc_mean_diff numeric(15,5),
    default_waf numeric(6,4),
    avg_gross_unit_load numeric(6,0),
    calc_avg_gross_unit_load numeric(6,0),
    aps_ind numeric(38,0),
    calc_aps_ind numeric(38,0),
    stnd_dev_diff numeric(15,5),
    calc_stnd_dev_diff numeric(15,5),
    confidence_coef numeric(15,5),
    calc_confidence_coef numeric(15,5),
    co2_o2_ref_method_cd character varying(7) COLLATE pg_catalog."default",
    ref_method_cd character varying(7) COLLATE pg_catalog."default",
    t_value numeric(6,3),
    calc_t_value numeric(6,3),
    stack_diameter numeric(5,2),
    stack_area numeric(6,1),
    calc_stack_area numeric(6,1),
    calc_waf numeric(6,4),
    calc_calc_waf numeric(6,4),
    num_traverse_point numeric(2,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    aps_cd character varying(7) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmps.rata_summary
    IS 'Relative Accuracy Test Audit (RATA) and bias test data summary.  Record Type 611 and 616.';

COMMENT ON COLUMN camdecmps.rata_summary.rata_sum_id
    IS 'Unique identifier of a RATA summary record. ';

COMMENT ON COLUMN camdecmps.rata_summary.rata_id
    IS 'Unique identifier of a RATA record. ';

COMMENT ON COLUMN camdecmps.rata_summary.relative_accuracy
    IS 'Reported relative accuracy. ';

COMMENT ON COLUMN camdecmps.rata_summary.calc_relative_accuracy
    IS 'Reported relative accuracy. ';

COMMENT ON COLUMN camdecmps.rata_summary.bias_adj_factor
    IS 'Reported bias adjustment factor of load level. ';

COMMENT ON COLUMN camdecmps.rata_summary.calc_bias_adj_factor
    IS 'Reported bias adjustment factor of load level. ';

COMMENT ON COLUMN camdecmps.rata_summary.mean_cem_value
    IS 'Arithmetic mean of CEMS values. ';

COMMENT ON COLUMN camdecmps.rata_summary.calc_mean_cem_value
    IS 'Arithmetic mean of CEMS values. ';

COMMENT ON COLUMN camdecmps.rata_summary.mean_rata_ref_value
    IS 'Arithmetic mean of reference method values. ';

COMMENT ON COLUMN camdecmps.rata_summary.calc_mean_rata_ref_value
    IS 'Arithmetic mean of reference method values. ';

COMMENT ON COLUMN camdecmps.rata_summary.op_level_cd
    IS 'Code used to identify the operating level. ';

COMMENT ON COLUMN camdecmps.rata_summary.mean_diff
    IS 'Reported mean of the difference data. ';

COMMENT ON COLUMN camdecmps.rata_summary.calc_mean_diff
    IS 'Reported mean of the difference data. ';

COMMENT ON COLUMN camdecmps.rata_summary.default_waf
    IS 'Default wall effects adjustment factor. ';

COMMENT ON COLUMN camdecmps.rata_summary.avg_gross_unit_load
    IS 'Average gross unit load (MWe or steam) or average velocity at operating level. ';

COMMENT ON COLUMN camdecmps.rata_summary.calc_avg_gross_unit_load
    IS 'Average gross unit load (MWe or steam) or average velocity at operating level. ';

COMMENT ON COLUMN camdecmps.rata_summary.aps_ind
    IS 'Used to indicate if the alternative performance specification (APS) is used. ';

COMMENT ON COLUMN camdecmps.rata_summary.calc_aps_ind
    IS 'Used to indicate if the alternative performance specification (APS) is used. ';

COMMENT ON COLUMN camdecmps.rata_summary.stnd_dev_diff
    IS 'Standard deviation of difference data. ';

COMMENT ON COLUMN camdecmps.rata_summary.calc_stnd_dev_diff
    IS 'Standard deviation of difference data. ';

COMMENT ON COLUMN camdecmps.rata_summary.confidence_coef
    IS 'Confidence coefficient. ';

COMMENT ON COLUMN camdecmps.rata_summary.calc_confidence_coef
    IS 'Confidence coefficient. ';

COMMENT ON COLUMN camdecmps.rata_summary.co2_o2_ref_method_cd
    IS 'Code used to identify reference method used for CO2 or O2. ';

COMMENT ON COLUMN camdecmps.rata_summary.ref_method_cd
    IS 'Code used to identify a reference method. ';

COMMENT ON COLUMN camdecmps.rata_summary.t_value
    IS 'Tabulated t-value. ';

COMMENT ON COLUMN camdecmps.rata_summary.calc_t_value
    IS 'Tabulated t-value. ';

COMMENT ON COLUMN camdecmps.rata_summary.stack_diameter
    IS 'Stack diameter at test port location. ';

COMMENT ON COLUMN camdecmps.rata_summary.stack_area
    IS 'Stack or duct cross-sectional area at test port. ';

COMMENT ON COLUMN camdecmps.rata_summary.calc_stack_area
    IS 'Stack or duct cross-sectional area at test port. ';

COMMENT ON COLUMN camdecmps.rata_summary.calc_waf
    IS 'Calculated WAF applied to all runs of this RATA load level. ';

COMMENT ON COLUMN camdecmps.rata_summary.calc_calc_waf
    IS 'Calculated WAF applied to all runs of this RATA load level. ';

COMMENT ON COLUMN camdecmps.rata_summary.num_traverse_point
    IS 'The number of Method 1 traverse points in the test runs ';

COMMENT ON COLUMN camdecmps.rata_summary.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.rata_summary.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.rata_summary.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.rata_summary.aps_cd
    IS 'Code used to identify the Alternate Performance Spec.';
