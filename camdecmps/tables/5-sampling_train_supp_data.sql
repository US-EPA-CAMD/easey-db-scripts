-- Table: camdecmps.sampling_train_supp_data

-- DROP TABLE IF EXISTS camdecmps.sampling_train_supp_data;

CREATE TABLE IF NOT EXISTS camdecmps.sampling_train_supp_data
(
    trap_train_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    trap_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    component_id character varying(45) COLLATE pg_catalog."default",
    train_qa_status_cd character varying(10) COLLATE pg_catalog."default" NOT NULL,
    ref_flow_to_sampling_ratio numeric(4,1),
    hg_concentration character varying(30) COLLATE pg_catalog."default",
    sfsr_total_count numeric(38,0),
    sfsr_deviated_count numeric(38,0),
    gfm_total_count numeric(38,0),
    gfm_not_available_count numeric(38,0),
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    sampling_ratio_test_result_cd character varying(7) COLLATE pg_catalog."default",
    CONSTRAINT pk_sampling_train_sd PRIMARY KEY (trap_train_id),
    CONSTRAINT fk_sampling_train_sd_prd FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_sampling_train_sd_rrc FOREIGN KEY (sampling_ratio_test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_sampling_train_sd_tqs FOREIGN KEY (train_qa_status_cd)
        REFERENCES camdecmpsmd.train_qa_status_code (train_qa_status_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_sampling_train_supp_data_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_sampling_train_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_sampling_train_supp_data_sorbent_trap_supp_data FOREIGN KEY (trap_id)
        REFERENCES camdecmps.sorbent_trap_supp_data (trap_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);

COMMENT ON TABLE camdecmps.sampling_train_supp_data
    IS 'Sampling train supplemental data. ';

COMMENT ON COLUMN camdecmps.sampling_train_supp_data.trap_train_id
    IS 'Unique identifier of a sampling train record. ';

COMMENT ON COLUMN camdecmps.sampling_train_supp_data.trap_id
    IS 'Unique identifier of a sorbent trap record. ';

COMMENT ON COLUMN camdecmps.sampling_train_supp_data.component_id
    IS 'Unique identifier of a component record. ';

COMMENT ON COLUMN camdecmps.sampling_train_supp_data.train_qa_status_cd
    IS 'QA status of this sampling train. ';

COMMENT ON COLUMN camdecmps.sampling_train_supp_data.ref_flow_to_sampling_ratio
    IS 'Reference SFSR Ratio. ';

COMMENT ON COLUMN camdecmps.sampling_train_supp_data.hg_concentration
    IS 'Reported mercury concentration. ';

COMMENT ON COLUMN camdecmps.sampling_train_supp_data.sfsr_total_count
    IS 'Total SFSR count for the emission report in which the sampling train was reported.';

COMMENT ON COLUMN camdecmps.sampling_train_supp_data.sfsr_deviated_count
    IS 'Deviated SFSR count for the emission report in which the sampling train was reported.';

COMMENT ON COLUMN camdecmps.sampling_train_supp_data.gfm_total_count
    IS 'Total GFM count for the emission report in which the sampling train was reported.';

COMMENT ON COLUMN camdecmps.sampling_train_supp_data.gfm_not_available_count
    IS 'No Allowed GFM count for the emission report in which the sampling train was reported.';

COMMENT ON COLUMN camdecmps.sampling_train_supp_data.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.sampling_train_supp_data.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmps.sampling_train_supp_data.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.sampling_train_supp_data.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.sampling_train_supp_data.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.sampling_train_supp_data.sampling_ratio_test_result_cd
    IS 'Whether the ratio of the stack gas flow rate to the sampling rate was maintained within the required percentage. ';

-- Index: idx_sampling_train_sd_cmp

-- DROP INDEX IF EXISTS camdecmps.idx_sampling_train_sd_cmp;

CREATE INDEX IF NOT EXISTS idx_sampling_train_sd_cmp
    ON camdecmps.sampling_train_supp_data USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_sampling_train_sd_loc

-- DROP INDEX IF EXISTS camdecmps.idx_sampling_train_sd_loc;

CREATE INDEX IF NOT EXISTS idx_sampling_train_sd_loc
    ON camdecmps.sampling_train_supp_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_sampling_train_sd_prd_loc

-- DROP INDEX IF EXISTS camdecmps.idx_sampling_train_sd_prd_loc;

CREATE INDEX IF NOT EXISTS idx_sampling_train_sd_prd_loc
    ON camdecmps.sampling_train_supp_data USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_sampling_train_sd_rrc

-- DROP INDEX IF EXISTS camdecmps.idx_sampling_train_sd_rrc;

CREATE INDEX IF NOT EXISTS idx_sampling_train_sd_rrc
    ON camdecmps.sampling_train_supp_data USING btree
    (sampling_ratio_test_result_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_sampling_train_sd_tqs

-- DROP INDEX IF EXISTS camdecmps.idx_sampling_train_sd_tqs;

CREATE INDEX IF NOT EXISTS idx_sampling_train_sd_tqs
    ON camdecmps.sampling_train_supp_data USING btree
    (train_qa_status_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_sampling_train_sd_trp

-- DROP INDEX IF EXISTS camdecmps.idx_sampling_train_sd_trp;

CREATE INDEX IF NOT EXISTS idx_sampling_train_sd_trp
    ON camdecmps.sampling_train_supp_data USING btree
    (trap_id COLLATE pg_catalog."default" ASC NULLS LAST);