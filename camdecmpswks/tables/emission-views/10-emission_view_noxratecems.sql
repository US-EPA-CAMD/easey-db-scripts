-- Table: camdecmpswks.emission_view_noxratecems

-- DROP TABLE camdecmpswks.emission_view_noxratecems;

CREATE TABLE camdecmpswks.emission_view_noxratecems
(
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id integer NOT NULL,
    date_hour character varying(25) COLLATE pg_catalog."default" NOT NULL,
    op_time numeric(3,2),
    unit_load numeric(6,0),
    load_uom character varying(7) COLLATE pg_catalog."default",
    nox_rate_modc character varying(7) COLLATE pg_catalog."default",
    nox_rate_pma numeric(4,1),
    unadj_nox numeric(13,3),
    nox_modc character varying(7) COLLATE pg_catalog."default",
    diluent_param character varying(3) COLLATE pg_catalog."default",
    pct_diluent_used numeric(5,1),
    diluent_modc character varying(7) COLLATE pg_catalog."default",
    pct_h2o_used numeric(5,1),
    source_h2o_value character varying(7) COLLATE pg_catalog."default",
    f_factor numeric(8,1),
    nox_rate_formula_cd character varying(7) COLLATE pg_catalog."default",
    rpt_unadj_nox_rate numeric(13,3),
    calc_unadj_nox_rate numeric(13,3),
    calc_nox_baf numeric(5,3),
    rpt_adj_nox_rate numeric(14,4),
    calc_adj_nox_rate numeric(14,4),
    calc_hi_rate numeric(14,4),
    nox_mass_formula_cd character varying(7) COLLATE pg_catalog."default",
    rpt_nox_mass numeric(14,4),
    calc_nox_mass numeric(14,4),
    error_codes character varying(1000) COLLATE pg_catalog."default",
    rpt_diluent numeric(13,3),
    CONSTRAINT pk_emission_view_noxratecems PRIMARY KEY (mon_plan_id, mon_loc_id, rpt_period_id, date_hour),
    CONSTRAINT fk_emission_view_noxratecems_emission_evaluation FOREIGN KEY (rpt_period_id, mon_plan_id)
        REFERENCES camdecmpswks.emission_evaluation (rpt_period_id, mon_plan_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_emission_view_noxratecems_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_emission_view_noxratecems_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmpswks.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_emission_view_noxratecems_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);