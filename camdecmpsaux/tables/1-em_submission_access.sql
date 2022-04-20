-- Table: camdecmpsaux.em_submission_access

-- DROP TABLE camdecmpsaux.em_submission_access;

CREATE TABLE IF NOT EXISTS camdecmpsaux.em_submission_access
(
    em_sub_access_id numeric(38,0) NOT NULL,
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    access_begin_date date NOT NULL,
    access_end_date date NOT NULL,
    em_sub_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    resub_explanation character varying(4000) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    em_status_cd character varying(7) COLLATE pg_catalog."default",
    data_loaded_flg character varying(1) COLLATE pg_catalog."default",
    sub_availability_cd character varying(7) COLLATE pg_catalog."default",
    CONSTRAINT pk_em_submission_access PRIMARY KEY (em_sub_access_id),
    CONSTRAINT em_submission_access_u01 UNIQUE (mon_plan_id, rpt_period_id, access_begin_date, access_end_date),
    CONSTRAINT em_submission_access_r04 FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmps.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT em_submission_access_r05 FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_em_status_cod_em_submission FOREIGN KEY (em_status_cd)
        REFERENCES camdecmpsmd.em_status_code (em_status_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_em_sub_type_c_em_submission FOREIGN KEY (em_sub_type_cd)
        REFERENCES camdecmpsmd.em_sub_type_code (em_sub_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT em_submission_access_c01 CHECK (access_begin_date <= access_end_date)
);

COMMENT ON TABLE camdecmpsaux.em_submission_access
    IS 'Maintains the windows of submission opportunity for each monitor plan in a given reporting period.';

COMMENT ON COLUMN camdecmpsaux.em_submission_access.em_sub_access_id
    IS ' Unique identifier of an emissions submission access record.';

COMMENT ON COLUMN camdecmpsaux.em_submission_access.mon_plan_id
    IS ' Unique identifier of a monitoring plan record. ';

COMMENT ON COLUMN camdecmpsaux.em_submission_access.rpt_period_id
    IS ' Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmpsaux.em_submission_access.access_begin_date
    IS ' Date and time in which submission access began.';

COMMENT ON COLUMN camdecmpsaux.em_submission_access.access_end_date
    IS ' Date and time in which submission access ended.';

COMMENT ON COLUMN camdecmpsaux.em_submission_access.em_sub_type_cd
    IS ' Code used to identify the emission submission type code.';

COMMENT ON COLUMN camdecmpsaux.em_submission_access.resub_explanation
    IS ' Explanation of reason for resubmission of emissions data.';

COMMENT ON COLUMN camdecmpsaux.em_submission_access.userid
    IS ' User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmpsaux.em_submission_access.add_date
    IS ' Date and time in which record was added.';

COMMENT ON COLUMN camdecmpsaux.em_submission_access.update_date
    IS ' Date and time in which record was last updated.';

COMMENT ON COLUMN camdecmpsaux.em_submission_access.em_status_cd
    IS ' Code used to identify the emissions status.';

COMMENT ON COLUMN camdecmpsaux.em_submission_access.data_loaded_flg
    IS ' Flag indicating if the data are loaded.';

COMMENT ON COLUMN camdecmpsaux.em_submission_access.sub_availability_cd
    IS 'Identity key for SUBMISSION_AVAILABILITY_CODE table';

-- Index: em_submission_a_idx$$_15a60001

-- DROP INDEX camdecmpsaux."em_submission_a_idx$$_15a60001";

CREATE INDEX "em_submission_a_idx$$_15a60001"
    ON camdecmpsaux.em_submission_access USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST, rpt_period_id ASC NULLS LAST);

-- Index: idx_em_submission_a_em_status_

-- DROP INDEX camdecmpsaux.idx_em_submission_a_em_status_;

CREATE INDEX idx_em_submission_a_em_status_
    ON camdecmpsaux.em_submission_access USING btree
    (em_status_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_em_submission_a_em_sub_typ

-- DROP INDEX camdecmpsaux.idx_em_submission_a_em_sub_typ;

CREATE INDEX idx_em_submission_a_em_sub_typ
    ON camdecmpsaux.em_submission_access USING btree
    (em_sub_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_em_submission_access_0729

-- DROP INDEX camdecmpsaux.idx_em_submission_access_0729;

CREATE INDEX idx_em_submission_access_0729
    ON camdecmpsaux.em_submission_access USING btree
    (rpt_period_id ASC NULLS LAST);
