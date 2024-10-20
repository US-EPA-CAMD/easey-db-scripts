CREATE TABLE IF NOT EXISTS camdecmps.monitor_qualification_lme
(
    mon_lme_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_qual_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    qual_data_year numeric(4,0) NOT NULL,
    so2_tons numeric(4,1),
    nox_tons numeric(4,1),
    op_hours numeric(38,0),
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);

COMMENT ON TABLE camdecmps.monitor_qualification_lme
    IS 'Monitoring qualification data that are submitted for low mass emitters.  Record Type 645.';

COMMENT ON COLUMN camdecmps.monitor_qualification_lme.mon_lme_id
    IS 'Unique identifier of a monitoring qualification LME record. ';

COMMENT ON COLUMN camdecmps.monitor_qualification_lme.mon_qual_id
    IS 'Unique identifier of a monitoring qualification record. ';

COMMENT ON COLUMN camdecmps.monitor_qualification_lme.qual_data_year
    IS 'Year corresponding to the qualification data. ';

COMMENT ON COLUMN camdecmps.monitor_qualification_lme.so2_tons
    IS 'Annual SO2 value used to determine qualification. ';

COMMENT ON COLUMN camdecmps.monitor_qualification_lme.nox_tons
    IS 'Annual NOX emissions to determine qualification. ';

COMMENT ON COLUMN camdecmps.monitor_qualification_lme.op_hours
    IS 'Annual number of operating hours used to determine qualification. ';

COMMENT ON COLUMN camdecmps.monitor_qualification_lme.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.monitor_qualification_lme.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.monitor_qualification_lme.update_date
    IS 'Date and time in which record was last updated. ';
