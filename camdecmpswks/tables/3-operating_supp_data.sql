-- Table: camdecmpswks.operating_supp_data

-- DROP TABLE camdecmpswks.operating_supp_data;

CREATE TABLE IF NOT EXISTS camdecmpswks.operating_supp_data
(
    op_supp_data_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    fuel_cd character varying(7) COLLATE pg_catalog."default",
    op_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    op_value numeric(13,3),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_operating_supp_data PRIMARY KEY (op_supp_data_id),
    CONSTRAINT fk_fuel_code_operating_sup FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_locat_operating_sup FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_operating_typ_operating_sup FOREIGN KEY (op_type_cd)
        REFERENCES camdecmpsmd.operating_type_code (op_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_reporting_per_operating_sup FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmpswks.operating_supp_data
    IS 'Contains summary information about unit/stack/pipe operating hours and fuel hours by quarter for use by the emissions evaluation routines';

COMMENT ON COLUMN camdecmpswks.operating_supp_data.op_supp_data_id
    IS 'Unique identifier of an operating supplemental data record. ';

COMMENT ON COLUMN camdecmpswks.operating_supp_data.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmpswks.operating_supp_data.fuel_cd
    IS 'Code used to identify the type of fuel. ';

COMMENT ON COLUMN camdecmpswks.operating_supp_data.op_type_cd
    IS 'Code used to identify the operating type. ';

COMMENT ON COLUMN camdecmpswks.operating_supp_data.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmpswks.operating_supp_data.op_value
    IS 'Number of hours (or other units) corresponding to the calendar year, quarter and operating type code. ';

COMMENT ON COLUMN camdecmpswks.operating_supp_data.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmpswks.operating_supp_data.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmpswks.operating_supp_data.update_date
    IS 'Date and time in which record was last updated.';
-- Index: idx_operating_supp_data_emr

-- DROP INDEX camdecmpswks.idx_operating_supp_data_emr;

CREATE INDEX idx_operating_supp_data_emr
    ON camdecmpswks.operating_supp_data USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_operating_supp_fuel_cd

-- DROP INDEX camdecmpswks.idx_operating_supp_fuel_cd;

CREATE INDEX idx_operating_supp_fuel_cd
    ON camdecmpswks.operating_supp_data USING btree
    (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_operating_supp_mon_loc_id

-- DROP INDEX camdecmpswks.idx_operating_supp_mon_loc_id;

CREATE INDEX idx_operating_supp_mon_loc_id
    ON camdecmpswks.operating_supp_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_operating_supp_op_type_cd

-- DROP INDEX camdecmpswks.idx_operating_supp_op_type_cd;

CREATE INDEX idx_operating_supp_op_type_cd
    ON camdecmpswks.operating_supp_data USING btree
    (op_type_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: operating_supp_data_idx001

-- DROP INDEX camdecmpswks.operating_supp_data_idx001;

CREATE INDEX operating_supp_data_idx001
    ON camdecmpswks.operating_supp_data USING btree
    (rpt_period_id ASC NULLS LAST)
    TABLESPACE pg_default;