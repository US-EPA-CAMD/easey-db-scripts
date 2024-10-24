CREATE TABLE IF NOT EXISTS camdecmps.sampling_train
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
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
) PARTITION BY RANGE (rpt_period_id);

COMMENT ON TABLE camdecmps.sampling_train
    IS 'Sampling train data. ';

COMMENT ON COLUMN camdecmps.sampling_train.trap_train_id
    IS 'Unique identifier of a sampling train record. ';

COMMENT ON COLUMN camdecmps.sampling_train.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmps.sampling_train.component_id
    IS 'Unique identifier of a component record. ';

COMMENT ON COLUMN camdecmps.sampling_train.sorbent_trap_serial_number
    IS 'Serial number of the sorbent trap. ';

COMMENT ON COLUMN camdecmps.sampling_train.main_trap_hg
    IS 'Reported mass of Hg recovered from the main collection section of the sorbent trap. ';

COMMENT ON COLUMN camdecmps.sampling_train.breakthrough_trap_hg
    IS 'Reported mass of Hg recovered from the breakthrough section of the sorbent trap. ';

COMMENT ON COLUMN camdecmps.sampling_train.spike_trap_hg
    IS 'Reported mass of Hg recovered from the spiked section of the sorbent trap. ';

COMMENT ON COLUMN camdecmps.sampling_train.spike_ref_value
    IS 'Reported mass of the pre-sampling Hg spike calculation. ';

COMMENT ON COLUMN camdecmps.sampling_train.total_sample_volume
    IS 'Reported total volume of dry gas metered. ';

COMMENT ON COLUMN camdecmps.sampling_train.ref_flow_to_sampling_ratio
    IS 'Reference SFSR Ratio. ';

COMMENT ON COLUMN camdecmps.sampling_train.hg_concentration
    IS 'Reported mercury concentration. ';

COMMENT ON COLUMN camdecmps.sampling_train.percent_breakthrough
    IS 'Reported percent breakthrough. ';

COMMENT ON COLUMN camdecmps.sampling_train.percent_spike_recovery
    IS 'Reported percent spike recovery. ';

COMMENT ON COLUMN camdecmps.sampling_train.sampling_ratio_test_result_cd
    IS 'Whether the ratio of the stack gas flow rate to the sampling rate was maintained within the required percentage. ';

COMMENT ON COLUMN camdecmps.sampling_train.post_leak_test_result_cd
    IS 'Results of the post-test leak check conducted at the end of the sample collection period. ';

COMMENT ON COLUMN camdecmps.sampling_train.train_qa_status_cd
    IS 'QA status of this sampling train. ';

COMMENT ON COLUMN camdecmps.sampling_train.sample_damage_explanation
    IS 'Reason why the sample could not be analyzed. ';

COMMENT ON COLUMN camdecmps.sampling_train.calc_hg_concentration
    IS 'Calculated mercury concentration. ';

COMMENT ON COLUMN camdecmps.sampling_train.calc_percent_breakthrough
    IS 'Calculated percent breakthrough. ';

COMMENT ON COLUMN camdecmps.sampling_train.calc_percent_spike_recovery
    IS 'Calculated percent spike recovery. ';

COMMENT ON COLUMN camdecmps.sampling_train.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.sampling_train.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.sampling_train.update_date
    IS 'Date and time in which record was last updated. ';
