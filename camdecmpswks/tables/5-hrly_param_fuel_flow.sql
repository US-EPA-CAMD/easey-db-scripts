-- Table: camdecmpswks.hrly_param_fuel_flow

-- DROP TABLE camdecmpswks.hrly_param_fuel_flow;

CREATE TABLE IF NOT EXISTS camdecmpswks.hrly_param_fuel_flow
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
    CONSTRAINT fk_hrly_param_fuel_flow_hrly_fuel_flow FOREIGN KEY (hrly_fuel_flow_id)
        REFERENCES camdecmpswks.hrly_fuel_flow (hrly_fuel_flow_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_hrly_param_fuel_flow_monitor_formula FOREIGN KEY (mon_form_id)
        REFERENCES camdecmpswks.monitor_formula (mon_form_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_hrly_param_fuel_flow_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_hrly_param_fuel_flow_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmpswks.monitor_system (mon_sys_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_hrly_param_fuel_flow_operating_condition_code FOREIGN KEY (operating_condition_cd)
        REFERENCES camdecmpsmd.operating_condition_code (operating_condition_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_hrly_param_fuel_flow_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_hrly_param_fuel_flow_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_hrly_param_fuel_flow_sample_type_code FOREIGN KEY (sample_type_cd)
        REFERENCES camdecmpsmd.sample_type_code (sample_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_hrly_param_fuel_flow_units_of_measure_code FOREIGN KEY (parameter_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmpswks.hrly_param_fuel_flow
    IS 'Calculated SO2, CO2 or heat input determined from fuel flow information.  Record Types 302, 303, 313 and 314.';

COMMENT ON COLUMN camdecmpswks.hrly_param_fuel_flow.hrly_param_ff_id
    IS 'Unique identifier of an hourly parameter fuel flow record. ';

COMMENT ON COLUMN camdecmpswks.hrly_param_fuel_flow.hrly_fuel_flow_id
    IS 'Unique identifier of an hourly fuel flow record. ';

COMMENT ON COLUMN camdecmpswks.hrly_param_fuel_flow.mon_sys_id
    IS 'Unique identifier of a monitoring system record. ';

COMMENT ON COLUMN camdecmpswks.hrly_param_fuel_flow.mon_form_id
    IS 'Unique identifier of a monitoring formula record. ';

COMMENT ON COLUMN camdecmpswks.hrly_param_fuel_flow.parameter_cd
    IS 'Unique code value for a lookup table.';

COMMENT ON COLUMN camdecmpswks.hrly_param_fuel_flow.param_val_fuel
    IS 'Hourly parameter value for fuel.  (Currently SO2 mass rate, CO2 mass rate or heat input rate.) ';

COMMENT ON COLUMN camdecmpswks.hrly_param_fuel_flow.calc_param_val_fuel
    IS 'Hourly parameter value for fuel.  (Currently SO2 mass rate, CO2 mass rate or heat input rate.) ';

COMMENT ON COLUMN camdecmpswks.hrly_param_fuel_flow.sample_type_cd
    IS 'Code used to identify the sample type. ';

COMMENT ON COLUMN camdecmpswks.hrly_param_fuel_flow.operating_condition_cd
    IS 'Code used to identify the operating condition. ';

COMMENT ON COLUMN camdecmpswks.hrly_param_fuel_flow.segment_num
    IS 'Segment number of correlation curve.  Rather than a user-assigned identifier, this is just an integer that indicates the segment number (assuming the first segment is number 1). ';

COMMENT ON COLUMN camdecmpswks.hrly_param_fuel_flow.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmpswks.hrly_param_fuel_flow.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmpswks.hrly_param_fuel_flow.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmpswks.hrly_param_fuel_flow.parameter_uom_cd
    IS 'Code used to identify the parameter units of measure. ';

COMMENT ON COLUMN camdecmpswks.hrly_param_fuel_flow.calc_appe_status
    IS 'QA Status for Appendix E Check determined by EPA. ';

COMMENT ON COLUMN camdecmpswks.hrly_param_fuel_flow.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmpswks.hrly_param_fuel_flow.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';
