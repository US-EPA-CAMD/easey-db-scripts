ALTER TABLE camdecmpsmd.earliest_partition_quarter
    ADD CONSTRAINT pk_earliest_partition_quarter_id PRIMARY KEY (earliest_partition_quarter_id),
    ADD CONSTRAINT uq_table_name UNIQUE (table_name),
    ADD CONSTRAINT fk_rpt_period_id FOREIGN KEY (rpt_period_id) REFERENCES camdecmpsmd.reporting_period (rpt_period_id) ON DELETE CASCADE;