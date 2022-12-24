-- Table: camdecmpswks.emission_view_co2calc

-- DROP TABLE camdecmpswks.emission_view_co2calc;

CREATE TABLE IF NOT EXISTS camdecmpswks.emission_view_co2calc
(
    em_co2_calc_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id integer NOT NULL,
    date_hour character varying(25) COLLATE pg_catalog."default" NOT NULL,
    op_time numeric(3,2),
    co2c_modc character varying(7) COLLATE pg_catalog."default",
    co2c_pma numeric(4,1),
    rpt_pct_o2 numeric(13,3),
    pct_o2_used numeric(5,1),
    o2_modc character varying(7) COLLATE pg_catalog."default",
    pct_h2o_used numeric(5,1),
    source_h2o_value character varying(7) COLLATE pg_catalog."default",
    fc_factor numeric(8,1),
    fd_factor numeric(8,1),
    formula_cd character varying(7) COLLATE pg_catalog."default",
    rpt_pct_co2 numeric(14,4),
    calc_pct_co2 numeric(14,4),
    error_codes character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_emission_view_co2calc PRIMARY KEY (em_co2_calc_id),
    CONSTRAINT fk_emission_view_co2calc_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_emission_view_co2calc_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmpswks.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);