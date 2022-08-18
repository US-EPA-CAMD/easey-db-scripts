-- Table: camdecmpswks.mats_derived_hrly_value

-- DROP TABLE IF EXISTS camdecmpswks.mats_derived_hrly_value;

CREATE TABLE IF NOT EXISTS camdecmpswks.mats_derived_hrly_value
(
    mats_dhv_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    hour_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    unadjusted_hrly_value character varying(30) COLLATE pg_catalog."default",
    modc_cd character varying(7) COLLATE pg_catalog."default",
    mon_form_id character varying(45) COLLATE pg_catalog."default",
    calc_unadjusted_hrly_value character varying(30) COLLATE pg_catalog."default",
    calc_pct_diluent numeric(5,1),
    calc_pct_moisture numeric(5,1),
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_matsdhv PRIMARY KEY (mats_dhv_id),
    CONSTRAINT fk_mdhv_hour_id FOREIGN KEY (hour_id)
        REFERENCES camdecmpswks.hrly_op_data (hour_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_mdhv_modc_cd FOREIGN KEY (modc_cd)
        REFERENCES camdecmpsmd.modc_code (modc_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_mdhv_mon_form_id FOREIGN KEY (mon_form_id)
        REFERENCES camdecmpswks.monitor_formula (mon_form_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_mdhv_mon_loc_id FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_mdhv_parameter_cd FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_mdhv_rpt_period_id FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmpswks.mats_derived_hrly_value
    IS 'The derived hourly value for a parameter as calculated from measured values and reported by the source. ';

COMMENT ON COLUMN camdecmpswks.mats_derived_hrly_value.mats_dhv_id
    IS 'Unique identifier of a MATS derived hourly value record. ';

COMMENT ON COLUMN camdecmpswks.mats_derived_hrly_value.hour_id
    IS 'Unique identifier of an hourly operating data record. ';

COMMENT ON COLUMN camdecmpswks.mats_derived_hrly_value.parameter_cd
    IS 'Code used to identify the parameter. ';

COMMENT ON COLUMN camdecmpswks.mats_derived_hrly_value.unadjusted_hrly_value
    IS 'Unadjusted value calculated from measured values for the hour in scientific notation. ';

COMMENT ON COLUMN camdecmpswks.mats_derived_hrly_value.modc_cd
    IS 'Code used to identify the method of determination. ';

COMMENT ON COLUMN camdecmpswks.mats_derived_hrly_value.mon_form_id
    IS 'Unique identifier of a monitoring formula record. ';

COMMENT ON COLUMN camdecmpswks.mats_derived_hrly_value.calc_unadjusted_hrly_value
    IS 'Unadjusted value calculated from measured values for the hour in scientific notation. ';

COMMENT ON COLUMN camdecmpswks.mats_derived_hrly_value.calc_pct_diluent
    IS 'The percent CO2 or O2 used in the calculation of emission rate.  (It may be the reported value, the diluent cap, or the recalculated CO2 concentration from an O2 monitor).';

COMMENT ON COLUMN camdecmpswks.mats_derived_hrly_value.calc_pct_moisture
    IS 'The percent H2O used in various calculations.  (It may be the reported value, a moisture default, the recalculated H2O from an O2 wet and dry monitor.)';

COMMENT ON COLUMN camdecmpswks.mats_derived_hrly_value.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmpswks.mats_derived_hrly_value.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmpswks.mats_derived_hrly_value.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmpswks.mats_derived_hrly_value.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmpswks.mats_derived_hrly_value.update_date
    IS 'Date and time in which record was last updated. ';

-- Index: idx_matsdhv_002

-- DROP INDEX IF EXISTS camdecmpswks.idx_matsdhv_002;

CREATE INDEX IF NOT EXISTS idx_matsdhv_002
    ON camdecmpswks.mats_derived_hrly_value USING btree
    (modc_cd COLLATE pg_catalog."default" ASC NULLS LAST, unadjusted_hrly_value COLLATE pg_catalog."default" ASC NULLS LAST, parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST, hour_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_matsdhv_add_date

-- DROP INDEX IF EXISTS camdecmpswks.idx_matsdhv_add_date;

CREATE INDEX IF NOT EXISTS idx_matsdhv_add_date
    ON camdecmpswks.mats_derived_hrly_value USING btree
    (add_date ASC NULLS LAST);

-- Index: idx_matsdhv_hour_id

-- DROP INDEX IF EXISTS camdecmpswks.idx_matsdhv_hour_id;

CREATE INDEX IF NOT EXISTS idx_matsdhv_hour_id
    ON camdecmpswks.mats_derived_hrly_value USING btree
    (hour_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_matsdhv_mon_form_id

-- DROP INDEX IF EXISTS camdecmpswks.idx_matsdhv_mon_form_id;

CREATE INDEX IF NOT EXISTS idx_matsdhv_mon_form_id
    ON camdecmpswks.mats_derived_hrly_value USING btree
    (mon_form_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_matsdhv_parameter_

-- DROP INDEX IF EXISTS camdecmpswks.idx_matsdhv_parameter_;

CREATE INDEX IF NOT EXISTS idx_matsdhv_parameter_
    ON camdecmpswks.mats_derived_hrly_value USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: matsdhv_idx001

-- DROP INDEX IF EXISTS camdecmpswks.matsdhv_idx001;

CREATE INDEX IF NOT EXISTS matsdhv_idx001
    ON camdecmpswks.mats_derived_hrly_value USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);