CREATE TABLE IF NOT EXISTS camdecmps.nsps4t_compliance_period
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
    CONSTRAINT pk_nsps4t_compliance_period PRIMARY KEY (nsps4t_cmp_id),
    CONSTRAINT fk_nsps4t_compliance_period_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    CONSTRAINT fk_nsps4t_compliance_period_nsps4t_summary FOREIGN KEY (nsps4t_sum_id)
        REFERENCES camdecmps.nsps4t_summary (nsps4t_sum_id) MATCH SIMPLE
        ON DELETE CASCADE,
    CONSTRAINT fk_nsps4t_compliance_period_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    CONSTRAINT fk_nsps4t_compliance_period_units_of_measure_code FOREIGN KEY (co2_emission_rate_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE
);

COMMENT ON TABLE camdecmps.nsps4t_compliance_period
    IS 'NSPS4T (monthly) Compliance Period Information. ';

COMMENT ON COLUMN camdecmps.nsps4t_compliance_period.nsps4t_cmp_id
    IS 'Unique identifier of a NSPS4T Compliance Period record. ';

COMMENT ON COLUMN camdecmps.nsps4t_compliance_period.nsps4t_sum_id
    IS 'Unique identifier of a NSPS4T Summary record. ';

COMMENT ON COLUMN camdecmps.nsps4t_compliance_period.begin_year
    IS 'The year of the first calendar month included in the rolling average for the compliance period.';

COMMENT ON COLUMN camdecmps.nsps4t_compliance_period.begin_month
    IS 'The month the first calendar month included in the rolling average for the compliance period.';

COMMENT ON COLUMN camdecmps.nsps4t_compliance_period.end_year
    IS 'The year of the last calendar month included in the rolling average for the compliance period.';

COMMENT ON COLUMN camdecmps.nsps4t_compliance_period.end_month
    IS 'The month of the last calendar month included in the rolling average for the compliance period.';

COMMENT ON COLUMN camdecmps.nsps4t_compliance_period.avg_co2_emission_rate
    IS '12 month rolling average for compliance month (the end month).';

COMMENT ON COLUMN camdecmps.nsps4t_compliance_period.co2_emission_rate_uom_cd
    IS 'Unit of measure for the 12 month rolling average.';

COMMENT ON COLUMN camdecmps.nsps4t_compliance_period.pct_valid_op_hours
    IS 'Percent of valid hours withing the compliance months.';

COMMENT ON COLUMN camdecmps.nsps4t_compliance_period.co2_violation_ind
    IS 'Indicates whether the 12 month rolling average violated the emission standard fpr the location.';

COMMENT ON COLUMN camdecmps.nsps4t_compliance_period.co2_violation_comment
    IS 'Comment on the violation of the emission standard for the location.';

COMMENT ON COLUMN camdecmps.nsps4t_compliance_period.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.nsps4t_compliance_period.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmps.nsps4t_compliance_period.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.nsps4t_compliance_period.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.nsps4t_compliance_period.update_date
    IS 'Date and time in which record was last updated. ';
