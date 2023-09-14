CREATE TABLE IF NOT EXISTS camdecmpswks.sorbent_trap
(
    trap_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    begin_date date NOT NULL,
    begin_hour numeric(2,0) NOT NULL,
    end_date date NOT NULL,
    end_hour numeric(2,0) NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    paired_trap_agreement numeric(5,2),
    absolute_difference_ind numeric(38,0),
    modc_cd character varying(7) COLLATE pg_catalog."default",
    hg_concentration character varying(30) COLLATE pg_catalog."default",
    calc_paired_trap_agreement numeric(5,2),
    calc_modc_cd character varying(7) COLLATE pg_catalog."default",
    calc_hg_concentration character varying(30) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    sorbent_trap_aps_cd character varying(7) COLLATE pg_catalog."default",
    rata_ind numeric(38,0)
);

COMMENT ON TABLE camdecmpswks.sorbent_trap
    IS 'Sorbent trap data. ';

COMMENT ON COLUMN camdecmpswks.sorbent_trap.trap_id
    IS 'Unique identifier of a sorbent trap record. ';

COMMENT ON COLUMN camdecmpswks.sorbent_trap.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmpswks.sorbent_trap.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmpswks.sorbent_trap.begin_date
    IS 'Begin date of the sorbent trap. ';

COMMENT ON COLUMN camdecmpswks.sorbent_trap.begin_hour
    IS 'Begin hour of the sorbent trap. ';

COMMENT ON COLUMN camdecmpswks.sorbent_trap.end_date
    IS 'End date of the sorbent trap. ';

COMMENT ON COLUMN camdecmpswks.sorbent_trap.end_hour
    IS 'End hour of the sorbent trap. ';

COMMENT ON COLUMN camdecmpswks.sorbent_trap.mon_sys_id
    IS 'Unique identifier of a monitoring system. ';

COMMENT ON COLUMN camdecmpswks.sorbent_trap.paired_trap_agreement
    IS 'Reported trap agreement. ';

COMMENT ON COLUMN camdecmpswks.sorbent_trap.absolute_difference_ind
    IS 'Indicator that paired trap agreement is reported in absolute difference rather than a percentage. ';

COMMENT ON COLUMN camdecmpswks.sorbent_trap.modc_cd
    IS 'Code used to identify the method of determination. ';

COMMENT ON COLUMN camdecmpswks.sorbent_trap.hg_concentration
    IS 'Reported mercury concentraion. ';

COMMENT ON COLUMN camdecmpswks.sorbent_trap.calc_paired_trap_agreement
    IS 'Calculated trap agreement. ';

COMMENT ON COLUMN camdecmpswks.sorbent_trap.calc_modc_cd
    IS 'Code used to identify the method of determination. ';

COMMENT ON COLUMN camdecmpswks.sorbent_trap.calc_hg_concentration
    IS 'Calculated mercury concentration. ';

COMMENT ON COLUMN camdecmpswks.sorbent_trap.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmpswks.sorbent_trap.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmpswks.sorbent_trap.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmpswks.sorbent_trap.sorbent_trap_aps_cd
    IS 'Code used to identify the sorbent trap APS.';

COMMENT ON COLUMN camdecmpswks.sorbent_trap.rata_ind
    IS 'Indicates whether the sorbent trap was used for a RATA.';
