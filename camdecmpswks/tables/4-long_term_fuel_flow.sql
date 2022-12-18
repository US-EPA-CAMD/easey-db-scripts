-- Table: camdecmpswks.long_term_fuel_flow

-- DROP TABLE camdecmpswks.long_term_fuel_flow;

CREATE TABLE camdecmpswks.long_term_fuel_flow
(
    ltff_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0),
    mon_loc_id character varying(45) COLLATE pg_catalog."default",
    mon_sys_id character varying(45) COLLATE pg_catalog."default",
    fuel_flow_period_cd character varying(7) COLLATE pg_catalog."default",
    long_term_fuel_flow_value numeric(10,0),
    ltff_uom_cd character varying(7) COLLATE pg_catalog."default",
    gross_calorific_value numeric(10,1),
    gcv_uom_cd character varying(7) COLLATE pg_catalog."default",
    total_heat_input numeric(10,0),
    calc_total_heat_input numeric(10,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_long_term_fuel_flow PRIMARY KEY (ltff_id),
    CONSTRAINT fk_long_term_fuel_flow_fuel_flow_period_code FOREIGN KEY (fuel_flow_period_cd)
        REFERENCES camdecmpsmd.fuel_flow_period_code (fuel_flow_period_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_long_term_fuel_flow_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_long_term_fuel_flow_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmpswks.monitor_system (mon_sys_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_long_term_fuel_flow_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_long_term_fuel_flow_units_of_measure_code_gcv FOREIGN KEY (gcv_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_long_term_fuel_flow_units_of_measure_code_ltff FOREIGN KEY (ltff_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmpswks.long_term_fuel_flow
    IS 'Long term fuel flow data for LME reporting.';

COMMENT ON COLUMN camdecmpswks.long_term_fuel_flow.ltff_id
    IS 'Unique identifier of a long term fuel flow record. ';

COMMENT ON COLUMN camdecmpswks.long_term_fuel_flow.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmpswks.long_term_fuel_flow.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmpswks.long_term_fuel_flow.mon_sys_id
    IS 'Unique identifier of a monitoring system record. ';

COMMENT ON COLUMN camdecmpswks.long_term_fuel_flow.fuel_flow_period_cd
    IS 'Code used to identify the long term fuel flow period. ';

COMMENT ON COLUMN camdecmpswks.long_term_fuel_flow.long_term_fuel_flow_value
    IS 'Long term fuel flow value ';

COMMENT ON COLUMN camdecmpswks.long_term_fuel_flow.ltff_uom_cd
    IS 'Code used to identify the units of measure for the long term fuel flow value. ';

COMMENT ON COLUMN camdecmpswks.long_term_fuel_flow.gross_calorific_value
    IS 'Gross Calorific Value. ';

COMMENT ON COLUMN camdecmpswks.long_term_fuel_flow.gcv_uom_cd
    IS 'Code used to identify the units of measure for the GCV. ';

COMMENT ON COLUMN camdecmpswks.long_term_fuel_flow.total_heat_input
    IS 'Total heat input from this long term fuel flow value. ';

COMMENT ON COLUMN camdecmpswks.long_term_fuel_flow.calc_total_heat_input
    IS 'Calculated total heat input from this long term fuel flow value. ';

COMMENT ON COLUMN camdecmpswks.long_term_fuel_flow.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmpswks.long_term_fuel_flow.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmpswks.long_term_fuel_flow.update_date
    IS 'Date and time in which record was last updated.';
-- Index: idx_long_term_fuel_flow_emr

-- DROP INDEX camdecmpswks.idx_long_term_fuel_flow_emr;

CREATE INDEX IF NOT EXISTS idx_long_term_fuel_flow_emr
    ON camdecmpswks.long_term_fuel_flow USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_long_term_fuel_fuel_flow

-- DROP INDEX camdecmpswks.idx_long_term_fuel_fuel_flow;

CREATE INDEX IF NOT EXISTS idx_long_term_fuel_fuel_flow
    ON camdecmpswks.long_term_fuel_flow USING btree
    (fuel_flow_period_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_long_term_fuel_gcv_uom_cd

-- DROP INDEX camdecmpswks.idx_long_term_fuel_gcv_uom_cd;

CREATE INDEX IF NOT EXISTS idx_long_term_fuel_gcv_uom_cd
    ON camdecmpswks.long_term_fuel_flow USING btree
    (gcv_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_long_term_fuel_ltff_uom_c

-- DROP INDEX camdecmpswks.idx_long_term_fuel_ltff_uom_c;

CREATE INDEX IF NOT EXISTS idx_long_term_fuel_ltff_uom_c
    ON camdecmpswks.long_term_fuel_flow USING btree
    (ltff_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_long_term_fuel_mon_loc_id

-- DROP INDEX camdecmpswks.idx_long_term_fuel_mon_loc_id;

CREATE INDEX IF NOT EXISTS idx_long_term_fuel_mon_loc_id
    ON camdecmpswks.long_term_fuel_flow USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_long_term_fuel_mon_sys_id

-- DROP INDEX camdecmpswks.idx_long_term_fuel_mon_sys_id;

CREATE INDEX IF NOT EXISTS idx_long_term_fuel_mon_sys_id
    ON camdecmpswks.long_term_fuel_flow USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_ltff_add_date

-- DROP INDEX camdecmpswks.idx_ltff_add_date;

CREATE INDEX IF NOT EXISTS idx_ltff_add_date
    ON camdecmpswks.long_term_fuel_flow USING btree
    (add_date ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: long_term_fuel_flow_idx001

-- DROP INDEX camdecmpswks.long_term_fuel_flow_idx001;

CREATE INDEX IF NOT EXISTS long_term_fuel_flow_idx001
    ON camdecmpswks.long_term_fuel_flow USING btree
    (rpt_period_id ASC NULLS LAST)
    TABLESPACE pg_default;