CREATE TABLE IF NOT EXISTS camdecmpscalc.derived_hrly_value
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    derv_id character varying(45) NOT NULL,
    calc_unadjusted_hrly_value numeric(13,3),
    calc_adjusted_hrly_value numeric(14,4),
    applicable_bias_adj_factor numeric(5,3),
    calc_pct_diluent numeric(5,1),
    calc_pct_moisture numeric(5,1),
    calc_rata_status character varying(75),
    calc_appe_status character varying(75),
    calc_fuel_flow_total numeric(15,4),
    calc_hour_measure_cd character varying(7)
);
