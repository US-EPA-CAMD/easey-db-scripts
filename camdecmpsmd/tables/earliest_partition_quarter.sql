CREATE TABLE IF NOT EXISTS camdecmpsmd.earliest_partition_quarter(
    earliest_partition_quarter_id bigint NOT NULL,
    table_name character varying(100) NOT NULL,
    rpt_period_id bigint NOT NULL
);

COMMENT ON TABLE camdecmpsmd.earliest_partition_quarter
    IS 'Lookup table for the earliest partition quarter.';

COMMENT ON COLUMN camdecmpsmd.earliest_partition_quarter.earliest_partition_quarter_id
    IS 'Unique identifier of a earliest partition quarter record.';

COMMENT ON COLUMN camdecmpsmd.earliest_partition_quarter.table_name
    IS 'The related table name.';

COMMENT ON COLUMN camdecmpsmd.earliest_partition_quarter.rpt_period_id
    IS 'Unique identifier of a reporting period record.';