DROP INDEX IF EXISTS camdecmpswks.idx_component_analytical_principle_cd;	

ALTER TABLE IF EXISTS camdecmpswks.component
	DROP CONSTRAINT IF EXISTS fk_component_analytical_principle_code,
	DROP COLUMN IF EXISTS analytical_principle_cd;