CREATE TABLE IF NOT EXISTS camdecmpscalc.linearity_summary
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
	  lin_sum_id character varying(45) NOT NULL,
    calc_mean_ref_value numeric(13,3),
    calc_mean_measured_value numeric(13,3),
    calc_percent_error numeric(5,1),
    calc_aps_ind numeric(38,0)
);
