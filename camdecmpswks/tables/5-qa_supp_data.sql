-- Table: camdecmpswks.qa_supp_data

-- DROP TABLE camdecmpswks.qa_supp_data;

CREATE TABLE IF NOT EXISTS camdecmpswks.qa_supp_data
(
    qa_supp_data_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default",
    component_id character varying(45) COLLATE pg_catalog."default",
    test_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default",
    test_reason_cd character varying(7) COLLATE pg_catalog."default",
    test_num character varying(18) COLLATE pg_catalog."default",
    span_scale character varying(10) COLLATE pg_catalog."default",
    begin_date date,
    begin_hour numeric(2,0),
    begin_min numeric(2,0),
    end_date date,
    end_hour numeric(2,0),
    end_min numeric(2,0),
    rpt_period_id numeric(38,0),
    test_result_cd character varying(7) COLLATE pg_catalog."default",
    gp_ind numeric(38,0),
    reinstallation_date date,
    reinstallation_hour numeric(2,0),
    test_expire_date date,
    test_expire_hour numeric(2,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    op_level_cd character varying(7) COLLATE pg_catalog."default",
    updated_status_flg character varying(1) COLLATE pg_catalog."default",    
    submission_id numeric(38,0),
    submission_availability_cd character varying(7) COLLATE pg_catalog."default",
    pending_status_cd character varying(7) COLLATE pg_catalog."default",
    operating_condition_cd character varying(7) COLLATE pg_catalog."default",
    fuel_cd character varying(7) COLLATE pg_catalog."default",
    CONSTRAINT pk_qa_supp_data PRIMARY KEY (qa_supp_data_id),
    CONSTRAINT fk_qa_supp_data_component FOREIGN KEY (component_id)
        REFERENCES camdecmpswks.component (component_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_qa_supp_data_fuel_code FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_qa_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_qa_supp_data_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmpswks.monitor_system (mon_sys_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_qa_supp_data_operating_condition_code FOREIGN KEY (operating_condition_cd)
        REFERENCES camdecmpsmd.operating_condition_code (operating_condition_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_qa_supp_data_operating_level_code FOREIGN KEY (op_level_cd)
        REFERENCES camdecmpsmd.operating_level_code (op_level_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_qa_supp_data_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_qa_supp_data_submission_availability_code FOREIGN KEY (submission_availability_cd)
        REFERENCES camdecmpsmd.submission_availability_code (submission_availability_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_qa_supp_data_pending_status_code FOREIGN KEY (pending_status_cd)
        REFERENCES camdecmpsmd.submission_availability_code (submission_availability_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_qa_supp_data_submission_test_reason_code FOREIGN KEY (test_reason_cd)
        REFERENCES camdecmpsmd.test_reason_code (test_reason_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_qa_supp_data_submission_test_result_code FOREIGN KEY (test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_qa_supp_data_submission_test_type_code FOREIGN KEY (test_type_cd)
        REFERENCES camdecmpsmd.test_type_code (test_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_qa_supp_data_submission_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- -- Index: idx_qa_supp_data_001

-- -- DROP INDEX camdecmpswks.idx_qa_supp_data_001;

-- CREATE INDEX idx_qa_supp_data_001
--     ON camdecmpswks.qa_supp_data USING btree
--     (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_qa_supp_data_chk_sessio

-- -- DROP INDEX camdecmpswks.idx_qa_supp_data_chk_sessio;

-- CREATE INDEX idx_qa_supp_data_chk_sessio
--     ON camdecmpswks.qa_supp_data USING btree
--     (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_qa_supp_data_component

-- -- DROP INDEX camdecmpswks.idx_qa_supp_data_component;

-- CREATE INDEX idx_qa_supp_data_component
--     ON camdecmpswks.qa_supp_data USING btree
--     (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_qa_supp_data_fuel_cd

-- -- DROP INDEX camdecmpswks.idx_qa_supp_data_fuel_cd;

-- CREATE INDEX idx_qa_supp_data_fuel_cd
--     ON camdecmpswks.qa_supp_data USING btree
--     (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_qa_supp_data_mon_loc_id

-- -- DROP INDEX camdecmpswks.idx_qa_supp_data_mon_loc_id;

-- CREATE INDEX idx_qa_supp_data_mon_loc_id
--     ON camdecmpswks.qa_supp_data USING btree
--     (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_qa_supp_data_mon_sys_id

-- -- DROP INDEX camdecmpswks.idx_qa_supp_data_mon_sys_id;

-- CREATE INDEX idx_qa_supp_data_mon_sys_id
--     ON camdecmpswks.qa_supp_data USING btree
--     (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_qa_supp_data_op_level_c

-- -- DROP INDEX camdecmpswks.idx_qa_supp_data_op_level_c;

-- CREATE INDEX idx_qa_supp_data_op_level_c
--     ON camdecmpswks.qa_supp_data USING btree
--     (op_level_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_qa_supp_data_operating_

-- -- DROP INDEX camdecmpswks.idx_qa_supp_data_operating_;

-- CREATE INDEX idx_qa_supp_data_operating_
--     ON camdecmpswks.qa_supp_data USING btree
--     (operating_condition_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_qa_supp_data_submission

-- -- DROP INDEX camdecmpswks.idx_qa_supp_data_submission;

-- CREATE INDEX idx_qa_supp_data_submission
--     ON camdecmpswks.qa_supp_data USING btree
--     (submission_availability_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_qa_supp_data_submission1

-- -- DROP INDEX camdecmpswks.idx_qa_supp_data_submission1;

-- CREATE INDEX idx_qa_supp_data_submission1
--     ON camdecmpswks.qa_supp_data USING btree
--     (submission_id ASC NULLS LAST);

-- -- Index: idx_qa_supp_data_test_reaso

-- -- DROP INDEX camdecmpswks.idx_qa_supp_data_test_reaso;

-- CREATE INDEX idx_qa_supp_data_test_reaso
--     ON camdecmpswks.qa_supp_data USING btree
--     (test_reason_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_qa_supp_data_test_resul

-- -- DROP INDEX camdecmpswks.idx_qa_supp_data_test_resul;

-- CREATE INDEX idx_qa_supp_data_test_resul
--     ON camdecmpswks.qa_supp_data USING btree
--     (test_result_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_qa_supp_data_test_type

-- -- DROP INDEX camdecmpswks.idx_qa_supp_data_test_type;

-- CREATE INDEX idx_qa_supp_data_test_type
--     ON camdecmpswks.qa_supp_data USING btree
--     (test_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: qa_supp_data_idx001

-- -- DROP INDEX camdecmpswks.qa_supp_data_idx001;

-- CREATE INDEX qa_supp_data_idx001
--     ON camdecmpswks.qa_supp_data USING btree
--     (rpt_period_id ASC NULLS LAST);
