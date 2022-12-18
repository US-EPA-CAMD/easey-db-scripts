-- Table: camdecmps.monitor_default

-- DROP TABLE camdecmps.monitor_default;

CREATE TABLE IF NOT EXISTS camdecmps.monitor_default
(
    mondef_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    begin_date date NOT NULL,
    begin_hour numeric(2,0) NOT NULL,
    end_date date,
    end_hour numeric(2,0),
    operating_condition_cd character varying(7) COLLATE pg_catalog."default",
    default_value numeric(15,4) NOT NULL,
    default_purpose_cd character varying(7) COLLATE pg_catalog."default",
    default_source_cd character varying(7) COLLATE pg_catalog."default",
    fuel_cd character varying(7) COLLATE pg_catalog."default",
    group_id character varying(10) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    default_uom_cd character varying(7) COLLATE pg_catalog."default",
    CONSTRAINT pk_monitor_default PRIMARY KEY (mondef_id),
    CONSTRAINT fk_default_purpo_monitor_defau FOREIGN KEY (default_purpose_cd)
        REFERENCES camdecmpsmd.default_purpose_code (default_purpose_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_default_sourc_monitor_defau FOREIGN KEY (default_source_cd)
        REFERENCES camdecmpsmd.default_source_code (default_source_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_fuel_code_monitor_defau FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_locat_monitor_defau FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_operating_con_monitor_defau FOREIGN KEY (operating_condition_cd)
        REFERENCES camdecmpsmd.operating_condition_code (operating_condition_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_parameter_cod_monitor_defau FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_units_of_meas_monitor_defau FOREIGN KEY (default_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.monitor_default
    IS 'List of unit-specific and fuel-specific constants used in Emissions calculations.  Record Type 531.';

COMMENT ON COLUMN camdecmps.monitor_default.mondef_id
    IS 'Unique identifier of a monitoring default record. ';

COMMENT ON COLUMN camdecmps.monitor_default.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.monitor_default.parameter_cd
    IS 'Code used to identify the parameter. ';

COMMENT ON COLUMN camdecmps.monitor_default.begin_date
    IS 'Date on which information became effective or activity started. ';

COMMENT ON COLUMN camdecmps.monitor_default.begin_hour
    IS 'Hour in which information became effective. ';

COMMENT ON COLUMN camdecmps.monitor_default.end_date
    IS 'Last date in which information was effective.  This date will be null for active records. ';

COMMENT ON COLUMN camdecmps.monitor_default.end_hour
    IS 'Last hour in which information was effective.  This value will be null for active records. ';

COMMENT ON COLUMN camdecmps.monitor_default.operating_condition_cd
    IS 'Code used to identify the operating condition. ';

COMMENT ON COLUMN camdecmps.monitor_default.default_value
    IS 'Value of default, maximum, minimum or constant. ';

COMMENT ON COLUMN camdecmps.monitor_default.default_purpose_cd
    IS 'Code used to identify the purpose or intended use of defaults, maximums and constants. ';

COMMENT ON COLUMN camdecmps.monitor_default.default_source_cd
    IS 'Code used to identify the source of the default value. ';

COMMENT ON COLUMN camdecmps.monitor_default.fuel_cd
    IS 'Code used to identify the type of fuel. ';

COMMENT ON COLUMN camdecmps.monitor_default.group_id
    IS 'For a group of identical units using testing to determine default NOx rate, this ID identifies the group. ';

COMMENT ON COLUMN camdecmps.monitor_default.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.monitor_default.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.monitor_default.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.monitor_default.default_uom_cd
    IS 'Code used to identify the hourly parameter units of measure. ';

-- Index: idx_monitor_default_default_pu

-- DROP INDEX camdecmps.idx_monitor_default_default_pu;

CREATE INDEX IF NOT EXISTS idx_monitor_default_default_pu
    ON camdecmps.monitor_default USING btree
    (default_purpose_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_monitor_default_default_so

-- DROP INDEX camdecmps.idx_monitor_default_default_so;

CREATE INDEX IF NOT EXISTS idx_monitor_default_default_so
    ON camdecmps.monitor_default USING btree
    (default_source_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_monitor_default_default_uo

-- DROP INDEX camdecmps.idx_monitor_default_default_uo;

CREATE INDEX IF NOT EXISTS idx_monitor_default_default_uo
    ON camdecmps.monitor_default USING btree
    (default_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_monitor_default_fuel_cd

-- DROP INDEX camdecmps.idx_monitor_default_fuel_cd;

CREATE INDEX IF NOT EXISTS idx_monitor_default_fuel_cd
    ON camdecmps.monitor_default USING btree
    (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_monitor_default_loc_prp

-- DROP INDEX camdecmps.idx_monitor_default_loc_prp;

CREATE INDEX IF NOT EXISTS idx_monitor_default_loc_prp
    ON camdecmps.monitor_default USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST, default_purpose_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_monitor_default_operating

-- DROP INDEX camdecmps.idx_monitor_default_operating;

CREATE INDEX IF NOT EXISTS idx_monitor_default_operating
    ON camdecmps.monitor_default USING btree
    (operating_condition_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: monitor_default_idx$$_15b00006

-- DROP INDEX camdecmps."monitor_default_idx$$_15b00006";

CREATE INDEX IF NOT EXISTS "monitor_default_idx$$_15b00006"
    ON camdecmps.monitor_default USING btree
    (begin_date ASC NULLS LAST, begin_hour ASC NULLS LAST, parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: monitor_default_idx001

-- DROP INDEX camdecmps.monitor_default_idx001;

CREATE INDEX IF NOT EXISTS monitor_default_idx001
    ON camdecmps.monitor_default USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);
