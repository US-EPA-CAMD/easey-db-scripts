CREATE TABLE IF NOT EXISTS camdecmpscalc.rata_summary
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
	  rata_sum_id character varying(45) NOT NULL,
    calc_relative_accuracy numeric(5,2),
    calc_bias_adj_factor numeric(5,3),
    calc_mean_cem_value numeric(15,5),
    calc_mean_rata_ref_value numeric(15,5),
    calc_mean_diff numeric(15,5),
    calc_avg_gross_unit_load numeric(6,0),
    calc_aps_ind numeric(38,0),
    calc_stnd_dev_diff numeric(15,5),
    calc_confidence_coef numeric(15,5),
    calc_t_value numeric(6,3),
    calc_stack_area numeric(6,1),
    calc_waf numeric(6,4),
    calc_calc_waf numeric(6,4)
);
