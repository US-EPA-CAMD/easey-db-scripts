-- Table: camdecmpswks.sampling_train

-- DROP TABLE camdecmpswks.sampling_train;

CREATE TABLE camdecmpswks.sampling_train
(
    trap_train_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    trap_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    component_id character varying(45) COLLATE pg_catalog."default",
    sorbent_trap_serial_number character varying(45) COLLATE pg_catalog."default" NOT NULL,
    main_trap_hg character varying(30) COLLATE pg_catalog."default",
    breakthrough_trap_hg character varying(30) COLLATE pg_catalog."default",
    spike_trap_hg character varying(30) COLLATE pg_catalog."default",
    spike_ref_value character varying(30) COLLATE pg_catalog."default",
    total_sample_volume numeric(14,4),
    ref_flow_to_sampling_ratio numeric(4,1),
    hg_concentration character varying(30) COLLATE pg_catalog."default",
    percent_breakthrough numeric(6,1),
    percent_spike_recovery numeric(4,1),
    sampling_ratio_test_result_cd character varying(7) COLLATE pg_catalog."default",
    post_leak_test_result_cd character varying(7) COLLATE pg_catalog."default",
    train_qa_status_cd character varying(10) COLLATE pg_catalog."default",
    sample_damage_explanation character varying(1000) COLLATE pg_catalog."default",
    calc_hg_concentration character varying(30) COLLATE pg_catalog."default",
    calc_percent_breakthrough numeric(6,1),
    calc_percent_spike_recovery numeric(4,1),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_sampling_train PRIMARY KEY (trap_train_id),
    CONSTRAINT fk_sampling_train_component FOREIGN KEY (component_id)
        REFERENCES camdecmpswks.component (component_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_sampling_train_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_sampling_train_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_sampling_train_sorbent_trap FOREIGN KEY (trap_id)
        REFERENCES camdecmpswks.sorbent_trap (trap_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_sampling_train_test_result_code_post_leak FOREIGN KEY (post_leak_test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_sampling_train_test_result_code_sampling_ratio FOREIGN KEY (sampling_ratio_test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_sampling_train_train_qa_status_code FOREIGN KEY (train_qa_status_cd)
        REFERENCES camdecmpsmd.train_qa_status_code (train_qa_status_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmpswks.sampling_train
    IS 'Sampling train data. ';

COMMENT ON COLUMN camdecmpswks.sampling_train.trap_train_id
    IS 'Unique identifier of a sampling train record. ';

COMMENT ON COLUMN camdecmpswks.sampling_train.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmpswks.sampling_train.component_id
    IS 'Unique identifier of a component record. ';

COMMENT ON COLUMN camdecmpswks.sampling_train.sorbent_trap_serial_number
    IS 'Serial number of the sorbent trap. ';

COMMENT ON COLUMN camdecmpswks.sampling_train.main_trap_hg
    IS 'Reported mass of Hg recovered from the main collection section of the sorbent trap. ';

COMMENT ON COLUMN camdecmpswks.sampling_train.breakthrough_trap_hg
    IS 'Reported mass of Hg recovered from the breakthrough section of the sorbent trap. ';

COMMENT ON COLUMN camdecmpswks.sampling_train.spike_trap_hg
    IS 'Reported mass of Hg recovered from the spiked section of the sorbent trap. ';

COMMENT ON COLUMN camdecmpswks.sampling_train.spike_ref_value
    IS 'Reported mass of the pre-sampling Hg spike calculation. ';

COMMENT ON COLUMN camdecmpswks.sampling_train.total_sample_volume
    IS 'Reported total volume of dry gas metered. ';

COMMENT ON COLUMN camdecmpswks.sampling_train.ref_flow_to_sampling_ratio
    IS 'Reference SFSR Ratio. ';

COMMENT ON COLUMN camdecmpswks.sampling_train.hg_concentration
    IS 'Reported mercury concentration. ';

COMMENT ON COLUMN camdecmpswks.sampling_train.percent_breakthrough
    IS 'Reported percent breakthrough. ';

COMMENT ON COLUMN camdecmpswks.sampling_train.percent_spike_recovery
    IS 'Reported percent spike recovery. ';

COMMENT ON COLUMN camdecmpswks.sampling_train.sampling_ratio_test_result_cd
    IS 'Whether the ratio of the stack gas flow rate to the sampling rate was maintained within the required percentage. ';

COMMENT ON COLUMN camdecmpswks.sampling_train.post_leak_test_result_cd
    IS 'Results of the post-test leak check conducted at the end of the sample collection period. ';

COMMENT ON COLUMN camdecmpswks.sampling_train.train_qa_status_cd
    IS 'QA status of this sampling train. ';

COMMENT ON COLUMN camdecmpswks.sampling_train.sample_damage_explanation
    IS 'Reason why the sample could not be analyzed. ';

COMMENT ON COLUMN camdecmpswks.sampling_train.calc_hg_concentration
    IS 'Calculated mercury concentration. ';

COMMENT ON COLUMN camdecmpswks.sampling_train.calc_percent_breakthrough
    IS 'Calculated percent breakthrough. ';

COMMENT ON COLUMN camdecmpswks.sampling_train.calc_percent_spike_recovery
    IS 'Calculated percent spike recovery. ';

COMMENT ON COLUMN camdecmpswks.sampling_train.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmpswks.sampling_train.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmpswks.sampling_train.update_date
    IS 'Date and time in which record was last updated. ';
-- Index: idx_sampling_train_001

-- DROP INDEX camdecmpswks.idx_sampling_train_001;

CREATE INDEX idx_sampling_train_001
    ON camdecmpswks.sampling_train USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_sampling_train_trp

-- DROP INDEX camdecmpswks.idx_sampling_train_trp;

CREATE INDEX idx_sampling_train_trp
    ON camdecmpswks.sampling_train USING btree
    (trap_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_train_add_date

-- DROP INDEX camdecmpswks.idx_train_add_date;

CREATE INDEX idx_train_add_date
    ON camdecmpswks.sampling_train USING btree
    (add_date ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_train_component_id

-- DROP INDEX camdecmpswks.idx_train_component_id;

CREATE INDEX idx_train_component_id
    ON camdecmpswks.sampling_train USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;