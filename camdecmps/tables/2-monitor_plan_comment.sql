-- Table: camdecmps.monitor_plan_comment

-- DROP TABLE camdecmps.monitor_plan_comment;

CREATE TABLE IF NOT EXISTS camdecmps.monitor_plan_comment
(
    mon_plan_comment_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_plan_comment character varying(4000) COLLATE pg_catalog."default" NOT NULL,
    begin_date date NOT NULL,
    end_date date,
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    submission_availability_cd character varying(7) COLLATE pg_catalog."default",
    update_date timestamp without time zone,
    CONSTRAINT pk_monitor_plan_comment PRIMARY KEY (mon_plan_comment_id),
    CONSTRAINT fk_monitor_plan_comment_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmps.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_plan_comment_submission_availability_code FOREIGN KEY (submission_availability_cd)
        REFERENCES camdecmpsmd.submission_availability_code (submission_availability_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.monitor_plan_comment
    IS 'History of comments made regarding a Monitor Plan.';

COMMENT ON COLUMN camdecmps.monitor_plan_comment.mon_plan_comment_id
    IS 'Unique identifier of a monitoring plan comment record. ';

COMMENT ON COLUMN camdecmps.monitor_plan_comment.mon_plan_id
    IS 'Unique identifier of a monitoring plan record. ';

COMMENT ON COLUMN camdecmps.monitor_plan_comment.mon_plan_comment
    IS 'Comment on a monitoring plan ';

COMMENT ON COLUMN camdecmps.monitor_plan_comment.begin_date
    IS 'Date and time in which an activity started or ended. ';

COMMENT ON COLUMN camdecmps.monitor_plan_comment.end_date
    IS 'Last date in which information was effective.  This date will be null for active records. ';

COMMENT ON COLUMN camdecmps.monitor_plan_comment.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.monitor_plan_comment.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.monitor_plan_comment.submission_availability_cd
    IS 'Code used to identify the submission availability of the data.';

COMMENT ON COLUMN camdecmps.monitor_plan_comment.update_date
    IS 'Date and time in which record was last updated.';

-- Index: idx_monitor_plan_comment_mon_plan_id

-- DROP INDEX camdecmps.idx_monitor_plan_comment_mon_plan_id;

CREATE INDEX idx_monitor_plan_comment_mon_plan_id
    ON camdecmps.monitor_plan_comment USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);
