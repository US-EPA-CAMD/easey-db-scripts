CREATE TABLE IF NOT EXISTS camdecmps.monitor_qualification
(
    mon_qual_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    qual_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    begin_date date NOT NULL,
    end_date date,
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_monitor_qualification PRIMARY KEY (mon_qual_id),
    CONSTRAINT fk_monitor_qualification_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    CONSTRAINT fk_monitor_qualification_qual_type_code FOREIGN KEY (qual_type_cd)
        REFERENCES camdecmpsmd.qual_type_code (qual_type_cd) MATCH SIMPLE
);

COMMENT ON TABLE camdecmps.monitor_qualification
    IS 'Special monitoring and testing exemptions and qualifications.';

COMMENT ON COLUMN camdecmps.monitor_qualification.mon_qual_id
    IS 'Unique identifier of a monitoring qualification record. ';

COMMENT ON COLUMN camdecmps.monitor_qualification.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.monitor_qualification.qual_type_cd
    IS 'Code used to identify the qualification type. ';

COMMENT ON COLUMN camdecmps.monitor_qualification.begin_date
    IS 'Date on which information became effective or activity started. ';

COMMENT ON COLUMN camdecmps.monitor_qualification.end_date
    IS 'Last date in which information was effective.  This date will be null for active records. ';

COMMENT ON COLUMN camdecmps.monitor_qualification.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.monitor_qualification.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.monitor_qualification.update_date
    IS 'Date and time in which record was last updated. ';
