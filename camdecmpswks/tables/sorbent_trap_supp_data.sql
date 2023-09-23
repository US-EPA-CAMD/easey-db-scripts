CREATE TABLE IF NOT EXISTS camdecmpswks.sorbent_trap_supp_data
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
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    delete_ind numeric(1,0) NOT NULL DEFAULT 0,
    sorbent_trap_aps_cd character varying(7) COLLATE pg_catalog."default",
    rata_ind numeric(38,0)
);

COMMENT ON TABLE camdecmpswks.sorbent_trap_supp_data
    IS 'Contains all summary information needed to evaluate sorbent trap data';

COMMENT ON COLUMN camdecmpswks.sorbent_trap_supp_data.trap_id
    IS 'Unique identifier.';

COMMENT ON COLUMN camdecmpswks.sorbent_trap_supp_data.mon_sys_id
    IS 'Unique identifier of a monitoring system record. ';

COMMENT ON COLUMN camdecmpswks.sorbent_trap_supp_data.begin_date
    IS 'Date in which information became effective or activity started. ';

COMMENT ON COLUMN camdecmpswks.sorbent_trap_supp_data.begin_hour
    IS 'Hour in which information became effective or activity started. ';

COMMENT ON COLUMN camdecmpswks.sorbent_trap_supp_data.end_date
    IS 'Last date in which information was effective or date in which activity ended. ';

COMMENT ON COLUMN camdecmpswks.sorbent_trap_supp_data.end_hour
    IS 'Last hour n which information was effective or hour in which activity ended. ';

COMMENT ON COLUMN camdecmpswks.sorbent_trap_supp_data.modc_cd
    IS 'Code used to identify the method of determination. ';

COMMENT ON COLUMN camdecmpswks.sorbent_trap_supp_data.hg_concentration
    IS 'Mercury concentration in scientific notation. ';

COMMENT ON COLUMN camdecmpswks.sorbent_trap_supp_data.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmpswks.sorbent_trap_supp_data.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmpswks.sorbent_trap_supp_data.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmpswks.sorbent_trap_supp_data.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmpswks.sorbent_trap_supp_data.update_date
    IS 'Date and time in which record was last updated.';

COMMENT ON COLUMN camdecmpswks.sorbent_trap_supp_data.delete_ind
    IS 'Indicates whether the supplemental sorbent trap data is in a deleted state, and that ECMPS client synchronization should delete it from the each client.';

COMMENT ON COLUMN camdecmpswks.sorbent_trap_supp_data.sorbent_trap_aps_cd
    IS 'Code used to identify the sorbent trap APS.';

COMMENT ON COLUMN camdecmpswks.sorbent_trap_supp_data.rata_ind
    IS 'Indicates whether the sorbent trap was used for a RATA.';
