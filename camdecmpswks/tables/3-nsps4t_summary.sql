-- Table: camdecmpswks.nsps4t_summary

-- DROP TABLE IF EXISTS camdecmpswks.nsps4t_summary;

CREATE TABLE IF NOT EXISTS camdecmpswks.nsps4t_summary
(
    nsps4t_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    emission_standard_cd character varying(7) COLLATE pg_catalog."default",
    modus_value numeric(5,0),
    modus_uom_cd character varying(7) COLLATE pg_catalog."default",
    electrical_load_cd character varying(7) COLLATE pg_catalog."default",
    no_period_ended_ind numeric(38,0),
    no_period_ended_comment character varying(4000) COLLATE pg_catalog."default",
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    userid character varying(25) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone,
    CONSTRAINT pk_nsps4t_summary PRIMARY KEY (nsps4t_sum_id),
    CONSTRAINT fk_nsps4t_summary_loc FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_nsps4t_summary_lod FOREIGN KEY (electrical_load_cd)
        REFERENCES camdecmpsmd.nsps4t_electrical_load_code (electrical_load_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_nsps4t_summary_prd FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_nsps4t_summary_stn FOREIGN KEY (emission_standard_cd)
        REFERENCES camdecmpsmd.nsps4t_emission_standard_code (emission_standard_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_nsps4t_summary_uom FOREIGN KEY (modus_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmpswks.nsps4t_summary
    IS 'NSPS4T (quarterly) Summary Information. ';

COMMENT ON COLUMN camdecmpswks.nsps4t_summary.nsps4t_sum_id
    IS 'Unique identifier of a NSPS4T Summary record. ';

COMMENT ON COLUMN camdecmpswks.nsps4t_summary.emission_standard_cd
    IS 'Code used to identify the NSPS4T Emission Standard.';

COMMENT ON COLUMN camdecmpswks.nsps4t_summary.modus_value
    IS 'Standard value for a modified steam generating or IGCC unit with a unit-specific stanrdard.';

COMMENT ON COLUMN camdecmpswks.nsps4t_summary.modus_uom_cd
    IS 'Code used to identify the NSPS4T Mass Rate for a modified steam generating or IGCC unit with a unit-specific stanrdard.';

COMMENT ON COLUMN camdecmpswks.nsps4t_summary.electrical_load_cd
    IS 'Code used to identify the NSPS4T Electrical Load.';

COMMENT ON COLUMN camdecmpswks.nsps4t_summary.no_period_ended_ind
    IS 'Indicates whether a compliance period ended during the reporting period.';

COMMENT ON COLUMN camdecmpswks.nsps4t_summary.no_period_ended_comment
    IS 'Comment about whether a compliance period ended during the reporting period.';

COMMENT ON COLUMN camdecmpswks.nsps4t_summary.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmpswks.nsps4t_summary.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmpswks.nsps4t_summary.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmpswks.nsps4t_summary.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmpswks.nsps4t_summary.update_date
    IS 'Date and time in which record was last updated. ';

-- Index: idx_nsps4t_summary_loc

-- DROP INDEX IF EXISTS camdecmpswks.idx_nsps4t_summary_loc;

CREATE INDEX IF NOT EXISTS idx_nsps4t_summary_loc
    ON camdecmpswks.nsps4t_summary USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_nsps4t_summary_lod

-- DROP INDEX IF EXISTS camdecmpswks.idx_nsps4t_summary_lod;

CREATE INDEX IF NOT EXISTS idx_nsps4t_summary_lod
    ON camdecmpswks.nsps4t_summary USING btree
    (electrical_load_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_nsps4t_summary_prd

-- DROP INDEX IF EXISTS camdecmpswks.idx_nsps4t_summary_prd;

CREATE INDEX IF NOT EXISTS idx_nsps4t_summary_prd
    ON camdecmpswks.nsps4t_summary USING btree
    (rpt_period_id ASC NULLS LAST);

-- Index: idx_nsps4t_summary_rpt

-- DROP INDEX IF EXISTS camdecmpswks.idx_nsps4t_summary_rpt;

CREATE INDEX IF NOT EXISTS idx_nsps4t_summary_rpt
    ON camdecmpswks.nsps4t_summary USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_nsps4t_summary_stn

-- DROP INDEX IF EXISTS camdecmpswks.idx_nsps4t_summary_stn;

CREATE INDEX IF NOT EXISTS idx_nsps4t_summary_stn
    ON camdecmpswks.nsps4t_summary USING btree
    (emission_standard_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_nsps4t_summary_uom

-- DROP INDEX IF EXISTS camdecmpswks.idx_nsps4t_summary_uom;

CREATE INDEX IF NOT EXISTS idx_nsps4t_summary_uom
    ON camdecmpswks.nsps4t_summary USING btree
    (modus_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);