-- Table: camdecmps.hrly_param_fuel_flow

-- DROP TABLE IF EXISTS camdecmps.hrly_param_fuel_flow;

CREATE TABLE IF NOT EXISTS camdecmps.hrly_param_fuel_flow
(
    hrly_param_ff_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    hrly_fuel_flow_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default",
    mon_form_id character varying(45) COLLATE pg_catalog."default",
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    param_val_fuel numeric(13,5),
    calc_param_val_fuel numeric(13,5),
    sample_type_cd character varying(7) COLLATE pg_catalog."default",
    operating_condition_cd character varying(7) COLLATE pg_catalog."default",
    segment_num numeric(38,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    parameter_uom_cd character varying(7) COLLATE pg_catalog."default",
    calc_appe_status character varying(75) COLLATE pg_catalog."default",
    rpt_period_id numeric(38,0) NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_hrly_param_fuel_flow PRIMARY KEY (hrly_param_ff_id),
    CONSTRAINT fk_hrly_fuel_flo_hrly_param_fu FOREIGN KEY (hrly_fuel_flow_id)
        REFERENCES camdecmps.hrly_fuel_flow (hrly_fuel_flow_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_formu_hrly_param_fu FOREIGN KEY (mon_form_id)
        REFERENCES camdecmps.monitor_formula (mon_form_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_syste_hrly_param_fu FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_operating_con_hrly_param_fu FOREIGN KEY (operating_condition_cd)
        REFERENCES camdecmpsmd.operating_condition_code (operating_condition_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_parameter_cod_hrly_param_fu FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_sample_type_c_hrly_param_fu FOREIGN KEY (sample_type_cd)
        REFERENCES camdecmpsmd.sample_type_code (sample_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_units_of_meas_hrly_param_fu FOREIGN KEY (parameter_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT hrly_param_fuel_flow_hrly_fuel_flow_id_check CHECK (hrly_fuel_flow_id IS NOT NULL),
    CONSTRAINT hrly_param_fuel_flow_hrly_fuel_flow_id_check1 CHECK (hrly_fuel_flow_id IS NOT NULL),
    CONSTRAINT hrly_param_fuel_flow_hrly_param_ff_id_check CHECK (hrly_param_ff_id IS NOT NULL),
    CONSTRAINT hrly_param_fuel_flow_hrly_param_ff_id_check1 CHECK (hrly_param_ff_id IS NOT NULL),
    CONSTRAINT hrly_param_fuel_flow_mon_loc_id_check CHECK (mon_loc_id IS NOT NULL),
    CONSTRAINT hrly_param_fuel_flow_mon_loc_id_check1 CHECK (mon_loc_id IS NOT NULL),
    CONSTRAINT hrly_param_fuel_flow_parameter_cd_check CHECK (parameter_cd IS NOT NULL),
    CONSTRAINT hrly_param_fuel_flow_parameter_cd_check1 CHECK (parameter_cd IS NOT NULL),
    CONSTRAINT hrly_param_fuel_flow_rpt_period_id_check CHECK (rpt_period_id IS NOT NULL),
    CONSTRAINT hrly_param_fuel_flow_rpt_period_id_check1 CHECK (rpt_period_id IS NOT NULL)
);

COMMENT ON TABLE camdecmps.hrly_param_fuel_flow
    IS 'Calculated SO2, CO2 or heat input determined from fuel flow information.  Record Types 302, 303, 313 and 314.';

COMMENT ON COLUMN camdecmps.hrly_param_fuel_flow.hrly_param_ff_id
    IS 'Unique identifier of an hourly parameter fuel flow record. ';

COMMENT ON COLUMN camdecmps.hrly_param_fuel_flow.hrly_fuel_flow_id
    IS 'Unique identifier of an hourly fuel flow record. ';

COMMENT ON COLUMN camdecmps.hrly_param_fuel_flow.mon_sys_id
    IS 'Unique identifier of a monitoring system record. ';

COMMENT ON COLUMN camdecmps.hrly_param_fuel_flow.mon_form_id
    IS 'Unique identifier of a monitoring formula record. ';

COMMENT ON COLUMN camdecmps.hrly_param_fuel_flow.parameter_cd
    IS 'Unique code value for a lookup table.';

COMMENT ON COLUMN camdecmps.hrly_param_fuel_flow.param_val_fuel
    IS 'Hourly parameter value for fuel.  (Currently SO2 mass rate, CO2 mass rate or heat input rate.) ';

COMMENT ON COLUMN camdecmps.hrly_param_fuel_flow.calc_param_val_fuel
    IS 'Hourly parameter value for fuel.  (Currently SO2 mass rate, CO2 mass rate or heat input rate.) ';

COMMENT ON COLUMN camdecmps.hrly_param_fuel_flow.sample_type_cd
    IS 'Code used to identify the sample type. ';

COMMENT ON COLUMN camdecmps.hrly_param_fuel_flow.operating_condition_cd
    IS 'Code used to identify the operating condition. ';

COMMENT ON COLUMN camdecmps.hrly_param_fuel_flow.segment_num
    IS 'Segment number of correlation curve.  Rather than a user-assigned identifier, this is just an integer that indicates the segment number (assuming the first segment is number 1). ';

COMMENT ON COLUMN camdecmps.hrly_param_fuel_flow.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.hrly_param_fuel_flow.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.hrly_param_fuel_flow.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.hrly_param_fuel_flow.parameter_uom_cd
    IS 'Code used to identify the parameter units of measure. ';

COMMENT ON COLUMN camdecmps.hrly_param_fuel_flow.calc_appe_status
    IS 'QA Status for Appendix E Check determined by EPA. ';

COMMENT ON COLUMN camdecmps.hrly_param_fuel_flow.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmps.hrly_param_fuel_flow.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';
-- Index: hrly_param_fuel_flow_idx001

-- DROP INDEX IF EXISTS camdecmps.hrly_param_fuel_flow_idx001;

CREATE INDEX IF NOT EXISTS IF NOT EXISTS hrly_param_fuel_flow_idx001
    ON camdecmps.hrly_param_fuel_flow USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: hrly_param_fuel_flow_idx002

-- DROP INDEX IF EXISTS camdecmps.hrly_param_fuel_flow_idx002;

CREATE INDEX IF NOT EXISTS IF NOT EXISTS hrly_param_fuel_flow_idx002
    ON camdecmps.hrly_param_fuel_flow USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_hpff_add_date

-- DROP INDEX IF EXISTS camdecmps.idx_hpff_add_date;

CREATE INDEX IF NOT EXISTS IF NOT EXISTS idx_hpff_add_date
    ON camdecmps.hrly_param_fuel_flow USING btree
    (add_date ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_hrly_param_fuel_hrly_fuel

-- DROP INDEX IF EXISTS camdecmps.idx_hrly_param_fuel_hrly_fuel;

CREATE INDEX IF NOT EXISTS IF NOT EXISTS idx_hrly_param_fuel_hrly_fuel
    ON camdecmps.hrly_param_fuel_flow USING btree
    (hrly_fuel_flow_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_hrly_param_fuel_mon_form_i

-- DROP INDEX IF EXISTS camdecmps.idx_hrly_param_fuel_mon_form_i;

CREATE INDEX IF NOT EXISTS IF NOT EXISTS idx_hrly_param_fuel_mon_form_i
    ON camdecmps.hrly_param_fuel_flow USING btree
    (mon_form_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_hrly_param_fuel_mon_sys_id

-- DROP INDEX IF EXISTS camdecmps.idx_hrly_param_fuel_mon_sys_id;

CREATE INDEX IF NOT EXISTS IF NOT EXISTS idx_hrly_param_fuel_mon_sys_id
    ON camdecmps.hrly_param_fuel_flow USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_hrly_param_fuel_operating

-- DROP INDEX IF EXISTS camdecmps.idx_hrly_param_fuel_operating;

CREATE INDEX IF NOT EXISTS IF NOT EXISTS idx_hrly_param_fuel_operating
    ON camdecmps.hrly_param_fuel_flow USING btree
    (operating_condition_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_hrly_param_fuel_parameter

-- DROP INDEX IF EXISTS camdecmps.idx_hrly_param_fuel_parameter;

CREATE INDEX IF NOT EXISTS IF NOT EXISTS idx_hrly_param_fuel_parameter
    ON camdecmps.hrly_param_fuel_flow USING btree
    (parameter_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_hrly_param_fuel_sample_typ

-- DROP INDEX IF EXISTS camdecmps.idx_hrly_param_fuel_sample_typ;

CREATE INDEX IF NOT EXISTS IF NOT EXISTS idx_hrly_param_fuel_sample_typ
    ON camdecmps.hrly_param_fuel_flow USING btree
    (sample_type_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;