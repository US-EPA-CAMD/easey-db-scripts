ALTER TABLE IF EXISTS camdecmpsmd.sorbent_trap_aps_code
    ADD CONSTRAINT pk_sorbent_trap_aps_code PRIMARY KEY (sorbent_trap_aps_cd),
    ADD CONSTRAINT uq_sorbent_trap_aps_code_description UNIQUE (sorbent_trap_aps_description);
