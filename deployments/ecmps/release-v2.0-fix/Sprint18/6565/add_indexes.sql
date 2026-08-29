CREATE INDEX IF NOT EXISTS idx_unit_program_umcbd 
	ON camd.unit_program USING btree 
	(unit_monitor_cert_begin_date ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_program_end_date 
	ON camd.unit_program USING btree 
	(end_date ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_program_class_cd 
	ON camd.unit_program USING btree 
	(class_cd ASC NULLS LAST);	

CREATE INDEX IF NOT EXISTS idx_unit_program_prg_cd 
	ON camd.unit_program USING btree 
	(prg_cd ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_program_phase_pmcd 
	ON camd.program_phase USING btree 
	(phase_monitor_cert_deadline ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_reporting_period_end_date 
	ON camdecmpsmd.reporting_period USING btree 
	(end_date ASC NULLS LAST);

CREATE UNIQUE INDEX IF NOT EXISTS idx_unit_op_status_all 
	ON camd.unit_op_status USING btree 
	(unit_id ASC NULLS LAST, op_status_cd ASC NULLS LAST, begin_date ASC NULLS LAST, end_date ASC NULLS LAST);