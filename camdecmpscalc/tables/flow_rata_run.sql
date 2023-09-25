CREATE TABLE IF NOT EXISTS camdecmpscalc.flow_rata_run
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
	  flow_rata_run_id character varying(45) NOT NULL,
    calc_dry_molecular_weight numeric(5,2),
    calc_wet_molecular_weight numeric(5,2),
    calc_avg_vel_wo_wall numeric(6,2),
    calc_avg_vel_w_wall numeric(6,2),
    calc_waf numeric(6,4),
    calc_calc_waf numeric(6,4)
);
