-- Table: camdecmps.derived_hrly_value

-- DROP TABLE IF EXISTS camdecmps.derived_hrly_value;

CREATE TABLE IF NOT EXISTS camdecmps.derived_hrly_value
(
    derv_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    hour_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default",
    mon_form_id character varying(45) COLLATE pg_catalog."default",
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    unadjusted_hrly_value numeric(13,3),
    applicable_bias_adj_factor numeric(5,3),
    calc_unadjusted_hrly_value numeric(13,3),
    adjusted_hrly_value numeric(14,4),
    calc_adjusted_hrly_value numeric(14,4),
    modc_cd character varying(7) COLLATE pg_catalog."default",
    operating_condition_cd character varying(7) COLLATE pg_catalog."default",
    pct_available numeric(4,1),
    diluent_cap_ind numeric(38,0),
    segment_num numeric(38,0),
    fuel_cd character varying(7) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    calc_pct_diluent character varying(10) COLLATE pg_catalog."default",
    calc_pct_moisture character varying(10) COLLATE pg_catalog."default",
    calc_rata_status character varying(75) COLLATE pg_catalog."default",
    calc_appe_status character varying(75) COLLATE pg_catalog."default",
    rpt_period_id numeric(38,0) NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    calc_fuel_flow_total numeric(15,4),
    calc_hour_measure_cd character varying(7) COLLATE pg_catalog."default",
    CONSTRAINT pk_derived_hrly_value PRIMARY KEY (derv_id),
    CONSTRAINT derived_hrly_value_r01 FOREIGN KEY (hour_id)
        REFERENCES camdecmps.hrly_op_data (hour_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_fuel_code_derived_hrly_ FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_modc_code_derived_hrly_ FOREIGN KEY (modc_cd)
        REFERENCES camdecmpsmd.modc_code (modc_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_formu_derived_hrly_ FOREIGN KEY (mon_form_id)
        REFERENCES camdecmps.monitor_formula (mon_form_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_syste_derived_hrly_ FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_operating_con_derived_hrly_ FOREIGN KEY (operating_condition_cd)
        REFERENCES camdecmpsmd.operating_condition_code (operating_condition_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_parameter_cod_derived_hrly_ FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.derived_hrly_value
    IS 'The derived hourly value for a parameter (e.g., SO2 lbs/hr) as calculated from measured values and reported by the source.  Record Types 300, 310, 320, 328, 330.';

COMMENT ON COLUMN camdecmps.derived_hrly_value.derv_id
    IS 'Unique identifier of a derived hourly value record. ';

COMMENT ON COLUMN camdecmps.derived_hrly_value.hour_id
    IS 'Unique identifier of an hourly operating data record. ';

COMMENT ON COLUMN camdecmps.derived_hrly_value.mon_sys_id
    IS 'Unique identifier of a monitoring system record. ';

COMMENT ON COLUMN camdecmps.derived_hrly_value.mon_form_id
    IS 'Unique identifier of a monitoring formula record. ';

COMMENT ON COLUMN camdecmps.derived_hrly_value.parameter_cd
    IS 'Code used to identify the parameter. ';

COMMENT ON COLUMN camdecmps.derived_hrly_value.unadjusted_hrly_value
    IS 'Unadjusted value calculated from measured values for the hour. ';

COMMENT ON COLUMN camdecmps.derived_hrly_value.applicable_bias_adj_factor
    IS 'BAF determined from most recent prior RATA (as calculated by ECMPS Client Tool). ';

COMMENT ON COLUMN camdecmps.derived_hrly_value.calc_unadjusted_hrly_value
    IS 'Unadjusted value calculated from measured values for the hour. ';

COMMENT ON COLUMN camdecmps.derived_hrly_value.adjusted_hrly_value
    IS 'Adjusted parameter value for the hour, as calculated from measured values and then adjusted for bias, or the substitute value for missing data hours. ';

COMMENT ON COLUMN camdecmps.derived_hrly_value.calc_adjusted_hrly_value
    IS 'Adjusted parameter value for the hour, as calculated from measured values and then adjusted for bias, or the substitute value for missing data hours. ';

COMMENT ON COLUMN camdecmps.derived_hrly_value.modc_cd
    IS 'Code used to identify the method of determination. ';

COMMENT ON COLUMN camdecmps.derived_hrly_value.operating_condition_cd
    IS 'Code used to identify the operating condition. ';

COMMENT ON COLUMN camdecmps.derived_hrly_value.pct_available
    IS 'Percent monitor data availability. ';

COMMENT ON COLUMN camdecmps.derived_hrly_value.diluent_cap_ind
    IS 'Indicates whether the diluent cap was used for the calculation for this hour. ';

COMMENT ON COLUMN camdecmps.derived_hrly_value.segment_num
    IS 'Segment number of correlation curve.  Rather than a user-assigned identifier, this is just an integer that indicates the segment number (assuming the first segment is number 1). ';

COMMENT ON COLUMN camdecmps.derived_hrly_value.fuel_cd
    IS 'Code used to identify the type of fuel. ';

COMMENT ON COLUMN camdecmps.derived_hrly_value.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.derived_hrly_value.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.derived_hrly_value.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.derived_hrly_value.calc_pct_diluent
    IS 'The percent CO2 or O2 used in the calculation of NOx emission rate.  (It may be the reported value, the diluent cap, or the recalculated CO2 concentration from an O2 monitor).';

COMMENT ON COLUMN camdecmps.derived_hrly_value.calc_pct_moisture
    IS 'The percent H2O used in various calculations.  (It may be the reported value, a moisture default, the recalculated H2O from an O2 wet and dry monitor.)';

COMMENT ON COLUMN camdecmps.derived_hrly_value.calc_rata_status
    IS 'QA Status for RATA Check determined by EPA. ';

COMMENT ON COLUMN camdecmps.derived_hrly_value.calc_appe_status
    IS 'QA Status for Appendix E Check determined by EPA. ';

COMMENT ON COLUMN camdecmps.derived_hrly_value.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmps.derived_hrly_value.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.derived_hrly_value.calc_fuel_flow_total
    IS 'Calculated fuel flow total.';

COMMENT ON COLUMN camdecmps.derived_hrly_value.calc_hour_measure_cd
    IS 'Code used to identify the how the calculated hour value was determined.';
-- Index: derived_hrly_value_idx001

-- DROP INDEX IF EXISTS camdecmps.derived_hrly_value_idx001;

CREATE INDEX IF NOT EXISTS derived_hrly_value_idx001
    ON camdecmps.derived_hrly_value USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_derived_hrly_frm

-- DROP INDEX IF EXISTS camdecmps.idx_derived_hrly_frm;

CREATE INDEX IF NOT EXISTS idx_derived_hrly_frm
    ON camdecmps.derived_hrly_value USING btree
    (modc_cd COLLATE pg_catalog."default" ASC NULLS LAST, unadjusted_hrly_value ASC NULLS LAST, parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST, hour_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_derived_hrly_va_fuel_cd

-- DROP INDEX IF EXISTS camdecmps.idx_derived_hrly_va_fuel_cd;

CREATE INDEX IF NOT EXISTS idx_derived_hrly_va_fuel_cd
    ON camdecmps.derived_hrly_value USING btree
    (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_derived_hrly_va_hour_id

-- DROP INDEX IF EXISTS camdecmps.idx_derived_hrly_va_hour_id;

CREATE INDEX IF NOT EXISTS idx_derived_hrly_va_hour_id
    ON camdecmps.derived_hrly_value USING btree
    (hour_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_derived_hrly_va_mon_form_i

-- DROP INDEX IF EXISTS camdecmps.idx_derived_hrly_va_mon_form_i;

CREATE INDEX IF NOT EXISTS idx_derived_hrly_va_mon_form_i
    ON camdecmps.derived_hrly_value USING btree
    (mon_form_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_derived_hrly_va_mon_sys_id

-- DROP INDEX IF EXISTS camdecmps.idx_derived_hrly_va_mon_sys_id;

CREATE INDEX IF NOT EXISTS idx_derived_hrly_va_mon_sys_id
    ON camdecmps.derived_hrly_value USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_derived_hrly_va_operating

-- DROP INDEX IF EXISTS camdecmps.idx_derived_hrly_va_operating;

CREATE INDEX IF NOT EXISTS idx_derived_hrly_va_operating
    ON camdecmps.derived_hrly_value USING btree
    (operating_condition_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_derived_hrly_va_parameter_

-- DROP INDEX IF EXISTS camdecmps.idx_derived_hrly_va_parameter_;

CREATE INDEX IF NOT EXISTS idx_derived_hrly_va_parameter_
    ON camdecmps.derived_hrly_value USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_dhv_add_date

-- DROP INDEX IF EXISTS camdecmps.idx_dhv_add_date;

CREATE INDEX IF NOT EXISTS idx_dhv_add_date
    ON camdecmps.derived_hrly_value USING btree
    (add_date ASC NULLS LAST)
    TABLESPACE pg_default;