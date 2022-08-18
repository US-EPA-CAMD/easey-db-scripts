-- Table: camdecmpswks.mats_monitor_hrly_value

-- DROP TABLE IF EXISTS camdecmpswks.mats_monitor_hrly_value;

CREATE TABLE IF NOT EXISTS camdecmpswks.mats_monitor_hrly_value
(
    mats_mhv_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    hour_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default",
    component_id character varying(45) COLLATE pg_catalog."default",
    unadjusted_hrly_value character varying(30) COLLATE pg_catalog."default",
    modc_cd character varying(7) COLLATE pg_catalog."default",
    pct_available numeric(4,1),
    calc_unadjusted_hrly_value character varying(30) COLLATE pg_catalog."default",
    calc_daily_cal_status character varying(75) COLLATE pg_catalog."default",
    calc_hg_line_status character varying(75) COLLATE pg_catalog."default",
    calc_hgi1_status character varying(75) COLLATE pg_catalog."default",
    calc_rata_status character varying(75) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_mats_monitor_hrly_value PRIMARY KEY (mats_mhv_id),
    CONSTRAINT fk_mmhv_component_id FOREIGN KEY (component_id)
        REFERENCES camdecmpswks.component (component_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_mmhv_hour_id FOREIGN KEY (hour_id)
        REFERENCES camdecmpswks.hrly_op_data (hour_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_mmhv_modc_cd FOREIGN KEY (modc_cd)
        REFERENCES camdecmpsmd.modc_code (modc_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_mmhv_mon_loc_id FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_mmhv_mon_sys_id FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmpswks.monitor_system (mon_sys_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_mmhv_parameter_cd FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_mmhv_rpt_period_id FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmpswks.mats_monitor_hrly_value
    IS 'The MATS hourly value monitored and reported for each parameter. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.mats_mhv_id
    IS 'Unique identifier of MATS monitor hourly value record. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.hour_id
    IS 'Unique identifier of an hourly operating data record. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.parameter_cd
    IS 'Code used to identify the parameter. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.mon_sys_id
    IS 'Unique identifier of a monitoring system record. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.unadjusted_hrly_value
    IS 'Unadjusted measured value in scientific notation. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.modc_cd
    IS 'Code used to identify the method of determination. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.pct_available
    IS 'Percent monitor data availability. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.calc_unadjusted_hrly_value
    IS 'Adjusted average concentration or flow for the hour. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.calc_daily_cal_status
    IS 'QA Status for Daily Calibration Check determined by EPA. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.calc_hg_line_status
    IS 'QA Status for HG Linearity Check determined by EPA. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.calc_rata_status
    IS 'QA Status for RATA Check determined by EPA. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.update_date
    IS 'Date and time in which record was last updated. ';

-- Index: idx_matsmhv_add_date

-- DROP INDEX IF EXISTS camdecmpswks.idx_matsmhv_add_date;

CREATE INDEX IF NOT EXISTS idx_matsmhv_add_date
    ON camdecmpswks.mats_monitor_hrly_value USING btree
    (add_date ASC NULLS LAST);

-- Index: idx_matsmhv_component

-- DROP INDEX IF EXISTS camdecmpswks.idx_matsmhv_component;

CREATE INDEX IF NOT EXISTS idx_matsmhv_component
    ON camdecmpswks.mats_monitor_hrly_value USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_matsmhv_mon_sys_id

-- DROP INDEX IF EXISTS camdecmpswks.idx_matsmhv_mon_sys_id;

CREATE INDEX IF NOT EXISTS idx_matsmhv_mon_sys_id
    ON camdecmpswks.mats_monitor_hrly_value USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_matsmhv_param1

-- DROP INDEX IF EXISTS camdecmpswks.idx_matsmhv_param1;

CREATE INDEX IF NOT EXISTS idx_matsmhv_param1
    ON camdecmpswks.mats_monitor_hrly_value USING btree
    (hour_id COLLATE pg_catalog."default" ASC NULLS LAST, parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_matsmhv_param2

-- DROP INDEX IF EXISTS camdecmpswks.idx_matsmhv_param2;

CREATE INDEX IF NOT EXISTS idx_matsmhv_param2
    ON camdecmpswks.mats_monitor_hrly_value USING btree
    (modc_cd COLLATE pg_catalog."default" ASC NULLS LAST, unadjusted_hrly_value COLLATE pg_catalog."default" ASC NULLS LAST, hour_id COLLATE pg_catalog."default" ASC NULLS LAST, parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_matsmhv_parameter_

-- DROP INDEX IF EXISTS camdecmpswks.idx_matsmhv_parameter_;

CREATE INDEX IF NOT EXISTS idx_matsmhv_parameter_
    ON camdecmpswks.mats_monitor_hrly_value USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_matsmhv_rpt_per_loc

-- DROP INDEX IF EXISTS camdecmpswks.idx_matsmhv_rpt_per_loc;

CREATE INDEX IF NOT EXISTS idx_matsmhv_rpt_per_loc
    ON camdecmpswks.mats_monitor_hrly_value USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);