CREATE TABLE IF NOT EXISTS camdecmpscalc.calibration_injection
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
	  cal_inj_id character varying(45) NOT NULL,
    calc_zero_cal_error numeric(6,2),
    calc_zero_aps_ind numeric(38,0),
    calc_upscale_cal_error numeric(6,2),
    calc_upscale_aps_ind numeric(38,0)
);
