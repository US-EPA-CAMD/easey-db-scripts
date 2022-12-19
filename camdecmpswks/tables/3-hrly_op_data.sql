-- Table: camdecmpswks.hrly_op_data

-- DROP TABLE camdecmpswks.hrly_op_data;

CREATE TABLE IF NOT EXISTS camdecmpswks.hrly_op_data
(
    hour_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    begin_date date NOT NULL,
    begin_hour numeric(2,0) NOT NULL,
    op_time numeric(3,2),
    hr_load numeric(6,0),
    load_range numeric(38,0),
    common_stack_load_range numeric(38,0),
    fc_factor numeric(8,1),
    fd_factor numeric(8,1),
    fw_factor numeric(8,1),
    fuel_cd character varying(7) COLLATE pg_catalog."default",
    multi_fuel_flg character varying(1) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    load_uom_cd character varying(7) COLLATE pg_catalog."default",
    operating_condition_cd character varying(7) COLLATE pg_catalog."default",
    fuel_cd_list character varying(100) COLLATE pg_catalog."default",
    mhhi_indicator numeric(38,0),
    mats_load numeric(6,0),
    mats_startup_shutdown_flg character varying(1) COLLATE pg_catalog."default",
    CONSTRAINT pk_hrly_op_data PRIMARY KEY (hour_id),
    CONSTRAINT fk_hrly_op_data_fuel_code FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_hrly_op_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_hrly_op_data_operating_condition_code FOREIGN KEY (operating_condition_cd)
        REFERENCES camdecmpsmd.operating_condition_code (operating_condition_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_hrly_op_data_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_hrly_op_data_units_of_measure_code FOREIGN KEY (load_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT hrly_op_data_begin_date_check CHECK (begin_date IS NOT NULL),
    CONSTRAINT hrly_op_data_begin_hour_check CHECK (begin_hour IS NOT NULL),
    CONSTRAINT hrly_op_data_hour_id_check CHECK (hour_id IS NOT NULL),
    CONSTRAINT hrly_op_data_mon_loc_id_check CHECK (mon_loc_id IS NOT NULL),
    CONSTRAINT hrly_op_data_rpt_period_id_check CHECK (rpt_period_id IS NOT NULL)
);

COMMENT ON TABLE camdecmpswks.hrly_op_data
    IS 'A collection of data that contains one record for each hour in which a monitor location may or may not have operated. RT 300.';

COMMENT ON COLUMN camdecmpswks.hrly_op_data.hour_id
    IS 'Unique identifier of an hourly operating data record. ';

COMMENT ON COLUMN camdecmpswks.hrly_op_data.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmpswks.hrly_op_data.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmpswks.hrly_op_data.begin_date
    IS 'Date of the hourly operating data. ';

COMMENT ON COLUMN camdecmpswks.hrly_op_data.begin_hour
    IS 'Hour of the hourly operating data. ';

COMMENT ON COLUMN camdecmpswks.hrly_op_data.op_time
    IS 'The fraction of the clock hour during which the unit (or any unit venting through the stack) combusted any fuel. ';

COMMENT ON COLUMN camdecmpswks.hrly_op_data.hr_load
    IS 'Gross unit load or steam load value during unit operation. ';

COMMENT ON COLUMN camdecmpswks.hrly_op_data.load_range
    IS 'Operating load range or load bin number (1 to 10). ';

COMMENT ON COLUMN camdecmpswks.hrly_op_data.common_stack_load_range
    IS 'Load range for stack flow at a common stack (between 1 and 20).  Optional alternative to standard load range. ';

COMMENT ON COLUMN camdecmpswks.hrly_op_data.fc_factor
    IS 'Carbon based F-factor corresponding to fuel(s) burned during the hour. ';

COMMENT ON COLUMN camdecmpswks.hrly_op_data.fd_factor
    IS 'Dry basis F-factor corresponding to fuel(s) burned during the hour. ';

COMMENT ON COLUMN camdecmpswks.hrly_op_data.fw_factor
    IS 'Wet basis F-factor corresponding to fuel(s) burned during the hour. ';

COMMENT ON COLUMN camdecmpswks.hrly_op_data.fuel_cd
    IS 'Code used to identify the type of fuel. ';

COMMENT ON COLUMN camdecmpswks.hrly_op_data.multi_fuel_flg
    IS 'Flag indicating that more than one fuel was burned during the hour. ';

COMMENT ON COLUMN camdecmpswks.hrly_op_data.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmpswks.hrly_op_data.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmpswks.hrly_op_data.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmpswks.hrly_op_data.load_uom_cd
    IS 'Code used to identify the load units of measure. ';

COMMENT ON COLUMN camdecmpswks.hrly_op_data.operating_condition_cd
    IS 'Code used to identify the operating condition. ';

COMMENT ON COLUMN camdecmpswks.hrly_op_data.fuel_cd_list
    IS 'List of fuel codes for fuel combusted during the operating time (LME only).  ';

COMMENT ON COLUMN camdecmpswks.hrly_op_data.mhhi_indicator
    IS 'Indicates whether maximum hourly heat input applies.';

COMMENT ON COLUMN camdecmpswks.hrly_op_data.mats_load
    IS 'The MATS speciic megawatt load.';

COMMENT ON COLUMN camdecmpswks.hrly_op_data.mats_startup_shutdown_flg
    IS 'Flag indicating whether the current hour is either a MATS startup or shutdown hour.';
-- Index: idx_hod_add_date

-- DROP INDEX camdecmpswks.idx_hod_add_date;

CREATE INDEX IF NOT EXISTS idx_hod_add_date
    ON camdecmpswks.hrly_op_data USING btree
    (add_date ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_hrly_op_data_1

-- DROP INDEX camdecmpswks.idx_hrly_op_data_1;

CREATE INDEX IF NOT EXISTS idx_hrly_op_data_1
    ON camdecmpswks.hrly_op_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_hrly_op_data_2

-- DROP INDEX camdecmpswks.idx_hrly_op_data_2;

CREATE INDEX IF NOT EXISTS idx_hrly_op_data_2
    ON camdecmpswks.hrly_op_data USING btree
    (rpt_period_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_hrly_op_data_emr

-- DROP INDEX camdecmpswks.idx_hrly_op_data_emr;

CREATE INDEX IF NOT EXISTS idx_hrly_op_data_emr
    ON camdecmpswks.hrly_op_data USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_hrly_op_data_fuel_cd

-- DROP INDEX camdecmpswks.idx_hrly_op_data_fuel_cd;

CREATE INDEX IF NOT EXISTS idx_hrly_op_data_fuel_cd
    ON camdecmpswks.hrly_op_data USING btree
    (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_hrly_op_data_operating_

-- DROP INDEX camdecmpswks.idx_hrly_op_data_operating_;

CREATE INDEX IF NOT EXISTS idx_hrly_op_data_operating_
    ON camdecmpswks.hrly_op_data USING btree
    (operating_condition_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;