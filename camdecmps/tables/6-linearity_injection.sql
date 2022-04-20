-- Table: camdecmps.linearity_injection

-- DROP TABLE camdecmps.linearity_injection;

CREATE TABLE IF NOT EXISTS camdecmps.linearity_injection
(
    lin_inj_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    lin_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    injection_date date NOT NULL,
    injection_hour numeric(2,0),
    injection_min numeric(2,0),
    measured_value numeric(13,3),
    ref_value numeric(13,3),
    userid character varying(8) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_linearity_injection PRIMARY KEY (lin_inj_id),
    CONSTRAINT fk_linearity_sum_linearity_inj FOREIGN KEY (lin_sum_id)
        REFERENCES camdecmps.linearity_summary (lin_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.linearity_injection
    IS 'Linearity check data and results for one injection.  Record Type 601.';

COMMENT ON COLUMN camdecmps.linearity_injection.lin_inj_id
    IS 'Unique identifier of a linearity injection record. ';

COMMENT ON COLUMN camdecmps.linearity_injection.lin_sum_id
    IS 'Unique identifier of a linearity summary record. ';

COMMENT ON COLUMN camdecmps.linearity_injection.injection_date
    IS 'Date on which injection occurred. ';

COMMENT ON COLUMN camdecmps.linearity_injection.injection_hour
    IS 'Hour in which injection occurred. ';

COMMENT ON COLUMN camdecmps.linearity_injection.injection_min
    IS 'Minute in which injection occurred. ';

COMMENT ON COLUMN camdecmps.linearity_injection.measured_value
    IS 'Measured value. ';

COMMENT ON COLUMN camdecmps.linearity_injection.ref_value
    IS 'Reference value. ';

COMMENT ON COLUMN camdecmps.linearity_injection.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.linearity_injection.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.linearity_injection.update_date
    IS 'Date and time in which record was last updated. ';

-- Index: linearity_injection_idx001

-- DROP INDEX camdecmps.linearity_injection_idx001;

CREATE INDEX linearity_injection_idx001
    ON camdecmps.linearity_injection USING btree
    (lin_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
