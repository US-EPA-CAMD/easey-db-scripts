CREATE TABLE IF NOT EXISTS camdecmpscalc.flow_to_load_reference
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    flow_load_ref_id character varying(45) NOT NULL,
    calc_avg_ref_method_flow numeric(10,0),
    calc_avg_gross_unit_load numeric(6,0),
    calc_ref_flow_load_ratio numeric(6,2),
    calc_ref_ghr numeric(6,0),
    calc_sep_ref_ind numeric(38,0)
);
