ALTER TABLE IF EXISTS camdecmpsaux.program_parameter
	  ADD CONSTRAINT pk_program_parameter PRIMARY KEY (prg_param_id),
    ADD CONSTRAINT uq_program_parameter UNIQUE (prg_id, parameter_cd, begin_rpt_period_id),
    ADD CONSTRAINT fk_program_parameter_begin_rpt_period FOREIGN KEY (begin_rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_program_parameter_end_rpt_period FOREIGN KEY (end_rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_program_parameter_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_program_parameter_program FOREIGN KEY (prg_id)
        REFERENCES camd.program (prg_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_program_parameter_begin_rpt_period_id
    ON camdecmpsaux.program_parameter USING btree
    (begin_rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_program_parameter_end_rpt_period_id
    ON camdecmpsaux.program_parameter USING btree
    (end_rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_program_parameter_parameter_cd
    ON camdecmpsaux.program_parameter USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_program_parameter_prg_id
    ON camdecmpsaux.program_parameter USING btree
    (prg_id ASC NULLS LAST);
