ALTER TABLE IF EXISTS camdecmpsmd.nsps4t_electrical_load_code
    ADD CONSTRAINT pk_nsps4t_electrical_load_code PRIMARY KEY (electrical_load_cd),
    ADD CONSTRAINT uq_nsps4t_electrical_load_code_description UNIQUE (electrical_load_description);
