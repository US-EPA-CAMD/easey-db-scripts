CREATE TABLE IF NOT EXISTS camdecmpswks.emission_view_massoilcalc(
    em_mass_oil_calc_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
    mon_plan_id VARCHAR(45) NOT NULL,
    mon_loc_id VARCHAR(45) NOT NULL,
    rpt_period_id INTEGER NOT NULL,
    date_hour character varying(25) COLLATE pg_catalog."default" NOT NULL,
    op_time NUMERIC(3,2),
    fuel_sys_id VARCHAR(3),
    oil_type VARCHAR(7) NOT NULL,
    fuel_use_time NUMERIC(3,2),
    rpt_volumetric_oil_flow NUMERIC(10,1),
    calc_volumetric_oil_flow NUMERIC(10,1),
    volumetric_oil_flow_uom VARCHAR(7),
    volumetric_oil_flow_sodc VARCHAR(7),
    oil_density NUMERIC(13,5),
    oil_density_uom VARCHAR(7),
    oil_density_sampling_type VARCHAR(7),
    rpt_mass_oil_flow NUMERIC(10,1),
    calc_mass_oil_flow NUMERIC(10,1),
    error_codes VARCHAR(1000)
)