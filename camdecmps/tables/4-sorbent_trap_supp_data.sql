-- Table: camdecmps.sorbent_trap_supp_data

-- DROP TABLE IF EXISTS camdecmps.sorbent_trap_supp_data;

CREATE TABLE IF NOT EXISTS camdecmps.sorbent_trap_supp_data
(
    trap_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default",
    begin_date date,
    begin_hour numeric(2,0),
    end_date date,
    end_hour numeric(2,0),
    modc_cd character varying(7) COLLATE pg_catalog."default",
    hg_concentration character varying(30) COLLATE pg_catalog."default",
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    delete_ind numeric(1,0) NOT NULL DEFAULT 0,
    sorbent_trap_aps_cd character varying(7) COLLATE pg_catalog."default",
    rata_ind numeric(38,0),
    CONSTRAINT pk_st_supp_data PRIMARY KEY (trap_id),
    CONSTRAINT fk_st_supp_data_aps_cd FOREIGN KEY (sorbent_trap_aps_cd)
        REFERENCES camdecmpsmd.sorbent_trap_aps_code (sorbent_trap_aps_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_st_supp_data_modc_cd FOREIGN KEY (modc_cd)
        REFERENCES camdecmpsmd.modc_code (modc_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_st_supp_data_mon_loc_id FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_st_supp_data_mon_sys_id FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_st_supp_data_rpt_period_id FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.sorbent_trap_supp_data
    IS 'Contains all summary information needed to evaluate sorbent trap data';

COMMENT ON COLUMN camdecmps.sorbent_trap_supp_data.trap_id
    IS 'Unique identifier.';

COMMENT ON COLUMN camdecmps.sorbent_trap_supp_data.mon_sys_id
    IS 'Unique identifier of a monitoring system record. ';

COMMENT ON COLUMN camdecmps.sorbent_trap_supp_data.begin_date
    IS 'Date in which information became effective or activity started. ';

COMMENT ON COLUMN camdecmps.sorbent_trap_supp_data.begin_hour
    IS 'Hour in which information became effective or activity started. ';

COMMENT ON COLUMN camdecmps.sorbent_trap_supp_data.end_date
    IS 'Last date in which information was effective or date in which activity ended. ';

COMMENT ON COLUMN camdecmps.sorbent_trap_supp_data.end_hour
    IS 'Last hour n which information was effective or hour in which activity ended. ';

COMMENT ON COLUMN camdecmps.sorbent_trap_supp_data.modc_cd
    IS 'Code used to identify the method of determination. ';

COMMENT ON COLUMN camdecmps.sorbent_trap_supp_data.hg_concentration
    IS 'Mercury concentration in scientific notation. ';

COMMENT ON COLUMN camdecmps.sorbent_trap_supp_data.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.sorbent_trap_supp_data.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmps.sorbent_trap_supp_data.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmps.sorbent_trap_supp_data.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmps.sorbent_trap_supp_data.update_date
    IS 'Date and time in which record was last updated.';

COMMENT ON COLUMN camdecmps.sorbent_trap_supp_data.delete_ind
    IS 'Indicates whether the supplemental sorbent trap data is in a deleted state, and that ECMPS client synchronization should delete it from the each client.';

COMMENT ON COLUMN camdecmps.sorbent_trap_supp_data.sorbent_trap_aps_cd
    IS 'Code used to identify the sorbent trap APS.';

COMMENT ON COLUMN camdecmps.sorbent_trap_supp_data.rata_ind
    IS 'Indicates whether the sorbent trap was used for a RATA.';

-- Index: idx_st_supp_data_emr

-- DROP INDEX IF EXISTS camdecmps.idx_st_supp_data_emr;

CREATE INDEX IF NOT EXISTS idx_st_supp_data_emr
    ON camdecmps.sorbent_trap_supp_data USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_st_supp_data_modc

-- DROP INDEX IF EXISTS camdecmps.idx_st_supp_data_modc;

CREATE INDEX IF NOT EXISTS idx_st_supp_data_modc
    ON camdecmps.sorbent_trap_supp_data USING btree
    (modc_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_st_supp_data_mon_loc_id

-- DROP INDEX IF EXISTS camdecmps.idx_st_supp_data_mon_loc_id;

CREATE INDEX IF NOT EXISTS idx_st_supp_data_mon_loc_id
    ON camdecmps.sorbent_trap_supp_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_st_supp_data_mon_sys_id

-- DROP INDEX IF EXISTS camdecmps.idx_st_supp_data_mon_sys_id;

CREATE INDEX IF NOT EXISTS idx_st_supp_data_mon_sys_id
    ON camdecmps.sorbent_trap_supp_data USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: st_supp_data_idx001

-- DROP INDEX IF EXISTS camdecmps.st_supp_data_idx001;

CREATE INDEX IF NOT EXISTS st_supp_data_idx001
    ON camdecmps.sorbent_trap_supp_data USING btree
    (rpt_period_id ASC NULLS LAST);