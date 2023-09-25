CREATE TABLE IF NOT EXISTS camdecmpscalc.monitor_hrly_value
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    monitor_hrly_val_id character varying(45) NOT NULL,
    calc_adjusted_hrly_value numeric(13,3),
    applicable_bias_adj_factor numeric(5,3),
    calc_line_status character varying(75),
    calc_rata_status character varying(75),
    calc_daycal_status character varying(75),
    calc_leak_status character varying(75),
    calc_dayint_status character varying(75),
    calc_f2l_status character varying(75)
);
