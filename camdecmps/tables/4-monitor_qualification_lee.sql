-- Table: camdecmps.monitor_qualification_lee

-- DROP TABLE camdecmps.monitor_qualification_lee;

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
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_monitor_qualification_lee PRIMARY KEY (mon_qual_lee_id),
    CONSTRAINT fk_monitor_qualification_lee_monitor_qualification FOREIGN KEY (mon_qual_id)
        REFERENCES camdecmps.monitor_qualification (mon_qual_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_qualification_lee_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_qualification_lee_qual_test_type_code FOREIGN KEY (qual_lee_test_type_cd)
        REFERENCES camdecmpsmd.qual_lee_test_type_code (qual_lee_test_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_qualification_lee_units_of_measure_code FOREIGN KEY (emission_standard_uom)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
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

-- Index: idx_monitor_qualification_lee_emission_standard_uom

-- DROP INDEX camdecmps.idx_monitor_qualification_lee_emission_standard_uom;

CREATE INDEX idx_monitor_qualification_lee_emission_standard_uom
    ON camdecmps.monitor_qualification_lee USING btree
    (emission_standard_uom COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_monitor_qualification_lee_mon_qual_id

-- DROP INDEX camdecmps.idx_monitor_qualification_lee_mon_qual_id;

CREATE INDEX idx_monitor_qualification_lee_mon_qual_id
    ON camdecmps.monitor_qualification_lee USING btree
    (mon_qual_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_monitor_qualification_lee_parameter_cd

-- DROP INDEX camdecmps.idx_monitor_qualification_lee_parameter_cd;

CREATE INDEX idx_monitor_qualification_lee_parameter_cd
    ON camdecmps.monitor_qualification_lee USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_monitor_qualification_lee_qaul_lee_test_type_cd

-- DROP INDEX camdecmps.idx_monitor_qualification_lee_qaul_lee_test_type_cd;

CREATE INDEX idx_monitor_qualification_lee_qaul_lee_test_type_cd
    ON camdecmps.monitor_qualification_lee USING btree
    (qual_lee_test_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);
