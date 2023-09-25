CREATE TABLE IF NOT EXISTS camdecmpscalc.on_off_cal
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    on_off_cal_id character varying(45) NOT NULL,
    calc_online_zero_aps_ind numeric(38,0),
    calc_online_zero_cal_error numeric(6,2),
    calc_online_upscale_aps_ind numeric(38,0),
    calc_online_upscale_cal_error numeric(6,2),
    calc_offline_zero_aps_ind numeric(38,0),
    calc_offline_zero_cal_error numeric(6,2),
    calc_offline_upscale_aps_ind numeric(38,0),
    calc_offline_upscale_cal_error numeric(6,2)
);
