CREATE TABLE IF NOT EXISTS camdecmpswks.trans_accuracy
(
    trans_ac_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    low_level_accuracy numeric(5,1),
    mid_level_accuracy numeric(5,1),
    high_level_accuracy numeric(5,1),
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    low_level_accuracy_spec_cd character varying(7) COLLATE pg_catalog."default",
    mid_level_accuracy_spec_cd character varying(7) COLLATE pg_catalog."default",
    high_level_accuracy_spec_cd character varying(7) COLLATE pg_catalog."default"
);
