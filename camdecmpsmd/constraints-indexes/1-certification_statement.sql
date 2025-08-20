ALTER TABLE IF EXISTS camdecmpsmd.certification_statement
ADD CONSTRAINT pk_certification_statement PRIMARY KEY (statement_id);

ALTER TABLE IF EXISTS camdecmpsmd.certification_statement
 ADD CONSTRAINT unique_prg_cd_nulls_index UNIQUE NULLS NOT DISTINCT (prg_cd);