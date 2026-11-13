ALTER TABLE IF EXISTS camddmw.program_year_dim
    ADD CONSTRAINT program_year_dim_pk PRIMARY KEY (unit_id, prg_code, op_year);
