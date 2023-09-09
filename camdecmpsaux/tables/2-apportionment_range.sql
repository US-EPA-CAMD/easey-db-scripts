CREATE TABLE IF NOT EXISTS camdecmpsaux.apportionment_range
(
    apport_range_id numeric(38,0) NOT NULL,
    apport_id numeric(38,0) NOT NULL,
    begin_date timestamp(0) without time zone NOT NULL,
    begin_hour numeric(2,0) NOT NULL,
    end_date timestamp(0) without time zone,
    end_hour numeric(2,0),
    CONSTRAINT pk_apportionment_range PRIMARY KEY (apport_range_id),
    CONSTRAINT fk_apportionment_range_apportionment FOREIGN KEY (apport_id)
        REFERENCES camdecmpsaux.apportionment (apport_id) MATCH SIMPLE
);

COMMENT ON TABLE camdecmpsaux.apportionment_range
    IS 'Contains child hour ranges that together span the reporting period range of a parent apportionment row.';

COMMENT ON COLUMN camdecmpsaux.apportionment_range.apport_range_id
    IS 'Unique identifier of an apportionment range record.';

COMMENT ON COLUMN camdecmpsaux.apportionment_range.apport_id
    IS 'Unique identifier of an apportionment record.';

COMMENT ON COLUMN camdecmpsaux.apportionment_range.begin_date
    IS 'Date of the begin hour of the applicable hour range for the apportionment data.';

COMMENT ON COLUMN camdecmpsaux.apportionment_range.begin_hour
    IS 'Hour of the begin hour of the applicable hour range for the apportionment data.';

COMMENT ON COLUMN camdecmpsaux.apportionment_range.end_date
    IS 'Date of the end hour of the applicable hour range for the apportionment data.';

COMMENT ON COLUMN camdecmpsaux.apportionment_range.end_hour
    IS 'Hour of the end hour of the applicable hour range for the apportionment data.';
