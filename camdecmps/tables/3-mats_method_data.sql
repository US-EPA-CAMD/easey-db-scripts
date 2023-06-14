-- Table: camdecmps.mats_method_data

-- DROP TABLE camdecmps.mats_method_data;

CREATE TABLE IF NOT EXISTS camdecmps.mats_method_data
(
    mats_method_data_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mats_method_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    mats_method_parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    begin_date date NOT NULL,
    begin_hour numeric(2,0) NOT NULL,
    end_date date,
    end_hour numeric(2,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_mats_method_data PRIMARY KEY (mats_method_data_id),
    CONSTRAINT fk_mats_method_data_mats_method_code FOREIGN KEY (mats_method_cd)
        REFERENCES camdecmpsmd.mats_method_code (mats_method_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_mats_method_data_mats_method_parameter_code FOREIGN KEY (mats_method_parameter_cd)
        REFERENCES camdecmpsmd.mats_method_parameter_code (mats_method_parameter_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_mats_method_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);

COMMENT ON TABLE camdecmps.mats_method_data
    IS 'Identifies each MATS Compliance Method for a particular MATS parameter at a location.';

COMMENT ON COLUMN camdecmps.mats_method_data.mats_method_data_id
    IS 'Unique identifier of a MATS compliance method record.';

COMMENT ON COLUMN camdecmps.mats_method_data.mon_loc_id
    IS 'Unique identifier of a monitoring location record.';

COMMENT ON COLUMN camdecmps.mats_method_data.mats_method_cd
    IS 'Code used to identify the MATS compliance methodology.';

COMMENT ON COLUMN camdecmps.mats_method_data.mats_method_parameter_cd
    IS 'Code used to identify the MATS parameter.';

COMMENT ON COLUMN camdecmps.mats_method_data.begin_date
    IS 'Date on which information became effective or activity started.';

COMMENT ON COLUMN camdecmps.mats_method_data.begin_hour
    IS 'Hour in which information became effective.';

COMMENT ON COLUMN camdecmps.mats_method_data.end_date
    IS 'Last date in which information was effective. This date will be null for active records.';

COMMENT ON COLUMN camdecmps.mats_method_data.end_hour
    IS 'Last hour in which information was effective. This value will be null for active records.';

COMMENT ON COLUMN camdecmps.mats_method_data.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmps.mats_method_data.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmps.mats_method_data.update_date
    IS 'Date and time in which record was last updated.';

-- Index: mats_method_data_method_cd

-- DROP INDEX camdecmps.mats_method_data_method_cd;

CREATE INDEX IF NOT EXISTS mats_method_data_method_cd
    ON camdecmps.mats_method_data USING btree
    (mats_method_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: mats_method_data_mon_loc_id

-- DROP INDEX camdecmps.mats_method_data_mon_loc_id;

CREATE INDEX IF NOT EXISTS mats_method_data_mon_loc_id
    ON camdecmps.mats_method_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: mats_method_data_param_cd

-- DROP INDEX camdecmps.mats_method_data_param_cd;

CREATE INDEX IF NOT EXISTS mats_method_data_param_cd
    ON camdecmps.mats_method_data USING btree
    (mats_method_parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);
