ALTER TABLE IF EXISTS camdecmpsmd.certification_statement
ADD CONSTRAINT pk_certification_statement PRIMARY KEY (statement_id);

-- Since PostgreSQL doesn't support the NULLS NOT DISTINCT, 
-- we can accomplish this by creating a unique index that includes 
-- a condition for NULL values and statement id.
-- Then, we can make a partial unique index that prevents 
-- multiple rows with NULL in prg_cd with the same statement_id.

-- Unique index for non-NULL statement_id and prg_cd
CREATE UNIQUE INDEX prgunique_index
ON camdecmpsmd.certification_statement (statement_id, prg_cd)
WHERE statement_id IS NOT NULL;

-- Unique index for NULL prg_cd and statement_id
CREATE UNIQUE INDEX prgunique_nulls_index
ON camdecmpsmd.certification_statement (statement_id)
WHERE prg_cd IS NULL;