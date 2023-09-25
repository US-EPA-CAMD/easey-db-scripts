CREATE TABLE IF NOT EXISTS camdecmpscalc.mats_monitor_hrly_value
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    mats_mhv_id character varying(45) NOT NULL,
    calc_unadjusted_hrly_value character varying(30),
    calc_daily_cal_status character varying(75),
    calc_hg_line_status character varying(75),
    calc_hgi1_status character varying(75),
    calc_rata_status character varying(75)
);
