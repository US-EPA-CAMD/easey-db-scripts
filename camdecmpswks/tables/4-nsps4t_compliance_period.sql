-- Table: camdecmpswks.nsps4t_compliance_period

-- DROP TABLE IF EXISTS camdecmpswks.nsps4t_compliance_period;

CREATE TABLE IF NOT EXISTS camdecmpswks.nsps4t_compliance_period
(
    nsps4t_cmp_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    nsps4t_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    begin_year numeric(4,0),
    begin_month numeric(2,0),
    end_year numeric(4,0),
    end_month numeric(2,0),
    avg_co2_emission_rate numeric(5,0),
    co2_emission_rate_uom_cd character varying(7) COLLATE pg_catalog."default",
    pct_valid_op_hours numeric(4,1),
    co2_violation_ind numeric(1,0),
    co2_violation_comment character varying(4000) COLLATE pg_catalog."default",
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    userid character varying(25) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone,
    CONSTRAINT pk_nsps4t_compliance_prd PRIMARY KEY (nsps4t_cmp_id),
    CONSTRAINT fk_nsps4t_compliance_prd_loc FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_nsps4t_compliance_prd_prd FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_nsps4t_compliance_prd_sum FOREIGN KEY (nsps4t_sum_id)
        REFERENCES camdecmpswks.nsps4t_summary (nsps4t_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_nsps4t_compliance_prd_uom FOREIGN KEY (co2_emission_rate_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmpswks.nsps4t_compliance_period
    IS 'NSPS4T (monthly) Compliance Period Information. ';

COMMENT ON COLUMN camdecmpswks.nsps4t_compliance_period.nsps4t_cmp_id
    IS 'Unique identifier of a NSPS4T Compliance Period record. ';

COMMENT ON COLUMN camdecmpswks.nsps4t_compliance_period.nsps4t_sum_id
    IS 'Unique identifier of a NSPS4T Summary record. ';

COMMENT ON COLUMN camdecmpswks.nsps4t_compliance_period.begin_year
    IS 'The year of the first calendar month included in the rolling average for the compliance period.';

COMMENT ON COLUMN camdecmpswks.nsps4t_compliance_period.begin_month
    IS 'The month the first calendar month included in the rolling average for the compliance period.';

COMMENT ON COLUMN camdecmpswks.nsps4t_compliance_period.end_year
    IS 'The year of the last calendar month included in the rolling average for the compliance period.';

COMMENT ON COLUMN camdecmpswks.nsps4t_compliance_period.end_month
    IS 'The month of the last calendar month included in the rolling average for the compliance period.';

COMMENT ON COLUMN camdecmpswks.nsps4t_compliance_period.avg_co2_emission_rate
    IS '12 month rolling average for compliance month (the end month).';

COMMENT ON COLUMN camdecmpswks.nsps4t_compliance_period.co2_emission_rate_uom_cd
    IS 'Unit of measure for the 12 month rolling average.';

COMMENT ON COLUMN camdecmpswks.nsps4t_compliance_period.pct_valid_op_hours
    IS 'Percent of valid hours withing the compliance months.';

COMMENT ON COLUMN camdecmpswks.nsps4t_compliance_period.co2_violation_ind
    IS 'Indicates whether the 12 month rolling average violated the emission standard fpr the location.';

COMMENT ON COLUMN camdecmpswks.nsps4t_compliance_period.co2_violation_comment
    IS 'Comment on the violation of the emission standard for the location.';

COMMENT ON COLUMN camdecmpswks.nsps4t_compliance_period.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmpswks.nsps4t_compliance_period.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmpswks.nsps4t_compliance_period.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmpswks.nsps4t_compliance_period.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmpswks.nsps4t_compliance_period.update_date
    IS 'Date and time in which record was last updated. ';

-- Index: idx_nsps4t_compliance_prd_loc

-- DROP INDEX IF EXISTS camdecmpswks.idx_nsps4t_compliance_prd_loc;

CREATE INDEX IF NOT EXISTS idx_nsps4t_compliance_prd_loc
    ON camdecmpswks.nsps4t_compliance_period USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_nsps4t_compliance_prd_prd

-- DROP INDEX IF EXISTS camdecmpswks.idx_nsps4t_compliance_prd_prd;

CREATE INDEX IF NOT EXISTS idx_nsps4t_compliance_prd_prd
    ON camdecmpswks.nsps4t_compliance_period USING btree
    (rpt_period_id ASC NULLS LAST);

-- Index: idx_nsps4t_compliance_prd_rpt

-- DROP INDEX IF EXISTS camdecmpswks.idx_nsps4t_compliance_prd_rpt;

CREATE INDEX IF NOT EXISTS idx_nsps4t_compliance_prd_rpt
    ON camdecmpswks.nsps4t_compliance_period USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_nsps4t_compliance_prd_sum

-- DROP INDEX IF EXISTS camdecmpswks.idx_nsps4t_compliance_prd_sum;

CREATE INDEX IF NOT EXISTS idx_nsps4t_compliance_prd_sum
    ON camdecmpswks.nsps4t_compliance_period USING btree
    (nsps4t_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_nsps4t_compliance_prd_uom

-- DROP INDEX IF EXISTS camdecmpswks.idx_nsps4t_compliance_prd_uom;

CREATE INDEX IF NOT EXISTS idx_nsps4t_compliance_prd_uom
    ON camdecmpswks.nsps4t_compliance_period USING btree
    (co2_emission_rate_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);