CREATE TABLE IF NOT EXISTS camdecmps.sorbent_trap
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
    rata_ind numeric(38,0),
    CONSTRAINT pk_sorbent_trap PRIMARY KEY (trap_id),
    CONSTRAINT fk_sorbent_trap_modc_code FOREIGN KEY (modc_cd)
        REFERENCES camdecmpsmd.modc_code (modc_cd) MATCH SIMPLE,
    CONSTRAINT fk_sorbent_trap_modc_code_calc FOREIGN KEY (calc_modc_cd)
        REFERENCES camdecmpsmd.modc_code (modc_cd) MATCH SIMPLE,
    CONSTRAINT fk_sorbent_trap_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    CONSTRAINT fk_sorbent_trap_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE,
    CONSTRAINT fk_sorbent_trap_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    CONSTRAINT fk_sorbent_trap_sorbent_trap_aps_code FOREIGN KEY (sorbent_trap_aps_cd)
        REFERENCES camdecmpsmd.sorbent_trap_aps_code (sorbent_trap_aps_cd) MATCH SIMPLE
);

COMMENT ON TABLE camdecmps.sorbent_trap
    IS 'Sorbent trap data. ';

COMMENT ON COLUMN camdecmps.sorbent_trap.trap_id
    IS 'Unique identifier of a sorbent trap record. ';

COMMENT ON COLUMN camdecmps.sorbent_trap.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.sorbent_trap.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmps.sorbent_trap.begin_date
    IS 'Begin date of the sorbent trap. ';

COMMENT ON COLUMN camdecmps.sorbent_trap.begin_hour
    IS 'Begin hour of the sorbent trap. ';

COMMENT ON COLUMN camdecmps.sorbent_trap.end_date
    IS 'End date of the sorbent trap. ';

COMMENT ON COLUMN camdecmps.sorbent_trap.end_hour
    IS 'End hour of the sorbent trap. ';

COMMENT ON COLUMN camdecmps.sorbent_trap.mon_sys_id
    IS 'Unique identifier of a monitoring system. ';

COMMENT ON COLUMN camdecmps.sorbent_trap.paired_trap_agreement
    IS 'Reported trap agreement. ';

COMMENT ON COLUMN camdecmps.sorbent_trap.absolute_difference_ind
    IS 'Indicator that paired trap agreement is reported in absolute difference rather than a percentage. ';

COMMENT ON COLUMN camdecmps.sorbent_trap.modc_cd
    IS 'Code used to identify the method of determination. ';

COMMENT ON COLUMN camdecmps.sorbent_trap.hg_concentration
    IS 'Reported mercury concentraion. ';

COMMENT ON COLUMN camdecmps.sorbent_trap.calc_paired_trap_agreement
    IS 'Calculated trap agreement. ';

COMMENT ON COLUMN camdecmps.sorbent_trap.calc_modc_cd
    IS 'Code used to identify the method of determination. ';

COMMENT ON COLUMN camdecmps.sorbent_trap.calc_hg_concentration
    IS 'Calculated mercury concentration. ';

COMMENT ON COLUMN camdecmps.sorbent_trap.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.sorbent_trap.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.sorbent_trap.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.sorbent_trap.sorbent_trap_aps_cd
    IS 'Code used to identify the sorbent trap APS.';

COMMENT ON COLUMN camdecmps.sorbent_trap.rata_ind
    IS 'Indicates whether the sorbent trap was used for a RATA.';
