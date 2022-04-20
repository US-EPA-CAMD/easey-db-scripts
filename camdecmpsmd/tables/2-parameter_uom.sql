-- Table: camdecmpsmd.parameter_uom

-- DROP TABLE camdecmpsmd.parameter_uom;

CREATE TABLE IF NOT EXISTS camdecmpsmd.parameter_uom
(
    param_id numeric(38,0) NOT NULL,
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    uom_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    parameter_format character varying(10) COLLATE pg_catalog."default",
    min_value numeric(13,3),
    max_value numeric(13,3),
    decimals_hrly numeric(38,0),
    decimals_fuel_flow numeric(38,0),
    decimals_summary numeric(38,0),
    CONSTRAINT pk_parameter_uom PRIMARY KEY (param_id),
    CONSTRAINT fk_parameter_cod_parameter_uom FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_units_of_meas_parameter_uom FOREIGN KEY (uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmpsmd.parameter_uom
    IS 'Lookup table of pollutants, emission inputs/outputs, equation factors, and calculated values measured and/or reported in the EDR.';

COMMENT ON COLUMN camdecmpsmd.parameter_uom.param_id
    IS 'Unique identifier of parameter code record. ';

COMMENT ON COLUMN camdecmpsmd.parameter_uom.parameter_cd
    IS 'Code used to identify the parameter. ';

COMMENT ON COLUMN camdecmpsmd.parameter_uom.uom_cd
    IS 'Code used to identify the parameter units of measure. ';

COMMENT ON COLUMN camdecmpsmd.parameter_uom.parameter_format
    IS 'Numeric format of Parameter. ';

COMMENT ON COLUMN camdecmpsmd.parameter_uom.min_value
    IS 'Minimum acceptable value for parameter. ';

COMMENT ON COLUMN camdecmpsmd.parameter_uom.max_value
    IS 'Maximum acceptable value for parameter. ';

COMMENT ON COLUMN camdecmpsmd.parameter_uom.decimals_hrly
    IS 'Hourly value decimal places.';

COMMENT ON COLUMN camdecmpsmd.parameter_uom.decimals_fuel_flow
    IS 'Fuel flow value decimal places.';

COMMENT ON COLUMN camdecmpsmd.parameter_uom.decimals_summary
    IS 'Summary value decimal places.';

-- Index: idx_parameter_uom_parameter

-- DROP INDEX camdecmpsmd.idx_parameter_uom_parameter;

CREATE INDEX idx_parameter_uom_parameter
    ON camdecmpsmd.parameter_uom USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_parameter_uom_uom_cd

-- DROP INDEX camdecmpsmd.idx_parameter_uom_uom_cd;

CREATE INDEX idx_parameter_uom_uom_cd
    ON camdecmpsmd.parameter_uom USING btree
    (uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);
