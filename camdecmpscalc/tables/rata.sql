CREATE TABLE IF NOT EXISTS camdecmpscalc.rata
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
	  rata_id character varying(45) NOT NULL,
    calc_rata_frequency_cd character varying(7),
    calc_relative_accuracy numeric(5,2),
    calc_overall_bias_adj_factor numeric(5,3),
    calc_num_load_level numeric(1,0)
);
