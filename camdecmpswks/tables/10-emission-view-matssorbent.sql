-- Table: camdecmpswks.emission_view_matssorbent

-- DROP TABLE camdecmpswks.emission_view_matssorbent;

CREATE TABLE IF NOT EXISTS camdecmpswks.emission_view_matssorbent
(
    em_mats_sorbent_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id integer NOT NULL,
    system_identifier character varying(3) COLLATE pg_catalog."default" NOT NULL,
    date_hour character varying(25) COLLATE pg_catalog."default" NOT NULL,
    end_date_time character varying(25) COLLATE pg_catalog."default" NOT NULL,
    paired_trap_agreement numeric(5,2),
    absolute_difference_ind integer,
    modc_cd character varying(7) COLLATE pg_catalog."default",
    hg_concentration character varying(30) COLLATE pg_catalog."default",
    a_component_id character varying(45) COLLATE pg_catalog."default",
    a_sorbent_trap_serial_number character varying(45) COLLATE pg_catalog."default",
    a_main_trap_hg character varying(30) COLLATE pg_catalog."default",
    a_breakthrough_trap_hg character varying(30) COLLATE pg_catalog."default",
    a_spike_trap_hg character varying(30) COLLATE pg_catalog."default",
    a_spike_ref_value character varying(30) COLLATE pg_catalog."default",
    a_total_sample_volume double precision,
    a_ref_flow_to_sampling_ratio numeric(4,1),
    a_hg_concentration character varying(30) COLLATE pg_catalog."default",
    a_percent_breakthrough numeric(6,1),
    a_percent_spike_recovery numeric(4,1),
    a_sampling_ratio_test_result_cd character varying(7) COLLATE pg_catalog."default",
    a_post_leak_test_result_cd character varying(7) COLLATE pg_catalog."default",
    a_train_qa_status_cd character varying(10) COLLATE pg_catalog."default" NOT NULL,
    a_sample_damage_explanation character varying(1000) COLLATE pg_catalog."default",
    b_component_id character varying(45) COLLATE pg_catalog."default",
    b_sorbent_trap_serial_number character varying(45) COLLATE pg_catalog."default",
    b_main_trap_hg character varying(30) COLLATE pg_catalog."default",
    b_breakthrough_trap_hg character varying(30) COLLATE pg_catalog."default",
    b_spike_trap_hg character varying(30) COLLATE pg_catalog."default",
    b_spike_ref_value character varying(30) COLLATE pg_catalog."default",
    b_total_sample_volume double precision,
    b_ref_flow_to_sampling_ratio numeric(4,1),
    b_hg_concentration character varying(30) COLLATE pg_catalog."default",
    b_percent_breakthrough numeric(6,1),
    b_percent_spike_recovery numeric(4,1),
    b_sampling_ratio_test_result_cd character varying(7) COLLATE pg_catalog."default",
    b_post_leak_test_result_cd character varying(7) COLLATE pg_catalog."default",
    b_train_qa_status_cd character varying(10) COLLATE pg_catalog."default" NOT NULL,
    b_sample_damage_explanation character varying(1000) COLLATE pg_catalog."default",
    error_codes character varying(1000) COLLATE pg_catalog."default",
    sorbent_trap_aps_cd character varying(7) COLLATE pg_catalog."default",
    rata_ind integer,
    CONSTRAINT pk_emission_view_mats_sorbent PRIMARY KEY (em_mats_sorbent_id),
    CONSTRAINT fk_emission_view_mats_sorbent_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_emission_view_mats_sorbent_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmpswks.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);