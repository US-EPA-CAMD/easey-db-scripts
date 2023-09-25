CREATE TABLE IF NOT EXISTS camdecmpscalc.hrly_gas_flow_meter
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    hrly_gas_flow_meter_id character varying(45) NOT NULL,
    calc_flow_to_sampling_ratio numeric(4,1),
    calc_flow_to_sampling_mult numeric(10,0)
);
