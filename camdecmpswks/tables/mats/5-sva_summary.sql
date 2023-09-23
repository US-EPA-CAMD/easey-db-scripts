-- Table: camdecmpswks.sva_summary

-- DROP TABLE camdecmpswks.sva_summary;

CREATE TABLE IF NOT EXISTS camdecmpswks.sva_summary
(
    sva_sum_id character varying(45) NOT NULL,
    test_sum_id character varying(45) NOT NULL,
    sample_volume_uom_cd character varying(7) NOT NULL,
    mean_cems_sample_volume numeric(15,5),
    mean_ref_sample_volume numeric(15,5),
    percent_error numeric(5,1),
    userid character varying(160),
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_sva_summary PRIMARY KEY (sva_sum_id),
    CONSTRAINT fk_sva_summary_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE,
    CONSTRAINT fk_sva_summary_sample_volume_uom FOREIGN KEY (sample_volume_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE,
    CONSTRAINT ck_sva_summary_sample_volume_uom_code CHECK (sample_volume_uom_cd = ANY(ARRAY['DSCF', 'DSCM', 'SCF', 'SCM']))
);
