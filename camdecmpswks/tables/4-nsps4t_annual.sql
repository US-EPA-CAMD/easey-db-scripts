-- Table: camdecmpswks.nsps4t_annual

-- DROP TABLE IF EXISTS camdecmpswks.nsps4t_annual;

CREATE TABLE IF NOT EXISTS camdecmpswks.nsps4t_annual
(
    nsps4t_ann_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    nsps4t_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    annual_energy_sold numeric(8,0),
    annual_energy_sold_type_cd character varying(7) COLLATE pg_catalog."default",
    annual_potential_output numeric(8,0),
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    userid character varying(25) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone,
    CONSTRAINT pk_nsps4t_annual PRIMARY KEY (nsps4t_ann_id),
    CONSTRAINT fk_nsps4t_annual_loc FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_nsps4t_annual_prd FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_nsps4t_annual_sum FOREIGN KEY (nsps4t_sum_id)
        REFERENCES camdecmpswks.nsps4t_summary (nsps4t_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_nsps4t_annual_uom FOREIGN KEY (annual_energy_sold_type_cd)
        REFERENCES camdecmpsmd.nsps4t_electrical_load_code (electrical_load_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmpswks.nsps4t_annual
    IS 'NSPS4T Annual (4th quarter) Information. ';

COMMENT ON COLUMN camdecmpswks.nsps4t_annual.nsps4t_ann_id
    IS 'Unique identifier of a NSPS4T Annual (4th Quarter) record. ';

COMMENT ON COLUMN camdecmpswks.nsps4t_annual.nsps4t_sum_id
    IS 'Unique identifier of a NSPS4T Summary record. ';

COMMENT ON COLUMN camdecmpswks.nsps4t_annual.annual_energy_sold
    IS 'The annual energy sold for the calendar year.';

COMMENT ON COLUMN camdecmpswks.nsps4t_annual.annual_energy_sold_type_cd
    IS 'Indicates the type of energy sold (i.e. NET or GROSS)';

COMMENT ON COLUMN camdecmpswks.nsps4t_annual.annual_potential_output
    IS 'The annual potential (energy) output for the calendar year.';

COMMENT ON COLUMN camdecmpswks.nsps4t_annual.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmpswks.nsps4t_annual.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmpswks.nsps4t_annual.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmpswks.nsps4t_annual.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmpswks.nsps4t_annual.update_date
    IS 'Date and time in which record was last updated. ';

-- Index: idx_nsps4t_annual_loc

-- DROP INDEX IF EXISTS camdecmpswks.idx_nsps4t_annual_loc;

CREATE INDEX IF NOT EXISTS idx_nsps4t_annual_loc
    ON camdecmpswks.nsps4t_annual USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_nsps4t_annual_prd

-- DROP INDEX IF EXISTS camdecmpswks.idx_nsps4t_annual_prd;

CREATE INDEX IF NOT EXISTS idx_nsps4t_annual_prd
    ON camdecmpswks.nsps4t_annual USING btree
    (rpt_period_id ASC NULLS LAST);

-- Index: idx_nsps4t_annual_rpt

-- DROP INDEX IF EXISTS camdecmpswks.idx_nsps4t_annual_rpt;

CREATE INDEX IF NOT EXISTS idx_nsps4t_annual_rpt
    ON camdecmpswks.nsps4t_annual USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_nsps4t_annual_sum

-- DROP INDEX IF EXISTS camdecmpswks.idx_nsps4t_annual_sum;

CREATE INDEX IF NOT EXISTS idx_nsps4t_annual_sum
    ON camdecmpswks.nsps4t_annual USING btree
    (nsps4t_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_nsps4t_annual_uom

-- DROP INDEX IF EXISTS camdecmpswks.idx_nsps4t_annual_uom;

CREATE INDEX IF NOT EXISTS idx_nsps4t_annual_uom
    ON camdecmpswks.nsps4t_annual USING btree
    (annual_energy_sold_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);