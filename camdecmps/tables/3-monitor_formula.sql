-- Table: camdecmps.monitor_formula

-- DROP TABLE camdecmps.monitor_formula;

CREATE TABLE IF NOT EXISTS camdecmps.monitor_formula
(
    mon_form_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    equation_cd character varying(7) COLLATE pg_catalog."default",
    formula_identifier character varying(3) COLLATE pg_catalog."default" NOT NULL,
    begin_date date,
    begin_hour numeric(2,0),
    end_date date,
    end_hour numeric(2,0),
    formula_equation character varying(200) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_monitor_formula PRIMARY KEY (mon_form_id),
    CONSTRAINT fk_equation_code_monitor_formu FOREIGN KEY (equation_cd)
        REFERENCES camdecmpsmd.equation_code (equation_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_locat_monitor_formu FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_parameter_cod_monitor_formu FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.monitor_formula
    IS 'The formula(s) that is used to calculate Emissions for parameters monitored at the monitoring location. Record Type 520.';

COMMENT ON COLUMN camdecmps.monitor_formula.mon_form_id
    IS 'Unique identifier of a monitoring formula record. ';

COMMENT ON COLUMN camdecmps.monitor_formula.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.monitor_formula.parameter_cd
    IS 'Code used to identify the parameter. ';

COMMENT ON COLUMN camdecmps.monitor_formula.equation_cd
    IS 'Code used to identify the equation as defined in Part 75. ';

COMMENT ON COLUMN camdecmps.monitor_formula.formula_identifier
    IS 'The three character formula ID assigned by the source. ';

COMMENT ON COLUMN camdecmps.monitor_formula.begin_date
    IS 'Date on which information became effective or activity started. ';

COMMENT ON COLUMN camdecmps.monitor_formula.begin_hour
    IS 'Hour in which information became effective. ';

COMMENT ON COLUMN camdecmps.monitor_formula.end_date
    IS 'Last date in which information was effective.  This date will be null for active records. ';

COMMENT ON COLUMN camdecmps.monitor_formula.end_hour
    IS 'Last hour in which information was effective.  This value will be null for active records. ';

COMMENT ON COLUMN camdecmps.monitor_formula.formula_equation
    IS 'The equation used to calculate the parameter. ';

COMMENT ON COLUMN camdecmps.monitor_formula.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.monitor_formula.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.monitor_formula.update_date
    IS 'Date and time in which record was last updated. ';

-- Index: idx_monitor_formula_equation_c

-- DROP INDEX camdecmps.idx_monitor_formula_equation_c;

CREATE INDEX IF NOT EXISTS idx_monitor_formula_equation_c
    ON camdecmps.monitor_formula USING btree
    (equation_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_monitor_formula_mon_loc_id

-- DROP INDEX camdecmps.idx_monitor_formula_mon_loc_id;

CREATE INDEX IF NOT EXISTS idx_monitor_formula_mon_loc_id
    ON camdecmps.monitor_formula USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: monitor_formula_idx$$_15b00008

-- DROP INDEX camdecmps."monitor_formula_idx$$_15b00008";

CREATE INDEX IF NOT EXISTS "monitor_formula_idx$$_15b00008"
    ON camdecmps.monitor_formula USING btree
    (formula_identifier COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: monitor_formula_idx001

-- DROP INDEX camdecmps.monitor_formula_idx001;

CREATE INDEX IF NOT EXISTS monitor_formula_idx001
    ON camdecmps.monitor_formula USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);
