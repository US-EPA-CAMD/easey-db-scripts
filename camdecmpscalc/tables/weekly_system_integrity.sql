CREATE TABLE IF NOT EXISTS camdecmpscalc.weekly_system_integrity
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    weekly_sys_integrity_id character varying(45) NOT NULL,
    calc_system_integrity_error numeric(5,1),
    calc_aps_ind numeric(38,0)
);
