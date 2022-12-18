-- Table: camdecmpsaux.apportionment_data

-- DROP TABLE camdecmpsaux.apportionment_data;

CREATE TABLE IF NOT EXISTS camdecmpsaux.apportionment_data
(
    apport_data_id numeric(38,0) NOT NULL,
    apport_range_id numeric(38,0) NOT NULL,
    evaluation_order numeric(3,0) NOT NULL,
    condition_xml xml,
    formulae_xml xml,
    subtractive_xml xml,
    CONSTRAINT apportionment_data_pk PRIMARY KEY (apport_data_id),
    CONSTRAINT apportionment_data_rng_fk FOREIGN KEY (apport_range_id)
        REFERENCES camdecmpsaux.apportionment_range (apport_range_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmpsaux.apportionment_data
    IS 'Contains the apportionment formulae and potentially the subtractive specification for an hour range and specific condtion.';

COMMENT ON COLUMN camdecmpsaux.apportionment_data.apport_data_id
    IS 'Unique identifier of an apportionment data record.';

COMMENT ON COLUMN camdecmpsaux.apportionment_data.apport_range_id
    IS 'Unique identifier of an apportionment range record.';

COMMENT ON COLUMN camdecmpsaux.apportionment_data.evaluation_order
    IS 'Indicates the order in which to check aportionment formulae conditions to find a matching set of formulae.';

COMMENT ON COLUMN camdecmpsaux.apportionment_data.condition_xml
    IS 'XML containing the condition information to check to idenitfy the matching formulae to use.';

COMMENT ON COLUMN camdecmpsaux.apportionment_data.formulae_xml
    IS 'The formulae to use for apportionment.';

COMMENT ON COLUMN camdecmpsaux.apportionment_data.subtractive_xml
    IS 'The substractive specification indicating ducts that empty into stacks.';

-- Index: apportionment_data_rng_ix

-- DROP INDEX camdecmpsaux.apportionment_data_rng_ix;

CREATE INDEX IF NOT EXISTS apportionment_data_rng_ix
    ON camdecmpsaux.apportionment_data USING btree
    (apport_range_id ASC NULLS LAST);
