-- Table: camdecmps.monitor_span

-- DROP TABLE camdecmps.monitor_span;

CREATE TABLE IF NOT EXISTS camdecmps.monitor_span
(
    span_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mpc_value numeric(6,1),
    mec_value numeric(6,1),
    mpf_value numeric(10,0),
    max_low_range numeric(6,1),
    span_value numeric(13,3),
    full_scale_range numeric(13,3),
    begin_date date NOT NULL,
    begin_hour numeric(2,0) NOT NULL,
    end_date date,
    end_hour numeric(2,0),
    default_high_range numeric(5,0),
    flow_span_value numeric(10,0),
    flow_full_scale_range numeric(10,0),
    component_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    span_scale_cd character varying(7) COLLATE pg_catalog."default",
    span_method_cd character varying(7) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    span_uom_cd character varying(7) COLLATE pg_catalog."default",
    CONSTRAINT pk_monitor_span PRIMARY KEY (span_id),
    CONSTRAINT fk_component_typ_monitor_span FOREIGN KEY (component_type_cd)
        REFERENCES camdecmpsmd.component_type_code (component_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_locat_monitor_span FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_span_method_c_monitor_span FOREIGN KEY (span_method_cd)
        REFERENCES camdecmpsmd.span_method_code (span_method_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_span_scale_co_monitor_span FOREIGN KEY (span_scale_cd)
        REFERENCES camdecmpsmd.span_scale_code (span_scale_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_units_of_meas_monitor_span FOREIGN KEY (span_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.monitor_span
    IS 'Measurement range and related attributes for a monitored CEM parameter.  Record Type 530.';

COMMENT ON COLUMN camdecmps.monitor_span.span_id
    IS 'Unique identifier of a monitoring span record. ';

COMMENT ON COLUMN camdecmps.monitor_span.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.monitor_span.mpc_value
    IS 'Maximum potential concentration (MPC). ';

COMMENT ON COLUMN camdecmps.monitor_span.mec_value
    IS 'Maximum expected concentration (MEC). ';

COMMENT ON COLUMN camdecmps.monitor_span.mpf_value
    IS 'Maximum Potential Flow (MPF). ';

COMMENT ON COLUMN camdecmps.monitor_span.max_low_range
    IS 'Maximum value determined by low-scale of a dual-range analyzer. ';

COMMENT ON COLUMN camdecmps.monitor_span.span_value
    IS 'Span value in units of daily calibration. ';

COMMENT ON COLUMN camdecmps.monitor_span.full_scale_range
    IS 'Full scale range in units of daily calibration. ';

COMMENT ON COLUMN camdecmps.monitor_span.begin_date
    IS 'Date on which information became effective or activity started. ';

COMMENT ON COLUMN camdecmps.monitor_span.begin_hour
    IS 'Hour in which information became effective. ';

COMMENT ON COLUMN camdecmps.monitor_span.end_date
    IS 'Last date in which information was effective.  This date will be null for active records. ';

COMMENT ON COLUMN camdecmps.monitor_span.end_hour
    IS 'Last hour in which information was effective.  This value will be null for active records. ';

COMMENT ON COLUMN camdecmps.monitor_span.default_high_range
    IS 'Default High Range value. ';

COMMENT ON COLUMN camdecmps.monitor_span.flow_span_value
    IS 'Flow rate span value in SCFH. ';

COMMENT ON COLUMN camdecmps.monitor_span.flow_full_scale_range
    IS 'Flow rate full scale value in SCFH. ';

COMMENT ON COLUMN camdecmps.monitor_span.component_type_cd
    IS 'Code used to indicate the component type. ';

COMMENT ON COLUMN camdecmps.monitor_span.span_scale_cd
    IS 'Code used to identify the span scale. ';

COMMENT ON COLUMN camdecmps.monitor_span.span_method_cd
    IS 'Code used to identify the method used to calculate MPC/MEC/MPF. ';

COMMENT ON COLUMN camdecmps.monitor_span.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.monitor_span.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.monitor_span.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.monitor_span.span_uom_cd
    IS 'Code used to identify the calibration units of measure. ';

-- Index: idx_monitor_span_component

-- DROP INDEX camdecmps.idx_monitor_span_component;

CREATE INDEX idx_monitor_span_component
    ON camdecmps.monitor_span USING btree
    (component_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_monitor_span_mon_loc_id

-- DROP INDEX camdecmps.idx_monitor_span_mon_loc_id;

CREATE INDEX idx_monitor_span_mon_loc_id
    ON camdecmps.monitor_span USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_monitor_span_span_metho

-- DROP INDEX camdecmps.idx_monitor_span_span_metho;

CREATE INDEX idx_monitor_span_span_metho
    ON camdecmps.monitor_span USING btree
    (span_method_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_monitor_span_span_scale

-- DROP INDEX camdecmps.idx_monitor_span_span_scale;

CREATE INDEX idx_monitor_span_span_scale
    ON camdecmps.monitor_span USING btree
    (span_scale_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_monitor_span_span_uom_c

-- DROP INDEX camdecmps.idx_monitor_span_span_uom_c;

CREATE INDEX idx_monitor_span_span_uom_c
    ON camdecmps.monitor_span USING btree
    (span_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);
