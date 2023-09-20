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
    update_date timestamp without time zone
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
