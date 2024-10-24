CREATE TABLE IF NOT EXISTS camdecmpsmd.sorbent_trap_aps_code
(
    sorbent_trap_aps_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    sorbent_trap_aps_description character varying(1000) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmpsmd.sorbent_trap_aps_code
    IS 'Lookup table of sorbent trap alternate performas specification codes.';

COMMENT ON COLUMN camdecmpsmd.sorbent_trap_aps_code.sorbent_trap_aps_cd
    IS 'Code used to identify the sorbent trap APS.';

COMMENT ON COLUMN camdecmpsmd.sorbent_trap_aps_code.sorbent_trap_aps_description
    IS 'Description of the sorbent trap APS code.';