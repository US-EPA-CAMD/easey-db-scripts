CREATE TABLE IF NOT EXISTS camdecmpsaux.apportionment
(
    apport_id numeric(38,0) NOT NULL,
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    begin_rpt_period_id numeric(38,0) NOT NULL,
    end_rpt_period_id numeric(38,0),
    userid character varying(25) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone,
    CONSTRAINT pk_apportionment PRIMARY KEY (apport_id),
    CONSTRAINT fk_apportionment_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmps.monitor_plan (mon_plan_id) MATCH SIMPLE,
    CONSTRAINT fk_apportionment_begin_rpt_period_id FOREIGN KEY (begin_rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    CONSTRAINT fk_apportionment_end_rpt_period_id FOREIGN KEY (end_rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
);

COMMENT ON TABLE camdecmpsaux.apportionment
    IS 'The apportionment data parent table for a specific monitoring plan and  reporting period range.';

COMMENT ON COLUMN camdecmpsaux.apportionment.apport_id
    IS 'Unique identifier of an apportionment record.';

COMMENT ON COLUMN camdecmpsaux.apportionment.mon_plan_id
    IS 'Unique identifier of a monitoring plan record. ';

COMMENT ON COLUMN camdecmpsaux.apportionment.begin_rpt_period_id
    IS 'Unique identifier of a reporting period record indicating the beginning of the applicable period for the apportionment data.';

COMMENT ON COLUMN camdecmpsaux.apportionment.end_rpt_period_id
    IS 'Unique identifier of a reporting period record indicating the ending of the applicable period for the apportionment data.';

COMMENT ON COLUMN camdecmpsaux.apportionment.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmpsaux.apportionment.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmpsaux.apportionment.update_date
    IS 'Date and time in which record was last updated. ';
