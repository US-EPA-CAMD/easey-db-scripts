CREATE TABLE IF NOT EXISTS camdecmps.nsps4t_annual
(
    nsps4t_ann_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    nsps4t_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    annual_energy_sold numeric(8,0),
    annual_energy_sold_type_cd character varying(7) COLLATE pg_catalog."default",
    annual_potential_output numeric(8,0),
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    userid character varying(160) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
);

COMMENT ON TABLE camdecmps.nsps4t_annual
    IS 'NSPS4T Annual (4th quarter) Information. ';

COMMENT ON COLUMN camdecmps.nsps4t_annual.nsps4t_ann_id
    IS 'Unique identifier of a NSPS4T Annual (4th Quarter) record. ';

COMMENT ON COLUMN camdecmps.nsps4t_annual.nsps4t_sum_id
    IS 'Unique identifier of a NSPS4T Summary record. ';

COMMENT ON COLUMN camdecmps.nsps4t_annual.annual_energy_sold
    IS 'The annual energy sold for the calendar year.';

COMMENT ON COLUMN camdecmps.nsps4t_annual.annual_energy_sold_type_cd
    IS 'Indicates the type of energy sold (i.e. NET or GROSS)';

COMMENT ON COLUMN camdecmps.nsps4t_annual.annual_potential_output
    IS 'The annual potential (energy) output for the calendar year.';

COMMENT ON COLUMN camdecmps.nsps4t_annual.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.nsps4t_annual.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmps.nsps4t_annual.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.nsps4t_annual.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.nsps4t_annual.update_date
    IS 'Date and time in which record was last updated. ';
