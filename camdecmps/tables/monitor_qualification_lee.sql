CREATE TABLE IF NOT EXISTS camdecmps.monitor_qualification_lee
(
    mon_qual_lee_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_qual_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    qual_test_date date NOT NULL,
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    qual_lee_test_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    potential_annual_emissions numeric(6,1),
    applicable_emission_standard numeric(9,4),
    emission_standard_uom character varying(7) COLLATE pg_catalog."default",
    emission_standard_pct numeric(5,1),
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);

COMMENT ON TABLE camdecmps.monitor_qualification_lee
    IS 'Monitoring qualification data for a MATS Low Emitting EGU (LEE) unit.';

COMMENT ON COLUMN camdecmps.monitor_qualification_lee.mon_qual_lee_id
    IS 'Unique identifier of a monitoring qualification LEE record.';

COMMENT ON COLUMN camdecmps.monitor_qualification_lee.mon_qual_id
    IS 'Unique identifier of a monitoring qualification record.';

COMMENT ON COLUMN camdecmps.monitor_qualification_lee.qual_test_date
    IS 'End date of the initial LEE qualifying test or a retest.';

COMMENT ON COLUMN camdecmps.monitor_qualification_lee.parameter_cd
    IS 'Parameter code associated with the LEE qualification.';

COMMENT ON COLUMN camdecmps.monitor_qualification_lee.qual_lee_test_type_cd
    IS 'Indication of whether the qualifying test was an initial test or retest.';

COMMENT ON COLUMN camdecmps.monitor_qualification_lee.potential_annual_emissions
    IS 'Potential annual mass emissions used for LEE qualification.';

COMMENT ON COLUMN camdecmps.monitor_qualification_lee.applicable_emission_standard
    IS 'Applicable Emission Standard used for LEE qualification.';

COMMENT ON COLUMN camdecmps.monitor_qualification_lee.emission_standard_uom
    IS 'Units of the Applicable Emission Standard.';

COMMENT ON COLUMN camdecmps.monitor_qualification_lee.emission_standard_pct
    IS 'Result of initial test or retest as a percentage of the Applicable Emission Standard.';

COMMENT ON COLUMN camdecmps.monitor_qualification_lee.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmps.monitor_qualification_lee.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmps.monitor_qualification_lee.update_date
    IS 'Date and time in which record was last updated.';
